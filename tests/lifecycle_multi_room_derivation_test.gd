extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(9016)
    state.reset()
    # T015 owns room-local lifecycle derivation, not economy survivability.
    state.cash = 100000

    for _day in range(22):
        state.next_day()

    if state.grow_day != 22:
        _fail("Primary room did not reach grow_day 22 before adding the second room.")
        return
    if String(state.current_lifecycle_stage()) != "Vega":
        _fail("Primary room did not reach Vega at grow_day 22.")
        return

    if not state.add_room("room_2", "sala_compacta"):
        _fail("Could not add the second room for multi-room lifecycle coverage.")
        return

    var snapshot := state.management_snapshot()
    if _room_stage(snapshot, "room_1") != "Vega":
        _fail("Existing room lost its independently derived Vega stage.")
        return
    if _room_stage(snapshot, "room_2") != "seedling":
        _fail("New room did not derive seedling independently from its own grow_day.")
        return
    if _room_grow_day(state.rooms, "room_1") != 22:
        _fail("Adding a second room changed the first room grow_day.")
        return
    if _room_grow_day(state.rooms, "room_2") != 0:
        _fail("New room did not start from an independent grow_day zero.")
        return

    for _day in range(23):
        state.next_day()

    snapshot = state.management_snapshot()
    if _room_grow_day(state.rooms, "room_1") != 45:
        _fail("Primary room did not advance independently to grow_day 45.")
        return
    if _room_grow_day(state.rooms, "room_2") != 23:
        _fail("Second room did not advance independently from its later start.")
        return
    if _room_stage(snapshot, "room_1") != "flora":
        _fail("Primary room did not derive flora from grow_day 45.")
        return
    if _room_stage(snapshot, "room_2") != "Vega":
        _fail("Second room did not independently derive Vega from grow_day 23.")
        return

    if not state.switch_active_room("room_2"):
        _fail("Could not switch to the second room.")
        return
    if String(state.current_lifecycle_stage()) != "Vega":
        _fail("Active-room lifecycle cache did not reflect room_2's independent stage.")
        return

    if not state.switch_active_room("room_1"):
        _fail("Could not switch back to the first room.")
        return
    if String(state.current_lifecycle_stage()) != "flora":
        _fail("Active-room lifecycle cache did not restore room_1's independent stage.")
        return

    print("MULTI-ROOM LIFECYCLE DERIVATION TEST PASSED")
    quit(0)

func _room_stage(snapshot: Dictionary, instance_id: String) -> String:
    for room_value in Array(snapshot.get("rooms", [])):
        var room: Dictionary = room_value
        if String(room.get("instance_id", "")) == instance_id:
            return String(room.get("lifecycle_stage", ""))
    return ""

func _room_grow_day(room_list: Array, instance_id: String) -> int:
    for room_value in room_list:
        if typeof(room_value) != TYPE_DICTIONARY:
            continue
        var room: Dictionary = room_value
        if String(room.get("instance_id", "")) != instance_id:
            continue
        var cultivation: Dictionary = Dictionary(room.get("cultivation", {}))
        return int(cultivation.get("grow_day", -1))
    return -1

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
