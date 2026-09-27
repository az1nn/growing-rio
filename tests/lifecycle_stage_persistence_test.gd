extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var source := GAME_STATE_SCRIPT.new()
    root.add_child(source)
    source.set_simulation_seed(9011)
    source.reset()
    # T011 owns persistence derivation, not economy survivability.
    source.cash = 100000

    for _day in range(45):
        source.next_day()

    if String(source.current_lifecycle_stage()) != "flora":
        _fail("Pre-save lifecycle stage did not reach the expected derived flora state.")
        return

    var payload := source.create_save_data()
    if int(payload.get("schema_version", 0)) != 11:
        _fail("Lifecycle persistence unexpectedly changed save schema version.")
        return

    var business: Dictionary = Dictionary(payload.get("business", {}))
    var rooms: Array = Array(business.get("rooms", []))
    if rooms.is_empty():
        _fail("Save payload did not preserve room cultivation state.")
        return

    var room: Dictionary = Dictionary(rooms[0])
    var cultivation: Dictionary = Dictionary(room.get("cultivation", {}))
    if cultivation.has("lifecycle_stage"):
        _fail("Lifecycle stage was persisted instead of remaining derived.")
        return
    if payload.has("lifecycle_stage"):
        _fail("Lifecycle stage leaked into the top-level save payload.")
        return

    var saved_grow_day := int(cultivation.get("grow_day", -1))
    if saved_grow_day != source.grow_day:
        _fail("Save payload did not preserve the canonical grow_day.")
        return

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(payload):
        _fail("Valid v11 lifecycle payload failed to load.")
        return
    if restored.grow_day != saved_grow_day:
        _fail("Round-trip changed canonical grow_day.")
        return
    if String(restored.current_lifecycle_stage()) != "flora":
        _fail("Lifecycle stage was not reconstructed from restored grow_day.")
        return

    var round_trip := restored.create_save_data()
    if int(round_trip.get("schema_version", 0)) != 11:
        _fail("Round-trip introduced a save schema bump.")
        return
    var round_trip_business: Dictionary = Dictionary(round_trip.get("business", {}))
    var round_trip_rooms: Array = Array(round_trip_business.get("rooms", []))
    var round_trip_room: Dictionary = Dictionary(round_trip_rooms[0])
    var round_trip_cultivation: Dictionary = Dictionary(
        round_trip_room.get("cultivation", {})
    )
    if round_trip_cultivation.has("lifecycle_stage"):
        _fail("Round-trip persisted a derived lifecycle stage.")
        return

    var late_payload := payload.duplicate(true)
    var late_business: Dictionary = Dictionary(late_payload["business"])
    var late_rooms: Array = Array(late_business["rooms"])
    var late_room: Dictionary = Dictionary(late_rooms[0])
    var late_cultivation: Dictionary = Dictionary(late_room["cultivation"])
    late_cultivation["grow_day"] = 68

    var late_restored := GAME_STATE_SCRIPT.new()
    root.add_child(late_restored)
    if not late_restored.load_save_data(late_payload):
        _fail("Adjusted grow_day payload failed to load.")
        return
    if String(late_restored.current_lifecycle_stage()) != "late flowering":
        _fail("Restored stage did not follow the persisted grow_day.")
        return

    print("LIFECYCLE STAGE PERSISTENCE TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
