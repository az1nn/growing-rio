extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

const FIRST_EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const SOL_EVENT_ID := "event_act_ii_sol_photo_reveal"
const FAROL_EVENT_ID := "event_bento_fita_farol"
const INVITE_EVENT_ID := "event_act_iii_council_invitation"
const ISA_EVENT_ID := "event_isa_mesa_sem_palco"
const FERRUGEM_EVENT_ID := "event_leilao_ferrugem"
const MEMORY_EVENT_ID := "event_ferrugem_quem_assina_memoria"
const AUDIENCE_EVENT_ID := "event_audiencia_periodo_verde"
const STAR_EVENT_ID := "event_foto_estrela"
const RECONSTRUCTION_EVENT_ID := "event_reconstrucao_sem_original"
const CITY_PARTS_EVENT_ID := "event_sete_partes_da_cidade"
const NAME_EVENT_ID := "event_nome_da_lata"
const FINAL_FORM_EVENT_ID := "event_forma_da_lata"

const EARLY_RESEARCH_IDS := [
    "research_onda_evidence_catalog",
    "research_symbol_order_comparison",
    "research_onda_provenance_gap_map",
    "research_evidence_boundary_synthesis",
]
const FINAL_RESEARCH_ID := "research_material_compatibility_review"

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(1414)
    state.reset()
    # This regression owns canonical end-to-end campaign progression, not
    # economy survivability. The 90-day cultivation cycle otherwise trips
    # the independent cash game-over gate before the first harvest.
    state.cash = 100000

    if not _complete_cycle_and_sell(state):
        return
    if not state.completed_arc_ids.has("arc_o_quarto"):
        _fail("Ato I did not close from a normal completed cycle + sale.")
        return
    state = _round_trip(state, "Ato I")
    if state == null:
        return

    if not _expect_and_resolve(
        state,
        FIRST_EVENT_ID,
        "choice_dalva_lucia_parallel_versions",
    ):
        return
    for step_id in EARLY_RESEARCH_IDS:
        if state.available_research_step_ids() != [step_id]:
            _fail("Expected surfaced research step was not uniquely available: %s" % step_id)
            return
        if not bool(state.complete_research_step(step_id).get("changed", false)):
            _fail("Normal research action could not complete: %s" % step_id)
            return

    if not _expect_and_resolve(state, SOL_EVENT_ID, "choice_sol_record_photo"):
        return
    if not state.completed_arc_ids.has("arc_o_negocio"):
        _fail("Ato II did not close through the surfaced narrative/research path.")
        return
    if not _expect_and_resolve(state, FAROL_EVENT_ID, "choice_farol_aurora_first"):
        return

    if not _complete_cycle_and_sell(state):
        return
    if not bool(state.narrative_flags.get("campaign_business_scale_reached", false)):
        _fail("Second successful sale did not establish the business-scale milestone.")
        return
    if not _expect_and_resolve(
        state,
        INVITE_EVENT_ID,
        "choice_council_receive_invitation",
    ):
        return
    if not state.completed_arc_ids.has("arc_dois_mercados"):
        _fail("Ato III did not close through normal market progression.")
        return

    state.civic_engagement()
    if not bool(state.narrative_flags.get("campaign_council_participation_ready", false)):
        _fail("Surfaced civic engagement did not satisfy council participation.")
        return
    state = _round_trip(state, "Ato III")
    if state == null:
        return

    for pair in [
        [ISA_EVENT_ID, "choice_isa_disclose_tradeoffs"],
        [FERRUGEM_EVENT_ID, "choice_ferrugem_shared_custody"],
        [MEMORY_EVENT_ID, "choice_memory_competing_annotations"],
        [AUDIENCE_EVENT_ID, "choice_audiencia_adaptive_review"],
        [STAR_EVENT_ID, "choice_star_publish_technical_limits"],
    ]:
        if not _expect_and_resolve(state, String(pair[0]), String(pair[1])):
            return

    if not state.completed_arc_ids.has("arc_o_sistema"):
        _fail("Ato IV did not close through the canonical Archive narrative chain.")
        return
    if state.available_research_step_ids() != [FINAL_RESEARCH_ID]:
        _fail("Ato IV did not expose the material compatibility review.")
        return
    if not bool(state.complete_research_step(FINAL_RESEARCH_ID).get("changed", false)):
        _fail("Material compatibility review could not complete normally.")
        return

    state = _round_trip(state, "Ato IV")
    if state == null:
        return

    for pair in [
        [RECONSTRUCTION_EVENT_ID, "choice_reconstruction_public_uncertainty"],
        [CITY_PARTS_EVENT_ID, "choice_city_contributions_attributed"],
        [NAME_EVENT_ID, "choice_name_evidence_forward"],
        [FINAL_FORM_EVENT_ID, "choice_final_form_fragmentary_origin_clause"],
    ]:
        if not _expect_and_resolve(state, String(pair[0]), String(pair[1])):
            return

    if not bool(state.narrative_flags.get("lore_final_form_debate_seen", false)):
        _fail("Natural Ato V path did not reach the final-form debate.")
        return
    if state.completed_arc_ids.has("arc_da_lata"):
        _fail("RB-14 baseline unexpectedly completed the finale arc.")
        return

    var eligible_before_save: Array = state.eligible_ending_ids()
    if eligible_before_save.is_empty():
        _fail(
            "Natural surfaced play reached pre-finale but produced no eligible ending; "
            + "this is a proven progression mismatch."
        )
        return

    state = _round_trip(state, "pre-finale")
    if state == null:
        return
    if state.eligible_ending_ids() != eligible_before_save:
        _fail("Derived ending eligibility changed across pre-finale save/load.")
        return

    var selected_id := String(eligible_before_save[0])
    var selected: Dictionary = state.select_ending(selected_id)
    if not bool(selected.get("changed", false)):
        _fail("A naturally eligible ending could not be selected through canonical state.")
        return
    if state.selected_ending_id != selected_id:
        _fail("Canonical ending selection was not persisted in memory.")
        return

    state = _round_trip(state, "ending selection")
    if state == null:
        return
    if state.selected_ending_id != selected_id:
        _fail("Ending selection changed across save/load.")
        return
    if state.completed_arc_ids.has("arc_da_lata"):
        _fail("Feature 008/RB-14 crossed the RB-15 finale boundary.")
        return

    print("CAMPAIGN REVALIDATION TEST PASSED")
    print("eligible=", eligible_before_save)
    print("selected=", selected_id)
    quit(0)

func _complete_cycle_and_sell(state: Node) -> bool:
    for index in range(state.current_cycle_days()):
        if index % 2 == 0:
            state.care_for_room()
        state.next_day()
    state.harvest()
    if state.inventory <= 0:
        _fail("Normal Operation play did not produce inventory.")
        return false
    state.sell_legal()
    if state.inventory != 0:
        _fail("Normal Market sale did not complete.")
        return false
    return true

func _expect_and_resolve(state: Node, event_id: String, choice_id: String) -> bool:
    if state.available_narrative_event_ids() != [event_id]:
        _fail("Expected canonical event was not uniquely available: %s" % event_id)
        return false
    var rng_before: int = int(state.rng.state)
    var result: Dictionary = state.resolve_narrative_choice(event_id, choice_id)
    if not bool(result.get("changed", false)):
        _fail("Canonical event could not resolve: %s" % event_id)
        return false
    if int(state.rng.state) != rng_before:
        _fail("Narrative event consumed simulation RNG: %s" % event_id)
        return false
    return true

func _round_trip(state: Node, boundary: String):
    var before: Dictionary = state.create_save_data()
    var rng_before: int = int(state.rng.state)
    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(before):
        _fail("Save/load failed at boundary: %s" % boundary)
        return null
    if restored.create_save_data() != before:
        _fail("Canonical snapshot changed after save/load at boundary: %s" % boundary)
        return null
    if int(restored.rng.state) != rng_before:
        _fail("RNG state changed after save/load at boundary: %s" % boundary)
        return null
    root.remove_child(state)
    state.free()
    return restored

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
