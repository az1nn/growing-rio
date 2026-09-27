extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(9014)
    state.reset()
    # T013 owns lifecycle invariants, not economy survivability.
    state.cash = 100000

    if not _verify_stage_derivation_rng_free(state):
        return
    if not _verify_stage_transitions_create_no_inventory(state):
        return

    print("LIFECYCLE RNG/INVENTORY INVARIANT TEST PASSED")
    quit(0)

func _verify_stage_derivation_rng_free(state: Node) -> bool:
    var stage_before := String(state.current_lifecycle_stage())
    var rng_state_before: int = state.rng.state

    for _sample in range(64):
        if String(state.current_lifecycle_stage()) != stage_before:
            _fail("Repeated lifecycle derivation changed stage without time progression.")
            return false

    if state.rng.state != rng_state_before:
        _fail("Lifecycle-stage derivation consumed simulation RNG.")
        return false

    return true

func _verify_stage_transitions_create_no_inventory(state: Node) -> bool:
    if state.inventory != 0:
        _fail("Fresh lifecycle unexpectedly started with inventory.")
        return false

    var previous_stage := String(state.current_lifecycle_stage())
    var transitions_seen := 0

    for _day in range(state.current_cycle_days()):
        var inventory_before := state.inventory
        state.next_day()
        var current_stage := String(state.current_lifecycle_stage())

        if state.inventory != inventory_before:
            _fail("Lifecycle progression changed inventory without explicit harvest.")
            return false

        if current_stage != previous_stage:
            transitions_seen += 1
            if state.inventory != 0:
                _fail("Lifecycle stage transition created inventory.")
                return false
            previous_stage = current_stage

    if previous_stage != "pronta":
        _fail("Lifecycle transition scan did not terminate at pronta.")
        return false
    if transitions_seen != 4:
        _fail("Lifecycle transition scan did not observe exactly four ordered stage changes.")
        return false
    if state.inventory != 0:
        _fail("Reaching pronta created inventory without explicit harvest.")
        return false

    return true

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
