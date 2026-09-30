extends SubViewportContainer

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $Viewport
@onready var camera: Camera3D = $Viewport/World/Camera3D
@onready var interactive_object: Area3D = $Viewport/World/InteractivePlantCluster
@onready var management_interactive_object: Area3D = $Viewport/World/ManagementStorageInteraction
@onready var focal_mesh: MeshInstance3D = $Viewport/World/CanopyB
@onready var management_marker: MeshInstance3D = $Viewport/World/StorageBinMid
@onready var action_button: Button = $ObjectActionButton
@onready var management_button: Button = $ManagementActionButton
@onready var interaction_status: Label = $InteractionStatus

const V1_CAMERA_POSITION := Vector3(6.5, 5.4, 8.5)
const V1_CAMERA_ROTATION := Vector3(-0.43, 0.66, 0.0)
const V1_CAMERA_SIZE := 8.6

const V1_SHELL_MATERIAL_ROLES := {
    "Floor": &"worn_concrete",
    "ForegroundApron": &"worn_concrete",
    "ForegroundServicePlinth": &"structural_dark",
    "ForegroundServiceLanding": &"worn_concrete",
    "BackWall": &"petrol_shadow",
    "SideWall": &"structural_dark",
    "MetalDoor": &"painted_metal",
    "BackWallBaseboard": &"painted_metal",
    "SideWallBaseboard": &"painted_metal",
    "DoorFrameTop": &"painted_metal",
    "DoorFrameLeft": &"painted_metal",
    "DoorFrameRight": &"painted_metal",
    "BackWallBayReveal": &"structural_dark",
    "BackWallEdgeReveal": &"structural_dark",
    "SideWallRearReveal": &"structural_dark",
    "SideWallFrontReveal": &"structural_dark",
}

var activation_count := 0
var _pulse_tween: Tween
var _base_management_scale := Vector3.ONE

func _ready() -> void:
    V1PixelRenderPolicy.apply(self, viewport)
    _configure_v1_camera()
    _apply_v1_shell_materials()
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Abrir cultivo — alternativa às plantas 3D"
    management_button.accessibility_name = "Abrir gestão — alternativa ao armazenamento 3D"
    _base_management_scale = management_marker.scale


func _configure_v1_camera() -> void:
    camera.projection = Camera3D.PROJECTION_ORTHOGONAL
    camera.position = V1_CAMERA_POSITION
    camera.rotation = V1_CAMERA_ROTATION
    camera.size = V1_CAMERA_SIZE
    camera.current = true

func _apply_v1_shell_materials() -> void:
    var world := $Viewport/World
    for node_name in V1_SHELL_MATERIAL_ROLES:
        var shell_mesh := world.get_node_or_null(String(node_name)) as MeshInstance3D
        if shell_mesh == null:
            continue
        shell_mesh.material_override = V1MaterialVocabulary.make_standard(
            V1_SHELL_MATERIAL_ROLES[node_name]
        )

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

func activate_management_object() -> void:
    activation_count += 1
    interaction_status.text = "Gestão 3D selecionada • salas, equipe e melhorias abaixo"
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    management_marker.scale = _base_management_scale * 1.18
    _pulse_tween = create_tween()
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(
        management_marker,
        "scale",
        _base_management_scale,
        0.22,
    )
    object_activated.emit("operation", "management_storage")

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_secondary_pointer_interaction() -> bool:
    return management_interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func has_secondary_accessible_button_fallback() -> bool:
    return not management_button.disabled and management_button.visible

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

func _on_management_storage_input_event(
    _camera: Node,
    event: InputEvent,
    _event_position: Vector3,
    _normal: Vector3,
    _shape_idx: int,
) -> void:
    if event is InputEventMouseButton:
        var mouse_event := event as InputEventMouseButton
        if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
            activate_management_object()
    elif event is InputEventScreenTouch:
        var touch_event := event as InputEventScreenTouch
        if touch_event.pressed:
            activate_management_object()

func _on_management_action_button_pressed() -> void:
    activate_management_object()

func _on_object_action_button_pressed() -> void:
    activate_primary_object()
