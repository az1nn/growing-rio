extends Control

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var interactive_object: Area3D = $ViewportContainer/Viewport/World/EvidenceDeskInteraction
@onready var history_interactive_object: Area3D = $ViewportContainer/Viewport/World/ArchiveWallInteraction
@onready var evidence_tray: MeshInstance3D = $ViewportContainer/Viewport/World/EvidenceDesk/EvidenceTray
@onready var archive_box: MeshInstance3D = $ViewportContainer/Viewport/World/ArchiveWall/BoxE
@onready var action_button: Button = $ObjectActionButton
@onready var history_button: Button = $HistoryActionButton
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween
var _base_tray_position := Vector3.ZERO
var _base_archive_box_scale := Vector3.ONE

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Abrir pesquisa do Arquivo — alternativa à mesa 3D"
    history_button.accessibility_name = "Abrir histórico narrativo — alternativa à prateleira 3D"
    _base_tray_position = evidence_tray.position
    _base_archive_box_scale = archive_box.scale

func activate_primary_object() -> void:
    activation_count += 1
    interaction_status.text = "Mesa selecionada • a pesquisa canônica está logo abaixo"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    evidence_tray.position = _base_tray_position + Vector3(0.0, 0.10, 0.0)
    evidence_tray.rotation.y = -0.10
    _pulse_tween = create_tween()
    _pulse_tween.set_parallel(true)
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(evidence_tray, "position", _base_tray_position, 0.28)
    _pulse_tween.tween_property(evidence_tray, "rotation:y", 0.0, 0.28)
    object_activated.emit("archive", "evidence_desk")

func activate_history_object() -> void:
    activation_count += 1
    interaction_status.text = "Prateleira selecionada • histórico narrativo logo abaixo"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    archive_box.scale = _base_archive_box_scale * 1.16
    _pulse_tween = create_tween()
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(archive_box, "scale", _base_archive_box_scale, 0.28)
    object_activated.emit("archive", "archive_wall")

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_secondary_pointer_interaction() -> bool:
    return history_interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func has_secondary_accessible_button_fallback() -> bool:
    return not history_button.disabled and history_button.visible

func _on_evidence_desk_input_event(
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

func _on_archive_wall_input_event(
    _camera: Node,
    event: InputEvent,
    _event_position: Vector3,
    _normal: Vector3,
    _shape_idx: int,
) -> void:
    if event is InputEventMouseButton:
        var mouse_event := event as InputEventMouseButton
        if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
            activate_history_object()
    elif event is InputEventScreenTouch:
        var touch_event := event as InputEventScreenTouch
        if touch_event.pressed:
            activate_history_object()

func _on_history_action_button_pressed() -> void:
    activate_history_object()

func _on_object_action_button_pressed() -> void:
    activate_primary_object()
