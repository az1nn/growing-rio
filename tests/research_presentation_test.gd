extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const MAIN_SCENE := preload("res://scenes/main/main.tscn")
const EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const CHOICE_ID := "choice_dalva_lucia_parallel_versions"
const FIRST_RESEARCH_STEP_ID := "research_onda_evidence_catalog"
const SECOND_RESEARCH_STEP_ID := "research_symbol_order_comparison"

var game_state

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)
    game_state.reset()
    game_state.set_simulation_seed(424242)

    if not game_state.complete_narrative_arc("arc_o_quarto"):
        _fail("Could not complete the canonical prerequisite arc.")
        return
    for flag_id in [
        "contact_char_dalva",
        "introduced_char_lucia",
        "memory_onda_can_received",
    ]:
        if not game_state.set_narrative_flag(flag_id):
            _fail("Could not set canonical prerequisite flag: %s" % flag_id)
            return

    var event_result: Dictionary = game_state.resolve_narrative_choice(EVENT_ID, CHOICE_ID)
    if not bool(event_result.get("changed", false)):
        _fail("Could not resolve the canonical narrative evidence gate.")
        return

    var first_presentation: Dictionary = game_state.research_step_presentation(
        FIRST_RESEARCH_STEP_ID
    )
    if String(first_presentation.get("display_name", "")).is_empty():
        _fail("GameState did not expose display-safe research metadata.")
        return

    var main := MAIN_SCENE.instantiate()
    root.add_child(main)
    await process_frame

    var actions: VBoxContainer = main.get_node("%ResearchActions")
    var result: Label = main.get_node("%ResearchResult")
    if actions.get_child_count() != 1:
        _fail("Research UI did not render exactly the first canonical available step.")
        return

    var first_button := actions.get_child(0) as Button
    if first_button == null:
        _fail("First research action is not a Button.")
        return
    if first_button.text != String(first_presentation.get("display_name", "")):
        _fail("Research action label did not come from canonical presentation metadata.")
        return

    var rng_before: int = game_state.rng.state
    first_button.pressed.emit()
    await process_frame

    if game_state.rng.state != rng_before:
        _fail("Research UI completion consumed simulation RNG.")
        return
    if not bool(
        game_state.narrative_flags.get("research_onda_evidence_catalogued", false)
    ):
        _fail("Research UI did not complete the first canonical research step.")
        return
    if game_state.available_research_step_ids() != [SECOND_RESEARCH_STEP_ID]:
        _fail("Research UI did not refresh to the second canonical step.")
        return
    if actions.get_child_count() != 1:
        _fail("Research UI did not replace the completed step with the next step.")
        return
    if result.text.find("proveniência não autenticada") == -1:
        _fail("Research result did not present semantic evidence.")
        return
    if result.text.find("incerteza permanece registrada") == -1:
        _fail("Research result lost the uncertainty guardrail.")
        return
    if result.text.find("linhagem histórica ou genética") == -1:
        _fail("Research result lost the historical-lineage guardrail.")
        return

    main._on_research_step_pressed(FIRST_RESEARCH_STEP_ID)
    await process_frame
    if result.text.find("indisponível") == -1:
        _fail("Stale research action did not fail safely through the UI boundary.")
        return
    if game_state.available_research_step_ids() != [SECOND_RESEARCH_STEP_ID]:
        _fail("Stale research action corrupted canonical availability.")
        return

    var second_button := actions.get_child(0) as Button
    if second_button == null:
        _fail("Second research action is not a Button.")
        return
    var second_presentation: Dictionary = game_state.research_step_presentation(
        SECOND_RESEARCH_STEP_ID
    )
    if second_button.text != String(second_presentation.get("display_name", "")):
        _fail("Second research action label is not canonical presentation metadata.")
        return

    rng_before = game_state.rng.state
    second_button.pressed.emit()
    await process_frame

    if game_state.rng.state != rng_before:
        _fail("Second research UI completion consumed simulation RNG.")
        return
    if not bool(
        game_state.narrative_flags.get("research_symbol_order_compared", false)
    ):
        _fail("Research UI did not complete the second canonical research step.")
        return
    if not game_state.available_research_step_ids().is_empty():
        _fail("Completed research remained canonically available.")
        return
    if actions.get_child_count() != 0:
        _fail("Completed research remained actionable in the presentation.")
        return
    if result.text.find("ordem dos símbolos permanece em aberto") == -1:
        _fail("Presentation resolved the protected symbol-order uncertainty.")
        return

    print("RESEARCH PRESENTATION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
