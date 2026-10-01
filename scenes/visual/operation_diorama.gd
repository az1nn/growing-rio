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

const V1_CAMERA_POSITION := Vector3(6.1, 6.95, 7.8)
const V1_CAMERA_ROTATION := Vector3(-0.50, 0.68, 0.0)
const V1_CAMERA_SIZE := 4.70
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
var _pixel_material_cache: Dictionary = {}

func _ready() -> void:
    V1PixelRenderPolicy.apply(self, viewport, V1_OPERATION_PIXEL_SHRINK)
    _configure_v1_camera()
    _configure_v1_composition()
    _configure_v1_compact_shell()
    _apply_v1_shell_materials()
    _apply_v1_cluster_materials()
    _configure_v1_environment()
    _configure_v1_lighting()
    _rebuild_v1_from_accepted_concept()
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

    for node_name in [
        "Floor",
        "FloorJointForeground",
        "FloorJointSpine",
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
    environment.background_color = Color.from_string("#070A14", Color.BLACK)
    environment.ambient_light_color = Color.from_string("#4B6074", Color.WHITE)
    # Candidate 6: restore the cool-night counter-tone and let local amber pools
    # carry the workshop hierarchy instead of flattening the whole room warm.
    environment.ambient_light_energy = 1.68

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
    _build_v1_revision8_detail(dressing)
    _build_v1_revision9_detail(dressing)
    _build_v1_revision10_detail(dressing)
    _build_v1_revision11_detail(dressing)

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


func _build_v1_revision8_detail(dressing: Node3D) -> void:
    # Revision 8: preserve the CENA-016 canonical Floor node as structural
    # evidence, but stop rendering its 11-unit foreground slab. A compact
    # authored floor now defines the visible room footprint, matching the
    # accepted cutaway workshop composition without changing semantics.
    _add_box(
        dressing,
        "R8CompactFloorBase",
        Vector3(0.0, -0.075, -0.10),
        Vector3(6.45, 0.15, 6.45),
        &"worn_concrete",
    )
    _add_box(
        dressing,
        "R8CompactFloorInset",
        Vector3(-0.05, 0.012, -0.18),
        Vector3(5.95, 0.035, 5.85),
        &"petrol_shadow",
    )
    _add_box(
        dressing,
        "R8FrontFascia",
        Vector3(0.0, -0.19, 3.16),
        Vector3(6.45, 0.34, 0.26),
        &"structural_dark",
    )
    _add_box(
        dressing,
        "R8LeftFloorFrame",
        Vector3(-3.13, -0.03, -0.08),
        Vector3(0.18, 0.18, 6.30),
        &"brick_coral",
    )
    _add_box(
        dressing,
        "R8RightFloorFrame",
        Vector3(3.13, -0.03, -0.08),
        Vector3(0.18, 0.18, 6.30),
        &"painted_metal",
    )

    # Give the accepted amber crown a clear authored wall field and larger
    # silhouette so it survives portrait composition and scene pixelation.
    _add_box(
        dressing,
        "R8CrownPanel",
        Vector3(1.18, 3.15, -3.675),
        Vector3(2.18, 1.52, 0.055),
        &"petrol_shadow",
    )
    _add_box(dressing, "R8CrownBase", Vector3(1.18, 2.80, -3.610), Vector3(1.34, 0.16, 0.060), &"accent_amber")
    _add_box(dressing, "R8CrownLeft", Vector3(0.72, 3.18, -3.608), Vector3(0.16, 0.76, 0.060), &"accent_amber", Vector3(0.0, 0.0, -0.34))
    _add_box(dressing, "R8CrownMid", Vector3(1.18, 3.30, -3.608), Vector3(0.16, 0.88, 0.060), &"accent_amber")
    _add_box(dressing, "R8CrownRight", Vector3(1.64, 3.18, -3.608), Vector3(0.16, 0.76, 0.060), &"accent_amber", Vector3(0.0, 0.0, 0.34))
    _add_box(dressing, "R8CrownTipL", Vector3(0.58, 3.48, -3.607), Vector3(0.22, 0.22, 0.060), &"accent_amber")
    _add_box(dressing, "R8CrownTipM", Vector3(1.18, 3.70, -3.607), Vector3(0.22, 0.22, 0.060), &"accent_amber")
    _add_box(dressing, "R8CrownTipR", Vector3(1.78, 3.48, -3.607), Vector3(0.22, 0.22, 0.060), &"accent_amber")
    _add_box(dressing, "R8CrownSplashCyan", Vector3(0.35, 2.82, -3.606), Vector3(0.38, 0.10, 0.060), &"accent_cyan", Vector3(0.0, 0.0, -0.48))
    _add_box(dressing, "R8CrownSplashMagenta", Vector3(1.98, 3.02, -3.606), Vector3(0.42, 0.10, 0.060), &"accent_magenta", Vector3(0.0, 0.0, 0.42))
    _add_point_light(dressing, "R8CrownGlow", Vector3(1.18, 3.08, -2.72), &"accent_amber", 2.35, 3.10)

    # Warm workbench pool pulls the visual hierarchy into the compact room
    # instead of the removed foreground runway.
    _add_point_light(dressing, "R8WorkbenchGlow", Vector3(1.10, 2.05, -0.20), &"accent_amber", 2.10, 3.20)



func _build_v1_revision9_detail(dressing: Node3D) -> void:
    # Revision 9: move the visible room from macro-block low-poly toward the
    # accepted authored pixel-art workshop language. Geometry remains physical,
    # stylized and presentation-only; gameplay/semantic ownership is untouched.

    # Small repaired masonry/plaster chips create surface rhythm while leaving
    # the high/right crown field unobscured.
    var wall_roles: Array[StringName] = [
        &"brick_coral", &"worn_concrete", &"petrol_shadow",
        &"painted_metal", &"off_white",
    ]
    for row in range(6):
        for column in range(10):
            var wx := -3.02 + float(column) * 0.63
            var wy := 0.52 + float(row) * 0.47
            if wx > 0.05 and wy > 2.34:
                continue
            var wrole := wall_roles[(row * 3 + column * 2) % wall_roles.size()]
            _add_box(
                dressing,
                "R9BackChip_%02d_%02d" % [row, column],
                Vector3(wx, wy, -3.642),
                Vector3(0.46, 0.18, 0.038),
                wrole,
            )

    # Narrow corrugated strips give the side wall a handmade painted-metal read
    # instead of one broad flat plane.
    for index in range(12):
        var sz := -2.78 + float(index) * 0.43
        var srole: StringName = &"painted_metal" if index % 3 != 0 else &"structural_dark"
        _add_box(
            dressing,
            "R9SideSlat_%02d" % index,
            Vector3(-3.335, 2.08, sz),
            Vector3(0.042, 2.15, 0.22),
            srole,
        )
    _add_box(dressing, "R9SideAccentCyan", Vector3(-3.305, 3.05, -1.15), Vector3(0.045, 0.10, 1.32), &"accent_cyan", Vector3(0.10, 0.0, 0.0))
    _add_box(dressing, "R9SideAccentMagenta", Vector3(-3.303, 2.78, 0.45), Vector3(0.045, 0.09, 1.02), &"accent_magenta", Vector3(-0.12, 0.0, 0.0))

    # Dense small pixel-leaf clusters reinforce three distinct left/back tiers.
    # These are abstract fictional silhouettes, not cultivation instructions.
    for tier in range(3):
        var base_y := 1.78 + float(tier) * 0.82
        for slot in range(5):
            var base_x := -2.92 + float(slot) * 0.43
            _add_box(
                dressing,
                "R9RackPot_%02d_%02d" % [tier, slot],
                Vector3(base_x, base_y, -2.75),
                Vector3(0.25, 0.18, 0.28),
                &"painted_metal",
            )
            for leaf in range(4):
                var leaf_x := base_x + (float(leaf) - 1.5) * 0.075
                var leaf_y := base_y + 0.27 + (0.075 if leaf % 2 == 0 else 0.0)
                var leaf_rot := -0.72 + float(leaf) * 0.48
                _add_box(
                    dressing,
                    "R9RackLeaf_%02d_%02d_%02d" % [tier, slot, leaf],
                    Vector3(leaf_x, leaf_y, -2.69),
                    Vector3(0.085, 0.085, 0.29),
                    &"foliage_muted",
                    Vector3(0.0, leaf_rot, 0.24 - float(leaf) * 0.16),
                )

    # Unobscured amber crown field: thicker silhouette, handmade offsets and
    # drips stay above the central UI-safe composition.
    _add_box(dressing, "R9CrownField", Vector3(1.28, 3.45, -3.665), Vector3(2.45, 1.72, 0.042), &"structural_dark")
    _add_box(dressing, "R9CrownBase", Vector3(1.28, 3.05, -3.585), Vector3(1.55, 0.17, 0.070), &"accent_amber")
    _add_box(dressing, "R9CrownPeakL", Vector3(0.76, 3.48, -3.582), Vector3(0.18, 0.82, 0.070), &"accent_amber", Vector3(0.0, 0.0, -0.36))
    _add_box(dressing, "R9CrownPeakM", Vector3(1.28, 3.60, -3.582), Vector3(0.18, 0.96, 0.070), &"accent_amber")
    _add_box(dressing, "R9CrownPeakR", Vector3(1.80, 3.48, -3.582), Vector3(0.18, 0.82, 0.070), &"accent_amber", Vector3(0.0, 0.0, 0.36))
    _add_box(dressing, "R9CrownHaloTop", Vector3(1.28, 4.02, -3.580), Vector3(1.52, 0.10, 0.070), &"accent_amber")
    for index in range(6):
        var dx := 0.58 + float(index) * 0.28
        var dy := 2.78 - 0.07 * float(index % 3)
        _add_box(
            dressing,
            "R9CrownDrip_%02d" % index,
            Vector3(dx, dy, -3.578),
            Vector3(0.07, 0.30 + 0.08 * float(index % 2), 0.060),
            &"accent_amber",
        )
    _add_box(dressing, "R9CrownSlashCyan", Vector3(0.27, 3.28, -3.576), Vector3(0.48, 0.08, 0.060), &"accent_cyan", Vector3(0.0, 0.0, -0.55))
    _add_box(dressing, "R9CrownSlashMagenta", Vector3(2.18, 3.55, -3.576), Vector3(0.52, 0.08, 0.060), &"accent_magenta", Vector3(0.0, 0.0, 0.48))

    # Repeated shelf/workbench silhouettes add authored density around the UI
    # instead of relying on oversized masses.
    var prop_roles: Array[StringName] = [
        &"off_white", &"repaired_wood", &"painted_metal",
        &"accent_amber", &"accent_cyan", &"brick_coral",
    ]
    for index in range(12):
        var px := 1.52 + float(index % 6) * 0.28
        var py := 1.12 + float(index / 6) * 0.52
        _add_box(
            dressing,
            "R9SupplyProp_%02d" % index,
            Vector3(px, py, -2.72),
            Vector3(0.15, 0.18 + 0.04 * float(index % 3), 0.14),
            prop_roles[index % prop_roles.size()],
        )
    for index in range(8):
        var wx := 0.28 + float(index % 4) * 0.36
        var wz := -0.86 + float(index / 4) * 0.34
        _add_box(
            dressing,
            "R9WorkbenchProp_%02d" % index,
            Vector3(wx, 1.22 + 0.035 * float(index % 2), wz),
            Vector3(0.18, 0.14 + 0.03 * float(index % 3), 0.16),
            prop_roles[(index + 2) % prop_roles.size()],
        )

    # Strong focal light pools recover the accepted warm practical hierarchy
    # while cyan/magenta remain controlled edge accents.
    _add_point_light(dressing, "R9RackWarmPool", Vector3(-2.15, 3.05, -2.35), &"accent_amber", 2.35, 2.75)
    _add_point_light(dressing, "R9CrownWarmPool", Vector3(1.28, 3.48, -2.55), &"accent_amber", 2.75, 3.00)
    _add_point_light(dressing, "R9WorkbenchWarmPool", Vector3(0.95, 2.05, -0.35), &"accent_amber", 2.45, 2.85)
    _add_point_light(dressing, "R9CoolEdgePool", Vector3(-2.95, 2.85, 0.20), &"accent_cyan", 0.72, 2.20)
    _add_point_light(dressing, "R9MagentaEdgePool", Vector3(2.75, 2.25, -1.25), &"accent_magenta", 0.58, 1.95)


func _build_v1_revision10_detail(dressing: Node3D) -> void:
    # Revision 10: the Rev9 exact-head 540x960 capture still read as sparse
    # macro-block geometry. Push the same accepted concept with denser authored
    # pixel silhouettes, brighter practicals and a stronger right-wall signature.
    var leaf_roles: Array[StringName] = [
        &"foliage_muted", &"foliage_muted", &"foliage_muted",
        &"foliage_muted", &"accent_magenta", &"accent_cyan",
        &"foliage_muted", &"accent_amber",
    ]

    # A packed three-tier rack becomes the dominant left/back silhouette.
    for tier in range(3):
        var base_y := 1.62 + float(tier) * 0.84
        _add_box(
            dressing,
            "R10GrowLight_%02d" % tier,
            Vector3(-2.02, base_y + 0.70, -2.93),
            Vector3(2.62, 0.08, 0.12),
            &"accent_amber",
        )
        _add_point_light(
            dressing,
            "R10GrowGlow_%02d" % tier,
            Vector3(-2.02, base_y + 0.54, -2.45),
            &"accent_amber",
            1.45,
            1.85,
        )
        for slot in range(7):
            var base_x := -3.02 + float(slot) * 0.34
            _add_box(
                dressing,
                "R10RackPot_%02d_%02d" % [tier, slot],
                Vector3(base_x, base_y, -2.72),
                Vector3(0.21, 0.17, 0.26),
                &"painted_metal",
            )
            for leaf in range(6):
                var leaf_x := base_x + (float(leaf % 3) - 1.0) * 0.085
                var leaf_y := base_y + 0.24 + float(leaf / 3) * 0.13
                var leaf_z := -2.66 + (0.055 if leaf % 2 == 0 else -0.035)
                var role := leaf_roles[(tier * 5 + slot + leaf) % leaf_roles.size()]
                _add_box(
                    dressing,
                    "R10RackLeaf_%02d_%02d_%02d" % [tier, slot, leaf],
                    Vector3(leaf_x, leaf_y, leaf_z),
                    Vector3(0.075, 0.075, 0.24),
                    role,
                    Vector3(
                        0.08 * float((leaf % 3) - 1),
                        -0.62 + float(leaf) * 0.24,
                        0.30 - float(leaf) * 0.12,
                    ),
                )

    # Rebuild the right workshop wall as many small readable objects instead of
    # one large cupboard mass.
    for row in range(4):
        var shelf_y := 1.05 + float(row) * 0.57
        _add_box(
            dressing,
            "R10SupplyShelf_%02d" % row,
            Vector3(2.12, shelf_y, -2.96),
            Vector3(2.15, 0.08, 0.38),
            &"repaired_wood",
        )
        for column in range(6):
            var prop_x := 1.30 + float(column) * 0.33
            var role: StringName = &"painted_metal"
            if (row + column) % 7 == 0:
                role = &"accent_magenta"
            elif (row + column) % 5 == 0:
                role = &"accent_cyan"
            elif (row + column) % 4 == 0:
                role = &"accent_amber"
            _add_box(
                dressing,
                "R10SupplyProp_%02d_%02d" % [row, column],
                Vector3(prop_x, shelf_y + 0.20, -2.72),
                Vector3(0.15, 0.22 + 0.035 * float((row + column) % 3), 0.16),
                role,
            )

    # Stronger crown silhouette stays right/back so it can read around the
    # operation controls instead of disappearing behind them.
    _add_box(dressing, "R10CrownField", Vector3(1.72, 3.40, -3.545), Vector3(2.05, 1.50, 0.055), &"petrol_shadow")
    _add_box(dressing, "R10CrownBase", Vector3(1.72, 3.05, -3.47), Vector3(1.34, 0.18, 0.075), &"accent_amber")
    _add_box(dressing, "R10CrownPeakL", Vector3(1.28, 3.43, -3.46), Vector3(0.18, 0.76, 0.075), &"accent_amber", Vector3(0.0, 0.0, -0.42))
    _add_box(dressing, "R10CrownPeakM", Vector3(1.72, 3.57, -3.46), Vector3(0.18, 0.92, 0.075), &"accent_amber")
    _add_box(dressing, "R10CrownPeakR", Vector3(2.16, 3.43, -3.46), Vector3(0.18, 0.76, 0.075), &"accent_amber", Vector3(0.0, 0.0, 0.42))
    for index in range(8):
        _add_box(
            dressing,
            "R10CrownDrip_%02d" % index,
            Vector3(1.08 + float(index) * 0.18, 2.82 - 0.05 * float(index % 3), -3.455),
            Vector3(0.055, 0.22 + 0.07 * float(index % 2), 0.06),
            &"accent_amber",
        )
    _add_point_light(dressing, "R10CrownGlow", Vector3(1.72, 3.30, -2.40), &"accent_amber", 3.65, 3.25)

    # Fine repaired surface rhythm and foreground workshop clutter remove the
    # remaining large empty fields without changing any semantic hit target.
    var chip_roles: Array[StringName] = [
        &"brick_coral", &"worn_concrete", &"off_white",
        &"painted_metal", &"petrol_shadow",
    ]
    for index in range(36):
        var cx := -2.92 + float(index % 9) * 0.66
        var cy := 0.42 + float(index / 9) * 0.36
        _add_box(
            dressing,
            "R10WallChip_%02d" % index,
            Vector3(cx, cy, -3.525),
            Vector3(0.24 + 0.06 * float(index % 3), 0.10, 0.045),
            chip_roles[index % chip_roles.size()],
        )

    for index in range(18):
        var wx := -0.05 + float(index % 6) * 0.34
        var wz := -0.72 + float(index / 6) * 0.30
        _add_box(
            dressing,
            "R10WorkbenchMicro_%02d" % index,
            Vector3(wx, 1.20 + 0.04 * float(index % 3), wz),
            Vector3(0.14, 0.12 + 0.035 * float(index % 2), 0.13),
            chip_roles[(index + 2) % chip_roles.size()],
        )

    _add_point_light(dressing, "R10WorkbenchGlow", Vector3(1.00, 1.95, -0.10), &"accent_amber", 3.15, 3.10)
    _add_point_light(dressing, "R10RackCyanEdge", Vector3(-3.00, 2.65, -1.85), &"accent_cyan", 0.95, 2.20)
    _add_point_light(dressing, "R10SupplyMagentaEdge", Vector3(2.95, 2.18, -2.20), &"accent_magenta", 0.80, 2.05)



func _build_v1_revision11_detail(dressing: Node3D) -> void:
    # Revision 11 is a consolidation pass, not another additive layer.
    # Exact-head Rev10 evidence exposed overlapping historical generations:
    # multiple racks, crowns and floor treatments were simultaneously visible
    # and collapsed into macro masses after portrait pixelation. Keep those
    # nodes as rollback evidence, but render one authored generation at a time.
    var superseded_prefixes: Array[String] = [
        "PlantRack",
        "PlanterRail",
        "RackFoliage",
        "RackLeaf_",
        "R6Rack",
        "R7Rack",
        "R9Rack",
        "R10Rack",
        "R10Grow",
        "FloorPatch",
        "FloorChip_",
        "R6FloorTile_",
        "BrickPatch",
        "MuralPlaster",
        "R6BackBrick_",
        "R10WallChip_",
        "R6ConceptCrown",
        "R8Crown",
        "R9Crown",
        "R10Crown",
        "SupplyShelf",
        "SupplyPost",
        "SupplyBin",
        "SupplyBottle",
        "R6Supply_",
        "R7Supply_",
        "R9SupplyProp_",
        "R10SupplyShelf_",
        "R10SupplyProp_",
        "R9WorkbenchProp_",
        "R10WorkbenchMicro_",
        # Revision 12: Rev11 visual evidence exposed a second class of leftovers:
        # early wall/graffiti generations and oversized pendant geometry were not
        # part of the first retirement list, so they still competed with the
        # consolidated rack/crown/supply composition.
        "BackBrick_",
        "SideBrick_",
        "GraffitiRibbon",
        "GraffitiPixel",
        "GraffitiDrip",
        "SideWallTag",
        "R9BackChip_",
        "R9SideSlat_",
        "R9SideAccent",
        "WarmPendant",
        "WarmBulb",
        "PendantCord",
        "WarmRackLight",
        "R8CrownGlow",
        "R8WorkbenchGlow",
        "R9RackWarmPool",
        "R9CrownWarmPool",
        "R9WorkbenchWarmPool",
        "R9CoolEdgePool",
        "R9MagentaEdgePool",
    ]
    for child in dressing.get_children():
        var node := child as Node3D
        if node == null:
            continue
        var detail_name := String(node.name)
        for prefix in superseded_prefixes:
            if detail_name.begins_with(prefix):
                node.visible = false
                break

    var world := dressing.get_parent() as Node3D
    if world != null:
        for node_name in V1_GRAFFITI_MATERIAL_ROLES:
            var legacy_crown := world.get_node_or_null(String(node_name)) as Node3D
            if legacy_crown != null:
                legacy_crown.visible = false

    # One clean three-tier left/back rack. Leaves stay small and separated so
    # nearest-neighbour portrait rendering preserves individual silhouettes.
    # Revision 12: keep one rack generation, but narrow it into the accepted
    # left/back vertical garden so it no longer spans the whole room.
    _add_box(dressing, "R11RackPostL", Vector3(-3.02, 2.38, -3.10), Vector3(0.07, 2.48, 0.07), &"painted_metal")
    _add_box(dressing, "R11RackPostR", Vector3(-1.18, 2.38, -3.10), Vector3(0.07, 2.48, 0.07), &"painted_metal")
    for tier in range(3):
        var rack_y := 1.46 + float(tier) * 0.78
        _add_box(
            dressing,
            "R11RackShelf_%02d" % tier,
            Vector3(-2.10, rack_y, -3.08),
            Vector3(1.98, 0.070, 0.34),
            &"repaired_wood",
        )
        _add_box(
            dressing,
            "R11GrowBar_%02d" % tier,
            Vector3(-2.10, rack_y + 0.58, -3.00),
            Vector3(1.88, 0.040, 0.060),
            &"accent_amber",
        )
        _add_point_light(
            dressing,
            "R11GrowGlow_%02d" % tier,
            Vector3(-2.10, rack_y + 0.45, -2.48),
            &"accent_amber",
            1.55,
            1.80,
        )
        for slot in range(5):
            var plant_x := -2.86 + float(slot) * 0.39
            _add_box(
                dressing,
                "R11RackPot_%02d_%02d" % [tier, slot],
                Vector3(plant_x, rack_y + 0.13, -2.82),
                Vector3(0.17, 0.14, 0.20),
                &"painted_metal",
            )
            for leaf in range(4):
                var leaf_x := plant_x + (float(leaf % 2) - 0.5) * 0.115
                var leaf_y := rack_y + 0.34 + float(leaf / 2) * 0.12
                var leaf_z := -2.75 + (0.045 if leaf % 2 == 0 else -0.025)
                _add_box(
                    dressing,
                    "R11RackLeaf_%02d_%02d_%02d" % [tier, slot, leaf],
                    Vector3(leaf_x, leaf_y, leaf_z),
                    Vector3(0.060, 0.070, 0.205),
                    &"foliage_muted",
                    Vector3(
                        0.04 * float((leaf % 2) * 2 - 1),
                        -0.55 + float(leaf) * 0.36,
                        0.34 - float(leaf) * 0.22,
                    ),
                )
            var bloom_role: StringName = &"accent_magenta" if (tier + slot) % 3 == 0 else &"accent_cyan"
            if (tier + slot) % 4 == 0:
                bloom_role = &"accent_amber"
            _add_box(
                dressing,
                "R11RackBloom_%02d_%02d" % [tier, slot],
                Vector3(plant_x + 0.025, rack_y + 0.53, -2.72),
                Vector3(0.10, 0.10, 0.10),
                bloom_role,
            )

    # Rebuild the right supply wall once, with small repeated object rhythm.
    _add_box(dressing, "R11SupplyPostL", Vector3(1.22, 2.05, -3.08), Vector3(0.08, 2.25, 0.08), &"painted_metal")
    _add_box(dressing, "R11SupplyPostR", Vector3(3.06, 2.05, -3.08), Vector3(0.08, 2.25, 0.08), &"painted_metal")
    var supply_roles: Array[StringName] = [
        &"off_white", &"painted_metal", &"repaired_wood",
        &"accent_amber", &"painted_metal", &"accent_cyan",
        &"brick_coral", &"painted_metal", &"accent_magenta",
    ]
    for row in range(4):
        var shelf_y := 1.05 + float(row) * 0.53
        _add_box(
            dressing,
            "R11SupplyShelf_%02d" % row,
            Vector3(2.14, shelf_y, -3.08),
            Vector3(2.02, 0.07, 0.34),
            &"repaired_wood",
        )
        for column in range(5):
            var prop_x := 1.38 + float(column) * 0.38
            var role := supply_roles[(row * 2 + column) % supply_roles.size()]
            _add_box(
                dressing,
                "R11SupplyProp_%02d_%02d" % [row, column],
                Vector3(prop_x, shelf_y + 0.17, -2.84),
                Vector3(0.13, 0.20 + 0.025 * float((row + column) % 3), 0.13),
                role,
            )
    _add_point_light(dressing, "R11SupplyWarmPool", Vector3(2.10, 2.35, -2.42), &"accent_amber", 1.85, 2.45)

    # One amber crown generation with a dark breathing field. The silhouette is
    # intentionally compact and hand-offset rather than a large vector slab.
    # Revision 12: crown moves into its own center/right breathing field and
    # grows slightly so it survives the 3x nearest-neighbour portrait shrink.
    _add_box(dressing, "R11CrownField", Vector3(0.88, 3.43, -3.57), Vector3(1.95, 1.42, 0.045), &"petrol_shadow")
    _add_box(dressing, "R11CrownBase", Vector3(0.88, 3.10, -3.49), Vector3(1.20, 0.15, 0.065), &"accent_amber")
    _add_box(dressing, "R11CrownPeakL", Vector3(0.48, 3.49, -3.485), Vector3(0.14, 0.70, 0.065), &"accent_amber", Vector3(0.0, 0.0, -0.40))
    _add_box(dressing, "R11CrownPeakM", Vector3(0.88, 3.62, -3.485), Vector3(0.14, 0.86, 0.065), &"accent_amber")
    _add_box(dressing, "R11CrownPeakR", Vector3(1.28, 3.49, -3.485), Vector3(0.14, 0.70, 0.065), &"accent_amber", Vector3(0.0, 0.0, 0.40))
    _add_box(dressing, "R11CrownTipL", Vector3(0.30, 3.78, -3.48), Vector3(0.13, 0.13, 0.065), &"accent_amber")
    _add_box(dressing, "R11CrownTipM", Vector3(0.88, 4.08, -3.48), Vector3(0.13, 0.13, 0.065), &"accent_amber")
    _add_box(dressing, "R11CrownTipR", Vector3(1.46, 3.78, -3.48), Vector3(0.13, 0.13, 0.065), &"accent_amber")
    for index in range(5):
        _add_box(
            dressing,
            "R11CrownDrip_%02d" % index,
            Vector3(0.42 + float(index) * 0.23, 2.92 - 0.04 * float(index % 2), -3.48),
            Vector3(0.045, 0.20 + 0.055 * float(index % 3), 0.055),
            &"accent_amber",
        )
    _add_box(dressing, "R11CrownSlashCyan", Vector3(0.10, 3.34, -3.475), Vector3(0.38, 0.065, 0.055), &"accent_cyan", Vector3(0.0, 0.0, -0.52))
    _add_box(dressing, "R11CrownSlashMagenta", Vector3(1.66, 3.23, -3.475), Vector3(0.36, 0.065, 0.055), &"accent_magenta", Vector3(0.0, 0.0, 0.44))
    _add_point_light(dressing, "R11CrownGlow", Vector3(0.88, 3.38, -2.45), &"accent_amber", 4.65, 3.35)
    _add_pixel_crown_decal(dressing)

    # Small repaired-wall rhythm replaces the large plaster and brick panels.
    var wall_roles: Array[StringName] = [
        &"brick_coral", &"worn_concrete", &"petrol_shadow",
        &"brick_coral", &"painted_metal", &"worn_concrete",
    ]
    for row in range(6):
        for column in range(9):
            var wall_x := -2.92 + float(column) * 0.61 + (0.20 if row % 2 == 1 else 0.0)
            var wall_y := 0.50 + float(row) * 0.39
            _add_box(
                dressing,
                "R11WallChip_%02d_%02d" % [row, column],
                Vector3(wall_x, wall_y, -3.535),
                Vector3(0.40, 0.12, 0.035),
                wall_roles[(row + column * 2) % wall_roles.size()],
            )

    # Fine mosaic fragments sit on the compact R8 floor; former half-metre
    # accent tiles are hidden above so the floor no longer dominates the room.
    var floor_roles: Array[StringName] = [
        &"worn_concrete", &"petrol_shadow", &"brick_coral",
        &"structural_dark", &"worn_concrete", &"repaired_wood",
        &"accent_amber", &"accent_cyan", &"accent_magenta",
    ]
    for row in range(5):
        for column in range(8):
            if (row * 2 + column) % 3 == 0:
                continue
            var tile_x := -2.22 + float(column) * 0.56
            var tile_z := 0.72 + float(row) * 0.52
            _add_box(
                dressing,
                "R11FloorTile_%02d_%02d" % [row, column],
                Vector3(tile_x, 0.045, tile_z),
                Vector3(0.29, 0.045, 0.29),
                floor_roles[(row * 3 + column) % floor_roles.size()],
            )

    # Keep the workbench readable as one foreground anchor with small tools,
    # not another stack of historical micro-prop generations.
    for index in range(12):
        var tool_x := 0.18 + float(index % 6) * 0.25
        var tool_z := -0.84 + float(index / 6) * 0.34
        var tool_role: StringName = &"painted_metal"
        if index % 5 == 0:
            tool_role = &"accent_amber"
        elif index % 7 == 0:
            tool_role = &"accent_cyan"
        _add_box(
            dressing,
            "R11WorkbenchMicro_%02d" % index,
            Vector3(tool_x, 1.19 + 0.025 * float(index % 3), tool_z),
            Vector3(0.11, 0.09 + 0.02 * float(index % 2), 0.10),
            tool_role,
        )
    _add_point_light(dressing, "R11WorkbenchGlow", Vector3(0.92, 1.90, -0.20), &"accent_amber", 3.45, 3.05)

func _rebuild_v1_from_accepted_concept() -> void:
    # R04 structural rebase: Rev1-13 additive dressing was rejected by ARTIST/CENA.
    # Replace the visible scaffold while preserving canonical interaction ownership.
    var world := $Viewport/World

    for child in world.get_children():
        if child is MeshInstance3D:
            (child as MeshInstance3D).visible = false

    var rebuild := Node3D.new()
    rebuild.name = "OperationV1AcceptedRebuild"
    world.add_child(rebuild)

    _add_box(rebuild, "AcceptedFloor", Vector3(0.0, -0.03, -0.35), Vector3(5.35, 0.18, 3.55), &"worn_concrete")
    _add_box(rebuild, "AcceptedBackWall", Vector3(0.0, 2.15, -2.43), Vector3(5.70, 4.30, 0.16), &"petrol_shadow")
    _add_box(rebuild, "AcceptedSideWall", Vector3(-2.78, 1.95, -0.15), Vector3(0.16, 3.90, 4.45), &"structural_dark")
    _add_box(rebuild, "AcceptedBackLintel", Vector3(0.0, 4.20, -2.30), Vector3(5.70, 0.16, 0.20), &"painted_metal")
    _add_box(rebuild, "AcceptedSideLintel", Vector3(-2.66, 4.05, -0.15), Vector3(0.20, 0.16, 4.45), &"painted_metal")

    for row in range(8):
        for column in range(14):
            if (row + column * 2) % 5 == 0:
                continue
            var brick_x := -2.52 + float(column) * 0.39 + (0.18 if row % 2 == 1 else 0.0)
            var brick_y := 0.42 + float(row) * 0.43
            var brick_role: StringName = &"brick_coral" if (row + column) % 4 == 0 else &"worn_concrete"
            _add_box(rebuild, "AcceptedBackBrick_%02d_%02d" % [row, column], Vector3(brick_x, brick_y, -2.31), Vector3(0.25, 0.12, 0.055), brick_role)

    for row in range(7):
        for column in range(8):
            if (row * 3 + column) % 4 == 0:
                continue
            _add_box(
                rebuild,
                "AcceptedSideRepair_%02d_%02d" % [row, column],
                Vector3(-2.66, 0.48 + float(row) * 0.46, -1.95 + float(column) * 0.48),
                Vector3(0.055, 0.14, 0.29),
                &"brick_coral" if (row + column) % 3 == 0 else &"painted_metal",
            )

    _add_box(rebuild, "GardenPostLeft", Vector3(-2.35, 2.12, -2.02), Vector3(0.10, 2.65, 0.12), &"painted_metal")
    _add_box(rebuild, "GardenPostRight", Vector3(-0.92, 2.12, -2.02), Vector3(0.10, 2.65, 0.12), &"painted_metal")
    for tier in range(3):
        var shelf_y := 1.18 + float(tier) * 0.78
        _add_box(rebuild, "GardenShelf_%02d" % tier, Vector3(-1.63, shelf_y, -2.02), Vector3(1.62, 0.09, 0.48), &"repaired_wood")
        _add_box(rebuild, "GardenWarmBar_%02d" % tier, Vector3(-1.63, shelf_y + 0.34, -1.78), Vector3(1.44, 0.055, 0.07), &"accent_amber")
        for pot in range(5):
            var pot_x := -2.25 + float(pot) * 0.31
            _add_box(rebuild, "GardenPot_%02d_%02d" % [tier, pot], Vector3(pot_x, shelf_y + 0.14, -1.91), Vector3(0.22, 0.22, 0.24), &"painted_metal")
            for leaf in range(4):
                _add_box(
                    rebuild,
                    "GardenLeaf_%02d_%02d_%02d" % [tier, pot, leaf],
                    Vector3(
                        pot_x + (-0.12 + float(leaf % 2) * 0.24),
                        shelf_y + 0.38 + float(leaf / 2) * 0.16,
                        -1.82 + (-0.08 if leaf % 3 == 0 else 0.08)
                    ),
                    Vector3(0.16, 0.18, 0.14),
                    &"foliage_muted",
                    Vector3(0.0, 0.18 * float((pot + leaf) % 3), 0.0),
                )
    _add_point_light(rebuild, "GardenWarmPool", Vector3(-1.62, 2.38, -1.30), &"accent_amber", 7.4, 3.0)
    _promote_accepted_garden_foliage(rebuild)

    var bench_top := _add_box(rebuild, "WorkbenchTop", Vector3(0.18, 0.78, -0.22), Vector3(2.05, 0.18, 1.02), &"repaired_wood")
    _add_box(rebuild, "WorkbenchCabinetLeft", Vector3(-0.42, 0.36, -0.20), Vector3(0.78, 0.72, 0.92), &"painted_metal")
    _add_box(rebuild, "WorkbenchCabinetRight", Vector3(0.66, 0.36, -0.20), Vector3(0.78, 0.72, 0.92), &"structural_dark")
    for prop in range(16):
        var role: StringName = &"off_white"
        if prop % 5 == 0:
            role = &"accent_amber"
        elif prop % 7 == 0:
            role = &"accent_cyan"
        elif prop % 3 == 0:
            role = &"painted_metal"
        _add_box(
            rebuild,
            "WorkbenchProp_%02d" % prop,
            Vector3(-0.62 + float(prop % 8) * 0.22, 0.96 + 0.025 * float(prop % 3), -0.50 + float(prop / 8) * 0.42),
            Vector3(0.12, 0.15 + 0.025 * float(prop % 2), 0.12),
            role,
        )
    _add_point_light(rebuild, "WorkbenchWarmPool", Vector3(0.10, 1.62, -0.24), &"accent_amber", 8.2, 3.1)

    _add_box(rebuild, "SupplyPostLeft", Vector3(0.82, 2.00, -1.72), Vector3(0.10, 2.72, 0.10), &"painted_metal")
    _add_box(rebuild, "SupplyPostRight", Vector3(2.18, 2.00, -1.72), Vector3(0.10, 2.72, 0.10), &"painted_metal")
    var supply_roles: Array[StringName] = [&"off_white", &"painted_metal", &"accent_amber", &"brick_coral", &"accent_cyan", &"accent_magenta"]
    var management_focus: MeshInstance3D
    for tier in range(4):
        var supply_y := 0.92 + float(tier) * 0.67
        _add_box(rebuild, "SupplyShelf_%02d" % tier, Vector3(1.50, supply_y, -1.72), Vector3(1.55, 0.09, 0.46), &"repaired_wood")
        for item in range(6):
            var supply_prop := _add_box(
                rebuild,
                "SupplyProp_%02d_%02d" % [tier, item],
                Vector3(0.92 + float(item) * 0.23, supply_y + 0.20, -1.49),
                Vector3(0.13, 0.20 + 0.03 * float((tier + item) % 3), 0.13),
                supply_roles[(tier + item * 2) % supply_roles.size()],
            )
            if tier == 2 and item == 3:
                management_focus = supply_prop
    _add_point_light(rebuild, "SupplyWarmPool", Vector3(1.58, 2.18, -1.12), &"accent_amber", 5.4, 2.7)

    # Candidate 8: exact-head evidence showed Candidate 7 was large enough in
    # geometry but still hidden by the garden/supply silhouettes. Keep the same
    # accepted rebuild and move the existing focal language into the exposed
    # back-wall corridor between those two clusters, matching the accepted
    # concept's readable crown-on-dark-field hierarchy without new dressing.
    _add_box(rebuild, "AcceptedShutterField", Vector3(-0.04, 2.50, -2.27), Vector3(1.36, 1.64, 0.055), &"painted_metal")
    for slat in range(5):
        _add_box(
            rebuild,
            "AcceptedShutterSlat_%02d" % slat,
            Vector3(-0.04, 1.96 + float(slat) * 0.26, -2.20),
            Vector3(1.24, 0.075, 0.045),
            &"structural_dark",
        )
    _add_box(rebuild, "GraffitiStrokeCyan", Vector3(-0.18, 2.22, -2.14), Vector3(1.18, 0.22, 0.055), &"accent_cyan", Vector3(0.0, 0.0, -0.30))
    _add_box(rebuild, "GraffitiStrokeMagenta", Vector3(0.12, 2.55, -2.13), Vector3(1.20, 0.22, 0.055), &"accent_magenta", Vector3(0.0, 0.0, 0.34))
    _add_box(rebuild, "GraffitiPixelCyan", Vector3(-0.42, 2.82, -2.12), Vector3(0.34, 0.34, 0.055), &"accent_cyan")
    _add_box(rebuild, "GraffitiPixelMagenta", Vector3(0.40, 2.06, -2.12), Vector3(0.34, 0.34, 0.055), &"accent_magenta")

    # The dark crown field is deliberately bounded to the unobstructed corridor:
    # garden right edge ~= -0.82, supply left edge ~= +0.72.
    _add_box(rebuild, "CrownField", Vector3(-0.04, 2.56, -2.17), Vector3(1.32, 1.48, 0.045), &"structural_dark")
    _add_box(rebuild, "CrownBase", Vector3(-0.04, 2.29, -2.05), Vector3(1.12, 0.23, 0.055), &"accent_amber")
    _add_box(rebuild, "CrownPeakLeft", Vector3(-0.36, 2.58, -2.04), Vector3(0.20, 0.72, 0.055), &"accent_amber", Vector3(0.0, 0.0, -0.38))
    _add_box(rebuild, "CrownPeakMiddle", Vector3(-0.04, 2.68, -2.04), Vector3(0.20, 0.86, 0.055), &"accent_amber")
    _add_box(rebuild, "CrownPeakRight", Vector3(0.28, 2.58, -2.04), Vector3(0.20, 0.72, 0.055), &"accent_amber", Vector3(0.0, 0.0, 0.38))
    _add_box(rebuild, "CrownTipLeft", Vector3(-0.48, 2.88, -2.03), Vector3(0.23, 0.23, 0.055), &"accent_amber")
    _add_box(rebuild, "CrownTipMiddle", Vector3(-0.04, 3.05, -2.03), Vector3(0.23, 0.23, 0.055), &"accent_amber")
    _add_box(rebuild, "CrownTipRight", Vector3(0.40, 2.88, -2.03), Vector3(0.23, 0.23, 0.055), &"accent_amber")
    _add_box(rebuild, "CrownSlashCyan", Vector3(-0.55, 2.39, -2.02), Vector3(0.35, 0.13, 0.055), &"accent_cyan", Vector3(0.0, 0.0, -0.44))
    _add_box(rebuild, "CrownSlashMagenta", Vector3(0.49, 2.38, -2.02), Vector3(0.35, 0.13, 0.055), &"accent_magenta", Vector3(0.0, 0.0, 0.44))
    _add_point_light(rebuild, "CrownGlow", Vector3(-0.04, 2.48, -1.32), &"accent_amber", 10.2, 2.8)

    _add_box(rebuild, "FanFrameTop", Vector3(1.42, 3.92, -2.24), Vector3(0.92, 0.07, 0.07), &"painted_metal")
    _add_box(rebuild, "FanFrameBottom", Vector3(1.42, 3.13, -2.24), Vector3(0.92, 0.07, 0.07), &"painted_metal")
    _add_box(rebuild, "FanBladeVertical", Vector3(1.42, 3.52, -2.18), Vector3(0.10, 0.70, 0.06), &"painted_metal")
    _add_box(rebuild, "FanBladeHorizontal", Vector3(1.42, 3.52, -2.18), Vector3(0.70, 0.10, 0.06), &"painted_metal")
    _add_box(rebuild, "PendantCordLeft", Vector3(-1.02, 3.72, -0.70), Vector3(0.04, 0.88, 0.04), &"structural_dark")
    _add_box(rebuild, "PendantShadeLeft", Vector3(-1.02, 3.28, -0.70), Vector3(0.30, 0.16, 0.30), &"painted_metal")
    _add_point_light(rebuild, "PendantLightLeft", Vector3(-1.02, 3.14, -0.70), &"accent_amber", 4.8, 2.5)
    _add_box(rebuild, "PendantCordRight", Vector3(0.88, 3.78, -0.58), Vector3(0.04, 0.96, 0.04), &"structural_dark")
    _add_box(rebuild, "PendantShadeRight", Vector3(0.88, 3.30, -0.58), Vector3(0.30, 0.16, 0.30), &"painted_metal")
    _add_point_light(rebuild, "PendantLightRight", Vector3(0.88, 3.15, -0.58), &"accent_amber", 4.6, 2.5)

    var floor_roles: Array[StringName] = [&"worn_concrete", &"structural_dark", &"brick_coral", &"repaired_wood", &"accent_cyan", &"accent_magenta", &"accent_amber"]
    for row in range(5):
        for column in range(8):
            if (row + column) % 4 == 0:
                continue
            _add_box(
                rebuild,
                "FloorPatch_%02d_%02d" % [row, column],
                Vector3(-2.30 + float(column) * 0.60, 0.075, -0.85 + float(row) * 0.58),
                Vector3(0.31, 0.045, 0.31),
                floor_roles[(row * 2 + column) % floor_roles.size()],
            )

    _add_box(rebuild, "EntryStepTop", Vector3(-1.72, -0.10, 1.48), Vector3(1.32, 0.18, 0.50), &"worn_concrete")
    _add_box(rebuild, "EntryStepMid", Vector3(-1.80, -0.22, 1.82), Vector3(1.48, 0.20, 0.52), &"brick_coral")
    _add_box(rebuild, "EntryStepLow", Vector3(-1.88, -0.35, 2.18), Vector3(1.64, 0.22, 0.54), &"worn_concrete")

    interactive_object.position = Vector3(-1.63, 2.05, -1.82)
    management_interactive_object.position = Vector3(1.50, 1.95, -1.47)
    workbench_interactive_object.position = Vector3(0.18, 0.84, -0.20)

    var plant_focus := rebuild.get_node_or_null("GardenLeaf_01_02_03") as MeshInstance3D
    if plant_focus != null:
        focal_mesh = plant_focus
    if management_focus != null:
        management_marker = management_focus
    workbench_marker = bench_top


func _promote_accepted_garden_foliage(rebuild: Node3D) -> void:
    # Candidate 6 keeps the shared foliage hue but raises local luminance so
    # the garden reads as alive against the petrol wall without adding a new
    # gameplay or cultivation mechanic.
    for child in rebuild.get_children():
        var leaf := child as MeshInstance3D
        if leaf == null or not String(leaf.name).begins_with("GardenLeaf_"):
            continue
        var source_material := leaf.material_override as StandardMaterial3D
        if source_material == null:
            continue
        var focal_material := source_material.duplicate() as StandardMaterial3D
        focal_material.emission_enabled = true
        focal_material.emission = source_material.albedo_color
        focal_material.emission_energy_multiplier = 0.62
        leaf.material_override = focal_material


func _configure_v1_pixel_foliage() -> void:
    var world := $Viewport/World

    # Structural-rebase fence: the accepted-concept rebuild owns the visible
    # garden and hotspot alignment. Do not let the legacy foliage cleanup path
    # overwrite the semantic anchor established by _rebuild_v1_from_accepted_concept().
    var accepted_rebuild := world.get_node_or_null("OperationV1AcceptedRebuild") as Node3D
    if accepted_rebuild != null:
        var accepted_focus := accepted_rebuild.get_node_or_null("GardenLeaf_01_02_03") as MeshInstance3D
        if accepted_focus != null:
            focal_mesh = accepted_focus
        return

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
            if detail_name.begins_with("RackFoliage") or detail_name.begins_with("PixelFoliage") or detail_name.begins_with("PixelPlant") or detail_name.begins_with("PlantLeaf_"):
                rack_detail.visible = false

    interactive_object.position = Vector3(-2.18, 2.18, -2.72)
    var pixel_focus := world.get_node_or_null("V1ProductionDressing/R11RackLeaf_01_03_02") as MeshInstance3D
    if pixel_focus != null:
        focal_mesh = pixel_focus


func _operation_material(role: StringName, variant_key: String = "") -> StandardMaterial3D:
    var variant := variant_key.length() % 4
    var cache_key := "%s:%d" % [String(role), variant]
    if _pixel_material_cache.has(cache_key):
        return _pixel_material_cache[cache_key]

    var material := V1MaterialVocabulary.make_standard(role)
    material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
    material.albedo_texture = _make_pixel_surface_texture(role, material.albedo_color, variant)
    _pixel_material_cache[cache_key] = material
    return material


func _make_pixel_surface_texture(
    role: StringName,
    base_color: Color,
    variant: int,
) -> ImageTexture:
    # Keep the role swatch in material.albedo_color and use this image only
    # as a luminance/detail multiplier. Baking the swatch into both places
    # would double-tint the surface and make the room darker than the target.
    var image := Image.create(16, 16, false, Image.FORMAT_RGBA8)
    var neutral := Color(0.94, 0.94, 0.94, 1.0)
    image.fill(neutral)

    var lighter := Color(1.0, 1.0, 1.0, 1.0)
    var lightest := Color(1.0, 1.0, 1.0, 1.0)
    var darker := Color(0.76, 0.76, 0.76, 1.0)
    var darkest := Color(0.58, 0.58, 0.58, 1.0)
    var key := String(role)

    for y in range(16):
        for x in range(16):
            var color := neutral
            if key == "brick_coral":
                var row := int(y / 4)
                var joint_x := (x + (4 if row % 2 == 1 else 0)) % 8
                if y % 4 == 0 or joint_x == 0:
                    color = darkest
                elif (x * 3 + y + variant) % 11 == 0:
                    color = lighter
            elif key == "repaired_wood":
                if y % 4 == 0:
                    color = darker
                elif (x * 5 + y + variant * 3) % 13 == 0:
                    color = lightest
                elif (x + y * 2 + variant) % 9 == 0:
                    color = darker
            elif key == "worn_concrete":
                if (x * 7 + y * 5 + variant) % 17 == 0:
                    color = lightest
                elif (x * 3 + y * 11 + variant) % 13 == 0:
                    color = darkest
                elif (x + y + variant) % 7 == 0:
                    color = darker
            elif key == "painted_metal":
                if (x + variant) % 6 == 0:
                    color = lighter
                elif (x + y * 3 + variant) % 15 == 0:
                    color = darkest
            elif key == "structural_dark" or key == "petrol_shadow":
                if (x + y + variant) % 6 == 0:
                    color = lighter
                elif (x * 2 + y * 3 + variant) % 13 == 0:
                    color = darkest
            elif key == "foliage_muted":
                if (int(x / 2) + int(y / 2) + variant) % 3 == 0:
                    color = lighter
                elif (x * 3 + y + variant) % 10 == 0:
                    color = darkest
            elif key.begins_with("accent_"):
                if (x + y * 2 + variant) % 11 == 0:
                    color = lightest
                elif (x * 2 + y + variant) % 17 == 0:
                    color = darker
            elif key == "off_white":
                if (x * 5 + y * 3 + variant) % 19 == 0:
                    color = darker

            image.set_pixel(x, y, color)

    return ImageTexture.create_from_image(image)


func _add_pixel_crown_decal(parent: Node3D) -> MeshInstance3D:
    var image := Image.create(32, 24, false, Image.FORMAT_RGBA8)
    image.fill(Color(0.0, 0.0, 0.0, 0.0))

    var amber := Color.from_string("#E7AD48", Color.WHITE)
    var amber_hot := Color.from_string("#FFD36A", Color.WHITE)
    var cyan := Color.from_string("#36BAC6", Color.WHITE)
    var magenta := Color.from_string("#E83F88", Color.WHITE)

    image.fill_rect(Rect2i(5, 16, 22, 3), amber)
    image.fill_rect(Rect2i(7, 9, 3, 9), amber)
    image.fill_rect(Rect2i(15, 5, 3, 13), amber_hot)
    image.fill_rect(Rect2i(23, 9, 3, 9), amber)
    image.fill_rect(Rect2i(6, 7, 5, 3), amber_hot)
    image.fill_rect(Rect2i(14, 3, 5, 3), amber_hot)
    image.fill_rect(Rect2i(22, 7, 5, 3), amber_hot)
    image.fill_rect(Rect2i(8, 19, 2, 4), amber)
    image.fill_rect(Rect2i(14, 19, 2, 3), amber)
    image.fill_rect(Rect2i(21, 19, 2, 5), amber)
    image.fill_rect(Rect2i(3, 13, 6, 2), cyan)
    image.fill_rect(Rect2i(24, 12, 6, 2), magenta)

    var texture := ImageTexture.create_from_image(image)
    var material := StandardMaterial3D.new()
    material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
    material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
    material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
    material.cull_mode = BaseMaterial3D.CULL_DISABLED
    material.albedo_texture = texture

    var mesh := QuadMesh.new()
    mesh.size = Vector2(2.15, 1.55)

    var node := MeshInstance3D.new()
    node.name = &"R13CrownDecal"
    node.mesh = mesh
    node.position = Vector3(0.92, 3.50, -3.42)
    node.material_override = material
    parent.add_child(node)
    return node


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
    node.material_override = _operation_material(role, node_name)
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
    node.material_override = _operation_material(role, node_name)
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
    node.material_override = _operation_material(role, node_name)
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
        mesh_instance.material_override = _operation_material(StringName(role_map[node_name]), String(node_name))

func _configure_v1_lighting() -> void:
    var cyan := V1MaterialVocabulary.make_standard(&"accent_cyan")
    var amber := V1MaterialVocabulary.make_standard(&"accent_amber")
    cool_key.light_color = cyan.albedo_color
    # Candidate 7: strengthen the existing cool-night key while pulling back
    # the global amber practical. Local authored amber pools remain the warm
    # hierarchy; no new lighting architecture is introduced.
    cool_key.light_energy = 0.92
    warm_practical.light_color = amber.albedo_color
    warm_practical.light_energy = 6.20
    warm_practical.omni_range = 6.20

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
