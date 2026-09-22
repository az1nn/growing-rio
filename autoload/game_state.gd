extends Node

signal state_changed
signal message_posted(text: String)

const MAX_DAYS := 30
const DAILY_UPKEEP := 15

const DEFAULT_CULTIVAR := preload("res://resources/cultivars/quarto_classica.tres")
const LICENSED_BUYER := preload("res://resources/buyers/varejista_licenciado.tres")
const PARALLEL_BUYER := preload("res://resources/buyers/rede_paralela.tres")
const CULTIVATION_SERVICE := preload("res://domain/cultivation/cultivation_service.gd")
const ECONOMY_SERVICE := preload("res://domain/economy/economy_service.gd")
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

var simulation_seed := -1
var rng := RandomNumberGenerator.new()
var cultivation_service := CULTIVATION_SERVICE.new()
var economy_service := ECONOMY_SERVICE.new()
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

func create_save_data() -> Dictionary:
    return save_service.create_v1(
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

    var simulation: Dictionary = parsed["simulation"]
    simulation_seed = int(simulation["seed"])
    # Restore the exact generator position after JSON-safe string transport.
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
    cash -= DAILY_UPKEEP
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
    # Abstract game risk/reward only; no real-world logistics.
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

func _reset_rng() -> void:
    if simulation_seed >= 0:
        rng.seed = simulation_seed
    else:
        rng.randomize()

func _post(text: String) -> void:
    message_posted.emit(text)
