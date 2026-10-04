extends SceneTree

const CITY_DIORAMA := preload("res://scenes/visual/city_diorama.tscn")
const DALATA_BUTTON_SCRIPT := "res://scenes/ui/v1/dalata_button.gd"

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
        "ViewportContainer/Viewport/World/StairSpine/Step01",
        "ViewportContainer/Viewport/World/StairSpine/Step11",
        "ViewportContainer/Viewport/World/RooftopV1/DistrictMarker",
        "ViewportContainer/Viewport/World/NeighborhoodNode/MuralWall",
        "ViewportContainer/Viewport/World/NeighborhoodNode/LocalEventMarker",
        "ViewportContainer/Viewport/World/RouteMarkers/RouteMarkerB",
        "ViewportContainer/Viewport/World/DistrictOverlookInteraction/CollisionShape3D",
        "ViewportContainer/Viewport/World/RouteNodesInteraction/CollisionShape3D",
        "ViewportContainer/Viewport/World/CommunityClusterInteraction/CollisionShape3D",
        "CommunityActionButton",
        "RouteActionButton",
        "ObjectActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("R06 City V1 missing required node: %s" % path)
            return

    var viewport_container := scene.get_node("ViewportContainer") as Control
    if viewport_container.anchor_right - viewport_container.anchor_left < 0.85:
        _fail("R06 City V1 viewport is not wide enough for portrait framing.")
        return
    if viewport_container.anchor_bottom - viewport_container.anchor_top < 0.45:
        _fail("R06 City V1 viewport is not tall enough for the accepted vertical composition.")
        return

    if not scene.has_pointer_interaction():
        _fail("R06 district-rooftop hotspot lost pointer/touch picking.")
        return
    if not scene.has_route_pointer_interaction():
        _fail("R06 route-node hotspot lost pointer/touch picking.")
        return
    if not scene.has_secondary_pointer_interaction():
        _fail("R06 local-event hotspot lost pointer/touch picking.")
        return
    if not scene.has_accessible_button_fallback():
        _fail("R06 district-rooftop hotspot lost accessible button fallback.")
        return
    if not scene.has_route_accessible_button_fallback():
        _fail("R06 route-node hotspot lost accessible button fallback.")
        return
    if not scene.has_secondary_accessible_button_fallback():
        _fail("R06 local-event hotspot lost accessible button fallback.")
        return

    for button_path in ["CommunityActionButton", "RouteActionButton", "ObjectActionButton"]:
        var button := scene.get_node(button_path) as Button
        if button.get_script() == null or button.get_script().resource_path != DALATA_BUTTON_SCRIPT:
            _fail("R06 City V1 must reuse DA LATA UI V1 on %s." % button_path)
            return
        if button.custom_minimum_size.y < 48.0:
            _fail("R06 City V1 touch target below 48px on %s." % button_path)
            return
        if String(button.semantic_action_id).is_empty():
            _fail("R06 City V1 missing semantic_action_id on %s." % button_path)
            return

    scene.object_activated.connect(_on_object_activated)

    scene.activate_primary_object()
    await process_frame
    if _activation_context != "city" or _activation_object != "district_rooftops":
        _fail("R06 City district hotspot did not emit city/district_rooftops.")
        return

    _activation_context = ""
    _activation_object = ""
    scene.activate_route_object()
    await process_frame
    if _activation_context != "city" or _activation_object != "route_nodes":
        _fail("R06 City route hotspot did not emit city/route_nodes.")
        return

    _activation_context = ""
    _activation_object = ""
    scene.activate_community_object()
    await process_frame
    if _activation_context != "city" or _activation_object != "local_event":
        _fail("R06 City local-event hotspot did not emit city/local_event.")
        return

    var source := FileAccess.get_file_as_string("res://scenes/visual/city_diorama.gd")
    for forbidden in ["/root/GameState", "select_district(", "advance_day(", "sell_"]:
        if source.contains(forbidden):
            _fail("R06 City diorama gained forbidden domain reference: %s" % forbidden)
            return

    var scene_source := FileAccess.get_file_as_string("res://scenes/visual/city_diorama.tscn")
    for required_token in [
        "StairSpine",
        "RooftopV1",
        "NeighborhoodNode",
        "CableRhythm",
        "Mat_cyan",
        "Mat_magenta",
        "Mat_amber",
        "city/hotspot/routes",
    ]:
        if not scene_source.contains(required_token):
            _fail("R06 City V1 lost accepted-concept production token: %s" % required_token)
            return

    var mesh_count := _count_nodes_by_class(scene, "MeshInstance3D")
    if mesh_count < 70:
        _fail("R06 City V1 regressed below the production geometry floor: %d meshes." % mesh_count)
        return

    print("CITY V1 RUNTIME TEST PASSED: %d MeshInstance3D nodes / 3 semantic anchors" % mesh_count)
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
