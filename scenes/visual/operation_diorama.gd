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
const V1_CAMERA_SIZE := 5.15
const V1_OPERATION_PIXEL_SHRINK := 3

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
    V1PixelRenderPolicy.apply(self, viewport, V1_OPERATION_PIXEL_SHRINK)
    _configure_v1_camera()
    _configure_v1_composition()
    _configure_v1_compact_shell()
    _apply_v1_shell_materials()
    _apply_v1_cluster_materials()
    _configure_v1_environment()
    _configure_v1_lighting()
    _build_v1_dense_dressing()
    _configure_v1_pixel_foliage()
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

func _configure_v1_compact_shell() -> void:
    # Revision 7: remove the long runway/platform read and make Operation feel
    # like the compact cutaway room in the accepted concept. This is visual-only:
    # interaction nodes and gameplay ownership remain untouched.
    var world := $Viewport/World
    var floor := world.get_node_or_null("Floor") as MeshInstance3D
    if floor != null:
        floor.scale.z = 0.66
        floor.position.z = 0.10

    for node_name in [
        "ForegroundApron",
        "ForegroundApronEdge",
        "ForegroundServicePlinth",
        "ForegroundServiceRailLeft",
        "ForegroundServiceRailRight",
        "ForegroundServiceEdge",
        "ForegroundServiceLanding",
        "ForegroundServiceLandingEdge",
    ]:
        var node := world.get_node_or_null(node_name) as Node3D
        if node != null:
            node.visible = false


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
    environment.ambient_light_color = Color.from_string("#8B7467", Color.WHITE)
    environment.ambient_light_energy = 1.82

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
    _add_point_light(dressing, "WarmPendantLightA", Vector3(-0.75, 2.88, -1.0), &"accent_amber", 2.6, 4.1)
    _add_box(dressing, "PendantCordB", Vector3(1.48, 3.72, -0.72), Vector3(0.04, 1.22, 0.04), &"structural_dark")
    _add_cylinder(dressing, "WarmPendantB", Vector3(1.48, 3.13, -0.72), 0.12, 0.30, 0.22, &"painted_metal")
    _add_sphere(dressing, "WarmBulbB", Vector3(1.48, 2.99, -0.72), 0.09, &"accent_amber")
    _add_point_light(dressing, "WarmPendantLightB", Vector3(1.48, 2.90, -0.72), &"accent_amber", 2.3, 3.8)

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

    # Revision 3: physical wall art and blocky accents push the room from low-poly
    # blockout toward the locked Pixel Art x Graffiti x Urban Diorama target.
    _add_box(dressing, "MuralPlasterA", Vector3(-0.30, 3.55, -3.70), Vector3(1.55, 0.62, 0.055), &"off_white")
    _add_box(dressing, "MuralPlasterB", Vector3(1.20, 3.68, -3.69), Vector3(1.05, 0.42, 0.055), &"brick_coral")
    _add_box(dressing, "GraffitiRibbonCyan", Vector3(-0.15, 3.56, -3.62), Vector3(1.25, 0.11, 0.055), &"accent_cyan", Vector3(0.0, 0.0, -0.42))
    _add_box(dressing, "GraffitiRibbonMagenta", Vector3(0.35, 3.48, -3.61), Vector3(1.05, 0.11, 0.055), &"accent_magenta", Vector3(0.0, 0.0, 0.55))
    _add_box(dressing, "GraffitiRibbonAmber", Vector3(0.82, 3.72, -3.60), Vector3(0.92, 0.12, 0.055), &"accent_amber", Vector3(0.0, 0.0, -0.24))
    _add_box(dressing, "GraffitiPixelCyan", Vector3(1.42, 3.35, -3.60), Vector3(0.30, 0.30, 0.055), &"accent_cyan")
    _add_box(dressing, "GraffitiPixelMagenta", Vector3(1.78, 3.65, -3.60), Vector3(0.28, 0.28, 0.055), &"accent_magenta")
    _add_box(dressing, "GraffitiPixelAmber", Vector3(1.55, 3.98, -3.60), Vector3(0.24, 0.24, 0.055), &"accent_amber")

    # Boxy foliage clusters deliberately break the smooth-orb silhouette.
    _add_box(dressing, "PixelFoliageA", Vector3(-2.88, 2.72, -2.96), Vector3(0.42, 0.42, 0.42), &"foliage_muted")
    _add_box(dressing, "PixelFoliageB", Vector3(-2.36, 2.90, -2.98), Vector3(0.46, 0.38, 0.40), &"foliage_muted")
    _add_box(dressing, "PixelFoliageC", Vector3(-1.82, 2.76, -2.96), Vector3(0.40, 0.46, 0.38), &"foliage_muted")
    _add_box(dressing, "PixelFoliageD", Vector3(-1.30, 2.92, -2.98), Vector3(0.38, 0.38, 0.44), &"foliage_muted")

    # Revision 4: replace the dominant smooth legacy canopy read with authored
    # chunky voxel-like crowns while preserving the existing planter hitboxes.
    _add_box(dressing, "PixelPlantAMain", Vector3(-2.12, 1.02, -0.67), Vector3(0.72, 0.62, 0.68), &"foliage_muted")
    _add_box(dressing, "PixelPlantAUpper", Vector3(-2.18, 1.39, -0.69), Vector3(0.44, 0.38, 0.42), &"foliage_muted", Vector3(0.0, 0.18, 0.0))
    _add_box(dressing, "PixelPlantALeft", Vector3(-2.48, 1.08, -0.70), Vector3(0.34, 0.42, 0.36), &"foliage_muted")
    _add_box(dressing, "PixelPlantARight", Vector3(-1.78, 1.14, -0.61), Vector3(0.38, 0.34, 0.40), &"foliage_muted")
    _add_box(dressing, "PixelPlantATip", Vector3(-2.02, 1.63, -0.67), Vector3(0.22, 0.24, 0.24), &"foliage_muted")

    _add_box(dressing, "PixelPlantBMain", Vector3(-0.85, 1.04, -0.13), Vector3(0.74, 0.64, 0.70), &"foliage_muted")
    _add_box(dressing, "PixelPlantBUpper", Vector3(-0.92, 1.43, -0.15), Vector3(0.46, 0.40, 0.44), &"foliage_muted", Vector3(0.0, -0.16, 0.0))
    _add_box(dressing, "PixelPlantBLeft", Vector3(-1.19, 1.08, -0.19), Vector3(0.36, 0.38, 0.38), &"foliage_muted")
    _add_box(dressing, "PixelPlantBRight", Vector3(-0.50, 1.13, -0.05), Vector3(0.40, 0.36, 0.42), &"foliage_muted")
    _add_box(dressing, "PixelPlantBTip", Vector3(-0.78, 1.68, -0.13), Vector3(0.24, 0.24, 0.26), &"foliage_muted")

    _add_box(dressing, "PixelPlantCMain", Vector3(0.42, 1.03, -0.53), Vector3(0.70, 0.60, 0.66), &"foliage_muted")
    _add_box(dressing, "PixelPlantCUpper", Vector3(0.46, 1.39, -0.57), Vector3(0.42, 0.38, 0.42), &"foliage_muted", Vector3(0.0, 0.14, 0.0))
    _add_box(dressing, "PixelPlantCLeft", Vector3(0.10, 1.08, -0.57), Vector3(0.34, 0.38, 0.36), &"foliage_muted")
    _add_box(dressing, "PixelPlantCRight", Vector3(0.75, 1.12, -0.47), Vector3(0.38, 0.34, 0.38), &"foliage_muted")
    _add_box(dressing, "PixelPlantCTip", Vector3(0.53, 1.61, -0.55), Vector3(0.22, 0.22, 0.24), &"foliage_muted")

    # More irregular physical graffiti marks keep the wall from reading as a
    # clean vector logo while retaining fictional, project-owned iconography.
    _add_box(dressing, "GraffitiDripMagenta", Vector3(0.48, 3.06, -3.59), Vector3(0.10, 0.58, 0.05), &"accent_magenta", Vector3(0.0, 0.0, 0.08))
    _add_box(dressing, "GraffitiDripCyan", Vector3(-0.34, 3.20, -3.59), Vector3(0.08, 0.42, 0.05), &"accent_cyan", Vector3(0.0, 0.0, -0.10))
    _add_box(dressing, "GraffitiTagAmberA", Vector3(1.12, 3.18, -3.59), Vector3(0.42, 0.09, 0.05), &"accent_amber", Vector3(0.0, 0.0, 0.72))
    _add_box(dressing, "GraffitiTagAmberB", Vector3(1.34, 3.02, -3.59), Vector3(0.30, 0.09, 0.05), &"accent_amber", Vector3(0.0, 0.0, -0.55))

    # Foreground accents improve hotspot hierarchy without changing semantics.
    _add_box(dressing, "WorkbenchEdgeCyan", Vector3(0.55, 1.02, -0.18), Vector3(1.15, 0.055, 0.055), &"accent_cyan")
    _add_box(dressing, "WorkbenchEdgeAmber", Vector3(1.78, 1.02, -0.18), Vector3(0.72, 0.055, 0.055), &"accent_amber")
    _build_v1_revision5_detail(dressing)
    _build_v1_revision6_detail(dressing)
    _build_v1_revision7_detail(dressing)

func _build_v1_revision5_detail(dressing: Node3D) -> void:
    # Revision 5: replace remaining macro-block emptiness with authored micro-density.
    # Every element remains real 3D geometry and presentation-only.

    # Individual repaired bricks: staggered back-wall courses read as masonry rather
    # than a few large coral panels.
    for row in range(3):
        for column in range(7):
            var back_offset := 0.30 if row % 2 == 1 else 0.0
            var back_x := -2.88 + float(column) * 0.78 + back_offset
            var back_y := 0.62 + float(row) * 0.29
            var back_role: StringName = &"brick_coral" if (row + column) % 4 != 0 else &"structural_dark"
            _add_box(
                dressing,
                "BackBrick_%02d_%02d" % [row, column],
                Vector3(back_x, back_y, -3.685),
                Vector3(0.66, 0.19, 0.055),
                back_role,
            )

    # Side-wall repair field fills the formerly empty slab without flattening the cutaway.
    for row in range(3):
        for column in range(5):
            var side_offset := 0.22 if row % 2 == 1 else 0.0
            var side_z := -2.58 + float(column) * 0.72 + side_offset
            var side_y := 1.28 + float(row) * 0.30
            _add_box(
                dressing,
                "SideBrick_%02d_%02d" % [row, column],
                Vector3(-3.385, side_y, side_z),
                Vector3(0.055, 0.19, 0.60),
                &"brick_coral",
            )

    # Pixel-leaf rack: layered narrow boxes replace the old rounded rack blobs.
    for row in range(2):
        for column in range(7):
            var leaf_x := -2.92 + float(column) * 0.31
            var leaf_y := 2.45 + float(row) * 0.48 + (0.08 if column % 2 == 1 else 0.0)
            var leaf_rot := -0.38 if column % 2 == 0 else 0.38
            _add_box(
                dressing,
                "RackLeaf_%02d_%02d" % [row, column],
                Vector3(leaf_x, leaf_y, -2.94),
                Vector3(0.18, 0.18, 0.48),
                &"foliage_muted",
                Vector3(0.0, leaf_rot, 0.0),
            )
    _add_point_light(dressing, "WarmRackLight", Vector3(-2.05, 2.62, -2.62), &"accent_amber", 1.45, 2.65)

    # Handmade side-wall tag fragments break the remaining clean plane.
    _add_box(dressing, "SideWallTagCyan", Vector3(-3.345, 2.38, -0.55), Vector3(0.050, 0.12, 1.22), &"accent_cyan", Vector3(0.18, 0.0, 0.0))
    _add_box(dressing, "SideWallTagMagenta", Vector3(-3.342, 2.14, -0.20), Vector3(0.050, 0.11, 0.92), &"accent_magenta", Vector3(-0.22, 0.0, 0.0))
    _add_box(dressing, "SideWallTagAmberA", Vector3(-3.340, 2.61, -0.02), Vector3(0.050, 0.10, 0.62), &"accent_amber", Vector3(0.28, 0.0, 0.0))
    _add_box(dressing, "SideWallTagAmberB", Vector3(-3.338, 1.92, -0.76), Vector3(0.050, 0.10, 0.48), &"accent_amber", Vector3(-0.30, 0.0, 0.0))

    # Smaller floor chips make the patched floor read as authored pixel texture.
    var floor_roles: Array[StringName] = [
        &"brick_coral", &"structural_dark", &"accent_amber", &"petrol_shadow", &"accent_cyan",
    ]
    for index in range(10):
        var chip_x := -2.35 + float(index % 5) * 0.55
        var chip_z := 2.82 + float(index / 5) * 0.48
        _add_box(
            dressing,
            "FloorChip_%02d" % index,
            Vector3(chip_x, 0.034, chip_z),
            Vector3(0.38, 0.050, 0.34),
            floor_roles[index % floor_roles.size()],
        )

    # Extra leaflets give the three foreground abstract plants a less cubic silhouette.
    var plant_centers := [
        Vector3(-2.12, 1.30, -0.67),
        Vector3(-0.85, 1.32, -0.13),
        Vector3(0.42, 1.30, -0.53),
    ]
    for plant_index in range(plant_centers.size()):
        var center: Vector3 = plant_centers[plant_index]
        _add_box(dressing, "PlantLeaf_%02d_A" % plant_index, center + Vector3(-0.30, 0.12, 0.0), Vector3(0.16, 0.15, 0.52), &"foliage_muted", Vector3(0.0, -0.72, 0.18))
        _add_box(dressing, "PlantLeaf_%02d_B" % plant_index, center + Vector3(0.30, 0.08, 0.0), Vector3(0.16, 0.15, 0.52), &"foliage_muted", Vector3(0.0, 0.72, -0.16))
        _add_box(dressing, "PlantLeaf_%02d_C" % plant_index, center + Vector3(0.0, 0.30, -0.08), Vector3(0.16, 0.15, 0.48), &"foliage_muted", Vector3(0.0, 0.12, 0.68))


func _build_v1_revision6_detail(dressing: Node3D) -> void:
    # Revision 6: concept-parity pass. The accepted target is a compact, dense
    # pixel-art urban room; this pass moves the runtime away from large low-poly
    # masses without changing gameplay, saves or semantic object IDs.

    # Smaller repaired masonry courses across the back wall.
    var masonry_roles: Array[StringName] = [
        &"brick_coral", &"brick_coral", &"worn_concrete", &"structural_dark",
    ]
    for row in range(5):
        for column in range(8):
            var offset := 0.30 if row % 2 == 1 else 0.0
            var x := -2.95 + float(column) * 0.72 + offset
            var y := 0.52 + float(row) * 0.27
            _add_box(
                dressing,
                "R6BackBrick_%02d_%02d" % [row, column],
                Vector3(x, y, -3.635),
                Vector3(0.58, 0.16, 0.040),
                masonry_roles[(row + column) % masonry_roles.size()],
            )

    # Irregular plaster repairs break the remaining clean wall fields.
    _add_box(dressing, "R6PlasterBackA", Vector3(-1.78, 3.56, -3.655), Vector3(0.92, 0.48, 0.042), &"worn_concrete")
    _add_box(dressing, "R6PlasterBackB", Vector3(-0.88, 3.70, -3.650), Vector3(0.62, 0.31, 0.042), &"off_white")
    _add_box(dressing, "R6PlasterSideA", Vector3(-3.365, 3.02, 0.45), Vector3(0.042, 0.62, 1.10), &"worn_concrete")
    _add_box(dressing, "R6PlasterSideB", Vector3(-3.360, 2.72, 1.62), Vector3(0.042, 0.36, 0.70), &"brick_coral")

    # Prominent amber crown, matching the accepted concept's visual signature.
    _add_box(dressing, "R6ConceptCrownBase", Vector3(1.18, 2.58, -3.565), Vector3(1.10, 0.13, 0.055), &"accent_amber")
    _add_box(dressing, "R6ConceptCrownLeft", Vector3(0.80, 2.86, -3.565), Vector3(0.14, 0.62, 0.055), &"accent_amber", Vector3(0.0, 0.0, -0.34))
    _add_box(dressing, "R6ConceptCrownMid", Vector3(1.18, 2.96, -3.565), Vector3(0.14, 0.72, 0.055), &"accent_amber")
    _add_box(dressing, "R6ConceptCrownRight", Vector3(1.56, 2.86, -3.565), Vector3(0.14, 0.62, 0.055), &"accent_amber", Vector3(0.0, 0.0, 0.34))
    _add_box(dressing, "R6ConceptCrownTipL", Vector3(0.69, 3.12, -3.565), Vector3(0.20, 0.20, 0.055), &"accent_amber", Vector3(0.0, 0.0, 0.38))
    _add_box(dressing, "R6ConceptCrownTipM", Vector3(1.18, 3.30, -3.565), Vector3(0.20, 0.20, 0.055), &"accent_amber")
    _add_box(dressing, "R6ConceptCrownTipR", Vector3(1.67, 3.12, -3.565), Vector3(0.20, 0.20, 0.055), &"accent_amber", Vector3(0.0, 0.0, -0.38))

    # Dense left/back rack becomes the primary plant read, as in the approved image.
    for tier in range(2):
        var rack_y := 1.72 + float(tier) * 0.92
        _add_box(dressing, "R6RackShelf_%02d" % tier, Vector3(-2.18, rack_y, -3.02), Vector3(2.20, 0.10, 0.56), &"repaired_wood")
        for slot in range(4):
            var px := -2.92 + float(slot) * 0.49
            _add_box(dressing, "R6RackPlanter_%02d_%02d" % [tier, slot], Vector3(px, rack_y + 0.18, -2.76), Vector3(0.34, 0.22, 0.34), &"painted_metal")
            for leaf in range(3):
                var leaf_x := px + (float(leaf) - 1.0) * 0.12
                var leaf_y := rack_y + 0.50 + (0.10 if leaf == 1 else 0.0)
                var leaf_rot := -0.62 + float(leaf) * 0.62
                _add_box(
                    dressing,
                    "R6RackLeaf_%02d_%02d_%02d" % [tier, slot, leaf],
                    Vector3(leaf_x, leaf_y, -2.72),
                    Vector3(0.13, 0.13, 0.46),
                    &"foliage_muted",
                    Vector3(0.0, leaf_rot, 0.30 - float(leaf) * 0.30),
                )

    # Right-side supply wall gets the small repeated object rhythm visible in concept art.
    for tier in range(3):
        var shelf_y := 1.52 + float(tier) * 0.64
        for slot in range(6):
            var sx := 1.62 + float(slot) * 0.27
            var role: StringName = &"off_white"
            if (tier + slot) % 5 == 0:
                role = &"accent_amber"
            elif (tier + slot) % 4 == 0:
                role = &"accent_cyan"
            _add_box(
                dressing,
                "R6Supply_%02d_%02d" % [tier, slot],
                Vector3(sx, shelf_y, -2.96),
                Vector3(0.16, 0.28 + 0.04 * float((tier + slot) % 2), 0.16),
                role,
            )

    # Patchwork tile field: many smaller tiles replace the oversized empty floor read.
    var tile_roles: Array[StringName] = [
        &"worn_concrete", &"petrol_shadow", &"brick_coral", &"structural_dark",
        &"accent_amber", &"accent_cyan", &"accent_magenta",
    ]
    for row in range(5):
        for column in range(7):
            var tx := -2.45 + float(column) * 0.62
            var tz := 0.72 + float(row) * 0.62
            var role := tile_roles[(row * 3 + column * 2) % tile_roles.size()]
            _add_box(
                dressing,
                "R6FloorTile_%02d_%02d" % [row, column],
                Vector3(tx, 0.038, tz),
                Vector3(0.50, 0.052, 0.50),
                role,
            )

    # Compact stool/crate silhouettes frame the foreground workbench like the concept.
    _add_cylinder(dressing, "R6StoolSeat", Vector3(0.72, 0.58, 1.12), 0.28, 0.28, 0.16, &"repaired_wood")
    _add_box(dressing, "R6StoolLegA", Vector3(0.55, 0.28, 1.12), Vector3(0.09, 0.58, 0.09), &"painted_metal")
    _add_box(dressing, "R6StoolLegB", Vector3(0.89, 0.28, 1.12), Vector3(0.09, 0.58, 0.09), &"painted_metal")
    _add_box(dressing, "R6ForegroundCrateA", Vector3(1.85, 0.42, 1.52), Vector3(0.68, 0.82, 0.68), &"repaired_wood")
    _add_box(dressing, "R6ForegroundCrateB", Vector3(2.38, 0.28, 1.72), Vector3(0.46, 0.56, 0.50), &"painted_metal")

func _build_v1_revision7_detail(dressing: Node3D) -> void:
    # Revision 7: compact-room parity pass. The accepted concept is defined by
    # a dense vertical shell, warm hanging practicals, a three-tier left rack,
    # a packed right supply wall, and a short threshold rather than a long stage.

    # Stronger room envelope / cutaway frame.
    _add_box(dressing, "R7RoofBeamBack", Vector3(0.0, 4.48, -3.48), Vector3(7.15, 0.18, 0.18), &"structural_dark")
    _add_box(dressing, "R7RoofBeamLeft", Vector3(-3.28, 4.40, -0.20), Vector3(0.18, 0.18, 6.55), &"structural_dark")
    _add_box(dressing, "R7RoofBeamFront", Vector3(-0.30, 4.33, 2.72), Vector3(5.70, 0.16, 0.16), &"painted_metal")
    _add_box(dressing, "R7FrontThreshold", Vector3(-0.10, -0.04, 3.50), Vector3(6.20, 0.16, 0.30), &"structural_dark")

    # Third rack tier closes the large empty upper-left field.
    _add_box(dressing, "R7RackShelfTop", Vector3(-2.18, 3.35, -3.02), Vector3(2.20, 0.10, 0.56), &"repaired_wood")
    for slot in range(5):
        var px := -2.95 + float(slot) * 0.39
        _add_box(
            dressing,
            "R7RackPlanterTop_%02d" % slot,
            Vector3(px, 3.53, -2.76),
            Vector3(0.28, 0.20, 0.30),
            &"painted_metal",
        )
        for leaf in range(4):
            var leaf_x := px + (float(leaf) - 1.5) * 0.09
            var leaf_y := 3.78 + (0.08 if leaf % 2 == 0 else 0.0)
            var leaf_rot := -0.72 + float(leaf) * 0.48
            _add_box(
                dressing,
                "R7RackLeafTop_%02d_%02d" % [slot, leaf],
                Vector3(leaf_x, leaf_y, -2.70),
                Vector3(0.11, 0.11, 0.40),
                &"foliage_muted",
                Vector3(0.0, leaf_rot, 0.22 - float(leaf) * 0.14),
            )

    # Smaller leaf clusters along the rack sides increase the pixel silhouette
    # without reintroducing the old oversized foreground plants.
    for index in range(10):
        var side_y := 1.65 + float(index % 5) * 0.43
        var side_z := -2.88 + float(index / 5) * 0.30
        _add_box(
            dressing,
            "R7RackSideLeaf_%02d" % index,
            Vector3(-3.05 + 0.10 * float(index % 2), side_y, side_z),
            Vector3(0.12, 0.12, 0.38),
            &"foliage_muted",
            Vector3(0.0, -0.55 + 0.18 * float(index % 4), 0.32),
        )

    # Packed right-hand object wall, closer to the accepted workshop rhythm.
    var supply_roles: Array[StringName] = [
        &"off_white", &"accent_amber", &"painted_metal", &"accent_cyan", &"brick_coral",
    ]
    for tier in range(4):
        for slot in range(7):
            var sx := 1.50 + float(slot) * 0.25
            var sy := 1.10 + float(tier) * 0.48
            var role := supply_roles[(tier * 2 + slot) % supply_roles.size()]
            _add_box(
                dressing,
                "R7Supply_%02d_%02d" % [tier, slot],
                Vector3(sx, sy, -2.86),
                Vector3(0.14, 0.20 + 0.04 * float((tier + slot) % 3), 0.14),
                role,
            )

    # Repeated warm practicals create the amber pool hierarchy seen in concept.
    for index in range(3):
        var lx := -1.65 + float(index) * 1.55
        var lz := -1.10 + 0.18 * float(index % 2)
        _add_box(
            dressing,
            "R7PendantCord_%02d" % index,
            Vector3(lx, 3.95, lz),
            Vector3(0.035, 0.82, 0.035),
            &"structural_dark",
        )
        _add_cylinder(
            dressing,
            "R7PendantShade_%02d" % index,
            Vector3(lx, 3.52, lz),
            0.11,
            0.18,
            0.18,
            &"painted_metal",
        )
        _add_sphere(
            dressing,
            "R7PendantBulb_%02d" % index,
            Vector3(lx, 3.41, lz),
            0.075,
            &"accent_amber",
        )
        _add_point_light(
            dressing,
            "R7PendantLight_%02d" % index,
            Vector3(lx, 3.30, lz),
            &"accent_amber",
            2.15,
            3.00,
        )

    # Compact floor patch field occupies the room, not a long empty runway.
    var floor_roles: Array[StringName] = [
        &"worn_concrete", &"brick_coral", &"petrol_shadow", &"accent_amber", &"accent_cyan", &"accent_magenta",
    ]
    for row in range(3):
        for column in range(8):
            var tx := -2.55 + float(column) * 0.68
            var tz := 0.35 + float(row) * 0.66
            _add_box(
                dressing,
                "R7FloorPatch_%02d_%02d" % [row, column],
                Vector3(tx, 0.043, tz),
                Vector3(0.52, 0.050, 0.48),
                floor_roles[(row + column * 2) % floor_roles.size()],
            )

    # Short exterior landing and pavers keep the urban threshold without the
    # previous multi-screen service platform.
    _add_box(dressing, "R7LandingA", Vector3(-2.62, -0.14, 4.12), Vector3(1.90, 0.18, 0.72), &"worn_concrete")
    _add_box(dressing, "R7LandingB", Vector3(-2.75, -0.28, 4.65), Vector3(2.15, 0.20, 0.62), &"brick_coral")
    for index in range(6):
        _add_box(
            dressing,
            "R7StreetPaver_%02d" % index,
            Vector3(-1.85 + float(index % 3) * 0.62, -0.37, 5.00 + float(index / 3) * 0.48),
            Vector3(0.50, 0.12, 0.38),
            &"structural_dark" if index % 2 == 0 else &"worn_concrete",
        )


func _configure_v1_pixel_foliage() -> void:
    var world := $Viewport/World
    for planter_name in ["PlanterA", "PlanterRimA", "PlanterB", "PlanterRimB", "PlanterC", "PlanterRimC"]:
        var legacy_planter := world.get_node_or_null(planter_name) as MeshInstance3D
        if legacy_planter != null:
            legacy_planter.visible = false

    for node_name in V1_PLANT_MATERIAL_ROLES:
        var name := String(node_name)
        if not name.begins_with("Canopy"):
            continue
        var legacy_canopy := world.get_node_or_null(name) as MeshInstance3D
        if legacy_canopy != null:
            legacy_canopy.visible = false

    var dressing := world.get_node_or_null("V1ProductionDressing") as Node3D
    if dressing != null:
        for child in dressing.get_children():
            var rack_detail := child as Node3D
            if rack_detail == null:
                continue
            var detail_name := String(rack_detail.name)
            if detail_name.begins_with("RackFoliage") or detail_name.begins_with("PixelPlant") or detail_name.begins_with("PlantLeaf_"):
                rack_detail.visible = false

    interactive_object.position = Vector3(-2.18, 2.18, -2.72)
    var pixel_focus := world.get_node_or_null("V1ProductionDressing/R6RackLeaf_01_02_01") as MeshInstance3D
    if pixel_focus != null:
        focal_mesh = pixel_focus


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
    cool_key.light_energy = 0.78
    warm_practical.light_color = amber.albedo_color
    warm_practical.light_energy = 4.10
    warm_practical.omni_range = 5.8

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
