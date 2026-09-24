extends Node

signal state_changed
signal message_posted(text: String)

const MAX_DAYS := 30

const DEFAULT_CULTIVAR := preload("res://resources/cultivars/quarto_classica.tres")
const LICENSED_BUYER := preload("res://resources/buyers/varejista_licenciado.tres")
const PARALLEL_BUYER := preload("res://resources/buyers/rede_paralela.tres")
const DEFAULT_ROOM_DEFINITION := preload("res://resources/rooms/quarto_inicial.tres")
const COMPACT_ROOM_DEFINITION := preload("res://resources/rooms/sala_compacta.tres")
const MORRO_CEDRO := preload("res://resources/districts/morro_cedro.tres")
const CENTRO_BAIXO := preload("res://resources/districts/centro_baixo.tres")
const BAIA_VELHA := preload("res://resources/districts/baia_velha.tres")
const ORLA_VIGIA := preload("res://resources/districts/orla_vigia.tres")
const ARCO_NORTE := preload("res://resources/districts/arco_norte.tres")
const RESTINGA_CLARA := preload("res://resources/districts/restinga_clara.tres")
const MERCADO_MADRUGADA := preload("res://resources/districts/mercado_madrugada.tres")
const PARTICIPATORY_REGISTRY := preload("res://resources/policies/participatory_registry.tres")
const LOCAL_MARKET_CHARTER := preload("res://resources/policies/local_market_charter.tres")
const BAY_CIVIC_COMPACT := preload("res://resources/policies/bay_civic_compact.tres")
const BASIC_SENSORS := preload("res://resources/upgrades/sensores_basicos.tres")
const OPERATIONS_ASSISTANT := preload("res://resources/staff/assistente_operacional.tres")
const CULTIVATION_SERVICE := preload("res://domain/cultivation/cultivation_service.gd")
const ECONOMY_SERVICE := preload("res://domain/economy/economy_service.gd")
const BUSINESS_SERVICE := preload("res://domain/business/business_service.gd")
const COMPLIANCE_SERVICE := preload("res://domain/business/compliance_service.gd")
const CITY_SERVICE := preload("res://domain/city/city_service.gd")
const COMMUNITY_SERVICE := preload("res://domain/city/community_service.gd")
const POLICY_SERVICE := preload("res://domain/politics/policy_service.gd")
const NARRATIVE_EVENT_SERVICE := preload("res://domain/events/narrative_event_service.gd")
const ENDING_ELIGIBILITY_SERVICE := preload("res://domain/ending/ending_eligibility_service.gd")
const ENDING_SELECTION_SERVICE := preload("res://domain/ending/ending_selection_service.gd")
const RESEARCH_SERVICE := preload("res://domain/research/research_service.gd")
const FIRST_NARRATIVE_EVENT := preload("res://resources/events/dalva_lucia_primeiro_depoimento.tres")
const SOL_PHOTO_EVENT := preload("res://resources/events/act_ii_sol_photo_reveal.tres")
const FAROL_TAPE_EVENT := preload("res://resources/events/bento_fita_farol.tres")
const COUNCIL_INVITATION_EVENT := preload("res://resources/events/act_iii_council_invitation.tres")
const ISA_TABLE_EVENT := preload("res://resources/events/isa_mesa_sem_palco.tres")
const FERRUGEM_LOT_EVENT := preload("res://resources/events/leilao_ferrugem.tres")
const FERRUGEM_MEMORY_EVENT := preload("res://resources/events/ferrugem_quem_assina_memoria.tres")
const GREEN_PERIOD_AUDIENCE_EVENT := preload("res://resources/events/audiencia_periodo_verde.tres")
const STAR_PHOTO_EVENT := preload("res://resources/events/foto_estrela.tres")
const RECONSTRUCTION_OPENING_EVENT := preload("res://resources/events/reconstrucao_sem_original.tres")
const CITY_PARTS_EVENT := preload("res://resources/events/sete_partes_da_cidade.tres")
const DA_LATA_NAME_EVENT := preload("res://resources/events/nome_da_lata.tres")
const FINAL_FORM_EVENT := preload("res://resources/events/forma_da_lata.tres")
const FIRST_RESEARCH_STEP := preload("res://resources/research/onda_evidence_catalog.tres")
const SECOND_RESEARCH_STEP := preload("res://resources/research/symbol_order_comparison.tres")
const THIRD_RESEARCH_STEP := preload("res://resources/research/onda_provenance_gap_map.tres")
const FOURTH_RESEARCH_STEP := preload("res://resources/research/evidence_boundary_synthesis.tres")
const FIFTH_RESEARCH_STEP := preload("res://resources/research/material_compatibility_review.tres")
const ACT_ONE_ARC_ID := "arc_o_quarto"
const ACT_ONE_CONTACT_FLAG := "contact_char_dalva"
const ACT_TWO_INTRODUCTION_FLAG := "introduced_char_lucia"
const ACT_ONE_MEMORY_FLAG := "memory_onda_can_received"
const BUSINESS_SCALE_FLAG := "campaign_business_scale_reached"
const COUNCIL_PARTICIPATION_FLAG := "campaign_council_participation_ready"
const EVENT_ARC_COMPLETIONS := {
    "event_act_ii_sol_photo_reveal": "arc_o_negocio",
    "event_act_iii_council_invitation": "arc_dois_mercados",
    "event_foto_estrela": "arc_o_sistema",
}
const SAVE_SERVICE := preload("res://autoload/save_service.gd")

var day := 1
var cash := 250
var heat := 5.0
var reputation := 0.0
var influence := 0.0
var game_over := false

# UI-facing cache for the active room. Canonical cultivation state lives in rooms[].
var active_cultivar: CultivarDefinition = DEFAULT_CULTIVAR
var grow_day := 0
var grow_health := 0.72
var cared_today := false
var inventory := 0
var batch_quality := 0.0

var rooms: Array = [
    {
        "instance_id": "room_1",
        "definition_id": "quarto_inicial",
        "cultivation": {
            "active_cultivar_id": "quarto_classica",
            "grow_day": 0,
            "grow_health": 0.72,
            "cared_today": false,
            "inventory": 0,
            "batch_quality": 0.0,
        },
    },
]
var active_room_id := "room_1"
var hired_staff_ids: Array = []
var owned_upgrade_ids: Array = []
var buyer_relationships: Dictionary = {
    "varejista_licenciado": 0.0,
    "rede_paralela": 0.0,
}
var active_contract_id := ""
var compliance_level := 0
var active_district_id := "district_morro_cedro"
var district_demand: Dictionary = {
    "district_morro_cedro": 55.0,
    "district_centro_baixo": 60.0,
    "district_baia_velha": 45.0,
    "district_orla_vigia": 70.0,
    "district_arco_norte": 50.0,
    "district_restinga_clara": 58.0,
    "district_mercado_madrugada": 65.0,
}
var community_support: Dictionary = {
    "district_morro_cedro": 50.0,
    "district_centro_baixo": 50.0,
    "district_baia_velha": 50.0,
    "district_orla_vigia": 50.0,
    "district_arco_norte": 50.0,
    "district_restinga_clara": 50.0,
    "district_mercado_madrugada": 50.0,
}
var institution_level := 0
var enacted_policy_ids: Array = []
var completed_arc_ids: Array = []
var completed_event_ids: Array = []
var narrative_flags: Dictionary = {}
var selected_ending_id := ""

var simulation_seed := -1
var rng := RandomNumberGenerator.new()
var cultivation_service := CULTIVATION_SERVICE.new()
var economy_service := ECONOMY_SERVICE.new()
var business_service := BUSINESS_SERVICE.new()
var compliance_service := COMPLIANCE_SERVICE.new()
var city_service := CITY_SERVICE.new()
var community_service := COMMUNITY_SERVICE.new()
var policy_service := POLICY_SERVICE.new()
var narrative_event_service := NARRATIVE_EVENT_SERVICE.new()
var ending_eligibility_service := ENDING_ELIGIBILITY_SERVICE.new()
var ending_selection_service := ENDING_SELECTION_SERVICE.new()
var research_service := RESEARCH_SERVICE.new()
var save_service := SAVE_SERVICE.new()

func _ready() -> void:
    _reset_rng()
    _sync_active_room_cache()

func set_simulation_seed(seed_value: int) -> void:
    simulation_seed = seed_value
    rng.seed = seed_value

func clear_simulation_seed() -> void:
    simulation_seed = -1
    rng.randomize()

func current_cycle_days() -> int:
    return cultivation_service.current_cycle_days(active_cultivar)

func cultivation_action_availability() -> Dictionary:
    return cultivation_service.action_availability(
        grow_day,
        cared_today,
        inventory,
        current_cycle_days(),
        game_over,
    )

func room_count() -> int:
    return rooms.size()

func district_count() -> int:
    return _district_definition_catalog().size()

func city_snapshot() -> Dictionary:
    var catalog := _district_definition_catalog()
    var district_ids := catalog.keys()
    district_ids.sort()
    var districts: Array = []

    for district_id_value in district_ids:
        var district_id := String(district_id_value)
        var definition: DistrictDefinition = catalog[district_id_value]
        var demand := float(
            district_demand.get(district_id, definition.base_demand)
        )
        districts.append({
            "id": district_id,
            "display_name": String(definition.display_name),
            "demand": demand,
            "base_demand": float(definition.base_demand),
            "price_multiplier": city_service.price_multiplier(
                demand,
                definition,
            ),
            "active": district_id == active_district_id,
        })

    return {
        "active_district_id": active_district_id,
        "districts": districts,
    }

func current_demand() -> float:
    return float(district_demand.get(active_district_id, 50.0))

func current_community_support() -> float:
    return float(community_support.get(active_district_id, 50.0))

func advance_community_feedback() -> void:
    community_support = community_service.advance_day(
        community_support,
        reputation,
        institution_level,
        district_demand,
        _district_definition_catalog(),
    )
    reputation = clampf(
        reputation + community_service.reputation_delta(
            community_support,
            active_district_id,
        ),
        0.0,
        100.0,
    )

func select_district(district_id: String) -> bool:
    if not _district_definition_catalog().has(district_id):
        return false
    if district_id == active_district_id:
        return true

    active_district_id = district_id
    state_changed.emit()
    return true

func district_price_multiplier() -> float:
    var definition: DistrictDefinition = _district_definition_catalog().get(
        active_district_id
    )
    if definition == null:
        return 1.0
    return city_service.price_multiplier(current_demand(), definition)

func policy_count() -> int:
    return _policy_definition_catalog().size()

func available_policy_ids() -> Array:
    return policy_service.available_proposals(
        institution_level,
        compliance_level,
        enacted_policy_ids,
        _policy_definition_catalog(),
    )

func enact_policy(policy_id: String) -> bool:
    if game_over:
        return false

    var transition: Dictionary = policy_service.resolve_enactment(
        policy_id,
        institution_level,
        enacted_policy_ids,
        compliance_level,
        cash,
        influence,
        _policy_definition_catalog(),
    )
    if not transition["changed"]:
        _post(transition["message"])
        return false

    institution_level = int(transition["institution_level"])
    enacted_policy_ids = Array(
        transition["enacted_policy_ids"]
    ).duplicate(true)
    cash += int(transition["cash_delta"])
    influence = maxf(
        0.0,
        influence + float(transition["influence_delta"]),
    )
    reputation = maxf(
        0.0,
        reputation + float(transition["reputation_delta"]),
    )
    heat = clampf(
        heat + float(transition["heat_delta"]),
        0.0,
        100.0,
    )
    _refresh_council_participation_flag()
    _post(transition["message"])
    state_changed.emit()
    return true

func narrative_event_count() -> int:
    return _narrative_event_catalog().size()

func complete_narrative_arc(arc_id: String) -> bool:
    if not _known_narrative_arc_ids().has(arc_id):
        return false
    if completed_arc_ids.has(arc_id):
        return true
    completed_arc_ids.append(arc_id)
    state_changed.emit()
    return true

func set_narrative_flag(flag_id: String, value: bool = true) -> bool:
    if not _known_narrative_flag_ids().has(flag_id):
        return false
    narrative_flags[flag_id] = value
    state_changed.emit()
    return true

func available_narrative_event_ids() -> Array:
    var available: Array = []
    for event_id in _narrative_event_catalog():
        var definition: NarrativeEventDefinition = _narrative_event_catalog()[event_id]
        if narrative_event_service.is_available(
            definition,
            completed_arc_ids,
            completed_event_ids,
            narrative_flags,
        ):
            available.append(String(event_id))
    return available

func narrative_event_presentation(event_id: String) -> Dictionary:
    var definition: NarrativeEventDefinition = _narrative_event_catalog().get(event_id)
    if definition == null:
        return {}

    return {
        "id": String(definition.id),
        "display_title": definition.display_title,
        "body_text": definition.body_text,
        "choice_ids": Array(definition.choice_ids),
        "choice_labels": definition.choice_labels.duplicate(true),
    }

func resolve_narrative_choice(event_id: String, choice_id: String) -> Dictionary:
    if game_over:
        return {"changed": false, "message": "Campanha encerrada."}

    var definition: NarrativeEventDefinition = _narrative_event_catalog().get(event_id)
    if definition == null:
        return {"changed": false, "message": "Evento narrativo desconhecido."}

    var transition: Dictionary = narrative_event_service.resolve_choice(
        definition,
        choice_id,
        completed_arc_ids,
        completed_event_ids,
        narrative_flags,
    )
    if not transition["changed"]:
        return transition

    completed_event_ids = Array(transition["completed_event_ids"]).duplicate(true)
    narrative_flags = Dictionary(transition["narrative_flags"]).duplicate(true)
    _complete_arc_for_narrative_event(event_id)
    _post("Evento narrativo concluído: %s." % event_id)
    state_changed.emit()
    return transition

func eligible_ending_ids() -> Array:
    return Array(ending_eligibility_service.eligible_ending_ids({
        "cash": cash,
        "reputation": reputation,
        "influence": influence,
        "community_support": community_support.duplicate(true),
        "buyer_relationships": buyer_relationships.duplicate(true),
        "narrative_flags": narrative_flags.duplicate(true),
    }))

func select_ending(ending_id: String) -> Dictionary:
    var transition: Dictionary = ending_selection_service.select_ending(
        selected_ending_id,
        ending_id,
        eligible_ending_ids(),
    )
    if not bool(transition.get("changed", false)):
        return transition

    selected_ending_id = String(transition["selected_ending_id"])
    _post("Família de final registrada: %s." % selected_ending_id)
    state_changed.emit()
    return transition

func research_step_count() -> int:
    return _research_step_catalog().size()

func available_research_step_ids() -> Array:
    var available: Array = []
    for step_id in _research_step_catalog():
        var definition: ResearchStepDefinition = _research_step_catalog()[step_id]
        if research_service.is_available(
            definition,
            completed_event_ids,
            narrative_flags,
        ):
            available.append(String(step_id))
    return available

func research_step_presentation(step_id: String) -> Dictionary:
    var definition: ResearchStepDefinition = _research_step_catalog().get(step_id)
    if definition == null:
        return {}

    return {
        "id": String(definition.id),
        "display_name": definition.display_name,
        "evidence_tags": Array(definition.evidence_tags),
        "system_signals": Array(definition.system_signals),
        "canon_guardrails": Array(definition.canon_guardrails),
    }

func complete_research_step(step_id: String) -> Dictionary:
    if game_over:
        return {"changed": false, "message": "Campanha encerrada."}

    var definition: ResearchStepDefinition = _research_step_catalog().get(step_id)
    if definition == null:
        return {"changed": false, "message": "Etapa de pesquisa desconhecida."}

    var transition: Dictionary = research_service.resolve(
        definition,
        completed_event_ids,
        narrative_flags,
    )
    if not transition["changed"]:
        return transition

    narrative_flags = Dictionary(transition["narrative_flags"]).duplicate(true)
    _post("Pesquisa concluída: %s." % definition.display_name)
    state_changed.emit()
    return transition

func daily_operating_cost() -> int:
    return (
        business_service.daily_operating_cost(
            rooms,
            _room_definition_catalog(),
        )
        + business_service.daily_staff_cost(
            hired_staff_ids,
            _staff_definition_catalog(),
        )
        + business_service.daily_upgrade_cost(
            owned_upgrade_ids,
            _upgrade_definition_catalog(),
        )
    )

func health_stability_modifier() -> float:
    return business_service.health_stability_modifier(
        hired_staff_ids,
        owned_upgrade_ids,
        _staff_definition_catalog(),
        _upgrade_definition_catalog(),
    )

func management_snapshot() -> Dictionary:
    var room_entries: Array = []
    var room_catalog := _room_definition_catalog()
    for room_value in rooms:
        if typeof(room_value) != TYPE_DICTIONARY:
            continue
        var room: Dictionary = room_value
        var instance_id := String(room.get("instance_id", ""))
        var definition_id := String(room.get("definition_id", ""))
        var room_definition: RoomDefinition = room_catalog.get(definition_id)
        if room_definition == null:
            continue
        var is_active := instance_id == active_room_id
        room_entries.append({
            "instance_id": instance_id,
            "definition_id": definition_id,
            "display_name": room_definition.display_name,
            "daily_operating_cost": room_definition.daily_operating_cost,
            "state": "active" if is_active else "available",
            "action": {
                "enabled": not is_active,
                "reason": "Sala já está ativa." if is_active else "",
            },
        })

    var staff_entries: Array = []
    var staff_catalog := _staff_definition_catalog()
    for staff_id_value in staff_catalog:
        var staff_id := String(staff_id_value)
        var staff_definition: StaffDefinition = staff_catalog.get(staff_id)
        if staff_definition == null:
            continue
        var staff_owned := hired_staff_ids.has(staff_id)
        var staff_affordable := cash >= staff_definition.hire_cost
        var staff_state := "available"
        var staff_reason := ""
        if staff_owned:
            staff_state = "owned"
            staff_reason = "Equipe já contratada."
        elif not staff_affordable:
            staff_state = "unavailable"
            staff_reason = "Saldo insuficiente para contratar."
        staff_entries.append({
            "id": staff_id,
            "display_name": staff_definition.display_name,
            "description": staff_definition.description,
            "hire_cost": staff_definition.hire_cost,
            "daily_cost": staff_definition.daily_cost,
            "health_stability_delta": staff_definition.health_stability_delta,
            "state": staff_state,
            "action": {
                "enabled": not staff_owned and staff_affordable,
                "reason": staff_reason,
            },
        })

    var upgrade_entries: Array = []
    var upgrade_catalog := _upgrade_definition_catalog()
    for upgrade_id_value in upgrade_catalog:
        var upgrade_id := String(upgrade_id_value)
        var upgrade_definition: UpgradeDefinition = upgrade_catalog.get(upgrade_id)
        if upgrade_definition == null:
            continue
        var upgrade_owned := owned_upgrade_ids.has(upgrade_id)
        var upgrade_affordable := cash >= upgrade_definition.cost
        var upgrade_state := "available"
        var upgrade_reason := ""
        if upgrade_owned:
            upgrade_state = "owned"
            upgrade_reason = "Melhoria já adquirida."
        elif not upgrade_affordable:
            upgrade_state = "unavailable"
            upgrade_reason = "Saldo insuficiente para adquirir."
        upgrade_entries.append({
            "id": upgrade_id,
            "display_name": upgrade_definition.display_name,
            "description": upgrade_definition.description,
            "cost": upgrade_definition.cost,
            "daily_upkeep_delta": upgrade_definition.daily_upkeep_delta,
            "health_stability_delta": upgrade_definition.health_stability_delta,
            "state": upgrade_state,
            "action": {
                "enabled": not upgrade_owned and upgrade_affordable,
                "reason": upgrade_reason,
            },
        })

    return {
        "rooms": room_entries,
        "staff": staff_entries,
        "upgrades": upgrade_entries,
        "daily_operating_cost": daily_operating_cost(),
        "health_stability_modifier": health_stability_modifier(),
    }

func add_room(instance_id: String, definition_id: String) -> bool:
    if instance_id.is_empty() or definition_id.is_empty():
        return false
    if _has_room(instance_id):
        return false
    if not _room_definition_catalog().has(definition_id):
        return false

    rooms.append(_new_room_state(instance_id, definition_id))
    state_changed.emit()
    return true

func hire_staff(staff_id: String) -> bool:
    var catalog := _staff_definition_catalog()
    var definition: StaffDefinition = catalog.get(staff_id)
    if definition == null:
        return false
    if hired_staff_ids.has(staff_id):
        return false
    if cash < definition.hire_cost:
        return false

    cash -= definition.hire_cost
    hired_staff_ids.append(staff_id)
    _post("Equipe ampliada: %s." % definition.display_name)
    state_changed.emit()
    return true

func purchase_upgrade(upgrade_id: String) -> bool:
    var catalog := _upgrade_definition_catalog()
    var definition: UpgradeDefinition = catalog.get(upgrade_id)
    if definition == null:
        return false
    if owned_upgrade_ids.has(upgrade_id):
        return false
    if cash < definition.cost:
        return false

    cash -= definition.cost
    owned_upgrade_ids.append(upgrade_id)
    _post("Upgrade adquirido: %s." % definition.display_name)
    state_changed.emit()
    return true

func switch_active_room(instance_id: String) -> bool:
    if not _has_room(instance_id):
        return false
    if instance_id == active_room_id:
        return true

    active_room_id = instance_id
    _sync_active_room_cache()
    state_changed.emit()
    return true

func create_save_data() -> Dictionary:
    return save_service.create_v11(
        {
            "day": day,
            "cash": cash,
            "heat": heat,
            "reputation": reputation,
            "influence": influence,
            "game_over": game_over,
        },
        rooms,
        active_room_id,
        hired_staff_ids,
        owned_upgrade_ids,
        buyer_relationships,
        active_contract_id,
        compliance_level,
        active_district_id,
        district_demand,
        institution_level,
        enacted_policy_ids,
        community_support,
        completed_arc_ids,
        completed_event_ids,
        narrative_flags,
        selected_ending_id,
        simulation_seed,
        rng.state,
    )

func load_save_data(payload: Dictionary) -> bool:
    var parsed: Dictionary = save_service.parse(payload)
    if not parsed["ok"]:
        _post("Save inválido: %s" % parsed["error"])
        return false

    var version := int(parsed["schema_version"])
    var snapshot: Dictionary = parsed["state"]
    var loaded_rooms: Array
    var loaded_active_room_id: String
    var loaded_staff_ids: Array = []
    var loaded_upgrade_ids: Array = []
    var loaded_buyer_relationships := _default_buyer_relationships()
    var loaded_active_contract_id := ""
    var loaded_compliance_level := 0
    var loaded_active_district_id := String(MORRO_CEDRO.id)
    var loaded_district_demand := _default_district_demand()
    var loaded_institution_level := 0
    var loaded_enacted_policy_ids: Array = []
    var loaded_community_support := _default_community_support()
    var loaded_completed_arc_ids: Array = []
    var loaded_completed_event_ids: Array = []
    var loaded_narrative_flags: Dictionary = {}
    var loaded_selected_ending_id := ""

    if version == 1:
        var legacy_cultivation_v1 := _legacy_cultivation_from_snapshot(snapshot)
        if legacy_cultivation_v1.is_empty():
            return false
        loaded_rooms = [
            _new_room_state(
                "room_1",
                String(DEFAULT_ROOM_DEFINITION.id),
                legacy_cultivation_v1,
            ),
        ]
        loaded_active_room_id = "room_1"
    elif version == 2:
        var business_v2: Dictionary = parsed["business"]
        var legacy_rooms: Array = business_v2["rooms"]
        loaded_active_room_id = String(business_v2["active_room_id"])
        loaded_rooms = []
        for room_value in legacy_rooms:
            var room: Dictionary = room_value
            loaded_rooms.append(_new_room_state(
                String(room["instance_id"]),
                String(room["definition_id"]),
            ))

        var legacy_cultivation_v2 := _legacy_cultivation_from_snapshot(snapshot)
        if legacy_cultivation_v2.is_empty():
            return false
        if not _set_room_cultivation(
            loaded_rooms,
            loaded_active_room_id,
            legacy_cultivation_v2,
        ):
            _post("Save inválido: sala ativa desconhecida.")
            return false
    else:
        var business_modern: Dictionary = parsed["business"]
        loaded_active_room_id = String(business_modern["active_room_id"])
        loaded_rooms = []
        for room_value in business_modern["rooms"]:
            var saved_room: Dictionary = room_value
            var saved_cultivation: Dictionary = saved_room["cultivation"]
            loaded_rooms.append(_new_room_state(
                String(saved_room["instance_id"]),
                String(saved_room["definition_id"]),
                {
                    "active_cultivar_id": String(
                        saved_cultivation["active_cultivar_id"],
                    ),
                    "grow_day": int(saved_cultivation["grow_day"]),
                    "grow_health": float(saved_cultivation["grow_health"]),
                    "cared_today": bool(saved_cultivation["cared_today"]),
                    "inventory": int(saved_cultivation["inventory"]),
                    "batch_quality": float(saved_cultivation["batch_quality"]),
                },
            ))
        if version >= 4:
            loaded_staff_ids = Array(business_modern["staff_ids"]).duplicate(true)
            loaded_upgrade_ids = Array(business_modern["upgrade_ids"]).duplicate(true)
        if version >= 5:
            loaded_buyer_relationships = Dictionary(
                business_modern["buyer_relationships"]
            ).duplicate(true)
            loaded_active_contract_id = String(
                business_modern["active_contract_id"]
            )
        if version >= 6:
            loaded_compliance_level = int(
                business_modern["compliance_level"]
            )
        if version >= 7:
            var city_modern: Dictionary = parsed["city"]
            loaded_active_district_id = String(
                city_modern["active_district_id"]
            )
            loaded_district_demand = Dictionary(
                city_modern["district_demand"]
            ).duplicate(true)
        if version >= 8:
            var policy_modern: Dictionary = parsed["policy"]
            loaded_institution_level = int(
                policy_modern["institution_level"]
            )
            loaded_enacted_policy_ids = Array(
                policy_modern["enacted_policy_ids"]
            ).duplicate(true)
        if version >= 9:
            var community_modern: Dictionary = parsed["community"]
            loaded_community_support = Dictionary(
                community_modern["support"]
            ).duplicate(true)
        if version >= 10:
            var campaign_modern: Dictionary = parsed["campaign"]
            loaded_completed_arc_ids = Array(
                campaign_modern["completed_arc_ids"]
            ).duplicate(true)
            loaded_completed_event_ids = Array(
                campaign_modern["completed_event_ids"]
            ).duplicate(true)
            loaded_narrative_flags = Dictionary(
                campaign_modern["narrative_flags"]
            ).duplicate(true)
            if version >= 11:
                loaded_selected_ending_id = String(
                    campaign_modern["selected_ending_id"]
                )

    if not _rooms_have_known_definitions(loaded_rooms):
        _post("Save inválido: definição de sala desconhecida.")
        return false
    if not _rooms_have_known_cultivars(loaded_rooms):
        _post("Save inválido: cultivar de sala desconhecido.")
        return false
    if not _room_list_has_instance(loaded_rooms, loaded_active_room_id):
        _post("Save inválido: sala ativa desconhecida.")
        return false
    if not _ids_are_known(loaded_staff_ids, _staff_definition_catalog()):
        _post("Save inválido: funcionário desconhecido.")
        return false
    if not _ids_are_known(loaded_upgrade_ids, _upgrade_definition_catalog()):
        _post("Save inválido: upgrade desconhecido.")
        return false
    if not _relationship_ids_are_known(loaded_buyer_relationships):
        _post("Save inválido: comprador desconhecido.")
        return false
    if (
        not loaded_active_contract_id.is_empty()
        and not _contract_catalog().has(loaded_active_contract_id)
    ):
        _post("Save inválido: contrato desconhecido.")
        return false
    if (
        loaded_compliance_level < 0
        or loaded_compliance_level > compliance_service.MAX_LEVEL
    ):
        _post("Save inválido: nível de conformidade desconhecido.")
        return false
    if not _district_definition_catalog().has(loaded_active_district_id):
        _post("Save inválido: distrito ativo desconhecido.")
        return false
    if not _district_state_is_known(loaded_district_demand):
        _post("Save inválido: estado de demanda distrital desconhecido.")
        return false
    if not policy_service.is_valid_state(
        loaded_institution_level,
        loaded_enacted_policy_ids,
        _policy_definition_catalog(),
    ):
        _post("Save inválido: estado institucional desconhecido.")
        return false
    if not community_service.is_valid_state(
        loaded_community_support,
        _district_definition_catalog(),
    ):
        _post("Save inválido: estado comunitário desconhecido.")
        return false
    if not _ids_are_known(
        loaded_completed_arc_ids,
        _known_narrative_arc_ids(),
    ):
        _post("Save inválido: arco narrativo desconhecido.")
        return false
    if not _ids_are_known(
        loaded_completed_event_ids,
        _narrative_event_catalog(),
    ):
        _post("Save inválido: evento narrativo desconhecido.")
        return false
    if not _narrative_flags_are_known(loaded_narrative_flags):
        _post("Save inválido: flag narrativa desconhecida.")
        return false
    if (
        not loaded_selected_ending_id.is_empty()
        and not _known_ending_ids().has(loaded_selected_ending_id)
    ):
        _post("Save inválido: família de final desconhecida.")
        return false

    day = int(snapshot["day"])
    cash = int(snapshot["cash"])
    heat = float(snapshot["heat"])
    reputation = float(snapshot["reputation"])
    influence = float(snapshot["influence"])
    game_over = bool(snapshot["game_over"])
    rooms = loaded_rooms
    active_room_id = loaded_active_room_id
    hired_staff_ids = loaded_staff_ids
    owned_upgrade_ids = loaded_upgrade_ids
    buyer_relationships = _normalized_buyer_relationships(
        loaded_buyer_relationships
    )
    active_contract_id = loaded_active_contract_id
    compliance_level = loaded_compliance_level
    active_district_id = loaded_active_district_id
    district_demand = loaded_district_demand
    institution_level = loaded_institution_level
    enacted_policy_ids = loaded_enacted_policy_ids
    community_support = loaded_community_support
    completed_arc_ids = loaded_completed_arc_ids
    completed_event_ids = loaded_completed_event_ids
    narrative_flags = loaded_narrative_flags
    selected_ending_id = loaded_selected_ending_id
    _sync_active_room_cache()
    if version >= 10:
        _refresh_council_participation_flag()

    var simulation: Dictionary = parsed["simulation"]
    simulation_seed = int(simulation["seed"])
    rng.state = int(String(simulation["rng_state"]))

    state_changed.emit()
    return true

func reset() -> void:
    _reset_rng()
    day = 1
    cash = 250
    heat = 5.0
    reputation = 0.0
    influence = 0.0
    game_over = false
    rooms = _default_room_states()
    active_room_id = "room_1"
    hired_staff_ids = []
    owned_upgrade_ids = []
    buyer_relationships = _default_buyer_relationships()
    active_contract_id = ""
    compliance_level = 0
    active_district_id = String(MORRO_CEDRO.id)
    district_demand = _default_district_demand()
    community_support = _default_community_support()
    institution_level = 0
    enacted_policy_ids = []
    completed_arc_ids = []
    completed_event_ids = []
    narrative_flags = {}
    selected_ending_id = ""
    _sync_active_room_cache()
    _post("Novo ciclo iniciado.")
    state_changed.emit()

func care_for_room() -> void:
    if game_over:
        return

    var cultivation := _active_cultivation()
    var transition: Dictionary = cultivation_service.care(
        int(cultivation["grow_day"]),
        float(cultivation["grow_health"]),
        bool(cultivation["cared_today"]),
        current_cycle_days(),
    )
    if not transition["changed"]:
        _post(transition["message"])
        return

    cultivation["grow_health"] = transition["grow_health"]
    cultivation["cared_today"] = transition["cared_today"]
    _write_active_cultivation(cultivation)
    cash += transition["cash_delta"]
    _post(transition["message"])
    state_changed.emit()

func next_day() -> void:
    if game_over:
        return

    cash -= daily_operating_cost()
    var stability_modifier := health_stability_modifier()
    for index in range(rooms.size()):
        var room: Dictionary = rooms[index]
        var cultivation: Dictionary = room["cultivation"]
        var cultivar := _resolve_cultivar(
            StringName(cultivation["active_cultivar_id"]),
        )
        var cultivation_transition: Dictionary = cultivation_service.advance_day(
            int(cultivation["grow_day"]),
            float(cultivation["grow_health"]),
            bool(cultivation["cared_today"]),
            cultivation_service.current_cycle_days(cultivar),
            rng,
            stability_modifier,
        )
        cultivation["grow_day"] = cultivation_transition["grow_day"]
        cultivation["grow_health"] = cultivation_transition["grow_health"]
        cultivation["cared_today"] = cultivation_transition["cared_today"]
        room["cultivation"] = cultivation
        rooms[index] = room

    district_demand = city_service.advance_day(
        district_demand,
        _district_definition_catalog(),
        day,
    )
    advance_community_feedback()
    _sync_active_room_cache()
    heat = maxf(0.0, heat - 1.5)
    _roll_event()
    day += 1
    if day > MAX_DAYS or cash < -100:
        game_over = true
        _post("Fim do ciclo. Reinicie para tentar outra estratégia.")
    else:
        _post("Dia %d começou." % day)
    state_changed.emit()

func harvest() -> void:
    if game_over:
        return

    var cultivation := _active_cultivation()
    var transition: Dictionary = cultivation_service.harvest(
        int(cultivation["grow_day"]),
        float(cultivation["grow_health"]),
        int(cultivation["inventory"]),
        active_cultivar,
        rng,
    )
    if not transition["changed"]:
        _post(transition["message"])
        return

    cultivation["grow_day"] = transition["grow_day"]
    cultivation["grow_health"] = transition["grow_health"]
    cultivation["cared_today"] = transition["cared_today"]
    cultivation["inventory"] = transition["inventory"]
    cultivation["batch_quality"] = transition["batch_quality"]
    _write_active_cultivation(cultivation)
    reputation += transition["reputation_delta"]
    _post("Lote concluído: %d unidades, qualidade %s." % [inventory, quality_label()])
    state_changed.emit()

func sell_legal() -> void:
    _sell_to_buyer(LICENSED_BUYER)

func sell_parallel() -> void:
    _sell_to_buyer(PARALLEL_BUYER)

func relationship_for_buyer(buyer_id: String) -> float:
    return float(buyer_relationships.get(buyer_id, 0.0))

func market_snapshot() -> Dictionary:
    var cultivation: Dictionary = _active_cultivation()
    var current_inventory := int(cultivation["inventory"])
    var current_quality := float(cultivation["batch_quality"])
    var buyers: Array = []

    for buyer_value in [LICENSED_BUYER, PARALLEL_BUYER]:
        var buyer: BuyerDefinition = buyer_value
        var buyer_id := String(buyer.id)
        var contract_id := String(buyer.contract_id)
        var relationship := relationship_for_buyer(buyer_id)
        var sale_preview: Dictionary = economy_service.resolve_sale(
            current_inventory,
            current_quality,
            buyer,
            relationship,
            district_price_multiplier(),
        )
        var contract_preview: Dictionary = economy_service.resolve_contract(
            current_inventory,
            current_quality,
            buyer,
            relationship,
            district_price_multiplier(),
        )

        var contract_state := "available"
        var contract_action := {
            "enabled": not game_over,
            "mode": "accept",
            "reason": "Disponível para aceite.",
        }
        if contract_id.is_empty():
            contract_state = "unavailable"
            contract_action = {
                "enabled": false,
                "mode": "none",
                "reason": "Contrato indisponível.",
            }
        elif not active_contract_id.is_empty():
            if active_contract_id == contract_id:
                contract_state = "active"
                contract_action = {
                    "enabled": (
                        not game_over
                        and bool(contract_preview.get("changed", false))
                    ),
                    "mode": "resolve",
                    "reason": (
                        "Pronto para concluir."
                        if bool(contract_preview.get("changed", false))
                        else String(
                            contract_preview.get(
                                "message",
                                "Contrato ainda não pode ser concluído.",
                            )
                        )
                    ),
                }
            else:
                contract_state = "blocked"
                contract_action = {
                    "enabled": false,
                    "mode": "none",
                    "reason": "Outro contrato já está ativo.",
                }

        buyers.append({
            "id": buyer_id,
            "display_name": buyer.display_name,
            "channel": "licensed" if buyer.channel == 0 else "parallel",
            "relationship": relationship,
            "sale_action": {
                "enabled": (
                    not game_over
                    and bool(sale_preview.get("changed", false))
                ),
                "reason": String(
                    sale_preview.get("message", "Venda indisponível.")
                ),
            },
            "sale_preview": _market_consequence_preview(sale_preview),
            "contract": {
                "id": contract_id,
                "units": buyer.contract_units,
                "min_quality": buyer.contract_min_quality,
                "cash_bonus": buyer.contract_cash_bonus,
                "relationship_gain": buyer.contract_relationship_gain,
                "state": contract_state,
                "action": contract_action,
                "completion_preview": _market_consequence_preview(
                    contract_preview
                ),
            },
        })

    return {
        "inventory": current_inventory,
        "batch_quality": current_quality,
        "quality_label": quality_label(),
        "active_contract_id": active_contract_id,
        "buyers": buyers,
        "compliance": {
            "level": compliance_level,
            "next_requirement": compliance_requirement(),
        },
        "district": {
            "id": active_district_id,
            "display_name": String(
                _district_definition_catalog()[active_district_id].display_name
            ),
            "demand": current_demand(),
            "price_multiplier": district_price_multiplier(),
        },
    }

func _market_consequence_preview(transition: Dictionary) -> Dictionary:
    if not bool(transition.get("changed", false)):
        return {
            "available": false,
            "message": String(
                transition.get("message", "Ação indisponível.")
            ),
        }

    return {
        "available": true,
        "cash_delta": int(transition.get("cash_delta", 0)),
        "reputation_delta": float(
            transition.get("reputation_delta", 0.0)
        ),
        "influence_delta": float(
            transition.get("influence_delta", 0.0)
        ),
        "heat_delta": float(transition.get("heat_delta", 0.0)),
        "relationship_delta": float(
            transition.get("relationship_delta", 0.0)
        ),
        "message": String(transition.get("message", "")),
    }

func accept_contract(contract_id: String) -> bool:
    if game_over or not active_contract_id.is_empty():
        return false

    var buyer: BuyerDefinition = _contract_catalog().get(contract_id)
    if buyer == null:
        return false

    active_contract_id = contract_id
    _post("Contrato aceito: %s." % buyer.display_name)
    state_changed.emit()
    return true

func resolve_active_contract() -> bool:
    if game_over or active_contract_id.is_empty():
        return false

    var buyer: BuyerDefinition = _contract_catalog().get(active_contract_id)
    if buyer == null:
        return false

    var cultivation := _active_cultivation()
    var buyer_id := String(buyer.id)
    var transition: Dictionary = economy_service.resolve_contract(
        int(cultivation["inventory"]),
        float(cultivation["batch_quality"]),
        buyer,
        relationship_for_buyer(buyer_id),
        district_price_multiplier(),
    )
    if not transition["changed"]:
        _post(transition["message"])
        return false

    cash += transition["cash_delta"]
    reputation = maxf(0.0, reputation + transition["reputation_delta"])
    influence = maxf(0.0, influence + transition["influence_delta"])
    heat = clampf(heat + transition["heat_delta"], 0.0, 100.0)
    _refresh_council_participation_flag()
    buyer_relationships[buyer_id] = clampf(
        relationship_for_buyer(buyer_id) + transition["relationship_delta"],
        0.0,
        100.0,
    )
    cultivation["inventory"] = transition["inventory"]
    cultivation["batch_quality"] = transition["batch_quality"]
    _write_active_cultivation(cultivation)
    active_contract_id = ""
    _advance_campaign_after_completed_sale()
    _post(transition["message"])
    state_changed.emit()
    return true

func compliance_snapshot() -> Dictionary:
    var requirement: Dictionary = compliance_requirement()
    var progression: Dictionary = compliance_service.resolve_progression(
        compliance_level,
        cash,
        reputation,
        influence,
        heat,
    )

    return {
        "level": compliance_level,
        "max_level": compliance_service.MAX_LEVEL,
        "complete": requirement.is_empty(),
        "next_requirement": requirement,
        "progression": {
            "available": bool(progression.get("changed", false)),
            "target_level": mini(
                compliance_level + 1,
                compliance_service.MAX_LEVEL,
            ),
            "message": String(
                progression.get(
                    "message",
                    "Progressão de compliance indisponível.",
                )
            ),
        },
    }

func compliance_requirement() -> Dictionary:
    return compliance_service.requirement_for(compliance_level)

func advance_compliance() -> bool:
    if game_over:
        return false

    var transition: Dictionary = compliance_service.resolve_progression(
        compliance_level,
        cash,
        reputation,
        influence,
        heat,
    )
    if not transition["changed"]:
        _post(transition["message"])
        return false

    compliance_level = int(transition["compliance_level"])
    cash += int(transition["cash_delta"])
    reputation = maxf(
        0.0,
        reputation + float(transition["reputation_delta"]),
    )
    influence = maxf(
        0.0,
        influence + float(transition["influence_delta"]),
    )
    heat = clampf(
        heat + float(transition["heat_delta"]),
        0.0,
        100.0,
    )
    _refresh_council_participation_flag()
    _post(transition["message"])
    state_changed.emit()
    return true

func civic_engagement() -> void:
    if game_over:
        return
    const COST := 80
    if cash < COST:
        _post("Capital insuficiente para a ação institucional.")
        return
    cash -= COST
    influence += 4.0
    reputation += 2.0
    _refresh_council_participation_flag()
    _post("Participação institucional concluída: Influence +4.")
    state_changed.emit()

func quality_label() -> String:
    if batch_quality >= 0.9:
        return "Boutique"
    if batch_quality >= 0.75:
        return "Premium"
    if batch_quality >= 0.55:
        return "Boa"
    return "Comum"

func progress_ratio() -> float:
    return clampf(float(grow_day) / float(current_cycle_days()), 0.0, 1.0)

func _sell_to_buyer(buyer: BuyerDefinition) -> void:
    if game_over:
        return

    var cultivation := _active_cultivation()
    var transition: Dictionary = economy_service.resolve_sale(
        int(cultivation["inventory"]),
        float(cultivation["batch_quality"]),
        buyer,
        relationship_for_buyer(String(buyer.id)),
        district_price_multiplier(),
    )
    if not transition["changed"]:
        _post(transition["message"])
        return

    cash += transition["cash_delta"]
    reputation = maxf(0.0, reputation + transition["reputation_delta"])
    influence = maxf(0.0, influence + transition["influence_delta"])
    heat = clampf(heat + transition["heat_delta"], 0.0, 100.0)
    _refresh_council_participation_flag()
    cultivation["inventory"] = transition["inventory"]
    cultivation["batch_quality"] = transition["batch_quality"]
    _write_active_cultivation(cultivation)
    _advance_campaign_after_completed_sale()
    _post(transition["message"])
    state_changed.emit()

func _advance_campaign_after_completed_sale() -> bool:
    if not completed_arc_ids.has(ACT_ONE_ARC_ID):
        completed_arc_ids.append(ACT_ONE_ARC_ID)
        narrative_flags[ACT_ONE_CONTACT_FLAG] = true
        narrative_flags[ACT_TWO_INTRODUCTION_FLAG] = true
        narrative_flags[ACT_ONE_MEMORY_FLAG] = true
        return true

    if not bool(narrative_flags.get(BUSINESS_SCALE_FLAG, false)):
        narrative_flags[BUSINESS_SCALE_FLAG] = true
        return true

    return false

func _refresh_council_participation_flag() -> bool:
    if influence < 4.0:
        return false
    if bool(narrative_flags.get(COUNCIL_PARTICIPATION_FLAG, false)):
        return false

    narrative_flags[COUNCIL_PARTICIPATION_FLAG] = true
    return true

func _complete_arc_for_narrative_event(event_id: String) -> bool:
    var arc_id := String(EVENT_ARC_COMPLETIONS.get(event_id, ""))
    if arc_id.is_empty() or completed_arc_ids.has(arc_id):
        return false

    completed_arc_ids.append(arc_id)
    return true

func _roll_event() -> void:
    var roll := rng.randi_range(0, 99)
    if roll < 9:
        var cultivation := _active_cultivation()
        cultivation["grow_health"] = clampf(
            float(cultivation["grow_health"]) - 0.08,
            0.15,
            1.0,
        )
        _write_active_cultivation(cultivation)
        _post("Evento: falha de equipamento reduziu a saúde do lote.")
    elif roll < 16:
        cash += 35
        _post("Evento: pequeno bônus operacional, +R$ 35.")
    elif roll < 21 and heat > 25.0:
        cash -= 45
        heat = maxf(0.0, heat - 8.0)
        _post("Evento: pressão regulatória gerou custo extraordinário.")

func _resolve_cultivar(content_id: StringName) -> CultivarDefinition:
    if content_id == DEFAULT_CULTIVAR.id:
        return DEFAULT_CULTIVAR
    return null

func _buyer_catalog() -> Dictionary:
    return {
        String(LICENSED_BUYER.id): LICENSED_BUYER,
        String(PARALLEL_BUYER.id): PARALLEL_BUYER,
    }

func _contract_catalog() -> Dictionary:
    return {
        String(LICENSED_BUYER.contract_id): LICENSED_BUYER,
        String(PARALLEL_BUYER.contract_id): PARALLEL_BUYER,
    }

func _default_buyer_relationships() -> Dictionary:
    return {
        String(LICENSED_BUYER.id): 0.0,
        String(PARALLEL_BUYER.id): 0.0,
    }

func _normalized_buyer_relationships(values: Dictionary) -> Dictionary:
    var normalized := _default_buyer_relationships()
    for buyer_id in values:
        normalized[String(buyer_id)] = clampf(
            float(values[buyer_id]),
            0.0,
            100.0,
        )
    return normalized

func _relationship_ids_are_known(values: Dictionary) -> bool:
    var catalog := _buyer_catalog()
    for buyer_id in values:
        if not catalog.has(String(buyer_id)):
            return false
    return true

func _room_definition_catalog() -> Dictionary:
    return {
        String(DEFAULT_ROOM_DEFINITION.id): DEFAULT_ROOM_DEFINITION,
        String(COMPACT_ROOM_DEFINITION.id): COMPACT_ROOM_DEFINITION,
    }

func _district_definition_catalog() -> Dictionary:
    return {
        String(MORRO_CEDRO.id): MORRO_CEDRO,
        String(CENTRO_BAIXO.id): CENTRO_BAIXO,
        String(BAIA_VELHA.id): BAIA_VELHA,
        String(ORLA_VIGIA.id): ORLA_VIGIA,
        String(ARCO_NORTE.id): ARCO_NORTE,
        String(RESTINGA_CLARA.id): RESTINGA_CLARA,
        String(MERCADO_MADRUGADA.id): MERCADO_MADRUGADA,
    }

func _default_district_demand() -> Dictionary:
    return city_service.initial_demand(_district_definition_catalog())

func _default_community_support() -> Dictionary:
    return community_service.initial_support(_district_definition_catalog())

func _policy_definition_catalog() -> Dictionary:
    return {
        String(PARTICIPATORY_REGISTRY.id): PARTICIPATORY_REGISTRY,
        String(LOCAL_MARKET_CHARTER.id): LOCAL_MARKET_CHARTER,
        String(BAY_CIVIC_COMPACT.id): BAY_CIVIC_COMPACT,
    }

func _narrative_event_catalog() -> Dictionary:
    return {
        String(FIRST_NARRATIVE_EVENT.id): FIRST_NARRATIVE_EVENT,
        String(SOL_PHOTO_EVENT.id): SOL_PHOTO_EVENT,
        String(FAROL_TAPE_EVENT.id): FAROL_TAPE_EVENT,
        String(COUNCIL_INVITATION_EVENT.id): COUNCIL_INVITATION_EVENT,
        String(ISA_TABLE_EVENT.id): ISA_TABLE_EVENT,
        String(FERRUGEM_LOT_EVENT.id): FERRUGEM_LOT_EVENT,
        String(FERRUGEM_MEMORY_EVENT.id): FERRUGEM_MEMORY_EVENT,
        String(GREEN_PERIOD_AUDIENCE_EVENT.id): GREEN_PERIOD_AUDIENCE_EVENT,
        String(STAR_PHOTO_EVENT.id): STAR_PHOTO_EVENT,
        String(RECONSTRUCTION_OPENING_EVENT.id): RECONSTRUCTION_OPENING_EVENT,
        String(CITY_PARTS_EVENT.id): CITY_PARTS_EVENT,
        String(DA_LATA_NAME_EVENT.id): DA_LATA_NAME_EVENT,
        String(FINAL_FORM_EVENT.id): FINAL_FORM_EVENT,
    }

func _research_step_catalog() -> Dictionary:
    return {
        String(FIRST_RESEARCH_STEP.id): FIRST_RESEARCH_STEP,
        String(SECOND_RESEARCH_STEP.id): SECOND_RESEARCH_STEP,
        String(THIRD_RESEARCH_STEP.id): THIRD_RESEARCH_STEP,
        String(FOURTH_RESEARCH_STEP.id): FOURTH_RESEARCH_STEP,
        String(FIFTH_RESEARCH_STEP.id): FIFTH_RESEARCH_STEP,
    }

func _known_ending_ids() -> Dictionary:
    return {
        String(ENDING_ELIGIBILITY_SERVICE.ENDING_MARCA_NACIONAL): true,
        String(ENDING_ELIGIBILITY_SERVICE.ENDING_REDE_VIVA): true,
        String(ENDING_ELIGIBILITY_SERVICE.ENDING_NOITE_SEM_ROTULO): true,
        String(ENDING_ELIGIBILITY_SERVICE.ENDING_ARQUIVO_PUBLICO): true,
        String(ENDING_ELIGIBILITY_SERVICE.ENDING_ATLANTICO): true,
        String(ENDING_ELIGIBILITY_SERVICE.ENDING_O_VERAO_VOLTA): true,
    }

func _known_narrative_arc_ids() -> Dictionary:
    var known := {}
    for definition_value in _narrative_event_catalog().values():
        var definition: NarrativeEventDefinition = definition_value
        var arc_id := String(definition.arc_id)
        var unlock_arc_id := String(definition.unlock_after_arc_id)
        if not arc_id.is_empty():
            known[arc_id] = true
        if not unlock_arc_id.is_empty():
            known[unlock_arc_id] = true
    return known

func _known_narrative_flag_ids() -> Dictionary:
    var known := {}
    for definition_value in _narrative_event_catalog().values():
        var definition: NarrativeEventDefinition = definition_value
        for flag_value in definition.required_flags:
            known[String(flag_value)] = true
        for flag_value in definition.forbidden_flags:
            known[String(flag_value)] = true
        for flag_value in definition.lore_assertions:
            known[String(flag_value)] = true
        for choice_id_value in definition.choice_ids:
            var choice_id := String(choice_id_value)
            for flag_value in definition.choice_flags.get(choice_id, PackedStringArray()):
                known[String(flag_value)] = true
    for definition_value in _research_step_catalog().values():
        var research_definition: ResearchStepDefinition = definition_value
        for flag_value in research_definition.required_flags:
            known[String(flag_value)] = true
        for flag_value in research_definition.forbidden_flags:
            known[String(flag_value)] = true
        for flag_value in research_definition.completion_flags:
            known[String(flag_value)] = true
    return known

func _narrative_flags_are_known(values: Dictionary) -> bool:
    var known := _known_narrative_flag_ids()
    for flag_id_value in values:
        var flag_id := String(flag_id_value)
        if not known.has(flag_id):
            return false
        if typeof(values[flag_id_value]) != TYPE_BOOL:
            return false
    return true

func _district_state_is_known(values: Dictionary) -> bool:
    var catalog := _district_definition_catalog()
    if values.size() != catalog.size():
        return false
    for district_id in values:
        var district_key := String(district_id)
        if not catalog.has(district_key):
            return false
        var demand_value := float(values[district_id])
        if demand_value < 0.0 or demand_value > 100.0:
            return false
    for district_id in catalog:
        if not values.has(district_id):
            return false
    return true

func _staff_definition_catalog() -> Dictionary:
    return {
        String(OPERATIONS_ASSISTANT.id): OPERATIONS_ASSISTANT,
    }

func _upgrade_definition_catalog() -> Dictionary:
    return {
        String(BASIC_SENSORS.id): BASIC_SENSORS,
    }

func _default_room_states() -> Array:
    return [
        _new_room_state(
            "room_1",
            String(DEFAULT_ROOM_DEFINITION.id),
        ),
    ]

func _new_room_state(
    instance_id: String,
    definition_id: String,
    cultivation_override: Dictionary = {},
) -> Dictionary:
    var cultivation: Dictionary
    if cultivation_override.is_empty():
        cultivation = cultivation_service.initial_state(DEFAULT_CULTIVAR)
        cultivation["active_cultivar_id"] = String(DEFAULT_CULTIVAR.id)
    else:
        cultivation = cultivation_override.duplicate(true)

    return {
        "instance_id": instance_id,
        "definition_id": definition_id,
        "cultivation": cultivation,
    }

func _legacy_cultivation_from_snapshot(snapshot: Dictionary) -> Dictionary:
    var cultivar := _resolve_cultivar(StringName(snapshot["active_cultivar_id"]))
    if cultivar == null:
        _post("Save inválido: cultivar desconhecido.")
        return {}

    return {
        "active_cultivar_id": String(cultivar.id),
        "grow_day": int(snapshot["grow_day"]),
        "grow_health": float(snapshot["grow_health"]),
        "cared_today": bool(snapshot["cared_today"]),
        "inventory": int(snapshot["inventory"]),
        "batch_quality": float(snapshot["batch_quality"]),
    }

func _active_cultivation() -> Dictionary:
    var room := _find_room(rooms, active_room_id)
    if room.is_empty():
        var fallback: Dictionary = cultivation_service.initial_state(DEFAULT_CULTIVAR)
        fallback["active_cultivar_id"] = String(DEFAULT_CULTIVAR.id)
        return fallback
    return Dictionary(room["cultivation"]).duplicate(true)

func _write_active_cultivation(cultivation: Dictionary) -> void:
    if _set_room_cultivation(rooms, active_room_id, cultivation):
        _sync_active_room_cache()

func _set_room_cultivation(
    room_list: Array,
    instance_id: String,
    cultivation: Dictionary,
) -> bool:
    for index in range(room_list.size()):
        var room_value = room_list[index]
        if typeof(room_value) != TYPE_DICTIONARY:
            continue
        var room: Dictionary = room_value
        if String(room.get("instance_id", "")) != instance_id:
            continue
        room["cultivation"] = cultivation.duplicate(true)
        room_list[index] = room
        return true
    return false

func _find_room(room_list: Array, instance_id: String) -> Dictionary:
    for room_value in room_list:
        if typeof(room_value) != TYPE_DICTIONARY:
            continue
        var room: Dictionary = room_value
        if String(room.get("instance_id", "")) == instance_id:
            return room
    return {}

func _sync_active_room_cache() -> void:
    var room := _find_room(rooms, active_room_id)
    if room.is_empty():
        return

    var cultivation: Dictionary = room["cultivation"]
    var cultivar := _resolve_cultivar(
        StringName(cultivation.get("active_cultivar_id", "")),
    )
    if cultivar == null:
        return

    active_cultivar = cultivar
    grow_day = int(cultivation.get("grow_day", 0))
    grow_health = float(cultivation.get("grow_health", 0.72))
    cared_today = bool(cultivation.get("cared_today", false))
    inventory = int(cultivation.get("inventory", 0))
    batch_quality = float(cultivation.get("batch_quality", 0.0))

func _has_room(instance_id: String) -> bool:
    return _room_list_has_instance(rooms, instance_id)

func _room_list_has_instance(room_list: Array, instance_id: String) -> bool:
    for room_value in room_list:
        if typeof(room_value) != TYPE_DICTIONARY:
            continue
        var room: Dictionary = room_value
        if String(room.get("instance_id", "")) == instance_id:
            return true
    return false

func _rooms_have_known_definitions(room_list: Array) -> bool:
    var catalog := _room_definition_catalog()
    for room_value in room_list:
        if typeof(room_value) != TYPE_DICTIONARY:
            return false
        var room: Dictionary = room_value
        var definition_id := String(room.get("definition_id", ""))
        if not catalog.has(definition_id):
            return false
    return true

func _rooms_have_known_cultivars(room_list: Array) -> bool:
    for room_value in room_list:
        if typeof(room_value) != TYPE_DICTIONARY:
            return false
        var room: Dictionary = room_value
        if typeof(room.get("cultivation")) != TYPE_DICTIONARY:
            return false
        var cultivation: Dictionary = room["cultivation"]
        var cultivar_id := StringName(cultivation.get("active_cultivar_id", ""))
        if _resolve_cultivar(cultivar_id) == null:
            return false
    return true

func _ids_are_known(ids: Array, catalog: Dictionary) -> bool:
    for id_value in ids:
        if not catalog.has(String(id_value)):
            return false
    return true

func _reset_rng() -> void:
    if simulation_seed >= 0:
        rng.seed = simulation_seed
    else:
        rng.randomize()

func _post(text: String) -> void:
    message_posted.emit(text)
