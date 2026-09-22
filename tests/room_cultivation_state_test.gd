extends SceneTree

const TEST_SEED := 4242
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()

    if not state.add_room("room_2", "sala_compacta"):
        _fail("Could not create second room.")
        return

    state.care_for_room()
    var room_1_after_care := _cultivation_for(state, "room_1")
    var room_2_before_switch := _cultivation_for(state, "room_2")

    if not bool(room_1_after_care["cared_today"]):
        _fail("Care did not persist in room_1 canonical state.")
        return
    if bool(room_2_before_switch["cared_today"]):
        _fail("Care leaked from room_1 into room_2.")
        return
    if is_equal_approx(
        float(room_1_after_care["grow_health"]),
        float(room_2_before_switch["grow_health"]),
    ):
        _fail("Room-specific cultivation health was not isolated.")
        return

    if not state.switch_active_room("room_2"):
        _fail("Could not switch to a known room.")
        return
    if state.active_room_id != "room_2":
        _fail("Active room ID was not updated.")
        return
    if state.cared_today:
        _fail("Active-room UI cache did not switch to room_2 state.")
        return
    if state.switch_active_room("missing_room"):
        _fail("Unknown room switch was accepted.")
        return

    state.next_day()

    var room_1_after_day := _cultivation_for(state, "room_1")
    var room_2_after_day := _cultivation_for(state, "room_2")
    if int(room_1_after_day["grow_day"]) != 1:
        _fail("room_1 did not advance independently.")
        return
    if int(room_2_after_day["grow_day"]) != 1:
        _fail("room_2 did not advance independently.")
        return
    if bool(room_1_after_day["cared_today"]) or bool(room_2_after_day["cared_today"]):
        _fail("Daily care reset did not remain room-scoped.")
        return

    if not state.switch_active_room("room_1"):
        _fail("Could not switch back to room_1.")
        return
    if state.grow_day != int(room_1_after_day["grow_day"]):
        _fail("Active-room cache did not restore room_1 progress.")
        return

    print("ROOM CULTIVATION STATE TEST PASSED")
    quit(0)

func _cultivation_for(state: Node, instance_id: String) -> Dictionary:
    for room_value in state.rooms:
        var room: Dictionary = room_value
        if String(room.get("instance_id", "")) == instance_id:
            return Dictionary(room["cultivation"]).duplicate(true)
    return {}

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
