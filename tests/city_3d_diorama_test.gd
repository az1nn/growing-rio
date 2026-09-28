extends SceneTree

const CITY_DIORAMA := preload("res://scenes/visual/city_diorama.tscn")

var _activation_context := ""
var _activation_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene = CITY_DIORAMA.instantiate()
    root.add_child(scene)
    await process_frame

    var required_paths := [
        "ViewportContainer/Viewport/World/Camera3D",
        "ViewportContainer/Viewport/World/WorldEnvironment",
        "ViewportContainer/Viewport/World/CoolCityKey",
        "ViewportContainer/Viewport/World/CoolRidgeRim",
        "ViewportContainer/Viewport/World/WarmNeighborhoodPractical",
        "ViewportContainer/Viewport/World/Terraces/TerrainLower",
        "ViewportContainer/Viewport/World/Terraces/TerrainUpper",
        "ViewportContainer/Viewport/World/Buildings/SkylineTowerA",
        "ViewportContainer/Viewport/World/WarmWindows/WindowA",
        "ViewportContainer/Viewport/World/Vegetation/Tree1Canopy",
        "ViewportContainer/Viewport/World/DistrictOverlookInteraction/CollisionShape3D",
        "ObjectActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("CENA-011 City diorama missing required node: %s" % path)
            return

    var viewport_container := scene.get_node("ViewportContainer") as Control
    if viewport_container.anchor_right - viewport_container.anchor_left < 0.85:
        _fail("CENA-011 City 3D viewport is not wide enough for player-visible framing.")
        return
    if viewport_container.anchor_bottom - viewport_container.anchor_top < 0.30:
        _fail("CENA-011 City 3D viewport is not tall enough for player-visible framing.")
        return

    if not scene.has_pointer_interaction():
        _fail("CENA-011 City diorama lost pointer/touch picking.")
        return
    if not scene.has_accessible_button_fallback():
        _fail("CENA-011 City diorama lost accessible button fallback.")
        return

    scene.object_activated.connect(_on_object_activated)
    scene.activate_primary_object()
    await process_frame
    if _activation_context != "city" or _activation_object != "district_overlook":
        _fail("CENA-011 City interaction did not emit the canonical city/district_overlook activation.")
        return

    var mesh_count := _count_nodes_by_class(scene, "MeshInstance3D")
    if mesh_count < 40:
        _fail("CENA-011 City composition regressed below the authored geometry floor: %d meshes." % mesh_count)
        return

    print("CITY 3D DIORAMA TEST PASSED: %d MeshInstance3D nodes" % mesh_count)
    quit(0)

func _count_nodes_by_class(node: Node, type_name: String) -> int:
    var total := 1 if node.is_class(type_name) else 0
    for child in node.get_children():
        total += _count_nodes_by_class(child, type_name)
    return total

func _on_object_activated(context_id: String, object_id: String) -> void:
    _activation_context = context_id
    _activation_object = object_id

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
