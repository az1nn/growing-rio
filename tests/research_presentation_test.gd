extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const ARCHIVE_SCENE := preload("res://scenes/archive/archive_surface.tscn")
const EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const CHOICE_ID := "choice_dalva_lucia_parallel_versions"
const FIRST_RESEARCH_STEP_ID := "research_onda_evidence_catalog"
const SECOND_RESEARCH_STEP_ID := "research_symbol_order_comparison"
const THIRD_RESEARCH_STEP_ID := "research_onda_provenance_gap_map"
const FOURTH_RESEARCH_STEP_ID := "research_evidence_boundary_synthesis"
const FIFTH_RESEARCH_STEP_ID := "research_material_compatibility_review"

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

    var archive := ARCHIVE_SCENE.instantiate()
    root.add_child(archive)
    await process_frame

    var actions: VBoxContainer = archive.get_node("%ResearchActions")
    var result: Label = archive.get_node("%ResearchResult")
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

    archive._on_research_step_pressed(FIRST_RESEARCH_STEP_ID)
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
    if result.text.find("ordem dos símbolos permanece em aberto") == -1:
        _fail("Presentation resolved the protected symbol-order uncertainty.")
        return
    if game_state.available_research_step_ids() != [THIRD_RESEARCH_STEP_ID]:
        _fail("Research UI did not refresh to the third provenance step.")
        return
    if actions.get_child_count() != 1:
        _fail("Research UI did not replace the second step with the third step.")
        return

    var third_button := actions.get_child(0) as Button
    if third_button == null:
        _fail("Third research action is not a Button.")
        return
    var third_presentation: Dictionary = game_state.research_step_presentation(
        THIRD_RESEARCH_STEP_ID
    )
    if third_button.text != String(third_presentation.get("display_name", "")):
        _fail("Third research action label is not canonical presentation metadata.")
        return

    rng_before = game_state.rng.state
    third_button.pressed.emit()
    await process_frame

    if game_state.rng.state != rng_before:
        _fail("Third research UI completion consumed simulation RNG.")
        return
    if not bool(
        game_state.narrative_flags.get("research_onda_provenance_gaps_mapped", false)
    ):
        _fail("Research UI did not complete the provenance-gap step.")
        return
    if game_state.available_research_step_ids() != [FOURTH_RESEARCH_STEP_ID]:
        _fail("Research UI did not refresh to the fourth evidence-boundary step.")
        return
    if actions.get_child_count() != 1:
        _fail("Research UI did not replace the third step with the fourth step.")
        return
    if result.text.find("lacunas de cadeia de custódia registradas") == -1:
        _fail("Provenance result did not present the evidence gap.")
        return
    if result.text.find("procedência da lata Onda permanece em aberto") == -1:
        _fail("Presentation authenticated the protected Onda provenance.")
        return
    if result.text.find("linhagem histórica ou genética") == -1:
        _fail("Provenance result lost the historical-lineage guardrail.")
        return

    var fourth_button := actions.get_child(0) as Button
    if fourth_button == null:
        _fail("Fourth research action is not a Button.")
        return
    var fourth_presentation: Dictionary = game_state.research_step_presentation(
        FOURTH_RESEARCH_STEP_ID
    )
    if fourth_button.text != String(fourth_presentation.get("display_name", "")):
        _fail("Fourth research action label is not canonical presentation metadata.")
        return

    rng_before = game_state.rng.state
    fourth_button.pressed.emit()
    await process_frame

    if game_state.rng.state != rng_before:
        _fail("Fourth research UI completion consumed simulation RNG.")
        return
    if not bool(
        game_state.narrative_flags.get("research_evidence_boundaries_synthesized", false)
    ):
        _fail("Research UI did not complete the evidence-boundary synthesis step.")
        return
    if not game_state.available_research_step_ids().is_empty():
        _fail("Fifth research step became available before Act IV evidence.")
        return
    if actions.get_child_count() != 0:
        _fail("Research UI exposed the fifth step before Act IV evidence.")
        return
    for expected_text in [
        "proveniência não autenticada",
        "ordem dos símbolos disputada",
        "procedência da lata Onda permanece em aberto",
        "ordem dos símbolos permanece em aberto",
        "linhagem histórica ou genética",
        "incerteza permanece registrada",
    ]:
        if result.text.find(expected_text) == -1:
            _fail("Evidence-boundary result lost protected presentation text: %s" % expected_text)
            return

    for flag_id in [
        "lore_material_origin_compatibility_established",
        "lore_star_mark_revealed",
    ]:
        if not game_state.set_narrative_flag(flag_id):
            _fail("Could not set canonical Act IV evidence flag: %s" % flag_id)
            return
        await process_frame
        if actions.get_child_count() != 0:
            _fail("Research UI exposed the fifth step before all Act IV evidence existed.")
            return

    if not game_state.set_narrative_flag("lore_original_lineage_still_unproven"):
        _fail("Could not set canonical Act IV lineage guardrail flag.")
        return
    await process_frame
    if game_state.available_research_step_ids() != [FIFTH_RESEARCH_STEP_ID]:
        _fail("Canonical state did not expose the fifth research step after Act IV evidence.")
        return
    if actions.get_child_count() != 1:
        _fail("Research UI did not render the fifth canonical step after Act IV evidence.")
        return

    var fifth_button := actions.get_child(0) as Button
    if fifth_button == null:
        _fail("Fifth research action is not a Button.")
        return
    var fifth_presentation: Dictionary = game_state.research_step_presentation(
        FIFTH_RESEARCH_STEP_ID
    )
    if fifth_button.text != String(fifth_presentation.get("display_name", "")):
        _fail("Fifth research action label is not canonical presentation metadata.")
        return

    rng_before = game_state.rng.state
    fifth_button.pressed.emit()
    await process_frame

    if game_state.rng.state != rng_before:
        _fail("Fifth research UI completion consumed simulation RNG.")
        return
    if not bool(
        game_state.narrative_flags.get("research_material_compatibility_reviewed", false)
    ):
        _fail("Research UI did not complete the material-compatibility review.")
        return
    if not game_state.available_research_step_ids().is_empty():
        _fail("Completed five-step research chain remained canonically available.")
        return
    if actions.get_child_count() != 0:
        _fail("Completed five-step research chain remained actionable.")
        return
    for expected_text in [
        "compatibilidade material limitada estabelecida",
        "compatibilidade material não prova linhagem",
        "procedência da lata Onda permanece em aberto",
        "ordem dos símbolos permanece em aberto",
        "linhagem histórica ou genética",
        "incerteza permanece registrada",
    ]:
        if result.text.find(expected_text) == -1:
            _fail("Material-compatibility result lost protected presentation text: %s" % expected_text)
            return

    print("RESEARCH PRESENTATION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
