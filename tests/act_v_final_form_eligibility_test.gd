extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const ELIGIBILITY_SERVICE_SCRIPT := preload("res://domain/ending/ending_eligibility_service.gd")
const FINAL_FORM_RESOURCE := preload("res://resources/events/forma_da_lata.tres")

const FINAL_FORM_EVENT_ID := "event_forma_da_lata"

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    if not _assert_resource_contract():
        return
    if not _assert_service_predicates():
        return
    if not _assert_game_state_integration():
        return
    print("ACT V FINAL FORM ELIGIBILITY TEST PASSED")
    quit(0)

func _assert_resource_contract() -> bool:
    if FINAL_FORM_RESOURCE.choice_ids.size() != 4:
        _fail("Final-form debate does not expose the four canonical interventions.")
        return false
    for choice_id_value in FINAL_FORM_RESOURCE.choice_ids:
        var choice_id := String(choice_id_value)
        var flags: Array = Array(FINAL_FORM_RESOURCE.choice_flags.get(choice_id, PackedStringArray()))
        if not flags.has("lore_final_form_debate_seen"):
            _fail("Final-form choice lost the shared debate flag: %s" % choice_id)
            return false
        for flag_value in flags:
            if String(flag_value).begins_with("ending_"):
                _fail("Final-form choice persisted an ending selection: %s" % choice_id)
                return false
    return true

func _assert_service_predicates() -> bool:
    var service := ELIGIBILITY_SERVICE_SCRIPT.new()
    var before_debate := _mature_snapshot()
    before_debate["narrative_flags"]["lore_final_form_debate_seen"] = false
    if not service.eligible_ending_ids(before_debate).is_empty():
        _fail("Ending eligibility opened before the final-form debate.")
        return false

    var marca := _base_snapshot()
    marca["cash"] = 500
    marca["reputation"] = 10.0
    marca["buyer_relationships"]["varejista_licenciado"] = 1.0
    if not service.eligible_ending_ids(marca).has(service.ENDING_MARCA_NACIONAL):
        _fail("Marca Nacional maturity vector was not recognized.")
        return false

    var rede := _base_snapshot()
    rede["reputation"] = 10.0
    rede["community_support"] = _community_at(60.0)
    if not service.eligible_ending_ids(rede).has(service.ENDING_REDE_VIVA):
        _fail("Rede Viva maturity vector was not recognized.")
        return false

    var noite := _base_snapshot()
    noite["buyer_relationships"]["rede_paralela"] = 1.0
    noite["narrative_flags"]["choice_city_contributions_distributed"] = true
    if not service.eligible_ending_ids(noite).has(service.ENDING_NOITE_SEM_ROTULO):
        _fail("Noite Sem Rótulo maturity vector was not recognized.")
        return false

    var arquivo := _base_snapshot()
    arquivo["narrative_flags"]["research_material_compatibility_reviewed"] = true
    arquivo["narrative_flags"]["lore_original_lineage_still_unproven"] = true
    arquivo["narrative_flags"]["choice_reconstruction_public_uncertainty"] = true
    if not service.eligible_ending_ids(arquivo).has(service.ENDING_ARQUIVO_PUBLICO):
        _fail("Arquivo Público maturity vector was not recognized.")
        return false

    var atlantico := _base_snapshot()
    atlantico["cash"] = 500
    atlantico["influence"] = 5.0
    atlantico["narrative_flags"]["choice_city_contributions_central_coordination"] = true
    if not service.eligible_ending_ids(atlantico).has(service.ENDING_ATLANTICO):
        _fail("Atlântico maturity vector was not recognized.")
        return false

    var composite := _mature_snapshot()
    if not service.eligible_ending_ids(composite).has(service.ENDING_O_VERAO_VOLTA):
        _fail("O Verão Volta composite maturity vector was not recognized.")
        return false

    var without_parallel := composite.duplicate(true)
    without_parallel["buyer_relationships"]["rede_paralela"] = 0.0
    if service.eligible_ending_ids(without_parallel).has(service.ENDING_O_VERAO_VOLTA):
        _fail("Composite ending ignored parallel-market participation.")
        return false

    var without_licensed := composite.duplicate(true)
    without_licensed["buyer_relationships"]["varejista_licenciado"] = 0.0
    if service.eligible_ending_ids(without_licensed).has(service.ENDING_O_VERAO_VOLTA):
        _fail("Composite ending ignored licensed-market participation.")
        return false

    var without_influence := composite.duplicate(true)
    without_influence["influence"] = 0.0
    if service.eligible_ending_ids(without_influence).has(service.ENDING_O_VERAO_VOLTA):
        _fail("Composite ending ignored Influence maturity.")
        return false
    return true

func _assert_game_state_integration() -> bool:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(7007)
    state.reset()

    if not state.complete_narrative_arc("arc_o_sistema"):
        _fail("Could not establish the canonical Ato V prerequisite arc.")
        return false
    if not state.set_narrative_flag("lore_da_lata_name_canonical"):
        _fail("DA LATA naming flag was not recognized.")
        return false
    if state.available_narrative_event_ids() != [FINAL_FORM_EVENT_ID]:
        _fail("DA LATA naming did not naturally unlock the final-form debate.")
        return false
    if not state.eligible_ending_ids().is_empty():
        _fail("GameState exposed ending eligibility before the debate.")
        return false

    var rng_before: int = int(state.rng.state)
    var transition: Dictionary = state.resolve_narrative_choice(
        FINAL_FORM_EVENT_ID,
        "choice_final_form_fragmentary_origin_clause",
    )
    if not bool(transition.get("changed", false)):
        _fail("Final-form debate could not resolve through GameState.")
        return false
    if state.rng.state != rng_before:
        _fail("Final-form debate consumed simulation RNG.")
        return false
    if not bool(state.narrative_flags.get("lore_final_form_debate_seen", false)):
        _fail("Final-form debate flag was not persisted.")
        return false
    if state.completed_arc_ids.has("arc_da_lata"):
        _fail("Feature 007 completed arc_da_lata.")
        return false
    if not state.available_narrative_event_ids().is_empty():
        _fail("Feature 007 exposed the handoff/coda before ending selection exists.")
        return false

    for flag_id in [
        "research_material_compatibility_reviewed",
        "lore_original_lineage_still_unproven",
        "choice_city_contributions_distributed",
    ]:
        if not state.set_narrative_flag(flag_id):
            _fail("Canonical eligibility flag was not recognized: %s" % flag_id)
            return false

    state.cash = 500
    state.reputation = 15.0
    state.influence = 5.0
    state.community_support = _community_at(60.0)
    state.buyer_relationships["varejista_licenciado"] = 2.0
    state.buyer_relationships["rede_paralela"] = 2.0

    var eligible_before_save: Array = state.eligible_ending_ids()
    if not eligible_before_save.has("ending_o_verao_volta"):
        _fail("GameState did not expose composite eligibility from canonical state.")
        return false

    var snapshot: Dictionary = state.create_save_data()
    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(snapshot):
        _fail("Feature-007 schema-v11 state failed to restore.")
        return false
    if restored.eligible_ending_ids() != eligible_before_save:
        _fail("Derived ending eligibility changed after save round-trip.")
        return false
    if restored.completed_arc_ids.has("arc_da_lata"):
        _fail("Save round-trip incorrectly completed arc_da_lata.")
        return false
    return true

func _base_snapshot() -> Dictionary:
    return {
        "cash": 0,
        "reputation": 0.0,
        "influence": 0.0,
        "community_support": _community_at(0.0),
        "buyer_relationships": {
            "varejista_licenciado": 0.0,
            "rede_paralela": 0.0,
        },
        "narrative_flags": {
            "lore_final_form_debate_seen": true,
        },
    }

func _mature_snapshot() -> Dictionary:
    var snapshot := _base_snapshot()
    snapshot["cash"] = 500
    snapshot["reputation"] = 15.0
    snapshot["influence"] = 5.0
    snapshot["community_support"] = _community_at(60.0)
    snapshot["buyer_relationships"]["varejista_licenciado"] = 2.0
    snapshot["buyer_relationships"]["rede_paralela"] = 2.0
    snapshot["narrative_flags"]["research_material_compatibility_reviewed"] = true
    snapshot["narrative_flags"]["lore_original_lineage_still_unproven"] = true
    snapshot["narrative_flags"]["choice_reconstruction_public_uncertainty"] = true
    snapshot["narrative_flags"]["choice_city_contributions_distributed"] = true
    snapshot["narrative_flags"]["choice_city_contributions_central_coordination"] = true
    return snapshot

func _community_at(value: float) -> Dictionary:
    return {
        "district_morro_cedro": value,
        "district_centro_baixo": value,
        "district_baia_velha": value,
        "district_orla_vigia": value,
        "district_arco_norte": value,
        "district_restinga_clara": value,
        "district_mercado_madrugada": value,
    }

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
