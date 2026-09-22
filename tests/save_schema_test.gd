extends SceneTree

const TEST_SEED := 20260922
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const SAVE_SERVICE := preload("res://autoload/save_service.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var original := GAME_STATE_SCRIPT.new()
    root.add_child(original)
    original.set_simulation_seed(TEST_SEED)
    original.reset()

    if not original.add_room("room_2", "sala_compacta"):
        _fail("Could not prepare multi-room save fixture.")
        return

    original.care_for_room()
    original.next_day()
    original.next_day()
    original.care_for_room()
    original.next_day()

    var save_data: Dictionary = original.create_save_data()

    if int(save_data.get("schema_version", -1)) != 2:
        _fail("Save schema version is not v2.")
        return

    var state_data: Dictionary = save_data.get("state", {})
    if state_data.has("active_cultivar"):
        _fail("Save payload leaked a Resource reference.")
        return
    if String(state_data.get("active_cultivar_id", "")) != "quarto_classica":
        _fail("Stable cultivar ID was not serialized.")
        return

    var business_data: Dictionary = save_data.get("business", {})
    var saved_rooms: Array = business_data.get("rooms", [])
    if saved_rooms.size() != 2:
        _fail("V2 save did not serialize both room states.")
        return
    if String(business_data.get("active_room_id", "")) != "room_1":
        _fail("V2 save did not serialize the active room ID.")
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
        _fail("Valid v2 payload was rejected.")
        return

    if _snapshot(original) != _snapshot(restored):
        print("original=", _snapshot(original))
        print("restored=", _snapshot(restored))
        _fail("V2 save/load round-trip did not restore equivalent state.")
        return

    original.next_day()
    restored.next_day()
    if _snapshot(original) != _snapshot(restored):
        print("continued_original=", _snapshot(original))
        print("continued_restored=", _snapshot(restored))
        _fail("RNG continuation diverged after v2 load.")
        return

    if not _verify_v1_migration(original):
        return

    var unsupported := decoded.duplicate(true)
    unsupported["schema_version"] = 999
    if restored.load_save_data(unsupported):
        _fail("Unsupported schema version was accepted.")
        return

    print("SAVE SCHEMA V2 TEST PASSED")
    print("snapshot=", _snapshot(restored))
    quit(0)

func _verify_v1_migration(source: Node) -> bool:
    var service := SAVE_SERVICE.new()
    var legacy := service.create_v1(
        {
            "day": source.day,
            "cash": source.cash,
            "heat": source.heat,
            "reputation": source.reputation,
            "influence": source.influence,
            "grow_day": source.grow_day,
            "grow_health": source.grow_health,
            "cared_today": source.cared_today,
            "inventory": source.inventory,
            "batch_quality": source.batch_quality,
            "game_over": source.game_over,
        },
        String(source.active_cultivar.id),
        source.simulation_seed,
        source.rng.state,
    )

    var legacy_round_trip_variant = JSON.parse_string(JSON.stringify(
        legacy,
        "",
        true,
        true,
    ))
    if typeof(legacy_round_trip_variant) != TYPE_DICTIONARY:
        _fail("Legacy v1 JSON fixture could not round-trip.")
        return false

    var restored_legacy := GAME_STATE_SCRIPT.new()
    root.add_child(restored_legacy)
    if not restored_legacy.load_save_data(legacy_round_trip_variant):
        _fail("Legacy v1 payload was rejected by v2 code.")
        return false
    if restored_legacy.room_count() != 1:
        _fail("Legacy v1 payload did not migrate to one default room.")
        return false
    if restored_legacy.daily_operating_cost() != 15:
        _fail("Legacy v1 migration did not preserve the original daily upkeep.")
        return false
    return true

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
        state.rooms.duplicate(true),
        state.active_room_id,
        state.simulation_seed,
        str(state.rng.state),
    ]

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
