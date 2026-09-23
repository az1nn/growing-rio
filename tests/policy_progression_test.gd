extends SceneTree

const TEST_SEED := 230923
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()

    var rng_before := str(state.rng.state)
    if state.policy_count() != 3:
        _fail("Canonical policy catalog is incomplete.")
        return
    if not state.available_policy_ids().is_empty():
        _fail("Policy became available before its compliance gate.")
        return
    if state.enact_policy("unknown_policy"):
        _fail("Unknown policy was accepted.")
        return

    state.compliance_level = 1
    if state.available_policy_ids() != ["policy_participatory_registry"]:
        _fail("Level 0 policy availability regressed.")
        return

    state.cash = 1000
    state.influence = 3.0
    if state.enact_policy("policy_participatory_registry"):
        _fail("Policy ignored its influence gate.")
        return
    if state.institution_level != 0 or not state.enacted_policy_ids.is_empty():
        _fail("Failed policy gate mutated institutional state.")
        return

    state.influence = 20.0
    if not state.enact_policy("policy_participatory_registry"):
        _fail("First institutional policy transition failed.")
        return
    if state.institution_level != 1:
        _fail("Institution level 1 transition regressed.")
        return
    if state.enacted_policy_ids != ["policy_participatory_registry"]:
        _fail("First enacted policy ID regressed.")
        return
    if state.cash != 975 or not is_equal_approx(state.influence, 16.0):
        _fail("First policy costs regressed.")
        return
    if not is_equal_approx(state.reputation, 2.0):
        _fail("First policy reputation effect regressed.")
        return
    if not is_equal_approx(state.heat, 3.0):
        _fail("First policy heat effect regressed.")
        return

    if not state.available_policy_ids().is_empty():
        _fail("Second policy ignored its compliance gate.")
        return
    state.compliance_level = 2
    if state.available_policy_ids() != ["policy_local_market_charter"]:
        _fail("Level 1 policy availability regressed.")
        return
    if not state.enact_policy("policy_local_market_charter"):
        _fail("Second institutional policy transition failed.")
        return
    if state.institution_level != 2:
        _fail("Institution level 2 transition regressed.")
        return

    state.compliance_level = 3
    if state.available_policy_ids() != ["policy_bay_civic_compact"]:
        _fail("Level 2 policy availability regressed.")
        return
    if not state.enact_policy("policy_bay_civic_compact"):
        _fail("Third institutional policy transition failed.")
        return
    if state.institution_level != 3 or state.enacted_policy_ids.size() != 3:
        _fail("Maximum institutional progression regressed.")
        return
    if not state.available_policy_ids().is_empty():
        _fail("Maximum institutional level still exposes proposals.")
        return
    if state.enact_policy("policy_bay_civic_compact"):
        _fail("Policy progression advanced beyond the maximum.")
        return
    if str(state.rng.state) != rng_before:
        _fail("Policy progression consumed RNG state.")
        return

    print("POLICY PROGRESSION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
