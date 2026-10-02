extends Control

signal management_requested

@export var embedded_in_3d_parent := false

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
@onready var management_button: Button = %ManagementButton
@onready var management_panel: PanelContainer = %ManagementPanel
@onready var management_summary_label: Label = %ManagementSummaryLabel
@onready var rooms_container: VBoxContainer = %RoomsContainer
@onready var staff_container: VBoxContainer = %StaffContainer
@onready var upgrades_container: VBoxContainer = %UpgradesContainer
@onready var interactive_3d: Control = %Interactive3D

func _ready() -> void:
    interactive_3d.visible = not embedded_in_3d_parent
    if embedded_in_3d_parent:
        _configure_embedded_presentation()
    game_state.state_changed.connect(_refresh)
    game_state.message_posted.connect(_on_message)
    _refresh()
    _on_message("Operação pronta. As ações usam o estado canônico da campanha.")

func _configure_embedded_presentation() -> void:
    # Revision 12: keep every canonical action and state transition, but make
    # the embedded surface a compact HUD instead of a large translucent mask
    # over the accepted Operation diorama.
    # Structural rebase: keep the empty feedback panel removed and reserve less
    # portrait height for the embedded HUD so accepted room anchors remain visible.
    # Canonical actions/state ownership and accessible fallbacks remain unchanged.
    custom_minimum_size = Vector2(0, 124)
    $VBox.add_theme_constant_override("separation", 3)
    $VBox/Heading.visible = false
    active_room_label.visible = false
    availability_label.visible = false
    inventory_label.visible = false
    feedback_label.visible = false
    $VBox/FeedbackPanel.visible = false
    $VBox/ManagementHandoff/ManagementCopy.visible = false
    cycle_label.add_theme_font_size_override("font_size", 12)
    health_label.add_theme_font_size_override("font_size", 11)
    progress_bar.custom_minimum_size = Vector2(0, 14)
    care_button.custom_minimum_size = Vector2(0, 30)
    next_day_button.custom_minimum_size = Vector2(0, 30)
    harvest_button.custom_minimum_size = Vector2(0, 30)
    management_button.custom_minimum_size = Vector2(104, 30)


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

    if management_panel.visible:
        _refresh_management()

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

func _refresh_management() -> void:
    var snapshot: Dictionary = game_state.management_snapshot()
    management_summary_label.text = "Custo diário: R$%d | Estabilidade: %s" % [
        int(snapshot.get("daily_operating_cost", 0)),
        _signed_percent(float(snapshot.get("health_stability_modifier", 0.0))),
    ]

    _clear_container(rooms_container)
    for entry_value in Array(snapshot.get("rooms", [])):
        var entry: Dictionary = entry_value
        var action_state := Dictionary(entry.get("action", {}))
        var row := HBoxContainer.new()
        var label := Label.new()
        label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        label.text = "%s (%s) — R$%d/dia" % [
            String(entry.get("display_name", "")),
            String(entry.get("instance_id", "")),
            int(entry.get("daily_operating_cost", 0)),
        ]
        var button := Button.new()
        button.text = "Ativa" if String(entry.get("state", "")) == "active" else "Selecionar"
        button.disabled = not bool(action_state.get("enabled", false))
        button.tooltip_text = String(action_state.get("reason", ""))
        button.pressed.connect(
            _on_room_selected.bind(String(entry.get("instance_id", "")))
        )
        row.add_child(label)
        row.add_child(button)
        rooms_container.add_child(row)

    _clear_container(staff_container)
    for entry_value in Array(snapshot.get("staff", [])):
        var entry: Dictionary = entry_value
        var action_state := Dictionary(entry.get("action", {}))
        var row := HBoxContainer.new()
        var label := Label.new()
        label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        label.text = "%s — contratar R$%d | +R$%d/dia | estabilidade %s\n%s" % [
            String(entry.get("display_name", "")),
            int(entry.get("hire_cost", 0)),
            int(entry.get("daily_cost", 0)),
            _signed_percent(float(entry.get("health_stability_delta", 0.0))),
            String(entry.get("description", "")),
        ]
        var button := Button.new()
        button.text = "Contratado" if String(entry.get("state", "")) == "owned" else "Contratar"
        button.disabled = not bool(action_state.get("enabled", false))
        button.tooltip_text = String(action_state.get("reason", ""))
        button.pressed.connect(_on_staff_hire.bind(String(entry.get("id", ""))))
        row.add_child(label)
        row.add_child(button)
        staff_container.add_child(row)

    _clear_container(upgrades_container)
    for entry_value in Array(snapshot.get("upgrades", [])):
        var entry: Dictionary = entry_value
        var action_state := Dictionary(entry.get("action", {}))
        var row := HBoxContainer.new()
        var label := Label.new()
        label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        label.text = "%s — adquirir R$%d | +R$%d/dia | estabilidade %s\n%s" % [
            String(entry.get("display_name", "")),
            int(entry.get("cost", 0)),
            int(entry.get("daily_upkeep_delta", 0)),
            _signed_percent(float(entry.get("health_stability_delta", 0.0))),
            String(entry.get("description", "")),
        ]
        var button := Button.new()
        button.text = "Adquirido" if String(entry.get("state", "")) == "owned" else "Adquirir"
        button.disabled = not bool(action_state.get("enabled", false))
        button.tooltip_text = String(action_state.get("reason", ""))
        button.pressed.connect(_on_upgrade_purchase.bind(String(entry.get("id", ""))))
        row.add_child(label)
        row.add_child(button)
        upgrades_container.add_child(row)

func _clear_container(container: Container) -> void:
    for child in container.get_children():
        container.remove_child(child)
        child.queue_free()

func _signed_percent(value: float) -> String:
    var percent := int(round(value * 100.0))
    if percent > 0:
        return "+%d%%" % percent
    return "%d%%" % percent

func _management_reason(collection_key: String, id_key: String, target_id: String) -> String:
    var snapshot: Dictionary = game_state.management_snapshot()
    for entry_value in Array(snapshot.get(collection_key, [])):
        var entry: Dictionary = entry_value
        if String(entry.get(id_key, "")) != target_id:
            continue
        return String(Dictionary(entry.get("action", {})).get("reason", "Ação indisponível."))
    return "Ação de gestão indisponível."

func _on_message(text: String) -> void:
    feedback_label.text = text

func _on_care_pressed() -> void:
    game_state.care_for_room()

func _on_next_day_pressed() -> void:
    game_state.next_day()

func _on_harvest_pressed() -> void:
    game_state.harvest()

func focus_presentation_region(region_id: String) -> void:
    match region_id:
        "cultivation":
            feedback_label.text = (
                "Cultivo 3D selecionado. As ações do ciclo permanecem nos controles existentes."
            )
            call_deferred("_focus_cultivation_presentation")
        "management":
            feedback_label.text = (
                "Armazenamento 3D selecionado. Gestão foi aberta apenas como apresentação."
            )
            call_deferred("_focus_management_presentation")

func _focus_cultivation_presentation() -> void:
    care_button.grab_focus()

func _focus_management_presentation() -> void:
    if not management_panel.visible:
        management_panel.visible = true
        management_button.text = "Fechar gestão"
        _refresh_management()
    management_button.grab_focus()

func _on_management_pressed() -> void:
    management_panel.visible = not management_panel.visible
    management_button.text = "Fechar gestão" if management_panel.visible else "Abrir gestão"
    if management_panel.visible:
        _refresh_management()
        feedback_label.text = "Gestão detalhada aberta com dados canônicos da operação."
        management_requested.emit()
    else:
        feedback_label.text = "Gestão detalhada fechada."

func _on_room_selected(instance_id: String) -> void:
    if game_state.switch_active_room(instance_id):
        feedback_label.text = "Sala ativa atualizada."
        return
    feedback_label.text = _management_reason("rooms", "instance_id", instance_id)

func _on_staff_hire(staff_id: String) -> void:
    if game_state.hire_staff(staff_id):
        return
    feedback_label.text = _management_reason("staff", "id", staff_id)

func _on_upgrade_purchase(upgrade_id: String) -> void:
    if game_state.purchase_upgrade(upgrade_id):
        return
    feedback_label.text = _management_reason("upgrades", "id", upgrade_id)
