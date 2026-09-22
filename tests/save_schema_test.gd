extends SceneTree

const TEST_SEED := 20260922
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var original := GAME_STATE_SCRIPT.new()
    root.add_child(original)
    original.set_simulation_seed(TEST_SEED)
    original.reset()

    original.care_for_room()
    original.next_day()
    original.next_day()
    original.care_for_room()
    original.next_day()

    var save_data: Dictionary = original.create_save_data()

    if int(save_data.get("schema_version", -1)) != 1:
        _fail("Save schema version is not v1.")
        return

    var state_data: Dictionary = save_data.get("state", {})
    if state_data.has("active_cultivar"):
        _fail("Save payload leaked a Resource reference.")
        return
    if String(state_data.get("active_cultivar_id", "")) != "quarto_classica":
        _fail("Stable cultivar ID was not serialized.")
        return

    var simulation_data: Dictionary = save_data.get("simulation", {})
    if typeof(simulation_data.get("rng_state")) != TYPE_STRING:
        _fail("RNG state must be serialized as a JSON-safe decimal string.")
        return

    var encoded := JSON.stringify(save_data, "", true, true)
    var decoded_variant = JSON.parse_string(encoded)
    if typeof(decoded_variant) != TYPE_DICTIONARY:
        _fail("JSON round-trip did not produce a Dictionary.")
        return

    var decoded: Dictionary = decoded_variant
    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)

    if not restored.load_save_data(decoded):
        _fail("Valid v1 payload was rejected.")
        return

    if _snapshot(original) != _snapshot(restored):
        print("original=", _snapshot(original))
        print("restored=", _snapshot(restored))
        _fail("Save/load round-trip did not restore equivalent state.")
        return

    # Both instances must consume the same next random values after restoration.
    original.next_day()
    restored.next_day()
    if _snapshot(original) != _snapshot(restored):
        print("continued_original=", _snapshot(original))
        print("continued_restored=", _snapshot(restored))
        _fail("RNG continuation diverged after load.")
        return

    var unsupported := decoded.duplicate(true)
    unsupported["schema_version"] = 999
    if restored.load_save_data(unsupported):
        _fail("Unsupported schema version was accepted.")
        return

    print("SAVE SCHEMA V1 TEST PASSED")
    print("snapshot=", _snapshot(restored))
    quit(0)

func _snapshot(state: Node) -> Array:
    return [
        state.day,
        state.cash,
        state.heat,
        state.reputation,
        state.influence,
        String(state.active_cultivar.id),
        state.grow_day,
        state.grow_health,
        state.cared_today,
        state.inventory,
        state.batch_quality,
        state.game_over,
        state.simulation_seed,
        str(state.rng.state),
    ]

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
