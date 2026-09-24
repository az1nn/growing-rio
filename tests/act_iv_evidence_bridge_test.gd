extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const NARRATIVE_SERVICE_SCRIPT := preload("res://domain/events/narrative_event_service.gd")

const FIRST_EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const SOL_EVENT_ID := "event_act_ii_sol_photo_reveal"
const FAROL_EVENT_ID := "event_bento_fita_farol"
const INVITE_EVENT_ID := "event_act_iii_council_invitation"
const ISA_EVENT_ID := "event_isa_mesa_sem_palco"
const FERRUGEM_EVENT_ID := "event_leilao_ferrugem"
const MEMORY_EVENT_ID := "event_ferrugem_quem_assina_memoria"
const AUDIENCE_EVENT_ID := "event_audiencia_periodo_verde"
const STAR_EVENT_ID := "event_foto_estrela"
const ACT_V_OPENING_EVENT_ID := "event_reconstrucao_sem_original"

const EARLY_RESEARCH_IDS := [
    "research_onda_evidence_catalog",
    "research_symbol_order_comparison",
    "research_onda_provenance_gap_map",
    "research_evidence_boundary_synthesis",
]
const FIFTH_RESEARCH_ID := "research_material_compatibility_review"

const SPINE_EVENTS := [
    preload("res://resources/events/act_ii_sol_photo_reveal.tres"),
    preload("res://resources/events/bento_fita_farol.tres"),
    preload("res://resources/events/act_iii_council_invitation.tres"),
    preload("res://resources/events/isa_mesa_sem_palco.tres"),
    preload("res://resources/events/leilao_ferrugem.tres"),
    preload("res://resources/events/ferrugem_quem_assina_memoria.tres"),
    preload("res://resources/events/audiencia_periodo_verde.tres"),
    preload("res://resources/events/foto_estrela.tres"),
]

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var service := NARRATIVE_SERVICE_SCRIPT.new()
    for definition in SPINE_EVENTS:
        if not service.is_valid_definition(definition):
            _fail("Invalid campaign-spine Resource: %s" % String(definition.id))
            return

    for route in ["licensed", "parallel"]:
        if not _run_route(route):
            return

    print("ACT IV EVIDENCE BRIDGE TEST PASSED")
    quit(0)

func _run_route(route: String) -> bool:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(1337 if route == "licensed" else 7331)
    state.reset()

    if not _complete_cycle_and_sell(state, route):
        return false
    if state.available_narrative_event_ids() != [FIRST_EVENT_ID]:
        _fail("%s route did not naturally unlock the first narrative event." % route)
        return false
    if not _resolve_event(
        state,
        FIRST_EVENT_ID,
        "choice_dalva_lucia_parallel_versions",
    ):
        return false

    for step_id in EARLY_RESEARCH_IDS:
        if state.available_research_step_ids() != [step_id]:
            _fail("%s route did not expose expected research step: %s" % [route, step_id])
            return false
        var rng_before: int = int(state.rng.state)
        var research_result: Dictionary = state.complete_research_step(step_id)
        if not bool(research_result.get("changed", false)):
            _fail("%s route could not complete research step: %s" % [route, step_id])
            return false
        if state.rng.state != rng_before:
            _fail("Research consumed simulation RNG: %s" % step_id)
            return false

    if state.available_narrative_event_ids() != [SOL_EVENT_ID]:
        _fail("%s route did not naturally unlock the Ato II Sol closing beat." % route)
        return false
    if not _resolve_event(state, SOL_EVENT_ID, "choice_sol_record_photo"):
        return false
    if not state.completed_arc_ids.has("arc_o_negocio"):
        _fail("Sol closing beat did not complete arc_o_negocio.")
        return false

    if state.available_narrative_event_ids() != [FAROL_EVENT_ID]:
        _fail("%s route did not unlock Fita do Farol." % route)
        return false
    if not _resolve_event(state, FAROL_EVENT_ID, "choice_farol_aurora_first"):
        return false

    if not state.available_narrative_event_ids().is_empty():
        _fail("Conselho invitation unlocked before the business-scale milestone.")
        return false
    if not _complete_cycle_and_sell(state, route):
        return false
    if not bool(state.narrative_flags.get("campaign_business_scale_reached", false)):
        _fail("%s route did not establish abstract business scale on the second sale." % route)
        return false
    if state.available_narrative_event_ids() != [INVITE_EVENT_ID]:
        _fail("%s route did not unlock the Conselho invitation." % route)
        return false
    if not _resolve_event(
        state,
        INVITE_EVENT_ID,
        "choice_council_receive_invitation",
    ):
        return false
    if not state.completed_arc_ids.has("arc_dois_mercados"):
        _fail("Conselho invitation did not complete arc_dois_mercados.")
        return false

    state.civic_engagement()
    if not bool(
        state.narrative_flags.get("campaign_council_participation_ready", false)
    ):
        _fail("%s route could not reach the fictional council participation gate." % route)
        return false

    if not _expect_and_resolve(
        state,
        ISA_EVENT_ID,
        "choice_isa_disclose_tradeoffs",
    ):
        return false
    if not _expect_and_resolve(
        state,
        FERRUGEM_EVENT_ID,
        "choice_ferrugem_shared_custody",
    ):
        return false
    if not _expect_and_resolve(
        state,
        MEMORY_EVENT_ID,
        "choice_memory_competing_annotations",
    ):
        return false
    if not _expect_and_resolve(
        state,
        AUDIENCE_EVENT_ID,
        "choice_audiencia_adaptive_review",
    ):
        return false
    if not _expect_and_resolve(
        state,
        STAR_EVENT_ID,
        "choice_star_publish_technical_limits",
    ):
        return false

    for flag_id in [
        "lore_material_origin_compatibility_established",
        "lore_star_mark_revealed",
        "lore_original_lineage_still_unproven",
    ]:
        if not bool(state.narrative_flags.get(flag_id, false)):
            _fail("Ato IV closing beat lost canonical evidence flag: %s" % flag_id)
            return false

    if not state.completed_arc_ids.has("arc_o_sistema"):
        _fail("A Estrela no Verso did not close arc_o_sistema.")
        return false
    if state.available_research_step_ids() != [FIFTH_RESEARCH_ID]:
        _fail("%s route did not naturally unlock the fifth research step." % route)
        return false

    var rng_before: int = int(state.rng.state)
    var final_research: Dictionary = state.complete_research_step(FIFTH_RESEARCH_ID)
    if not bool(final_research.get("changed", false)):
        _fail("%s route could not complete the fifth research step." % route)
        return false
    if state.rng.state != rng_before:
        _fail("Fifth research step consumed simulation RNG.")
        return false
    if not bool(
        state.narrative_flags.get("research_material_compatibility_reviewed", false)
    ):
        _fail("Fifth research completion flag was not persisted.")
        return false

    for guardrail in [
        "material_compatibility_does_not_prove_lineage",
        "onda_can_provenance_remains_open",
        "symbol_order_remains_open",
        "research_does_not_authenticate_historical_lineage",
    ]:
        if not Array(final_research.get("canon_guardrails", [])).has(guardrail):
            _fail("Final research lost protected guardrail: %s" % guardrail)
            return false

    var save_data: Dictionary = state.create_save_data()
    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(save_data):
        _fail("%s route final schema-v11 campaign state failed to restore." % route)
        return false
    if restored.completed_arc_ids != state.completed_arc_ids:
        _fail("Campaign arcs changed after save round-trip.")
        return false
    if restored.completed_event_ids != state.completed_event_ids:
        _fail("Campaign events changed after save round-trip.")
        return false
    if restored.narrative_flags != state.narrative_flags:
        _fail("Campaign flags changed after save round-trip.")
        return false
    if restored.available_narrative_event_ids() != [ACT_V_OPENING_EVENT_ID]:
        _fail("Completed Ato IV evidence path did not hand off to the Ato V opening.")
        return false
    if not restored.available_research_step_ids().is_empty():
        _fail("Completed fifth research step reopened after save round-trip.")
        return false

    return true

func _expect_and_resolve(
    state: Node,
    event_id: String,
    choice_id: String,
) -> bool:
    if state.available_narrative_event_ids() != [event_id]:
        _fail("Expected canonical event was not uniquely available: %s" % event_id)
        return false
    return _resolve_event(state, event_id, choice_id)

func _resolve_event(state: Node, event_id: String, choice_id: String) -> bool:
    var rng_before: int = int(state.rng.state)
    var result: Dictionary = state.resolve_narrative_choice(event_id, choice_id)
    if not bool(result.get("changed", false)):
        _fail("Canonical event could not resolve: %s" % event_id)
        return false
    if state.rng.state != rng_before:
        _fail("Narrative event consumed simulation RNG: %s" % event_id)
        return false
    return true

func _complete_cycle_and_sell(state: Node, route: String) -> bool:
    for index in range(state.current_cycle_days()):
        if index % 2 == 0:
            state.care_for_room()
        state.next_day()

    state.harvest()
    if state.inventory <= 0:
        _fail("%s route did not produce inventory for a completed sale." % route)
        return false

    if route == "licensed":
        state.sell_legal()
    elif route == "parallel":
        state.sell_parallel()
    else:
        _fail("Unknown route: %s" % route)
        return false

    if state.inventory != 0:
        _fail("%s route did not complete the sale." % route)
        return false
    return true

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
