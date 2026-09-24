extends Control

signal management_requested

@onready var game_state = get_node("/root/GameState")
@onready var active_room_label: Label = %ActiveRoomLabel
@onready var cycle_label: Label = %CycleLabel
@onready var health_label: Label = %HealthLabel
@onready var inventory_label: Label = %InventoryLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var availability_label: Label = %AvailabilityLabel
@onready var feedback_label: Label = %FeedbackLabel
@onready var care_button: Button = %CareButton
@onready var next_day_button: Button = %NextDayButton
@onready var harvest_button: Button = %HarvestButton

func _ready() -> void:
    game_state.state_changed.connect(_refresh)
    game_state.message_posted.connect(_on_message)
    _refresh()
    _on_message("Operação pronta. As ações usam o estado canônico da campanha.")

func _refresh() -> void:
    active_room_label.text = "Sala ativa: %s" % game_state.active_room_id
    cycle_label.text = "Ciclo: dia %d / %d" % [
        game_state.grow_day,
        game_state.current_cycle_days(),
    ]
    health_label.text = "Saúde do lote: %d%%" % int(round(game_state.grow_health * 100.0))
    inventory_label.text = "Estoque local: %d" % game_state.inventory
    progress_bar.value = game_state.progress_ratio() * 100.0

    var availability: Dictionary = game_state.cultivation_action_availability()
    _apply_action_state(care_button, Dictionary(availability.get("care", {})))
    _apply_action_state(
        next_day_button,
        Dictionary(availability.get("advance_day", {})),
    )
    _apply_action_state(
        harvest_button,
        Dictionary(availability.get("harvest", {})),
    )
    availability_label.text = _blocked_action_summary(availability)

func _apply_action_state(button: Button, state: Dictionary) -> void:
    var enabled := bool(state.get("enabled", false))
    button.disabled = not enabled
    button.tooltip_text = String(state.get("reason", ""))

func _blocked_action_summary(availability: Dictionary) -> String:
    var blocked: Array[String] = []
    var labels := {
        "care": "Cuidar",
        "advance_day": "Avançar dia",
        "harvest": "Colher",
    }
    for action_id in ["care", "advance_day", "harvest"]:
        var state := Dictionary(availability.get(action_id, {}))
        if bool(state.get("enabled", false)):
            continue
        var reason := String(state.get("reason", "Ação indisponível."))
        blocked.append("%s: %s" % [String(labels[action_id]), reason])

    if blocked.is_empty():
        return "Todas as ações do ciclo estão disponíveis."

    var summary := ""
    for item in blocked:
        if not summary.is_empty():
            summary += " | "
        summary += item
    return "Bloqueios atuais — %s" % summary

func _on_message(text: String) -> void:
    feedback_label.text = text

func _on_care_pressed() -> void:
    game_state.care_for_room()

func _on_next_day_pressed() -> void:
    game_state.next_day()

func _on_harvest_pressed() -> void:
    game_state.harvest()

func _on_management_pressed() -> void:
    feedback_label.text = "Gestão detalhada da operação solicitada."
    management_requested.emit()
