extends Control

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var interactive_object: Area3D = $ViewportContainer/Viewport/World/CampaignLedgerInteraction
@onready var ledger: MeshInstance3D = $ViewportContainer/Viewport/World/CampaignDesk/Ledger
@onready var action_button: Button = $ObjectActionButton
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween
var _base_ledger_position := Vector3.ZERO

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Inspecionar calendário da campanha — alternativa ao livro 3D"
    _base_ledger_position = ledger.position

func activate_primary_object() -> void:
    activation_count += 1
    interaction_status.text = "Calendário selecionado • ações da campanha permanecem abaixo"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    ledger.position = _base_ledger_position + Vector3(0.0, 0.10, 0.0)
    ledger.rotation.y = -0.12
    _pulse_tween = create_tween()
    _pulse_tween.set_parallel(true)
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(ledger, "position", _base_ledger_position, 0.28)
    _pulse_tween.tween_property(ledger, "rotation:y", 0.0, 0.28)
    object_activated.emit("campaign", "campaign_ledger")

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func _on_campaign_ledger_input_event(
    _camera: Node,
    event: InputEvent,
    _event_position: Vector3,
    _normal: Vector3,
    _shape_idx: int,
) -> void:
    if event is InputEventMouseButton:
        var mouse_event := event as InputEventMouseButton
        if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
            activate_primary_object()
    elif event is InputEventScreenTouch:
        var touch_event := event as InputEventScreenTouch
        if touch_event.pressed:
            activate_primary_object()

func _on_object_action_button_pressed() -> void:
    activate_primary_object()
