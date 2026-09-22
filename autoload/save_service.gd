extends RefCounted

const SCHEMA_VERSION := 1

const REQUIRED_STATE_KEYS := [
    "day",
    "cash",
    "heat",
    "reputation",
    "influence",
    "active_cultivar_id",
    "grow_day",
    "grow_health",
    "cared_today",
    "inventory",
    "batch_quality",
    "game_over",
]

const REQUIRED_SIMULATION_KEYS := [
    "seed",
    "rng_state",
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
        "schema_version": SCHEMA_VERSION,
        "state": serialized_state,
        "simulation": {
            "seed": simulation_seed,
            # JSON numbers cannot exactly represent every 64-bit RNG state.
            "rng_state": str(rng_state),
        },
    }

func parse(payload: Dictionary) -> Dictionary:
    if not payload.has("schema_version"):
        return _error("Missing schema_version.")

    var version := int(payload["schema_version"])
    match version:
        SCHEMA_VERSION:
            return _parse_v1(payload)
        _:
            return _error("Unsupported save schema version: %d." % version)

func _parse_v1(payload: Dictionary) -> Dictionary:
    if typeof(payload.get("state")) != TYPE_DICTIONARY:
        return _error("Missing or invalid state object.")
    if typeof(payload.get("simulation")) != TYPE_DICTIONARY:
        return _error("Missing or invalid simulation object.")

    var state: Dictionary = payload["state"]
    var simulation: Dictionary = payload["simulation"]

    for key in REQUIRED_STATE_KEYS:
        if not state.has(key):
            return _error("Missing state field: %s." % key)

    for key in REQUIRED_SIMULATION_KEYS:
        if not simulation.has(key):
            return _error("Missing simulation field: %s." % key)

    var cultivar_id := String(state["active_cultivar_id"])
    if cultivar_id.is_empty():
        return _error("active_cultivar_id must not be empty.")

    var rng_state_text := String(simulation["rng_state"])
    if not rng_state_text.is_valid_int():
        return _error("simulation.rng_state must be a decimal integer string.")

    return {
        "ok": true,
        "schema_version": SCHEMA_VERSION,
        "state": state.duplicate(true),
        "simulation": {
            "seed": int(simulation["seed"]),
            "rng_state": rng_state_text,
        },
    }

func _error(message: String) -> Dictionary:
    return {
        "ok": false,
        "error": message,
    }
