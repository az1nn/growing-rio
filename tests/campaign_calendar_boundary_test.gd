extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(9006)
    state.reset()

    if state.MAX_DAYS != 365:
        _fail("Campaign maximum is not exactly 365 in-game days.")
        return

    state.cash = 100000
    state.day = 364
    state.next_day()

    if state.day != 365:
        _fail("Advancing from Day 364 did not enter playable Day 365.")
        return
    if state.game_over:
        _fail("Campaign closed before Day 365 could be played.")
        return

    state.next_day()

    if state.day != 366:
        _fail("Day 365 did not advance to the calendar closure boundary.")
        return
    if not state.game_over:
        _fail("Campaign did not close after the playable Day 365.")
        return

    print("CAMPAIGN CALENDAR BOUNDARY TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
