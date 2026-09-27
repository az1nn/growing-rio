extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(9015)
    state.reset()
    # T014 owns calendar/cycle arithmetic, not economy survivability.
    state.cash = 1000000

    if state.current_cycle_days() != 90:
        _fail("Canonical cultivation cycle is not exactly 90 days.")
        return

    for cycle_index in range(4):
        for _growth_day in range(state.current_cycle_days()):
            if state.game_over:
                _fail("Campaign closed before completing four serial 90-day cycles.")
                return
            state.next_day()

        if state.grow_day != 90:
            _fail("Cycle %d did not reach the 90-day harvest boundary." % (cycle_index + 1))
            return
        if String(state.current_lifecycle_stage()) != "pronta":
            _fail("Cycle %d was not pronta at its 90-day boundary." % (cycle_index + 1))
            return

        state.harvest()
        if state.grow_day != 0:
            _fail("Cycle %d harvest did not reset grow_day for the next serial cycle." % (cycle_index + 1))
            return
        if state.inventory <= 0:
            _fail("Cycle %d harvest did not produce inventory needed to close the cycle." % (cycle_index + 1))
            return

        state.sell_legal()
        if state.inventory != 0:
            _fail("Cycle %d sale did not clear inventory before the next serial cycle." % (cycle_index + 1))
            return

    if state.day != 361:
        _fail("Four 90-day cycles did not consume exactly 360 campaign-day advances.")
        return
    if state.game_over:
        _fail("Campaign closed immediately after the four-cycle 360-day span.")
        return
    if state.grow_day != 0:
        _fail("Fourth serial cycle did not end with a fresh lifecycle.")
        return

    # After 360 consumed advances, playable days 361-365 remain: exactly five days.
    for expected_day in range(362, 366):
        state.next_day()
        if state.day != expected_day:
            _fail("Annual closure margin advanced to an unexpected campaign day.")
            return
        if state.game_over:
            _fail("Campaign closed before playable Day 365 completed.")
            return

    if state.day != 365:
        _fail("Four-cycle schedule did not leave Day 365 as the fifth playable margin day.")
        return

    state.next_day()
    if state.day != 366:
        _fail("Day 365 did not advance to the annual closure boundary.")
        return
    if not state.game_over:
        _fail("Campaign remained open after consuming the five-day annual closure margin.")
        return

    print("CAMPAIGN ANNUAL CYCLE MARGIN TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
