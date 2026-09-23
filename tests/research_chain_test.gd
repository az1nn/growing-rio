extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const CHOICE_ID := "choice_dalva_lucia_parallel_versions"
const FIRST_RESEARCH_STEP_ID := "research_onda_evidence_catalog"
const SECOND_RESEARCH_STEP_ID := "research_symbol_order_comparison"

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.reset()

    if state.research_step_count() != 2:
        _fail("GameState did not expose the two-step canonical research chain.")
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

    if state.available_research_step_ids() != [FIRST_RESEARCH_STEP_ID]:
        _fail("Only the first Onda research step should unlock after the canonical event.")
        return

    var premature_second := state.complete_research_step(SECOND_RESEARCH_STEP_ID)
    if bool(premature_second.get("changed", false)):
        _fail("Second research step bypassed ordered progression.")
        return

    var rng_before := state.rng.state
    var first_result := state.complete_research_step(FIRST_RESEARCH_STEP_ID)
    if not bool(first_result.get("changed", false)):
        _fail("First canonical research step did not resolve.")
        return
    if state.rng.state != rng_before:
        _fail("First research resolution consumed simulation RNG.")
        return

    for flag_id in [
        "research_da_lata_chain_started",
        "research_onda_evidence_catalogued",
    ]:
        if not bool(state.narrative_flags.get(flag_id, false)):
            _fail("First research completion flag was not persisted: %s" % flag_id)
            return

    if state.available_research_step_ids() != [SECOND_RESEARCH_STEP_ID]:
        _fail("Second research step did not unlock after persisted first-step evidence.")
        return

    rng_before = state.rng.state
    var second_result := state.complete_research_step(SECOND_RESEARCH_STEP_ID)
    if not bool(second_result.get("changed", false)):
        _fail("Second canonical research step did not resolve.")
        return
    if state.rng.state != rng_before:
        _fail("Second research resolution consumed simulation RNG.")
        return
    if not bool(state.narrative_flags.get("research_symbol_order_compared", false)):
        _fail("Second research completion flag was not persisted.")
        return
    if not second_result.get("canon_guardrails", []).has("symbol_order_remains_open"):
        _fail("Second research step resolved the protected symbol-order uncertainty.")
        return
    if not second_result.get("canon_guardrails", []).has(
        "research_does_not_authenticate_historical_lineage"
    ):
        _fail("Research result lost the historical-lineage guardrail.")
        return

    if not state.available_research_step_ids().is_empty():
        _fail("Completed research chain remained available.")
        return

    for completed_step_id in [FIRST_RESEARCH_STEP_ID, SECOND_RESEARCH_STEP_ID]:
        var repeated := state.complete_research_step(completed_step_id)
        if bool(repeated.get("changed", false)):
            _fail("Completed research was resolved twice: %s" % completed_step_id)
            return

    var unknown := state.complete_research_step("research_unknown")
    if bool(unknown.get("changed", false)):
        _fail("Unknown research step mutated campaign state.")
        return

    var save_data: Dictionary = state.create_save_data()
    if int(save_data.get("schema_version", -1)) != 10:
        _fail("Research chain unexpectedly changed the save schema.")
        return

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(save_data):
        _fail("Research campaign save did not round-trip.")
        return
    for flag_id in [
        "research_onda_evidence_catalogued",
        "research_symbol_order_compared",
    ]:
        if not bool(restored.narrative_flags.get(flag_id, false)):
            _fail("Research completion did not survive save v10 round-trip: %s" % flag_id)
            return
    if restored.research_step_count() != 2:
        _fail("Restored state lost the canonical research catalog.")
        return
    if not restored.available_research_step_ids().is_empty():
        _fail("Restored completed research became available again.")
        return

    print("RESEARCH CHAIN TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
