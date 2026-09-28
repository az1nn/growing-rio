extends SubViewportContainer

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $Viewport
@onready var interactive_object: Area3D = $Viewport/World/InteractivePlantCluster
@onready var focal_mesh: MeshInstance3D = $Viewport/World/CanopyB
@onready var action_button: Button = $ObjectActionButton
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Inspecionar plantas — alternativa ao objeto 3D"

func activate_primary_object() -> void:
    activation_count += 1
    interaction_status.text = "Cultivo 3D inspecionado • %d" % activation_count
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    focal_mesh.scale = Vector3.ONE * 1.08
    _pulse_tween = create_tween()
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(focal_mesh, "scale", Vector3.ONE, 0.22)
    object_activated.emit("operation", "plant_cluster")

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func _on_interactive_plant_cluster_input_event(
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
