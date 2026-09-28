extends Control

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var interactive_object: Area3D = $ViewportContainer/Viewport/World/DealCounterInteraction
@onready var contract_tray: MeshInstance3D = $ViewportContainer/Viewport/World/DealCounter/ContractTray
@onready var action_button: Button = $ObjectActionButton
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween
var _base_tray_position := Vector3.ZERO

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Abrir canais do Mercado — alternativa ao balcão 3D"
    _base_tray_position = contract_tray.position

func activate_primary_object() -> void:
    activation_count += 1
    interaction_status.text = "Balcão selecionado • toque leva aos canais de venda"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    contract_tray.position = _base_tray_position + Vector3(0.0, 0.10, 0.0)
    contract_tray.rotation.y = -0.18
    _pulse_tween = create_tween()
    _pulse_tween.set_parallel(true)
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(contract_tray, "position", _base_tray_position, 0.28)
    _pulse_tween.tween_property(contract_tray, "rotation:y", 0.0, 0.28)
    object_activated.emit("market", "deal_counter")

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func _on_deal_counter_input_event(
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
