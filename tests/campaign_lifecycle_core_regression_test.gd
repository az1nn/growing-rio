extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const CULTIVATION_SERVICE_SCRIPT := preload("res://domain/cultivation/cultivation_service.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    if not _verify_day_365_boundary():
        return
    if not _verify_readiness_and_early_harvest():
        return
    if not _verify_stage_monotonicity():
        return

    print("CAMPAIGN LIFECYCLE CORE REGRESSION TEST PASSED")
    quit(0)

func _verify_day_365_boundary() -> bool:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(9012)
    state.reset()
    state.cash = 100000
    state.day = 364

    state.next_day()
    if state.day != 365:
        _fail("Day 364 did not advance to playable Day 365.")
        return false
    if state.game_over:
        _fail("Campaign closed before playable Day 365.")
        return false

    state.next_day()
    if state.day != 366:
        _fail("Day 365 did not advance to the closure boundary.")
        return false
    if not state.game_over:
        _fail("Campaign remained open beyond Day 365.")
        return false

    state.queue_free()
    return true

func _verify_readiness_and_early_harvest() -> bool:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(9013)
    state.reset()
    state.cash = 100000

    if state.current_cycle_days() != 90:
        _fail("Canonical cycle is not exactly 90 growth days.")
        return false

    for _day in range(89):
        state.next_day()

    if state.grow_day != 89:
        _fail("Lifecycle did not reach grow_day 89 before readiness check.")
        return false
    if String(state.current_lifecycle_stage()) == "pronta":
        _fail("Lifecycle became pronta before the 90-day boundary.")
        return false

    var inventory_before := state.inventory
    var grow_day_before := state.grow_day
    state.harvest()

    if state.inventory != inventory_before:
        _fail("Early harvest changed inventory before readiness.")
        return false
    if state.grow_day != grow_day_before:
        _fail("Early harvest changed grow_day before readiness.")
        return false

    state.next_day()
    if state.grow_day != 90:
        _fail("The 90th growth-day advance did not reach grow_day 90.")
        return false
    if String(state.current_lifecycle_stage()) != "pronta":
        _fail("Lifecycle did not become pronta at the 90-day boundary.")
        return false

    var availability: Dictionary = state.cultivation_action_availability()
    var harvest_availability: Dictionary = Dictionary(availability.get("harvest", {}))
    if not bool(harvest_availability.get("enabled", false)):
        _fail("Harvest did not become available at pronta.")
        return false

    state.queue_free()
    return true

func _verify_stage_monotonicity() -> bool:
    var service := CULTIVATION_SERVICE_SCRIPT.new()
    var order := {
        "seedling": 0,
        "Vega": 1,
        "flora": 2,
        "late flowering": 3,
        "pronta": 4,
    }
    var previous_rank := -1

    for grow_day in range(91):
        var stage := String(service.lifecycle_stage(grow_day, 90))
        if not order.has(stage):
            _fail("Lifecycle produced an unknown stage at grow_day %d." % grow_day)
            return false

        var rank := int(order[stage])
        if rank < previous_rank:
            _fail("Lifecycle stage moved backward at grow_day %d." % grow_day)
            return false
        previous_rank = rank

    if previous_rank != int(order["pronta"]):
        _fail("Lifecycle monotonicity scan did not terminate at pronta.")
        return false

    return true

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
