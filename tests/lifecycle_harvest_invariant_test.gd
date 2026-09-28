extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(9010)
    state.reset()
    # T010 owns harvest/stage invariants, not economy survivability.
    state.cash = 100000

    if state.inventory != 0:
        _fail("Fresh cycle unexpectedly started with inventory.")
        return

    for _day in range(state.current_cycle_days() - 1):
        state.next_day()
        if state.inventory != 0:
            _fail("Lifecycle progression awarded inventory before terminal readiness.")
            return

    if String(state.current_lifecycle_stage()) == "pronta":
        _fail("Lifecycle reached pronta before the terminal growth day.")
        return

    var grow_day_before_early_harvest := state.grow_day
    state.harvest()
    if state.inventory != 0:
        _fail("Early harvest awarded inventory before pronta.")
        return
    if state.grow_day != grow_day_before_early_harvest:
        _fail("Rejected early harvest mutated lifecycle progress.")
        return

    state.next_day()
    if String(state.current_lifecycle_stage()) != "pronta":
        _fail("Terminal growth day did not expose pronta.")
        return
    if state.inventory != 0:
        _fail("Reaching pronta awarded inventory without an explicit harvest.")
        return

    state.harvest()
    var first_inventory := state.inventory
    if first_inventory <= 0:
        _fail("Terminal harvest did not award the single batch.")
        return
    if String(state.current_lifecycle_stage()) == "pronta":
        _fail("Successful harvest did not reset the lifecycle for the next cycle.")
        return

    state.harvest()
    if state.inventory != first_inventory:
        _fail("Repeated harvest created additional inventory from one terminal transition.")
        return

    print("LIFECYCLE HARVEST INVARIANT TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
