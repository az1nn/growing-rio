extends SceneTree

const OPERATION_DIORAMA := preload("res://scenes/visual/operation_diorama.tscn")

var _activation_context := ""
var _activation_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene = OPERATION_DIORAMA.instantiate()
    root.add_child(scene)
    await process_frame

    var required_paths := [
        "Viewport/World/Camera3D",
        "Viewport/World/WorldEnvironment",
        "Viewport/World/Floor",
        "Viewport/World/BackWall",
        "Viewport/World/SideWall",
        "Viewport/World/MetalDoor",
        "Viewport/World/V1GraffitiCrownBase",
        "Viewport/World/V1GraffitiCrownMidLeft",
        "Viewport/World/V1ProductionDressing",
        "Viewport/World/V1ProductionDressing/BrickPatchBackA",
        "Viewport/World/V1ProductionDressing/BackFanHub",
        "Viewport/World/V1ProductionDressing/WarmPendantA",
        "Viewport/World/V1ProductionDressing/FloorPatchAmber",
        "Viewport/World/V1ProductionDressing/GraffitiRibbonCyan",
        "Viewport/World/V1ProductionDressing/PixelFoliageA",
        "Viewport/World/V1ProductionDressing/PixelPlantBMain",
        "Viewport/World/V1ProductionDressing/GraffitiDripMagenta",
        "Viewport/World/V1ProductionDressing/WorkbenchEdgeAmber",
        "Viewport/World/TileCounter",
        "Viewport/World/InteractivePlantCluster/CollisionShape3D",
        "Viewport/World/ManagementStorageInteraction/CollisionShape3D",
        "Viewport/World/WorkbenchInteraction/CollisionShape3D",
        "ObjectActionButton",
        "ManagementActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("Feature 012 R04 Operation missing required node: %s" % path)
            return

    var viewport := scene.get_node("Viewport") as SubViewport
    var camera := scene.get_node("Viewport/World/Camera3D") as Camera3D
    if scene.stretch_shrink != 3:
        _fail("Feature 012 R04 did not apply the stronger Operation-specific V1 pixel shrink.")
        return
    if scene.texture_filter != CanvasItem.TEXTURE_FILTER_NEAREST:
        _fail("Feature 012 R04 did not keep nearest-neighbor scene filtering.")
        return
    if viewport.render_target_update_mode != SubViewport.UPDATE_ALWAYS:
        _fail("Feature 012 R04 V1 viewport is not configured for continuous runtime rendering.")
        return
    if camera.projection != Camera3D.PROJECTION_ORTHOGONAL:
        _fail("Feature 012 R04 Operation camera lost orthographic V1 composition.")
        return
    if camera.size > 7.5:
        _fail("Feature 012 R04 Operation camera regressed to a distant low-impact framing.")
        return

    var floor := scene.get_node("Viewport/World/Floor") as MeshInstance3D
    var back_wall := scene.get_node("Viewport/World/BackWall") as MeshInstance3D
    var metal_door := scene.get_node("Viewport/World/MetalDoor") as MeshInstance3D
    if not _has_v1_color(floor, "3B3E40"):
        _fail("Feature 012 R04 floor is not using V1 worn_concrete.")
        return
    if not _has_v1_color(back_wall, "173940"):
        _fail("Feature 012 R04 back wall is not using V1 petrol_shadow.")
        return
    if not _has_v1_color(metal_door, "263139"):
        _fail("Feature 012 R04 door is not using V1 painted_metal.")
        return
    if not _has_v1_color(scene.get_node("Viewport/World/CounterTop") as MeshInstance3D, "6B4B37"):
        _fail("Feature 012 R04 workbench is not using V1 repaired_wood.")
        return
    if not _has_v1_color(scene.get_node("Viewport/World/CanopyB") as MeshInstance3D, "536E54"):
        _fail("Feature 012 R04 abstract plants are not using V1 foliage_muted.")
        return
    if not _has_v1_color(scene.get_node("Viewport/World/StorageBinMid") as MeshInstance3D, "E83F88"):
        _fail("Feature 012 R04 storage focal accent is not using V1 magenta.")
        return
    if not _has_v1_color(scene.get_node("Viewport/World/V1GraffitiCrownBase") as MeshInstance3D, "E7AD48"):
        _fail("Feature 012 R04 physical crown is not using the accepted amber V1 crown role.")
        return

    var dressing := scene.get_node("Viewport/World/V1ProductionDressing") as Node3D
    if dressing.get_child_count() < 88:
        _fail("Feature 012 R04 dense V1 dressing regressed below the Revision 4 production detail floor.")
        return
    var environment := (scene.get_node("Viewport/World/WorldEnvironment") as WorldEnvironment).environment
    if environment == null or environment.ambient_light_energy < 1.25:
        _fail("Feature 012 R04 urban room lighting regressed below the accepted-concept readability floor.")
        return

    if not scene.has_pointer_interaction() or not scene.has_secondary_pointer_interaction() or not scene.has_workbench_pointer_interaction():
        _fail("Feature 012 R04 lost pointer/touch hotspot picking.")
        return
    if not scene.has_accessible_button_fallback() or not scene.has_secondary_accessible_button_fallback():
        _fail("Feature 012 R04 lost accessible hotspot fallback.")
        return

    var workbench_focus := scene.get_node("Viewport/World/WorkbenchInteraction") as Area3D
    var plant_focus := scene.get_node("Viewport/World/InteractivePlantCluster") as Area3D
    var storage_focus := scene.get_node("Viewport/World/ManagementStorageInteraction") as Area3D
    if workbench_focus.position.distance_to(plant_focus.position) < 1.5:
        _fail("Feature 012 R04 workbench and plant foci are not spatially distinct.")
        return
    if workbench_focus.position.distance_to(storage_focus.position) < 1.5:
        _fail("Feature 012 R04 workbench and storage foci are not spatially distinct.")
        return

    scene.object_activated.connect(_on_object_activated)
    scene.activate_primary_object()
    await process_frame
    if _activation_context != "operation" or _activation_object != "plant_cluster":
        _fail("Feature 012 R04 primary activation contract changed.")
        return

    _activation_context = ""
    _activation_object = ""
    scene.activate_management_object()
    await process_frame
    if _activation_context != "operation" or _activation_object != "management_storage":
        _fail("Feature 012 R04 management activation contract changed.")
        return

    var source := FileAccess.get_file_as_string("res://scenes/visual/operation_diorama.gd")
    for forbidden in ["/root/GameState", "care_for_room(", "harvest(", "next_day("]:
        if source.contains(forbidden):
            _fail("Feature 012 R04 visual diorama gained forbidden domain reference: %s" % forbidden)
            return

    print("OPERATION V1 DIORAMA TEST PASSED")
    quit(0)

func _has_v1_color(mesh: MeshInstance3D, expected_hex: String) -> bool:
    var material := mesh.material_override as StandardMaterial3D
    if material == null:
        return false
    return material.albedo_color.to_html(false).to_upper() == expected_hex

func _on_object_activated(context_id: String, object_id: String) -> void:
    _activation_context = context_id
    _activation_object = object_id

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
