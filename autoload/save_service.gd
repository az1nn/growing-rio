extends RefCounted

const SCHEMA_VERSION := 6

const REQUIRED_CAMPAIGN_STATE_KEYS := [
    "day",
    "cash",
    "heat",
    "reputation",
    "influence",
    "game_over",
]

const REQUIRED_LEGACY_CULTIVATION_KEYS := [
    "active_cultivar_id",
    "grow_day",
    "grow_health",
    "cared_today",
    "inventory",
    "batch_quality",
]

const REQUIRED_SIMULATION_KEYS := [
    "seed",
    "rng_state",
]

const REQUIRED_BUSINESS_KEYS := [
    "active_room_id",
    "rooms",
]

const REQUIRED_ROOM_CULTIVATION_KEYS := [
    "active_cultivar_id",
    "grow_day",
    "grow_health",
    "cared_today",
    "inventory",
    "batch_quality",
]

func create_v1(
    state: Dictionary,
    active_cultivar_id: String,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    var serialized_state := state.duplicate(true)
    serialized_state["active_cultivar_id"] = active_cultivar_id

    return {
        "schema_version": 1,
        "state": serialized_state,
        "simulation": {
            "seed": simulation_seed,
            "rng_state": str(rng_state),
        },
    }

func create_v2(
    state: Dictionary,
    active_cultivar_id: String,
    rooms: Array,
    active_room_id: String,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    var serialized_state := state.duplicate(true)
    serialized_state["active_cultivar_id"] = active_cultivar_id

    return {
        "schema_version": 2,
        "state": serialized_state,
        "business": {
            "active_room_id": active_room_id,
            "rooms": rooms.duplicate(true),
        },
        "simulation": {
            "seed": simulation_seed,
            "rng_state": str(rng_state),
        },
    }

func create_v3(
    state: Dictionary,
    rooms: Array,
    active_room_id: String,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    return {
        "schema_version": 3,
        "state": state.duplicate(true),
        "business": {
            "active_room_id": active_room_id,
            "rooms": rooms.duplicate(true),
        },
        "simulation": {
            "seed": simulation_seed,
            "rng_state": str(rng_state),
        },
    }

func create_v4(
    state: Dictionary,
    rooms: Array,
    active_room_id: String,
    staff_ids: Array,
    upgrade_ids: Array,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    return {
        "schema_version": 4,
        "state": state.duplicate(true),
        "business": {
            "active_room_id": active_room_id,
            "rooms": rooms.duplicate(true),
            "staff_ids": staff_ids.duplicate(true),
            "upgrade_ids": upgrade_ids.duplicate(true),
        },
        "simulation": {
            "seed": simulation_seed,
            "rng_state": str(rng_state),
        },
    }

func create_v5(
    state: Dictionary,
    rooms: Array,
    active_room_id: String,
    staff_ids: Array,
    upgrade_ids: Array,
    buyer_relationships: Dictionary,
    active_contract_id: String,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    return {
        "schema_version": 5,
        "state": state.duplicate(true),
        "business": {
            "active_room_id": active_room_id,
            "rooms": rooms.duplicate(true),
            "staff_ids": staff_ids.duplicate(true),
            "upgrade_ids": upgrade_ids.duplicate(true),
            "buyer_relationships": buyer_relationships.duplicate(true),
            "active_contract_id": active_contract_id,
        },
        "simulation": {
            "seed": simulation_seed,
            "rng_state": str(rng_state),
        },
    }

func create_v6(
    state: Dictionary,
    rooms: Array,
    active_room_id: String,
    staff_ids: Array,
    upgrade_ids: Array,
    buyer_relationships: Dictionary,
    active_contract_id: String,
    compliance_level: int,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    return {
        "schema_version": SCHEMA_VERSION,
        "state": state.duplicate(true),
        "business": {
            "active_room_id": active_room_id,
            "rooms": rooms.duplicate(true),
            "staff_ids": staff_ids.duplicate(true),
            "upgrade_ids": upgrade_ids.duplicate(true),
            "buyer_relationships": buyer_relationships.duplicate(true),
            "active_contract_id": active_contract_id,
            "compliance_level": compliance_level,
        },
        "simulation": {
            "seed": simulation_seed,
            "rng_state": str(rng_state),
        },
    }

func parse(payload: Dictionary) -> Dictionary:
    if not payload.has("schema_version"):
        return _error("Missing schema_version.")

    var version := int(payload["schema_version"])
    match version:
        1:
            return _parse_v1(payload)
        2:
            return _parse_v2(payload)
        3:
            return _parse_v3(payload)
        4:
            return _parse_v4(payload)
        5:
            return _parse_v5(payload)
        SCHEMA_VERSION:
            return _parse_v6(payload)
        _:
            return _error("Unsupported save schema version: %d." % version)

func _parse_v1(payload: Dictionary) -> Dictionary:
    var common := _parse_common(payload, true)
    if not common["ok"]:
        return common

    return {
        "ok": true,
        "schema_version": 1,
        "state": common["state"],
        "simulation": common["simulation"],
    }

func _parse_v2(payload: Dictionary) -> Dictionary:
    var common := _parse_common(payload, true)
    if not common["ok"]:
        return common

    var business := _parse_business(payload, false, false, false, false)
    if not business["ok"]:
        return business

    return {
        "ok": true,
        "schema_version": 2,
        "state": common["state"],
        "business": business["business"],
        "simulation": common["simulation"],
    }

func _parse_v3(payload: Dictionary) -> Dictionary:
    var common := _parse_common(payload, false)
    if not common["ok"]:
        return common

    var business := _parse_business(payload, true, false, false, false)
    if not business["ok"]:
        return business

    return {
        "ok": true,
        "schema_version": 3,
        "state": common["state"],
        "business": business["business"],
        "simulation": common["simulation"],
    }

func _parse_v4(payload: Dictionary) -> Dictionary:
    var common := _parse_common(payload, false)
    if not common["ok"]:
        return common

    var business := _parse_business(payload, true, true, false, false)
    if not business["ok"]:
        return business

    return {
        "ok": true,
        "schema_version": 4,
        "state": common["state"],
        "business": business["business"],
        "simulation": common["simulation"],
    }

func _parse_v5(payload: Dictionary) -> Dictionary:
    var common := _parse_common(payload, false)
    if not common["ok"]:
        return common

    var business := _parse_business(payload, true, true, true, false)
    if not business["ok"]:
        return business

    return {
        "ok": true,
        "schema_version": 5,
        "state": common["state"],
        "business": business["business"],
        "simulation": common["simulation"],
    }

func _parse_v6(payload: Dictionary) -> Dictionary:
    var common := _parse_common(payload, false)
    if not common["ok"]:
        return common

    var business := _parse_business(payload, true, true, true, true)
    if not business["ok"]:
        return business

    return {
        "ok": true,
        "schema_version": SCHEMA_VERSION,
        "state": common["state"],
        "business": business["business"],
        "simulation": common["simulation"],
    }

func _parse_common(payload: Dictionary, include_legacy_cultivation: bool) -> Dictionary:
    if typeof(payload.get("state")) != TYPE_DICTIONARY:
        return _error("Missing or invalid state object.")
    if typeof(payload.get("simulation")) != TYPE_DICTIONARY:
        return _error("Missing or invalid simulation object.")

    var state: Dictionary = payload["state"]
    var simulation: Dictionary = payload["simulation"]

    for key in REQUIRED_CAMPAIGN_STATE_KEYS:
        if not state.has(key):
            return _error("Missing state field: %s." % key)

    if include_legacy_cultivation:
        for key in REQUIRED_LEGACY_CULTIVATION_KEYS:
            if not state.has(key):
                return _error("Missing legacy cultivation field: %s." % key)
        var cultivar_id := String(state["active_cultivar_id"])
        if cultivar_id.is_empty():
            return _error("active_cultivar_id must not be empty.")

    for key in REQUIRED_SIMULATION_KEYS:
        if not simulation.has(key):
            return _error("Missing simulation field: %s." % key)

    var rng_state_text := String(simulation["rng_state"])
    if not rng_state_text.is_valid_int():
        return _error("simulation.rng_state must be a decimal integer string.")

    return {
        "ok": true,
        "state": state.duplicate(true),
        "simulation": {
            "seed": int(simulation["seed"]),
            "rng_state": rng_state_text,
        },
    }

func _parse_business(
    payload: Dictionary,
    require_cultivation: bool,
    require_staff_upgrades: bool,
    require_contracts: bool,
    require_compliance: bool,
) -> Dictionary:
    if typeof(payload.get("business")) != TYPE_DICTIONARY:
        return _error("Missing or invalid business object.")

    var business: Dictionary = payload["business"]
    for key in REQUIRED_BUSINESS_KEYS:
        if not business.has(key):
            return _error("Missing business field: %s." % key)

    var active_room_id := String(business["active_room_id"])
    if active_room_id.is_empty():
        return _error("business.active_room_id must not be empty.")

    if typeof(business["rooms"]) != TYPE_ARRAY:
        return _error("business.rooms must be an Array.")

    var rooms: Array = business["rooms"]
    if rooms.is_empty():
        return _error("business.rooms must contain at least one room.")

    var room_ids := {}
    for room_value in rooms:
        if typeof(room_value) != TYPE_DICTIONARY:
            return _error("Every room must be an object.")
        var room: Dictionary = room_value
        var instance_id := String(room.get("instance_id", ""))
        var definition_id := String(room.get("definition_id", ""))
        if instance_id.is_empty() or definition_id.is_empty():
            return _error("Room instance_id and definition_id must not be empty.")
        if room_ids.has(instance_id):
            return _error("Duplicate room instance_id: %s." % instance_id)
        room_ids[instance_id] = true

        if require_cultivation:
            if typeof(room.get("cultivation")) != TYPE_DICTIONARY:
                return _error("Room cultivation must be an object.")
            var cultivation: Dictionary = room["cultivation"]
            for key in REQUIRED_ROOM_CULTIVATION_KEYS:
                if not cultivation.has(key):
                    return _error("Missing room cultivation field: %s." % key)
            if String(cultivation["active_cultivar_id"]).is_empty():
                return _error("Room active_cultivar_id must not be empty.")

    if not room_ids.has(active_room_id):
        return _error("business.active_room_id does not reference a saved room.")

    var parsed_business := {
        "active_room_id": active_room_id,
        "rooms": rooms.duplicate(true),
    }

    if require_staff_upgrades:
        for key in ["staff_ids", "upgrade_ids"]:
            if typeof(business.get(key)) != TYPE_ARRAY:
                return _error("business.%s must be an Array." % key)
            var seen := {}
            for id_value in business[key]:
                var content_id := String(id_value)
                if content_id.is_empty():
                    return _error("business.%s contains an empty ID." % key)
                if seen.has(content_id):
                    return _error("business.%s contains duplicate ID: %s." % [key, content_id])
                seen[content_id] = true
        parsed_business["staff_ids"] = Array(business["staff_ids"]).duplicate(true)
        parsed_business["upgrade_ids"] = Array(business["upgrade_ids"]).duplicate(true)

    if require_contracts:
        if typeof(business.get("buyer_relationships")) != TYPE_DICTIONARY:
            return _error("business.buyer_relationships must be an object.")
        if typeof(business.get("active_contract_id")) != TYPE_STRING:
            return _error("business.active_contract_id must be a String.")

        var relationships: Dictionary = business["buyer_relationships"]
        for buyer_id_value in relationships:
            var buyer_id := String(buyer_id_value)
            if buyer_id.is_empty():
                return _error("business.buyer_relationships contains an empty ID.")
            var score_value = relationships[buyer_id_value]
            if typeof(score_value) != TYPE_INT and typeof(score_value) != TYPE_FLOAT:
                return _error(
                    "business.buyer_relationships values must be numeric."
                )
            var score := float(score_value)
            if score < 0.0 or score > 100.0:
                return _error(
                    "business.buyer_relationships values must be 0..100."
                )

        parsed_business["buyer_relationships"] = relationships.duplicate(true)
        parsed_business["active_contract_id"] = String(
            business["active_contract_id"]
        )

    if require_compliance:
        if typeof(business.get("compliance_level")) != TYPE_INT:
            return _error("business.compliance_level must be an int.")
        var compliance_level := int(business["compliance_level"])
        if compliance_level < 0 or compliance_level > 3:
            return _error("business.compliance_level must be 0..3.")
        parsed_business["compliance_level"] = compliance_level

    return {
        "ok": true,
        "business": parsed_business,
    }

func _error(message: String) -> Dictionary:
    return {
        "ok": false,
        "error": message,
    }
