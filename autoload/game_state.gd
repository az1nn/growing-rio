extends Node

signal state_changed
signal message_posted(text: String)

const MAX_DAYS := 30
const DAILY_UPKEEP := 15
const GROW_DAYS := 8

var day := 1
var cash := 250
var heat := 5.0
var reputation := 0.0
var influence := 0.0

var grow_day := 0
var grow_health := 0.72
var cared_today := false
var inventory := 0
var batch_quality := 0.0
var game_over := false

var rng := RandomNumberGenerator.new()

func _ready() -> void:
    rng.randomize()

func reset() -> void:
    day = 1
    cash = 250
    heat = 5.0
    reputation = 0.0
    influence = 0.0
    grow_day = 0
    grow_health = 0.72
    cared_today = false
    inventory = 0
    batch_quality = 0.0
    game_over = false
    _post("Novo ciclo iniciado.")
    state_changed.emit()

func care_for_room() -> void:
    if game_over:
        return
    if cared_today:
        _post("O espaço já recebeu os cuidados do dia.")
        return
    if grow_day >= GROW_DAYS:
        _post("O lote já está pronto para colheita.")
        return
    cared_today = true
    grow_health = clampf(grow_health + 0.08, 0.0, 1.0)
    cash -= 5
    _post("Cuidados concluídos: saúde do lote melhorou.")
    state_changed.emit()

func next_day() -> void:
    if game_over:
        return
    cash -= DAILY_UPKEEP
    if grow_day < GROW_DAYS:
        grow_day += 1
        var neglect_penalty := -0.07 if not cared_today else 0.01
        grow_health = clampf(grow_health + neglect_penalty + rng.randf_range(-0.03, 0.03), 0.15, 1.0)
    cared_today = false
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
    if grow_day < GROW_DAYS:
        _post("O lote ainda não está pronto.")
        return
    if inventory > 0:
        _post("Venda o estoque atual antes de iniciar outro lote.")
        return
    batch_quality = clampf(grow_health * 0.85 + rng.randf_range(0.05, 0.15), 0.0, 1.0)
    inventory = maxi(1, int(round(8.0 + grow_health * 8.0)))
    grow_day = 0
    grow_health = clampf(0.65 + rng.randf_range(-0.05, 0.05), 0.4, 0.9)
    cared_today = false
    reputation += batch_quality * 2.0
    _post("Lote concluído: %d unidades, qualidade %s." % [inventory, quality_label()])
    state_changed.emit()

func sell_legal() -> void:
    if not _can_sell():
        return
    var unit_price := int(round(18.0 + batch_quality * 18.0))
    var revenue := inventory * unit_price
    cash += revenue
    reputation += 5.0 + batch_quality * 4.0
    influence += 1.0
    heat = maxf(0.0, heat - 2.0)
    _post("Venda a varejista licenciado concluída: +R$ %d." % revenue)
    _clear_inventory()

func sell_parallel() -> void:
    if not _can_sell():
        return
    # Abstract game risk/reward only; no real-world logistics.
    var unit_price := int(round(27.0 + batch_quality * 25.0))
    var revenue := inventory * unit_price
    cash += revenue
    reputation = maxf(0.0, reputation - 1.0)
    heat = clampf(heat + 12.0 + inventory * 0.4, 0.0, 100.0)
    _post("Contrato do mercado paralelo resolvido: +R$ %d, Heat aumentou." % revenue)
    _clear_inventory()

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
    return clampf(float(grow_day) / float(GROW_DAYS), 0.0, 1.0)

func _can_sell() -> bool:
    if game_over:
        return false
    if inventory <= 0:
        _post("Não há estoque disponível.")
        return false
    return true

func _clear_inventory() -> void:
    inventory = 0
    batch_quality = 0.0
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

func _post(text: String) -> void:
    message_posted.emit(text)
