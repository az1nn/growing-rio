extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(9009)
    state.reset()
    state.cash = 100000

    if String(state.current_lifecycle_stage()) != "seedling":
        _fail("Fresh active room did not expose the derived seedling stage.")
        return
    if _room_stage(state.management_snapshot(), "room_1") != "seedling":
        _fail("Management presentation did not expose the initial derived stage.")
        return

    for _day in range(22):
        state.next_day()

    if String(state.current_lifecycle_stage()) != "Vega":
        _fail("Active-room presentation did not advance to the derived Vega stage.")
        return
    if _room_stage(state.management_snapshot(), "room_1") != "Vega":
        _fail("Room presentation duplicated or lost the domain-derived stage.")
        return

    var before_read := state.create_save_data().duplicate(true)
    state.current_lifecycle_stage()
    state.management_snapshot()
    if state.create_save_data() != before_read:
        _fail("Reading lifecycle presentation state mutated canonical state.")
        return

    print("LIFECYCLE STAGE PRESENTATION TEST PASSED")
    quit(0)

func _room_stage(snapshot: Dictionary, instance_id: String) -> String:
    for room_value in Array(snapshot.get("rooms", [])):
        var room: Dictionary = room_value
        if String(room.get("instance_id", "")) == instance_id:
            return String(room.get("lifecycle_stage", ""))
    return ""

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
