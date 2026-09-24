extends SceneTree

const TEST_SEED := 230923
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const INSTITUTIONAL_SCENE := preload(
    "res://scenes/institutional/institutional_surface.tscn"
)

var state

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    state = root.get_node_or_null("GameState")
    if state == null:
        state = GAME_STATE_SCRIPT.new()
        state.name = "GameState"
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

    var initial_snapshot: Dictionary = state.institutional_snapshot()
    var initial_policies: Array = Array(initial_snapshot.get("policies", []))
    if initial_policies.size() != 3:
        _fail("Institutional snapshot did not expose the canonical policy catalog.")
        return
    if String(Dictionary(initial_policies[0]).get("state", "")) != "unavailable":
        _fail("Institutional snapshot did not expose the blocked first proposal.")
        return
    if "Conformidade insuficiente" not in String(
        Dictionary(initial_policies[0]).get("message", "")
    ):
        _fail("Blocked policy reason diverged from PolicyService.")
        return

    var surface := INSTITUTIONAL_SCENE.instantiate()
    root.add_child(surface)
    await process_frame

    if surface.get_node("%PolicySelect").item_count != 3:
        _fail("Institutional surface did not render the canonical policy catalog.")
        return
    if not surface.get_node("%PolicyEnactButton").disabled:
        _fail("Institutional surface enabled a blocked policy.")
        return
    if "sem ranking" not in _scene_text(surface).to_lower():
        _fail("Institutional surface does not state the neutral presentation boundary.")
        return

    _prepare_first_policy_available()
    await process_frame

    var available_snapshot: Dictionary = state.institutional_snapshot()
    var available_policies: Array = Array(
        available_snapshot.get("policies", [])
    )
    var first_policy: Dictionary = Dictionary(available_policies[0])
    if String(first_policy.get("state", "")) != "available":
        _fail("Eligible first policy was not presented as available.")
        return
    if surface.get_node("%PolicyEnactButton").disabled:
        _fail("Institutional surface kept an eligible policy disabled.")
        return
    if "Registro Cívico Participativo" not in (
        surface.get_node("%PolicyStateLabel").text
    ):
        _fail("Institutional surface did not expose the selected policy.")
        return

    var policy_rng_before := str(state.rng.state)
    surface._on_policy_enact_pressed()
    await process_frame
    if state.institution_level != 1:
        _fail("Institutional surface did not reach canonical policy enactment.")
        return
    if state.enacted_policy_ids != ["policy_participatory_registry"]:
        _fail("Institutional surface enacted the wrong canonical policy.")
        return
    if str(state.rng.state) != policy_rng_before:
        _fail("Institutional surface policy enactment consumed RNG state.")
        return
    if "nível 1 / 3" not in surface.get_node("%InstitutionLevelLabel").text:
        _fail("Institutional level presentation did not refresh.")
        return

    var through_surface: Dictionary = state.create_save_data().duplicate(true)
    _prepare_first_policy_available()
    if not state.enact_policy("policy_participatory_registry"):
        _fail("Direct canonical policy comparison failed.")
        return
    var direct_policy: Dictionary = state.create_save_data().duplicate(true)
    if through_surface != direct_policy:
        _fail("Policy surface transition diverged from direct GameState command.")
        return

    _prepare_civic_engagement()
    await process_frame
    var civic_rng_before := str(state.rng.state)
    surface._on_civic_engagement_pressed()
    await process_frame
    if state.cash != 170 or not is_equal_approx(state.influence, 4.0):
        _fail("Institutional participation did not use canonical GameState effects.")
        return
    if not is_equal_approx(state.reputation, 2.0):
        _fail("Institutional participation reputation effect regressed.")
        return
    if str(state.rng.state) != civic_rng_before:
        _fail("Institutional participation consumed RNG state.")
        return
    var civic_surface: Dictionary = state.create_save_data().duplicate(true)

    _prepare_civic_engagement()
    if not state.civic_engagement():
        _fail("Direct canonical civic participation comparison failed.")
        return
    var civic_direct: Dictionary = state.create_save_data().duplicate(true)
    if civic_surface != civic_direct:
        _fail("Civic surface transition diverged from direct GameState command.")
        return

    state.reset()
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

    var lower_scene_text := _scene_text(surface).to_lower()
    if "sem ranking, recomendação ou opção preferida" not in lower_scene_text:
        _fail("Institutional surface does not state its neutral policy boundary.")
        return
    for disallowed in [
        "melhor proposta",
        "política correta",
        "recomendamos esta",
        "vote em",
        "candidato real",
        "partido real",
        "eleição real",
    ]:
        if disallowed in lower_scene_text:
            _fail("Institutional surface crossed its neutral fictional boundary.")
            return

    if str(state.rng.state) != rng_before:
        _fail("Policy progression consumed RNG state.")
        return

    print("POLICY PROGRESSION TEST PASSED")
    quit(0)

func _prepare_first_policy_available() -> void:
    state.set_simulation_seed(TEST_SEED)
    state.reset()
    state.compliance_level = 1
    state.cash = 1000
    state.influence = 20.0
    state.state_changed.emit()

func _prepare_civic_engagement() -> void:
    state.set_simulation_seed(TEST_SEED)
    state.reset()
    state.cash = 250
    state.influence = 0.0
    state.reputation = 0.0
    state.state_changed.emit()

func _scene_text(node: Node) -> String:
    var text := ""
    if node is Label:
        text += String(node.text) + "\n"
    elif node is Button:
        text += String(node.text) + "\n"
    elif node is OptionButton:
        for index in range(node.item_count):
            text += String(node.get_item_text(index)) + "\n"
    for child in node.get_children():
        text += _scene_text(child)
    return text

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
