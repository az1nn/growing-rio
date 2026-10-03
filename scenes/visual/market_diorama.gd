extends Control

const V1PixelRenderPolicy = preload("res://scenes/visual/v1/v1_pixel_render_policy.gd")

signal object_activated(context_id: String, object_id: String)

@onready var viewport_container: SubViewportContainer = $ViewportContainer
@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var interactive_object: Area3D = $ViewportContainer/Viewport/World/DealCounterInteraction
@onready var contract_interactive_object: Area3D = $ViewportContainer/Viewport/World/ContractTrayInteraction
@onready var buyer_marker: MeshInstance3D = $ViewportContainer/Viewport/World/DealCounter/CounterTerminal
@onready var contract_tray: MeshInstance3D = $ViewportContainer/Viewport/World/DealCounter/ContractTray
@onready var action_button: Button = $ObjectActionButton
@onready var contract_button: Button = $ContractActionButton
@onready var deal_touch_target: Button = $DealCounterTouchTarget
@onready var contract_touch_target: Button = $ContractTouchTarget
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween
var _base_tray_position := Vector3.ZERO
var _base_buyer_marker_scale := Vector3.ONE
var _embedded_ui_mode := false

func _ready() -> void:
    V1PixelRenderPolicy.apply(viewport_container, viewport)
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Abrir canais e compradores — alternativa ao balcão 3D"
    contract_button.accessibility_name = "Abrir contratos — alternativa à bandeja 3D"
    _base_tray_position = contract_tray.position
    _base_buyer_marker_scale = buyer_marker.scale

func set_embedded_ui_mode(enabled: bool) -> void:
    _embedded_ui_mode = enabled
    interaction_status.visible = not enabled
    action_button.visible = not enabled
    contract_button.visible = not enabled
    # Direct 2D hit areas make touch independent from SubViewport 3D picking.
    deal_touch_target.visible = enabled
    contract_touch_target.visible = enabled

func is_embedded_ui_mode() -> bool:
    return _embedded_ui_mode

func activate_primary_object() -> void:
    activation_count += 1
    interaction_status.text = "Balcão selecionado • toque leva aos canais de venda"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    buyer_marker.scale = _base_buyer_marker_scale * 1.18
    _pulse_tween = create_tween()
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(buyer_marker, "scale", _base_buyer_marker_scale, 0.28)
    object_activated.emit("market", "deal_counter")

func activate_contract_object() -> void:
    activation_count += 1
    interaction_status.text = "Bandeja selecionada • toque leva às informações de contrato"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    contract_tray.position = _base_tray_position + Vector3(0.0, 0.10, 0.0)
    contract_tray.rotation.y = -0.18
    _pulse_tween = create_tween()
    _pulse_tween.set_parallel(true)
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(contract_tray, "position", _base_tray_position, 0.28)
    _pulse_tween.tween_property(contract_tray, "rotation:y", -0.12, 0.28)
    object_activated.emit("market", "contract_tray")

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_secondary_pointer_interaction() -> bool:
    return contract_interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func has_secondary_accessible_button_fallback() -> bool:
    return not contract_button.disabled and contract_button.visible

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

func _on_contract_tray_input_event(
    _camera: Node,
    event: InputEvent,
    _event_position: Vector3,
    _normal: Vector3,
    _shape_idx: int,
) -> void:
    if event is InputEventMouseButton:
        var mouse_event := event as InputEventMouseButton
        if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
            activate_contract_object()
    elif event is InputEventScreenTouch:
        var touch_event := event as InputEventScreenTouch
        if touch_event.pressed:
            activate_contract_object()

func _on_contract_action_button_pressed() -> void:
    activate_contract_object()

func _on_object_action_button_pressed() -> void:
    activate_primary_object()

func _on_deal_touch_target_pressed() -> void:
    activate_primary_object()

func _on_contract_touch_target_pressed() -> void:
    activate_contract_object()
