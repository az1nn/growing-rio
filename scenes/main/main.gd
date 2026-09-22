extends Control

@onready var day_label: Label = %DayLabel
@onready var cash_label: Label = %CashLabel
@onready var heat_label: Label = %HeatLabel
@onready var rep_label: Label = %RepLabel
@onready var influence_label: Label = %InfluenceLabel
@onready var health_label: Label = %HealthLabel
@onready var inventory_label: Label = %InventoryLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var log_label: Label = %LogLabel
@onready var harvest_button: Button = %HarvestButton
@onready var legal_button: Button = %LegalButton
@onready var parallel_button: Button = %ParallelButton

func _ready() -> void:
    GameState.state_changed.connect(_refresh)
    GameState.message_posted.connect(_on_message)
    _refresh()
    _on_message("Vertical slice iniciado. Administre o primeiro ciclo de 30 dias.")

func _refresh() -> void:
    day_label.text = "DIA %d / %d" % [GameState.day, GameState.MAX_DAYS]
    cash_label.text = "Caixa\nR$ %d" % GameState.cash
    heat_label.text = "Heat\n%d" % int(round(GameState.heat))
    rep_label.text = "Reputação\n%d" % int(round(GameState.reputation))
    influence_label.text = "Influence\n%d" % int(round(GameState.influence))
    health_label.text = "Saúde do lote: %d%%" % int(round(GameState.grow_health * 100.0))
    inventory_label.text = "Estoque: %d" % GameState.inventory
    progress_bar.value = GameState.progress_ratio() * 100.0
    harvest_button.disabled = GameState.grow_day < GameState.current_cycle_days() or GameState.inventory > 0
    legal_button.disabled = GameState.inventory <= 0
    parallel_button.disabled = GameState.inventory <= 0

func _on_message(text: String) -> void:
    log_label.text = text

func _on_care_pressed() -> void:
    GameState.care_for_room()

func _on_next_day_pressed() -> void:
    GameState.next_day()

func _on_harvest_pressed() -> void:
    GameState.harvest()

func _on_legal_pressed() -> void:
    GameState.sell_legal()

func _on_parallel_pressed() -> void:
    GameState.sell_parallel()

func _on_civic_pressed() -> void:
    GameState.civic_engagement()

func _on_reset_pressed() -> void:
    GameState.reset()
