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
const FIFTH_RESEARCH_ID := "research_material_compatibility_review"

const OPENING_RESOURCES := [
    preload("res://resources/events/reconstrucao_sem_original.tres"),
    preload("res://resources/events/sete_partes_da_cidade.tres"),
    preload("res://resources/events/nome_da_lata.tres"),
]

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    if not _assert_resource_contracts():
        return

    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(260923)
    state.reset()

    if not _reach_completed_evidence_review(state):
        return

    if state.available_narrative_event_ids() != [RECONSTRUCTION_EVENT_ID]:
        _fail("Completed evidence review did not naturally unlock Ato V reconstruction.")
        return
    if not _resolve_event(
        state,
        RECONSTRUCTION_EVENT_ID,
        "choice_reconstruction_public_uncertainty",
    ):
        return
    if not bool(state.narrative_flags.get("lore_act_v_reconstruction_framed", false)):
        _fail("Reconstruction framing flag was not persisted.")
        return

    if state.available_narrative_event_ids() != [CITY_PARTS_EVENT_ID]:
        _fail("Reconstruction framing did not unlock Sete Partes da Cidade.")
        return
    if not _resolve_event(
        state,
        CITY_PARTS_EVENT_ID,
        "choice_city_contributions_attributed",
    ):
        return
    if not bool(state.narrative_flags.get("lore_act_v_city_contributions_mapped", false)):
        _fail("City contribution map flag was not persisted.")
        return

    if state.available_narrative_event_ids() != [NAME_EVENT_ID]:
        _fail("Mapped contributions did not unlock the DA LATA naming event.")
        return
    if not _resolve_event(
        state,
        NAME_EVENT_ID,
        "choice_name_evidence_forward",
    ):
        return
    if not bool(state.narrative_flags.get("lore_da_lata_name_canonical", false)):
        _fail("DA LATA present-day name was not canonized.")
        return

    if state.completed_arc_ids.has("arc_da_lata"):
        _fail("Feature 006 completed arc_da_lata before finale implementation.")
        return
    if not bool(state.narrative_flags.get("lore_original_lineage_still_unproven", false)):
        _fail("Ato V opening lost the unproven-lineage boundary.")
        return
    if state.available_narrative_event_ids() != [FINAL_FORM_EVENT_ID]:
        _fail("Completed Ato V opening did not hand off to the final-form debate.")
        return

    var snapshot: Dictionary = state.create_save_data()
    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(snapshot):
        _fail("Ato V opening schema-v11 state failed to restore.")
        return
    if restored.completed_event_ids != state.completed_event_ids:
        _fail("Ato V completed events changed after save round-trip.")
        return
    if restored.narrative_flags != state.narrative_flags:
        _fail("Ato V narrative flags changed after save round-trip.")
        return
    if restored.completed_arc_ids.has("arc_da_lata"):
        _fail("Save round-trip incorrectly completed arc_da_lata.")
        return
    if restored.available_narrative_event_ids() != [FINAL_FORM_EVENT_ID]:
        _fail("Save round-trip lost the final-form handoff.")
        return

    print("ACT V RECONSTRUCTION OPENING TEST PASSED")
    quit(0)

func _assert_resource_contracts() -> bool:
    var shared_flags := [
        "lore_act_v_reconstruction_framed",
        "lore_act_v_city_contributions_mapped",
        "lore_da_lata_name_canonical",
    ]
    for index in range(OPENING_RESOURCES.size()):
        var definition = OPENING_RESOURCES[index]
        var shared_flag: String = shared_flags[index]
        for choice_id_value in definition.choice_ids:
            var choice_id := String(choice_id_value)
            var flags: Array = Array(definition.choice_flags.get(choice_id, PackedStringArray()))
            if not flags.has(shared_flag):
                _fail("Choice lost shared Ato V progression flag: %s" % choice_id)
                return false
            for forbidden in [
                "lore_original_lineage_proven",
                "lore_symbol_order_resolved",
                "lore_historical_original_authenticated",
            ]:
                if flags.has(forbidden):
                    _fail("Choice introduced forbidden historical certainty: %s" % choice_id)
                    return false
    return true

func _reach_completed_evidence_review(state: Node) -> bool:
    if not _complete_cycle_and_sell(state):
        return false
    if state.available_narrative_event_ids() != [FIRST_EVENT_ID]:
        _fail("Ordinary play did not unlock first narrative event.")
        return false
    if not _resolve_event(state, FIRST_EVENT_ID, "choice_dalva_lucia_parallel_versions"):
        return false

    for step_id in EARLY_RESEARCH_IDS:
        if state.available_research_step_ids() != [step_id]:
            _fail("Expected early research step was not available: %s" % step_id)
            return false
        var rng_before: int = int(state.rng.state)
        var result: Dictionary = state.complete_research_step(step_id)
        if not bool(result.get("changed", false)):
            _fail("Could not complete early research step: %s" % step_id)
            return false
        if state.rng.state != rng_before:
            _fail("Research consumed simulation RNG: %s" % step_id)
            return false

    if not _expect_and_resolve(state, SOL_EVENT_ID, "choice_sol_record_photo"):
        return false
    if not _expect_and_resolve(state, FAROL_EVENT_ID, "choice_farol_aurora_first"):
        return false

    if not _complete_cycle_and_sell(state):
        return false
    if not _expect_and_resolve(
        state,
        INVITE_EVENT_ID,
        "choice_council_receive_invitation",
    ):
        return false

    state.civic_engagement()
    if not _expect_and_resolve(state, ISA_EVENT_ID, "choice_isa_disclose_tradeoffs"):
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

    if state.available_research_step_ids() != [FIFTH_RESEARCH_ID]:
        _fail("Ato IV completion did not unlock fifth research step.")
        return false
    var rng_before: int = int(state.rng.state)
    var final_research: Dictionary = state.complete_research_step(FIFTH_RESEARCH_ID)
    if not bool(final_research.get("changed", false)):
        _fail("Could not complete fifth research step.")
        return false
    if state.rng.state != rng_before:
        _fail("Fifth research step consumed simulation RNG.")
        return false
    return true

func _expect_and_resolve(state: Node, event_id: String, choice_id: String) -> bool:
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

func _complete_cycle_and_sell(state: Node) -> bool:
    for index in range(state.current_cycle_days()):
        if index % 2 == 0:
            state.care_for_room()
        state.next_day()
    state.harvest()
    if state.inventory <= 0:
        _fail("Ordinary cycle did not produce inventory.")
        return false
    state.sell_legal()
    if state.inventory != 0:
        _fail("Licensed route did not complete sale.")
        return false
    return true

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
