extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const CHOICE_ID := "choice_dalva_lucia_parallel_versions"
const RESEARCH_STEP_ID := "research_onda_evidence_catalog"

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.reset()

    if state.research_step_count() != 1:
        _fail("GameState did not expose the canonical research catalog.")
        return
    if not state.available_research_step_ids().is_empty():
        _fail("Research became available before the narrative evidence gate.")
        return

    if not state.complete_narrative_arc("arc_o_quarto"):
        _fail("Could not complete the canonical prerequisite arc.")
        return
    for flag_id in [
        "contact_char_dalva",
        "introduced_char_lucia",
        "memory_onda_can_received",
    ]:
        if not state.set_narrative_flag(flag_id):
            _fail("Canonical prerequisite flag was rejected: %s" % flag_id)
            return

    var event_result := state.resolve_narrative_choice(EVENT_ID, CHOICE_ID)
    if not bool(event_result.get("changed", false)):
        _fail("The prerequisite narrative event did not resolve.")
        return

    if state.available_research_step_ids() != [RESEARCH_STEP_ID]:
        _fail("Onda research did not unlock after the canonical event.")
        return

    var rng_before := state.rng.state
    var research_result := state.complete_research_step(RESEARCH_STEP_ID)
    if not bool(research_result.get("changed", false)):
        _fail("Canonical research step did not resolve.")
        return
    if state.rng.state != rng_before:
        _fail("Research resolution consumed simulation RNG.")
        return

    for flag_id in [
        "research_da_lata_chain_started",
        "research_onda_evidence_catalogued",
    ]:
        if not bool(state.narrative_flags.get(flag_id, false)):
            _fail("Research completion flag was not persisted: %s" % flag_id)
            return

    if not research_result.get("canon_guardrails", []).has(
        "research_does_not_authenticate_historical_lineage"
    ):
        _fail("Research result lost the historical-lineage guardrail.")
        return

    if not state.available_research_step_ids().is_empty():
        _fail("Completed research remained available.")
        return

    var repeated := state.complete_research_step(RESEARCH_STEP_ID)
    if bool(repeated.get("changed", false)):
        _fail("Completed research was resolved twice.")
        return

    var unknown := state.complete_research_step("research_unknown")
    if bool(unknown.get("changed", false)):
        _fail("Unknown research step mutated campaign state.")
        return

    var save_data: Dictionary = state.create_save_data()
    if int(save_data.get("schema_version", -1)) != 10:
        _fail("Research slice unexpectedly changed the save schema.")
        return

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(save_data):
        _fail("Research campaign save did not round-trip.")
        return
    if not bool(restored.narrative_flags.get(
        "research_onda_evidence_catalogued",
        false,
    )):
        _fail("Research completion did not survive save v10 round-trip.")
        return
    if not restored.available_research_step_ids().is_empty():
        _fail("Restored completed research became available again.")
        return

    print("RESEARCH CHAIN TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
