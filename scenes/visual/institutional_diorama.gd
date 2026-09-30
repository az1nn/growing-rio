extends Control

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var interactive_object: Area3D = $ViewportContainer/Viewport/World/ProposalRowInteraction
@onready var compliance_interactive_object: Area3D = $ViewportContainer/Viewport/World/ComplianceArchiveInteraction
@onready var proposal_caps: Array[MeshInstance3D] = [
    $ViewportContainer/Viewport/World/Proposals/ProposalCapA,
    $ViewportContainer/Viewport/World/Proposals/ProposalCapB,
    $ViewportContainer/Viewport/World/Proposals/ProposalCapC,
]
@onready var compliance_marker: MeshInstance3D = $ViewportContainer/Viewport/World/ArchiveWall/ArchiveCardA
@onready var action_button: Button = $ObjectActionButton
@onready var compliance_button: Button = $ComplianceActionButton
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween
var _base_cap_scales: Array[Vector3] = []
var _base_compliance_marker_scale := Vector3.ONE

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Revisar propostas institucionais — alternativa ao fórum 3D"
    compliance_button.accessibility_name = "Abrir compliance ficcional — alternativa ao arquivo 3D"
    _base_compliance_marker_scale = compliance_marker.scale
    for cap in proposal_caps:
        _base_cap_scales.append(cap.scale)

func activate_primary_object() -> void:
    activation_count += 1
    interaction_status.text = "Fórum selecionado • as três propostas mantêm tratamento visual equivalente"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    for index in proposal_caps.size():
        proposal_caps[index].scale = _base_cap_scales[index] * 1.12
    _pulse_tween = create_tween()
    _pulse_tween.set_parallel(true)
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    for index in proposal_caps.size():
        _pulse_tween.tween_property(proposal_caps[index], "scale", _base_cap_scales[index], 0.28)
    object_activated.emit("institutional", "proposal_row")

func activate_compliance_object() -> void:
    activation_count += 1
    interaction_status.text = "Arquivo selecionado • toque leva à seção de compliance ficcional"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    compliance_marker.scale = _base_compliance_marker_scale * 1.45
    _pulse_tween = create_tween()
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(
        compliance_marker,
        "scale",
        _base_compliance_marker_scale,
        0.28,
    )
    object_activated.emit("institutional", "compliance_archive")

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_secondary_pointer_interaction() -> bool:
    return compliance_interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func has_secondary_accessible_button_fallback() -> bool:
    return not compliance_button.disabled and compliance_button.visible

func _on_proposal_row_input_event(
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

func _on_compliance_archive_input_event(
    _camera: Node,
    event: InputEvent,
    _event_position: Vector3,
    _normal: Vector3,
    _shape_idx: int,
) -> void:
    if event is InputEventMouseButton:
        var mouse_event := event as InputEventMouseButton
        if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
            activate_compliance_object()
    elif event is InputEventScreenTouch:
        var touch_event := event as InputEventScreenTouch
        if touch_event.pressed:
            activate_compliance_object()

func _on_compliance_action_button_pressed() -> void:
    activate_compliance_object()

func _on_object_action_button_pressed() -> void:
    activate_primary_object()
