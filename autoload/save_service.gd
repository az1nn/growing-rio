extends RefCounted

const SCHEMA_VERSION := 10

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

const REQUIRED_CITY_KEYS := [
    "active_district_id",
    "district_demand",
]

const REQUIRED_POLICY_KEYS := [
    "institution_level",
    "enacted_policy_ids",
]

const REQUIRED_COMMUNITY_KEYS := [
    "support",
]

const REQUIRED_NARRATIVE_CAMPAIGN_KEYS := [
    "completed_arc_ids",
    "completed_event_ids",
    "narrative_flags",
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
        "schema_version": 6,
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

func create_v7(
    state: Dictionary,
    rooms: Array,
    active_room_id: String,
    staff_ids: Array,
    upgrade_ids: Array,
    buyer_relationships: Dictionary,
    active_contract_id: String,
    compliance_level: int,
    active_district_id: String,
    district_demand: Dictionary,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    return {
        "schema_version": 7,
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
        "city": {
            "active_district_id": active_district_id,
            "district_demand": district_demand.duplicate(true),
        },
        "simulation": {
            "seed": simulation_seed,
            "rng_state": str(rng_state),
        },
    }

func create_v8(
    state: Dictionary,
    rooms: Array,
    active_room_id: String,
    staff_ids: Array,
    upgrade_ids: Array,
    buyer_relationships: Dictionary,
    active_contract_id: String,
    compliance_level: int,
    active_district_id: String,
    district_demand: Dictionary,
    institution_level: int,
    enacted_policy_ids: Array,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    var payload := create_v7(
        state,
        rooms,
        active_room_id,
        staff_ids,
        upgrade_ids,
        buyer_relationships,
        active_contract_id,
        compliance_level,
        active_district_id,
        district_demand,
        simulation_seed,
        rng_state,
    )
    payload["schema_version"] = 8
    payload["policy"] = {
        "institution_level": institution_level,
        "enacted_policy_ids": enacted_policy_ids.duplicate(true),
    }
    return payload

func create_v9(
    state: Dictionary,
    rooms: Array,
    active_room_id: String,
    staff_ids: Array,
    upgrade_ids: Array,
    buyer_relationships: Dictionary,
    active_contract_id: String,
    compliance_level: int,
    active_district_id: String,
    district_demand: Dictionary,
    institution_level: int,
    enacted_policy_ids: Array,
    community_support: Dictionary,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    var payload := create_v8(
        state,
        rooms,
        active_room_id,
        staff_ids,
        upgrade_ids,
        buyer_relationships,
        active_contract_id,
        compliance_level,
        active_district_id,
        district_demand,
        institution_level,
        enacted_policy_ids,
        simulation_seed,
        rng_state,
    )
    payload["schema_version"] = 9
    payload["community"] = {
        "support": community_support.duplicate(true),
    }
    return payload

func create_v10(
    state: Dictionary,
    rooms: Array,
    active_room_id: String,
    staff_ids: Array,
    upgrade_ids: Array,
    buyer_relationships: Dictionary,
    active_contract_id: String,
    compliance_level: int,
    active_district_id: String,
    district_demand: Dictionary,
    institution_level: int,
    enacted_policy_ids: Array,
    community_support: Dictionary,
    completed_arc_ids: Array,
    completed_event_ids: Array,
    narrative_flags: Dictionary,
    simulation_seed: int,
    rng_state: int,
) -> Dictionary:
    var payload := create_v9(
        state,
        rooms,
        active_room_id,
        staff_ids,
        upgrade_ids,
        buyer_relationships,
        active_contract_id,
        compliance_level,
        active_district_id,
        district_demand,
        institution_level,
        enacted_policy_ids,
        community_support,
        simulation_seed,
        rng_state,
    )
    payload["schema_version"] = SCHEMA_VERSION
    payload["campaign"] = {
        "completed_arc_ids": completed_arc_ids.duplicate(true),
        "completed_event_ids": completed_event_ids.duplicate(true),
        "narrative_flags": narrative_flags.duplicate(true),
    }
    return payload

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
        6:
            return _parse_v6(payload)
        7:
            return _parse_v7(payload)
        8:
            return _parse_v8(payload)
        9:
            return _parse_v9(payload)
        SCHEMA_VERSION:
            return _parse_v10(payload)
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
        "schema_version": 6,
        "state": common["state"],
        "business": business["business"],
        "simulation": common["simulation"],
    }

func _parse_v7(payload: Dictionary) -> Dictionary:
    var common := _parse_common(payload, false)
    if not common["ok"]:
        return common

    var business := _parse_business(payload, true, true, true, true)
    if not business["ok"]:
        return business

    var city := _parse_city(payload)
    if not city["ok"]:
        return city

    return {
        "ok": true,
        "schema_version": 7,
        "state": common["state"],
        "business": business["business"],
        "city": city["city"],
        "simulation": common["simulation"],
    }

func _parse_v8(payload: Dictionary) -> Dictionary:
    var legacy := _parse_v7(payload)
    if not legacy["ok"]:
        return legacy

    var policy := _parse_policy(payload)
    if not policy["ok"]:
        return policy

    return {
        "ok": true,
        "schema_version": 8,
        "state": legacy["state"],
        "business": legacy["business"],
        "city": legacy["city"],
        "policy": policy["policy"],
        "simulation": legacy["simulation"],
    }

func _parse_v9(payload: Dictionary) -> Dictionary:
    var legacy := _parse_v8(payload)
    if not legacy["ok"]:
        return legacy

    var community := _parse_community(payload)
    if not community["ok"]:
        return community

    return {
        "ok": true,
        "schema_version": 9,
        "state": legacy["state"],
        "business": legacy["business"],
        "city": legacy["city"],
        "policy": legacy["policy"],
        "community": community["community"],
        "simulation": legacy["simulation"],
    }

func _parse_v10(payload: Dictionary) -> Dictionary:
    var legacy := _parse_v9(payload)
    if not legacy["ok"]:
        return legacy

    var campaign := _parse_campaign(payload)
    if not campaign["ok"]:
        return campaign

    return {
        "ok": true,
        "schema_version": SCHEMA_VERSION,
        "state": legacy["state"],
        "business": legacy["business"],
        "city": legacy["city"],
        "policy": legacy["policy"],
        "community": legacy["community"],
        "campaign": campaign["campaign"],
        "simulation": legacy["simulation"],
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
        var compliance_value = business.get("compliance_level")
        if (
            typeof(compliance_value) != TYPE_INT
            and typeof(compliance_value) != TYPE_FLOAT
        ):
            return _error("business.compliance_level must be numeric.")
        var compliance_float := float(compliance_value)
        var compliance_level := int(compliance_float)
        if (
            compliance_float != float(compliance_level)
            or compliance_level < 0
            or compliance_level > 3
        ):
            return _error("business.compliance_level must be an integer 0..3.")
        parsed_business["compliance_level"] = compliance_level

    return {
        "ok": true,
        "business": parsed_business,
    }

func _parse_city(payload: Dictionary) -> Dictionary:
    if typeof(payload.get("city")) != TYPE_DICTIONARY:
        return _error("Missing or invalid city object.")

    var city: Dictionary = payload["city"]
    for key in REQUIRED_CITY_KEYS:
        if not city.has(key):
            return _error("Missing city field: %s." % key)

    var active_district_id := String(city["active_district_id"])
    if active_district_id.is_empty():
        return _error("city.active_district_id must not be empty.")
    if typeof(city["district_demand"]) != TYPE_DICTIONARY:
        return _error("city.district_demand must be an object.")

    var district_demand: Dictionary = city["district_demand"]
    if district_demand.is_empty():
        return _error("city.district_demand must not be empty.")
    if not district_demand.has(active_district_id):
        return _error(
            "city.active_district_id does not reference saved demand state."
        )

    for district_id_value in district_demand:
        var district_id := String(district_id_value)
        if district_id.is_empty():
            return _error("city.district_demand contains an empty ID.")
        var demand_value = district_demand[district_id_value]
        if typeof(demand_value) != TYPE_INT and typeof(demand_value) != TYPE_FLOAT:
            return _error("city.district_demand values must be numeric.")
        var demand := float(demand_value)
        if demand < 0.0 or demand > 100.0:
            return _error("city.district_demand values must be 0..100.")

    return {
        "ok": true,
        "city": {
            "active_district_id": active_district_id,
            "district_demand": district_demand.duplicate(true),
        },
    }

func _parse_policy(payload: Dictionary) -> Dictionary:
    if typeof(payload.get("policy")) != TYPE_DICTIONARY:
        return _error("Missing or invalid policy object.")

    var policy: Dictionary = payload["policy"]
    for key in REQUIRED_POLICY_KEYS:
        if not policy.has(key):
            return _error("Missing policy field: %s." % key)

    var level_value = policy["institution_level"]
    if typeof(level_value) != TYPE_INT and typeof(level_value) != TYPE_FLOAT:
        return _error("policy.institution_level must be numeric.")
    var level_float := float(level_value)
    var institution_level := int(level_float)
    if (
        level_float != float(institution_level)
        or institution_level < 0
        or institution_level > 3
    ):
        return _error("policy.institution_level must be an integer 0..3.")

    if typeof(policy["enacted_policy_ids"]) != TYPE_ARRAY:
        return _error("policy.enacted_policy_ids must be an Array.")
    var enacted_policy_ids: Array = policy["enacted_policy_ids"]
    if enacted_policy_ids.size() != institution_level:
        return _error(
            "policy.enacted_policy_ids size must match institution_level."
        )

    var seen := {}
    for id_value in enacted_policy_ids:
        var policy_id := String(id_value)
        if policy_id.is_empty():
            return _error("policy.enacted_policy_ids contains an empty ID.")
        if seen.has(policy_id):
            return _error(
                "policy.enacted_policy_ids contains duplicate ID: %s." % policy_id
            )
        seen[policy_id] = true

    return {
        "ok": true,
        "policy": {
            "institution_level": institution_level,
            "enacted_policy_ids": enacted_policy_ids.duplicate(true),
        },
    }

func _parse_community(payload: Dictionary) -> Dictionary:
    if typeof(payload.get("community")) != TYPE_DICTIONARY:
        return _error("Missing or invalid community object.")

    var community: Dictionary = payload["community"]
    for key in REQUIRED_COMMUNITY_KEYS:
        if not community.has(key):
            return _error("Missing community field: %s." % key)

    if typeof(community["support"]) != TYPE_DICTIONARY:
        return _error("community.support must be an object.")

    var support: Dictionary = community["support"]
    if support.is_empty():
        return _error("community.support must not be empty.")

    for district_id_value in support:
        var district_id := String(district_id_value)
        if district_id.is_empty():
            return _error("community.support contains an empty ID.")
        var score_value = support[district_id_value]
        if typeof(score_value) != TYPE_INT and typeof(score_value) != TYPE_FLOAT:
            return _error("community.support values must be numeric.")
        var score := float(score_value)
        if score < 0.0 or score > 100.0:
            return _error("community.support values must be 0..100.")

    return {
        "ok": true,
        "community": {
            "support": support.duplicate(true),
        },
    }

func _parse_campaign(payload: Dictionary) -> Dictionary:
    if typeof(payload.get("campaign")) != TYPE_DICTIONARY:
        return _error("Missing or invalid campaign object.")

    var campaign: Dictionary = payload["campaign"]
    for key in REQUIRED_NARRATIVE_CAMPAIGN_KEYS:
        if not campaign.has(key):
            return _error("Missing campaign field: %s." % key)

    if typeof(campaign["completed_arc_ids"]) != TYPE_ARRAY:
        return _error("campaign.completed_arc_ids must be an Array.")
    if typeof(campaign["completed_event_ids"]) != TYPE_ARRAY:
        return _error("campaign.completed_event_ids must be an Array.")
    if typeof(campaign["narrative_flags"]) != TYPE_DICTIONARY:
        return _error("campaign.narrative_flags must be an object.")

    var completed_arc_ids: Array = campaign["completed_arc_ids"]
    var completed_event_ids: Array = campaign["completed_event_ids"]
    var narrative_flags: Dictionary = campaign["narrative_flags"]

    var seen_arcs := {}
    for id_value in completed_arc_ids:
        var arc_id := String(id_value)
        if arc_id.is_empty():
            return _error("campaign.completed_arc_ids contains an empty ID.")
        if seen_arcs.has(arc_id):
            return _error("campaign.completed_arc_ids contains duplicate ID: %s." % arc_id)
        seen_arcs[arc_id] = true

    var seen_events := {}
    for id_value in completed_event_ids:
        var event_id := String(id_value)
        if event_id.is_empty():
            return _error("campaign.completed_event_ids contains an empty ID.")
        if seen_events.has(event_id):
            return _error("campaign.completed_event_ids contains duplicate ID: %s." % event_id)
        seen_events[event_id] = true

    for flag_id_value in narrative_flags:
        var flag_id := String(flag_id_value)
        if flag_id.is_empty():
            return _error("campaign.narrative_flags contains an empty ID.")
        if typeof(narrative_flags[flag_id_value]) != TYPE_BOOL:
            return _error("campaign.narrative_flags values must be booleans.")

    return {
        "ok": true,
        "campaign": {
            "completed_arc_ids": completed_arc_ids.duplicate(true),
            "completed_event_ids": completed_event_ids.duplicate(true),
            "narrative_flags": narrative_flags.duplicate(true),
        },
    }

func _error(message: String) -> Dictionary:
    return {
        "ok": false,
        "error": message,
    }
