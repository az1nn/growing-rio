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
        "Viewport/World/TileCounter",
        "Viewport/World/InteractivePlantCluster/CollisionShape3D",
        "Viewport/World/ManagementStorageInteraction/CollisionShape3D",
        "ObjectActionButton",
        "ManagementActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("Feature 012 R04 Operation missing required node: %s" % path)
            return

    var viewport := scene.get_node("Viewport") as SubViewport
    var camera := scene.get_node("Viewport/World/Camera3D") as Camera3D
    if scene.stretch_shrink != V1PixelRenderPolicy.DEFAULT_SHRINK:
        _fail("Feature 012 R04 did not apply the shared V1 scene-only pixel shrink.")
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

    if not scene.has_pointer_interaction() or not scene.has_secondary_pointer_interaction():
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
