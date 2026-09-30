extends SubViewportContainer

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $Viewport
@onready var camera: Camera3D = $Viewport/World/Camera3D
@onready var cool_key: DirectionalLight3D = $Viewport/World/CoolKey
@onready var warm_practical: OmniLight3D = $Viewport/World/WarmPractical
@onready var world_environment: WorldEnvironment = $Viewport/World/WorldEnvironment
@onready var interactive_object: Area3D = $Viewport/World/InteractivePlantCluster
@onready var management_interactive_object: Area3D = $Viewport/World/ManagementStorageInteraction
@onready var workbench_interactive_object: Area3D = $Viewport/World/WorkbenchInteraction
@onready var focal_mesh: MeshInstance3D = $Viewport/World/CanopyB
@onready var management_marker: MeshInstance3D = $Viewport/World/StorageBinMid
@onready var workbench_marker: MeshInstance3D = $Viewport/World/CounterTop
@onready var action_button: Button = $ObjectActionButton
@onready var management_button: Button = $ManagementActionButton
@onready var interaction_status: Label = $InteractionStatus

const V1_CAMERA_POSITION := Vector3(6.5, 5.4, 8.5)
const V1_CAMERA_ROTATION := Vector3(-0.43, 0.66, 0.0)
const V1_CAMERA_SIZE := 7.9

const V1_WORKBENCH_MATERIAL_ROLES := {
    "TileCounter": &"structural_dark",
    "CounterTop": &"repaired_wood",
    "CounterFrontLeft": &"painted_metal",
    "CounterFrontCenter": &"painted_metal",
    "CounterFrontRight": &"painted_metal",
    "CounterHandleLeft": &"accent_amber",
    "CounterHandleCenter": &"accent_amber",
    "CounterHandleRight": &"accent_amber",
}

const V1_PLANT_MATERIAL_ROLES := {
    "PlanterA": &"painted_metal",
    "PlanterRimA": &"accent_cyan",
    "CanopyA": &"foliage_muted",
    "CanopyAUpper": &"foliage_muted",
    "CanopyALeft": &"foliage_muted",
    "CanopyARight": &"foliage_muted",
    "PlanterB": &"painted_metal",
    "PlanterRimB": &"accent_cyan",
    "CanopyB": &"foliage_muted",
    "CanopyBUpper": &"foliage_muted",
    "CanopyBLeft": &"foliage_muted",
    "CanopyBRight": &"foliage_muted",
    "PlanterC": &"painted_metal",
    "PlanterRimC": &"accent_cyan",
    "CanopyC": &"foliage_muted",
    "CanopyCUpper": &"foliage_muted",
    "CanopyCLeft": &"foliage_muted",
    "CanopyCRight": &"foliage_muted",
}

const V1_STORAGE_MATERIAL_ROLES := {
    "ShelfLeftPost": &"painted_metal",
    "ShelfRightPost": &"painted_metal",
    "ShelfLow": &"repaired_wood",
    "ShelfMid": &"repaired_wood",
    "ShelfHigh": &"repaired_wood",
    "ShelfBraceA": &"painted_metal",
    "ShelfBraceB": &"painted_metal",
    "StorageBinLowA": &"structural_dark",
    "StorageBinLowB": &"structural_dark",
    "StorageBinMid": &"accent_magenta",
    "StorageCrateA": &"repaired_wood",
    "StorageCrateB": &"painted_metal",
}

const V1_GRAFFITI_MATERIAL_ROLES := {
    "V1GraffitiCrownBase": &"accent_amber",
    "V1GraffitiCrownLeft": &"accent_amber",
    "V1GraffitiCrownMidLeft": &"accent_amber",
    "V1GraffitiCrownMidRight": &"accent_amber",
    "V1GraffitiCrownRight": &"accent_amber",
}

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
    _configure_v1_composition()
    _apply_v1_shell_materials()
    _apply_v1_cluster_materials()
    _configure_v1_environment()
    _configure_v1_lighting()
    _build_v1_dense_dressing()
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

func _configure_v1_composition() -> void:
    _translate_nodes(
        [
            "TileCounter",
            "CounterTop",
            "CounterFrontLeft",
            "CounterFrontCenter",
            "CounterFrontRight",
            "CounterHandleLeft",
            "CounterHandleCenter",
            "CounterHandleRight",
            "WorkbenchInteraction",
        ],
        Vector3(0.2, 0.0, 1.35),
    )
    _translate_nodes(
        [
            "PlanterA",
            "PlanterRimA",
            "CanopyA",
            "CanopyAUpper",
            "CanopyALeft",
            "CanopyARight",
            "PlanterB",
            "PlanterRimB",
            "CanopyB",
            "CanopyBUpper",
            "CanopyBLeft",
            "CanopyBRight",
            "PlanterC",
            "PlanterRimC",
            "CanopyC",
            "CanopyCUpper",
            "CanopyCLeft",
            "CanopyCRight",
            "InteractivePlantCluster",
        ],
        Vector3(-1.4, 0.0, -1.25),
    )
    _translate_nodes(
        [
            "ShelfLeftPost",
            "ShelfRightPost",
            "ShelfLow",
            "ShelfMid",
            "ShelfHigh",
            "ShelfBraceA",
            "ShelfBraceB",
            "StorageBinLowA",
            "StorageBinLowB",
            "StorageBinMid",
            "StorageCrateA",
            "StorageCrateB",
            "ManagementStorageInteraction",
        ],
        Vector3(4.35, 0.0, -1.95),
    )

func _translate_nodes(node_names: Array, delta: Vector3) -> void:
    var world := $Viewport/World
    for node_name in node_names:
        var node := world.get_node_or_null(String(node_name)) as Node3D
        if node != null:
            node.position += delta

func _configure_v1_environment() -> void:
    var environment := world_environment.environment
    if environment == null:
        return
    environment.background_color = Color.from_string("#090D12", Color.BLACK)
    environment.ambient_light_color = Color.from_string("#6A5D67", Color.WHITE)
    environment.ambient_light_energy = 1.22

func _build_v1_dense_dressing() -> void:
    var world := $Viewport/World
    if world.get_node_or_null("V1ProductionDressing") != null:
        return

    var dressing := Node3D.new()
    dressing.name = "V1ProductionDressing"
    world.add_child(dressing)

    # Repaired brick/plaster breaks the blockout silhouette into the accepted urban shell.
    _add_box(dressing, "BrickPatchBackA", Vector3(-2.72, 3.72, -3.73), Vector3(1.15, 0.32, 0.08), &"brick_coral")
    _add_box(dressing, "BrickPatchBackB", Vector3(-1.35, 3.86, -3.73), Vector3(1.0, 0.28, 0.08), &"brick_coral")
    _add_box(dressing, "BrickPatchBackC", Vector3(2.48, 3.68, -3.73), Vector3(1.35, 0.34, 0.08), &"brick_coral")
    _add_box(dressing, "BrickPatchBackD", Vector3(2.85, 2.95, -3.73), Vector3(0.7, 0.26, 0.08), &"brick_coral")
    _add_box(dressing, "BrickPatchSideA", Vector3(-3.45, 3.55, -2.25), Vector3(0.08, 0.34, 1.25), &"brick_coral")
    _add_box(dressing, "BrickPatchSideB", Vector3(-3.45, 3.1, 0.65), Vector3(0.08, 0.32, 1.1), &"brick_coral")
    _add_box(dressing, "BackLintel", Vector3(0.0, 4.25, -3.62), Vector3(7.1, 0.18, 0.18), &"structural_dark")
    _add_box(dressing, "SideLintel", Vector3(-3.34, 4.18, -0.2), Vector3(0.18, 0.18, 7.0), &"structural_dark")

    # Fan / duct silhouette from the accepted workshop concept.
    _add_cylinder(dressing, "BackFanHub", Vector3(0.72, 3.22, -3.60), 0.18, 0.18, 0.22, &"painted_metal", Vector3(PI / 2.0, 0.0, 0.0))
    _add_box(dressing, "BackFanBladeA", Vector3(0.72, 3.54, -3.57), Vector3(0.13, 0.72, 0.06), &"painted_metal")
    _add_box(dressing, "BackFanBladeB", Vector3(0.72, 2.90, -3.57), Vector3(0.13, 0.72, 0.06), &"painted_metal")
    _add_box(dressing, "BackFanBladeC", Vector3(1.04, 3.22, -3.57), Vector3(0.72, 0.13, 0.06), &"painted_metal")
    _add_box(dressing, "BackFanBladeD", Vector3(0.40, 3.22, -3.57), Vector3(0.72, 0.13, 0.06), &"painted_metal")
    _add_box(dressing, "BackFanFrameTop", Vector3(0.72, 3.78, -3.62), Vector3(1.35, 0.08, 0.08), &"structural_dark")
    _add_box(dressing, "BackFanFrameBottom", Vector3(0.72, 2.66, -3.62), Vector3(1.35, 0.08, 0.08), &"structural_dark")

    # Two warm pendants plus real light sources create the amber pool visible in the V1 target.
    _add_box(dressing, "PendantCordA", Vector3(-0.75, 3.63, -1.0), Vector3(0.04, 1.05, 0.04), &"structural_dark")
    _add_cylinder(dressing, "WarmPendantA", Vector3(-0.75, 3.12, -1.0), 0.12, 0.30, 0.22, &"painted_metal")
    _add_sphere(dressing, "WarmBulbA", Vector3(-0.75, 2.98, -1.0), 0.09, &"accent_amber")
    _add_point_light(dressing, "WarmPendantLightA", Vector3(-0.75, 2.88, -1.0), &"accent_amber", 2.1, 3.8)
    _add_box(dressing, "PendantCordB", Vector3(1.48, 3.72, -0.72), Vector3(0.04, 1.22, 0.04), &"structural_dark")
    _add_cylinder(dressing, "WarmPendantB", Vector3(1.48, 3.13, -0.72), 0.12, 0.30, 0.22, &"painted_metal")
    _add_sphere(dressing, "WarmBulbB", Vector3(1.48, 2.99, -0.72), 0.09, &"accent_amber")
    _add_point_light(dressing, "WarmPendantLightB", Vector3(1.48, 2.90, -0.72), &"accent_amber", 1.85, 3.4)

    # Back-wall growing rack: abstract silhouettes only; no operational cultivation detail.
    _add_box(dressing, "PlantRackTop", Vector3(-2.05, 2.78, -3.34), Vector3(2.35, 0.10, 0.55), &"repaired_wood")
    _add_box(dressing, "PlantRackMid", Vector3(-2.05, 2.03, -3.34), Vector3(2.35, 0.10, 0.55), &"repaired_wood")
    _add_box(dressing, "PlantRackPostL", Vector3(-3.10, 2.38, -3.34), Vector3(0.10, 1.55, 0.10), &"painted_metal")
    _add_box(dressing, "PlantRackPostR", Vector3(-1.00, 2.38, -3.34), Vector3(0.10, 1.55, 0.10), &"painted_metal")
    _add_box(dressing, "PlanterRailA", Vector3(-2.72, 2.18, -3.05), Vector3(0.50, 0.24, 0.42), &"painted_metal")
    _add_box(dressing, "PlanterRailB", Vector3(-2.05, 2.18, -3.05), Vector3(0.50, 0.24, 0.42), &"painted_metal")
    _add_box(dressing, "PlanterRailC", Vector3(-1.38, 2.18, -3.05), Vector3(0.50, 0.24, 0.42), &"painted_metal")
    _add_sphere(dressing, "RackFoliageA", Vector3(-2.72, 2.58, -3.00), 0.30, &"foliage_muted")
    _add_sphere(dressing, "RackFoliageB", Vector3(-2.05, 2.56, -3.02), 0.32, &"foliage_muted")
    _add_sphere(dressing, "RackFoliageC", Vector3(-1.38, 2.60, -3.00), 0.30, &"foliage_muted")
    _add_sphere(dressing, "RackFoliageUpperA", Vector3(-2.55, 3.08, -3.04), 0.26, &"foliage_muted")
    _add_sphere(dressing, "RackFoliageUpperB", Vector3(-1.72, 3.08, -3.04), 0.27, &"foliage_muted")

    # Right-side supply wall gives the management focus a dense readable silhouette.
    _add_box(dressing, "SupplyShelfHigh", Vector3(2.30, 2.82, -3.30), Vector3(1.75, 0.10, 0.48), &"repaired_wood")
    _add_box(dressing, "SupplyShelfMid", Vector3(2.30, 2.18, -3.30), Vector3(1.75, 0.10, 0.48), &"repaired_wood")
    _add_box(dressing, "SupplyShelfLow", Vector3(2.30, 1.54, -3.30), Vector3(1.75, 0.10, 0.48), &"repaired_wood")
    _add_box(dressing, "SupplyPostL", Vector3(1.52, 2.18, -3.30), Vector3(0.10, 1.48, 0.10), &"painted_metal")
    _add_box(dressing, "SupplyPostR", Vector3(3.08, 2.18, -3.30), Vector3(0.10, 1.48, 0.10), &"painted_metal")
    _add_box(dressing, "SupplyBinA", Vector3(1.82, 1.78, -3.02), Vector3(0.42, 0.34, 0.38), &"accent_magenta")
    _add_box(dressing, "SupplyBinB", Vector3(2.36, 1.78, -3.02), Vector3(0.42, 0.34, 0.38), &"painted_metal")
    _add_box(dressing, "SupplyBinC", Vector3(2.90, 1.78, -3.02), Vector3(0.42, 0.34, 0.38), &"accent_cyan")
    _add_cylinder(dressing, "SupplyBottleA", Vector3(1.88, 2.45, -3.00), 0.07, 0.09, 0.34, &"off_white")
    _add_cylinder(dressing, "SupplyBottleB", Vector3(2.20, 2.45, -3.00), 0.07, 0.09, 0.34, &"accent_amber")
    _add_cylinder(dressing, "SupplyBottleC", Vector3(2.52, 2.45, -3.00), 0.07, 0.09, 0.34, &"off_white")

    # Workbench clutter turns the former clean counter into a production surface.
    _add_box(dressing, "WorkbenchMat", Vector3(0.90, 1.07, -0.88), Vector3(1.35, 0.035, 0.72), &"petrol_shadow")
    _add_box(dressing, "WorkbenchTray", Vector3(0.26, 1.16, -0.72), Vector3(0.46, 0.14, 0.36), &"painted_metal")
    _add_cylinder(dressing, "WorkbenchJarA", Vector3(0.88, 1.28, -0.68), 0.10, 0.11, 0.30, &"off_white")
    _add_cylinder(dressing, "WorkbenchJarB", Vector3(1.18, 1.24, -0.73), 0.08, 0.09, 0.24, &"accent_amber")
    _add_box(dressing, "WorkbenchToolA", Vector3(1.52, 1.15, -0.70), Vector3(0.42, 0.05, 0.09), &"accent_cyan", Vector3(0.0, 0.35, 0.0))
    _add_box(dressing, "WorkbenchToolB", Vector3(1.58, 1.16, -1.05), Vector3(0.36, 0.05, 0.08), &"accent_magenta", Vector3(0.0, -0.45, 0.0))

    # Patched floor / tile fragments provide the chunky pixel-graffiti rhythm from the concept.
    _add_box(dressing, "FloorPatchAmber", Vector3(-1.75, 0.025, 1.45), Vector3(0.82, 0.045, 0.82), &"accent_amber")
    _add_box(dressing, "FloorPatchCoral", Vector3(-0.82, 0.026, 1.52), Vector3(0.70, 0.045, 0.70), &"brick_coral")
    _add_box(dressing, "FloorPatchCyan", Vector3(0.02, 0.027, 2.28), Vector3(0.72, 0.045, 0.72), &"accent_cyan")
    _add_box(dressing, "FloorPatchMagenta", Vector3(0.82, 0.028, 1.62), Vector3(0.62, 0.045, 0.62), &"accent_magenta")
    _add_box(dressing, "FloorPatchBrick", Vector3(-1.08, 0.029, 2.42), Vector3(0.88, 0.045, 0.88), &"brick_coral")
    _add_box(dressing, "FloorPatchDark", Vector3(1.48, 0.030, 2.58), Vector3(0.92, 0.045, 0.92), &"structural_dark")

    # Entry steps make the cutaway read as a small urban room instead of a floating stage.
    _add_box(dressing, "EntryStepTop", Vector3(-2.70, -0.05, 4.15), Vector3(1.75, 0.18, 0.82), &"worn_concrete")
    _add_box(dressing, "EntryStepMid", Vector3(-2.78, -0.18, 4.70), Vector3(1.95, 0.22, 0.86), &"brick_coral")
    _add_box(dressing, "EntryStepLow", Vector3(-2.86, -0.34, 5.28), Vector3(2.15, 0.24, 0.90), &"worn_concrete")

func _add_box(
    parent: Node3D,
    node_name: String,
    position: Vector3,
    size: Vector3,
    role: StringName,
    rotation: Vector3 = Vector3.ZERO,
) -> MeshInstance3D:
    var node := MeshInstance3D.new()
    node.name = StringName(node_name)
    var mesh := BoxMesh.new()
    mesh.size = size
    node.mesh = mesh
    node.position = position
    node.rotation = rotation
    node.material_override = V1MaterialVocabulary.make_standard(role)
    parent.add_child(node)
    return node

func _add_sphere(
    parent: Node3D,
    node_name: String,
    position: Vector3,
    radius: float,
    role: StringName,
) -> MeshInstance3D:
    var node := MeshInstance3D.new()
    node.name = StringName(node_name)
    var mesh := SphereMesh.new()
    mesh.radius = radius
    mesh.height = radius * 2.0
    mesh.radial_segments = 8
    mesh.rings = 4
    node.mesh = mesh
    node.position = position
    node.material_override = V1MaterialVocabulary.make_standard(role)
    parent.add_child(node)
    return node

func _add_cylinder(
    parent: Node3D,
    node_name: String,
    position: Vector3,
    top_radius: float,
    bottom_radius: float,
    height: float,
    role: StringName,
    rotation: Vector3 = Vector3.ZERO,
) -> MeshInstance3D:
    var node := MeshInstance3D.new()
    node.name = StringName(node_name)
    var mesh := CylinderMesh.new()
    mesh.top_radius = top_radius
    mesh.bottom_radius = bottom_radius
    mesh.height = height
    mesh.radial_segments = 8
    mesh.rings = 1
    node.mesh = mesh
    node.position = position
    node.rotation = rotation
    node.material_override = V1MaterialVocabulary.make_standard(role)
    parent.add_child(node)
    return node

func _add_point_light(
    parent: Node3D,
    node_name: String,
    position: Vector3,
    role: StringName,
    energy: float,
    light_range: float,
) -> OmniLight3D:
    var swatch := V1MaterialVocabulary.make_standard(role)
    var light := OmniLight3D.new()
    light.name = StringName(node_name)
    light.position = position
    light.light_color = swatch.albedo_color
    light.light_energy = energy
    light.omni_range = light_range
    light.shadow_enabled = false
    parent.add_child(light)
    return light

func _apply_v1_shell_materials() -> void:
    _apply_material_roles(V1_SHELL_MATERIAL_ROLES)

func _apply_v1_cluster_materials() -> void:
    _apply_material_roles(V1_WORKBENCH_MATERIAL_ROLES)
    _apply_material_roles(V1_PLANT_MATERIAL_ROLES)
    _apply_material_roles(V1_STORAGE_MATERIAL_ROLES)
    _apply_material_roles(V1_GRAFFITI_MATERIAL_ROLES)

func _apply_material_roles(role_map: Dictionary) -> void:
    var world := $Viewport/World
    for node_name in role_map:
        var mesh_instance := world.get_node_or_null(String(node_name)) as MeshInstance3D
        if mesh_instance == null:
            continue
        mesh_instance.material_override = V1MaterialVocabulary.make_standard(StringName(role_map[node_name]))

func _configure_v1_lighting() -> void:
    var cyan := V1MaterialVocabulary.make_standard(&"accent_cyan")
    var amber := V1MaterialVocabulary.make_standard(&"accent_amber")
    cool_key.light_color = cyan.albedo_color
    cool_key.light_energy = 1.08
    warm_practical.light_color = amber.albedo_color
    warm_practical.light_energy = 2.35
    warm_practical.omni_range = 6.2

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

func has_workbench_pointer_interaction() -> bool:
    return workbench_interactive_object.input_ray_pickable and viewport.physics_object_picking

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

func _on_workbench_input_event(
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
