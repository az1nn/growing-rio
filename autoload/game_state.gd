extends Node

signal state_changed
signal message_posted(text: String)

const MAX_DAYS := 30

const DEFAULT_CULTIVAR := preload("res://resources/cultivars/quarto_classica.tres")
const LICENSED_BUYER := preload("res://resources/buyers/varejista_licenciado.tres")
const PARALLEL_BUYER := preload("res://resources/buyers/rede_paralela.tres")
const DEFAULT_ROOM_DEFINITION := preload("res://resources/rooms/quarto_inicial.tres")
const COMPACT_ROOM_DEFINITION := preload("res://resources/rooms/sala_compacta.tres")
const CULTIVATION_SERVICE := preload("res://domain/cultivation/cultivation_service.gd")
const ECONOMY_SERVICE := preload("res://domain/economy/economy_service.gd")
const BUSINESS_SERVICE := preload("res://domain/business/business_service.gd")
const SAVE_SERVICE := preload("res://autoload/save_service.gd")

var day := 1
var cash := 250
var heat := 5.0
var reputation := 0.0
var influence := 0.0

var active_cultivar: CultivarDefinition = DEFAULT_CULTIVAR
var grow_day := 0
var grow_health := 0.72
var cared_today := false
var inventory := 0
var batch_quality := 0.0
var game_over := false

var rooms: Array = [
    {
        "instance_id": "room_1",
        "definition_id": "quarto_inicial",
    },
]
var active_room_id := "room_1"

var simulation_seed := -1
var rng := RandomNumberGenerator.new()
var cultivation_service := CULTIVATION_SERVICE.new()
var economy_service := ECONOMY_SERVICE.new()
var business_service := BUSINESS_SERVICE.new()
var save_service := SAVE_SERVICE.new()

func _ready() -> void:
    _reset_rng()

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
    return business_service.daily_operating_cost(
        rooms,
        _room_definition_catalog(),
    )

func add_room(instance_id: String, definition_id: String) -> bool:
    if instance_id.is_empty() or definition_id.is_empty():
        return false
    if _has_room(instance_id):
        return false
    if not _room_definition_catalog().has(definition_id):
        return false

    rooms.append({
        "instance_id": instance_id,
        "definition_id": definition_id,
    })
    state_changed.emit()
    return true

func create_save_data() -> Dictionary:
    return save_service.create_v2(
        {
            "day": day,
            "cash": cash,
            "heat": heat,
            "reputation": reputation,
            "influence": influence,
            "grow_day": grow_day,
            "grow_health": grow_health,
            "cared_today": cared_today,
            "inventory": inventory,
            "batch_quality": batch_quality,
            "game_over": game_over,
        },
        String(active_cultivar.id),
        rooms,
        active_room_id,
        simulation_seed,
        rng.state,
    )

func load_save_data(payload: Dictionary) -> bool:
    var parsed: Dictionary = save_service.parse(payload)
    if not parsed["ok"]:
        _post("Save inválido: %s" % parsed["error"])
        return false

    var snapshot: Dictionary = parsed["state"]
    var cultivar := _resolve_cultivar(StringName(snapshot["active_cultivar_id"]))
    if cultivar == null:
        _post("Save inválido: cultivar desconhecido.")
        return false

    var loaded_rooms: Array
    var loaded_active_room_id: String
    if int(parsed["schema_version"]) == 1:
        loaded_rooms = _default_room_states()
        loaded_active_room_id = "room_1"
    else:
        var business: Dictionary = parsed["business"]
        loaded_rooms = business["rooms"].duplicate(true)
        loaded_active_room_id = String(business["active_room_id"])
        if not _rooms_have_known_definitions(loaded_rooms):
            _post("Save inválido: definição de sala desconhecida.")
            return false
        if not _room_list_has_instance(loaded_rooms, loaded_active_room_id):
            _post("Save inválido: sala ativa desconhecida.")
            return false

    day = int(snapshot["day"])
    cash = int(snapshot["cash"])
    heat = float(snapshot["heat"])
    reputation = float(snapshot["reputation"])
    influence = float(snapshot["influence"])
    active_cultivar = cultivar
    grow_day = int(snapshot["grow_day"])
    grow_health = float(snapshot["grow_health"])
    cared_today = bool(snapshot["cared_today"])
    inventory = int(snapshot["inventory"])
    batch_quality = float(snapshot["batch_quality"])
    game_over = bool(snapshot["game_over"])
    rooms = loaded_rooms
    active_room_id = loaded_active_room_id

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
    rooms = _default_room_states()
    active_room_id = "room_1"
    active_cultivar = DEFAULT_CULTIVAR
    var cultivation_state: Dictionary = cultivation_service.initial_state(active_cultivar)
    grow_day = cultivation_state["grow_day"]
    grow_health = cultivation_state["grow_health"]
    cared_today = cultivation_state["cared_today"]
    inventory = cultivation_state["inventory"]
    batch_quality = cultivation_state["batch_quality"]
    game_over = false
    _post("Novo ciclo iniciado.")
    state_changed.emit()

func care_for_room() -> void:
    if game_over:
        return

    var transition: Dictionary = cultivation_service.care(
        grow_day,
        grow_health,
        cared_today,
        current_cycle_days(),
    )
    if not transition["changed"]:
        _post(transition["message"])
        return

    grow_health = transition["grow_health"]
    cared_today = transition["cared_today"]
    cash += transition["cash_delta"]
    _post(transition["message"])
    state_changed.emit()

func next_day() -> void:
    if game_over:
        return
    cash -= daily_operating_cost()
    var cultivation_transition: Dictionary = cultivation_service.advance_day(
        grow_day,
        grow_health,
        cared_today,
        current_cycle_days(),
        rng,
    )
    grow_day = cultivation_transition["grow_day"]
    grow_health = cultivation_transition["grow_health"]
    cared_today = cultivation_transition["cared_today"]
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

    var transition: Dictionary = cultivation_service.harvest(
        grow_day,
        grow_health,
        inventory,
        active_cultivar,
        rng,
    )
    if not transition["changed"]:
        _post(transition["message"])
        return

    grow_day = transition["grow_day"]
    grow_health = transition["grow_health"]
    cared_today = transition["cared_today"]
    inventory = transition["inventory"]
    batch_quality = transition["batch_quality"]
    reputation += transition["reputation_delta"]
    _post("Lote concluído: %d unidades, qualidade %s." % [inventory, quality_label()])
    state_changed.emit()

func sell_legal() -> void:
    _sell_to_buyer(LICENSED_BUYER)

func sell_parallel() -> void:
    _sell_to_buyer(PARALLEL_BUYER)

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

    var transition: Dictionary = economy_service.resolve_sale(
        inventory,
        batch_quality,
        buyer,
    )
    if not transition["changed"]:
        _post(transition["message"])
        return

    cash += transition["cash_delta"]
    reputation = maxf(0.0, reputation + transition["reputation_delta"])
    influence = maxf(0.0, influence + transition["influence_delta"])
    heat = clampf(heat + transition["heat_delta"], 0.0, 100.0)
    inventory = transition["inventory"]
    batch_quality = transition["batch_quality"]
    _post(transition["message"])
    state_changed.emit()

func _roll_event() -> void:
    var roll := rng.randi_range(0, 99)
    if roll < 9:
        grow_health = clampf(grow_health - 0.08, 0.15, 1.0)
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

func _room_definition_catalog() -> Dictionary:
    return {
        String(DEFAULT_ROOM_DEFINITION.id): DEFAULT_ROOM_DEFINITION,
        String(COMPACT_ROOM_DEFINITION.id): COMPACT_ROOM_DEFINITION,
    }

func _default_room_states() -> Array:
    return [
        {
            "instance_id": "room_1",
            "definition_id": String(DEFAULT_ROOM_DEFINITION.id),
        },
    ]

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

func _reset_rng() -> void:
    if simulation_seed >= 0:
        rng.seed = simulation_seed
    else:
        rng.randomize()

func _post(text: String) -> void:
    message_posted.emit(text)
