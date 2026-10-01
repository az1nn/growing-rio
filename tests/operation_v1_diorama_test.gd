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
        "Viewport/World/InteractivePlantCluster/CollisionShape3D",
        "Viewport/World/ManagementStorageInteraction/CollisionShape3D",
        "Viewport/World/WorkbenchInteraction/CollisionShape3D",
        "Viewport/World/OperationV1AcceptedRebuild",
        "Viewport/World/OperationV1AcceptedRebuild/AcceptedFloor",
        "Viewport/World/OperationV1AcceptedRebuild/AcceptedBackWall",
        "Viewport/World/OperationV1AcceptedRebuild/AcceptedSideWall",
        "Viewport/World/OperationV1AcceptedRebuild/GardenShelf_02",
        "Viewport/World/OperationV1AcceptedRebuild/GardenLeaf_01_02_03",
        "Viewport/World/OperationV1AcceptedRebuild/WorkbenchTop",
        "Viewport/World/OperationV1AcceptedRebuild/SupplyShelf_03",
        "Viewport/World/OperationV1AcceptedRebuild/SupplyProp_02_03",
        "Viewport/World/OperationV1AcceptedRebuild/CrownBase",
        "Viewport/World/OperationV1AcceptedRebuild/CrownPeakMiddle",
        "Viewport/World/OperationV1AcceptedRebuild/FloorPatch_02_03",
        "Viewport/World/OperationV1AcceptedRebuild/PendantLightLeft",
        "ObjectActionButton",
        "ManagementActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("Feature 012 R04 structural rebase missing required node: %s" % path)
            return

    if scene.get_node_or_null("Viewport/World/V1ProductionDressing") != null:
        _fail("Feature 012 R04 structural rebase restored rejected additive dressing.")
        return

    var viewport := scene.get_node("Viewport") as SubViewport
    var camera := scene.get_node("Viewport/World/Camera3D") as Camera3D
    if scene.stretch_shrink != 3 or scene.texture_filter != CanvasItem.TEXTURE_FILTER_NEAREST:
        _fail("Feature 012 R04 lost the scene-only nearest-neighbour pixel contract.")
        return
    if viewport.render_target_update_mode != SubViewport.UPDATE_ALWAYS:
        _fail("Feature 012 R04 V1 viewport is not continuously rendering.")
        return
    if camera.projection != Camera3D.PROJECTION_ORTHOGONAL or camera.size > 4.3:
        _fail("Feature 012 R04 lost compact portrait orthographic composition.")
        return

    for legacy_path in [
        "Viewport/World/Floor",
        "Viewport/World/BackWall",
        "Viewport/World/SideWall",
        "Viewport/World/MetalDoor",
        "Viewport/World/CounterTop",
        "Viewport/World/StorageBinMid",
        "Viewport/World/V1GraffitiCrownBase",
    ]:
        var legacy := scene.get_node(legacy_path) as MeshInstance3D
        if legacy.visible:
            _fail("Feature 012 R04 left rejected legacy visual mesh visible: %s" % legacy_path)
            return

    var rebuild := scene.get_node("Viewport/World/OperationV1AcceptedRebuild") as Node3D
    if rebuild.get_child_count() < 180:
        _fail("Feature 012 R04 accepted-concept rebuild regressed below detail floor.")
        return

    var wall := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/AcceptedBackWall") as MeshInstance3D
    var crown := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/CrownBase") as MeshInstance3D
    var garden := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/GardenLeaf_01_02_03") as MeshInstance3D
    if not _has_textured_material(wall) or not _has_textured_material(crown) or not _has_textured_material(garden):
        _fail("Feature 012 R04 structural rebase regressed to color-only macro primitives.")
        return
    if not _has_v1_color(crown, "E7AD48") or not _has_v1_color(garden, "536E54"):
        _fail("Feature 012 R04 accepted crown/garden palette contract changed.")
        return

    var plant_focus := scene.get_node("Viewport/World/InteractivePlantCluster") as Area3D
    var storage_focus := scene.get_node("Viewport/World/ManagementStorageInteraction") as Area3D
    var workbench_focus := scene.get_node("Viewport/World/WorkbenchInteraction") as Area3D
    if plant_focus.position.x > -1.2 or plant_focus.position.z > -1.2:
        _fail("Feature 012 R04 plant hotspot is not aligned to left/back garden.")
        return
    if storage_focus.position.x < 1.2 or storage_focus.position.z > -1.2:
        _fail("Feature 012 R04 management hotspot is not aligned to right/back storage.")
        return
    if abs(workbench_focus.position.x) > 0.8 or workbench_focus.position.z < -0.9:
        _fail("Feature 012 R04 workbench hotspot is not aligned to center bench.")
        return
    if workbench_focus.position.distance_to(plant_focus.position) < 1.4 or workbench_focus.position.distance_to(storage_focus.position) < 1.4:
        _fail("Feature 012 R04 focal anchors are not spatially distinct.")
        return

    var environment := (scene.get_node("Viewport/World/WorldEnvironment") as WorldEnvironment).environment
    if environment == null or environment.ambient_light_energy < 1.25:
        _fail("Feature 012 R04 lighting regressed below readability floor.")
        return
    if not scene.has_pointer_interaction() or not scene.has_secondary_pointer_interaction() or not scene.has_workbench_pointer_interaction():
        _fail("Feature 012 R04 lost pointer/touch hotspot picking.")
        return
    if not scene.has_accessible_button_fallback() or not scene.has_secondary_accessible_button_fallback():
        _fail("Feature 012 R04 lost accessible hotspot fallback.")
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

    print("OPERATION V1 STRUCTURAL REBASE TEST PASSED")
    quit(0)

func _has_textured_material(mesh: MeshInstance3D) -> bool:
    var material := mesh.material_override as StandardMaterial3D
    return material != null and material.albedo_texture != null

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
