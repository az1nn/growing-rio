extends SceneTree

const TEST_SEED := 9031
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()

    var rng_before := str(state.rng.state)
    var cash_before := state.cash

    state.reputation = 1.0
    state.influence = 4.0
    state.heat = 20.0
    state.cash = 1000
    if state.advance_compliance():
        _fail("Compliance advanced without meeting the reputation gate.")
        return
    if state.compliance_level != 0:
        _fail("Failed compliance gate mutated the level.")
        return
    if state.cash != 1000:
        _fail("Failed compliance gate mutated cash.")
        return

    state.reputation = 2.0
    if not state.advance_compliance():
        _fail("Level 1 compliance transition failed.")
        return
    if state.compliance_level != 1:
        _fail("Level 1 compliance state regressed.")
        return
    if state.cash != 940:
        _fail("Level 1 compliance cash cost regressed.")
        return
    if not is_equal_approx(state.reputation, 3.0):
        _fail("Level 1 compliance reputation reward regressed.")
        return
    if not is_equal_approx(state.heat, 16.0):
        _fail("Level 1 compliance heat delta regressed.")
        return

    state.reputation = 6.0
    state.influence = 8.0
    state.heat = 45.0
    if not state.advance_compliance():
        _fail("Level 2 compliance transition failed.")
        return
    if state.compliance_level != 2 or state.cash != 840:
        _fail("Level 2 compliance state or cost regressed.")
        return

    state.reputation = 12.0
    state.influence = 14.0
    state.heat = 31.0
    if state.advance_compliance():
        _fail("Level 3 compliance ignored the heat gate.")
        return
    if state.compliance_level != 2:
        _fail("Failed level 3 gate mutated compliance state.")
        return

    state.heat = 30.0
    if not state.advance_compliance():
        _fail("Level 3 compliance transition failed.")
        return
    if state.compliance_level != 3:
        _fail("Level 3 compliance state regressed.")
        return
    if state.cash != 680:
        _fail("Level 3 compliance cash cost regressed.")
        return
    if not is_equal_approx(state.reputation, 15.0):
        _fail("Level 3 compliance reputation reward regressed.")
        return
    if not is_equal_approx(state.heat, 22.0):
        _fail("Level 3 compliance heat delta regressed.")
        return

    if state.advance_compliance():
        _fail("Compliance advanced beyond the maximum level.")
        return
    if str(state.rng.state) != rng_before:
        _fail("Compliance progression consumed RNG state.")
        return

    var requirement := state.compliance_requirement()
    if not requirement.is_empty():
        _fail("Max compliance still exposed a next requirement.")
        return

    print("COMPLIANCE PROGRESSION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
