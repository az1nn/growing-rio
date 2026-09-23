extends Node

signal state_changed
signal message_posted(text: String)

const MAX_DAYS := 30

const DEFAULT_CULTIVAR := preload("res://resources/cultivars/quarto_classica.tres")
const LICENSED_BUYER := preload("res://resources/buyers/varejista_licenciado.tres")
const PARALLEL_BUYER := preload("res://resources/buyers/rede_paralela.tres")
const DEFAULT_ROOM_DEFINITION := preload("res://resources/rooms/quarto_inicial.tres")
const COMPACT_ROOM_DEFINITION := preload("res://resources/rooms/sala_compacta.tres")
const BASIC_SENSORS := preload("res://resources/upgrades/sensores_basicos.tres")
const OPERATIONS_ASSISTANT := preload("res://resources/staff/assistente_operacional.tres")
const CULTIVATION_SERVICE := preload("res://domain/cultivation/cultivation_service.gd")
const ECONOMY_SERVICE := preload("res://domain/economy/economy_service.gd")
const BUSINESS_SERVICE := preload("res://domain/business/business_service.gd")
const COMPLIANCE_SERVICE := preload("res://domain/business/compliance_service.gd")
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

var simulation_seed := -1
var rng := RandomNumberGenerator.new()
var cultivation_service := CULTIVATION_SERVICE.new()
var economy_service := ECONOMY_SERVICE.new()
var business_service := BUSINESS_SERVICE.new()
var compliance_service := COMPLIANCE_SERVICE.new()
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

func room_count() -> int:
    return rooms.size()

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
    return save_service.create_v6(
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
    _sync_active_room_cache()

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
    )
    if not transition["changed"]:
        _post(transition["message"])
        return false

    cash += transition["cash_delta"]
    reputation = maxf(0.0, reputation + transition["reputation_delta"])
    influence = maxf(0.0, influence + transition["influence_delta"])
    heat = clampf(heat + transition["heat_delta"], 0.0, 100.0)
    buyer_relationships[buyer_id] = clampf(
        relationship_for_buyer(buyer_id) + transition["relationship_delta"],
        0.0,
        100.0,
    )
    cultivation["inventory"] = transition["inventory"]
    cultivation["batch_quality"] = transition["batch_quality"]
    _write_active_cultivation(cultivation)
    active_contract_id = ""
    _post(transition["message"])
    state_changed.emit()
    return true

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
    )
    if not transition["changed"]:
        _post(transition["message"])
        return

    cash += transition["cash_delta"]
    reputation = maxf(0.0, reputation + transition["reputation_delta"])
    influence = maxf(0.0, influence + transition["influence_delta"])
    heat = clampf(heat + transition["heat_delta"], 0.0, 100.0)
    cultivation["inventory"] = transition["inventory"]
    cultivation["batch_quality"] = transition["batch_quality"]
    _write_active_cultivation(cultivation)
    _post(transition["message"])
    state_changed.emit()

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
