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
        "ViewportContainer/Viewport/World/WarmCityFill",
        "ViewportContainer/Viewport/World/WarmNeighborhoodPractical",
        "ViewportContainer/Viewport/World/CityV1Environment/Ground/LowerStreet",
        "ViewportContainer/Viewport/World/CityV1Environment/StairSpine/Step14",
        "ViewportContainer/Viewport/World/CityV1Environment/StairSpine/Step01",
        "ViewportContainer/Viewport/World/CityV1Environment/StairSpine/Step14",
        "ViewportContainer/Viewport/World/CityV1Environment/RooftopV1/DistrictMarker",
        "ViewportContainer/Viewport/World/CityV1Environment/NeighborhoodNode/MuralWall",
        "ViewportContainer/Viewport/World/CityV1Environment/NeighborhoodNode/LocalEventMarker",
        "ViewportContainer/Viewport/World/CityV1Environment/RouteMarkers/RouteMarkerB",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate4AuthoredDensity",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate4AuthoredDensity/MuralFocal/MuralPlate",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate4AuthoredDensity/ShopfrontCluster/UtilityPoleA",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate4AuthoredDensity/FarCityLayer2/FarHouseA06",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate5CompositionDensity",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate5CompositionDensity/MuralReadability/MuralPlateC5_1",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate5CompositionDensity/MidfieldActivity/FigureC5_1",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate5CompositionDensity/RooftopUtilities/WaterTankC5_1",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate5CompositionDensity/FarCityLayer3/FarCityC5_06",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate6TargetRecompose",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate6TargetRecompose/MuralGateway/MuralPlateC6",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate6TargetRecompose/StreetLife/ForegroundPlayerC6Body",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate6TargetRecompose/StairForeground/StairWallC6Left",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate6TargetRecompose/DepthSkyline/SkyC6_4",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate7StreetPerspective",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate7StreetPerspective/ForegroundFacadeLeft/MuralField",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate7StreetPerspective/ForegroundFacadeRight/BalconyRail",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate7StreetPerspective/HangingLife/Laundry03",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate7StreetPerspective/StreetMarket/ResidentB",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate7StreetPerspective/StreetMarket/ForegroundPlantLeft",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate8ProductionLayer",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate8ProductionLayer/GraffitiWalls/LeftWall",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate8ProductionLayer/StreetLife/ForegroundHeroTorso",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate8ProductionLayer/Vegetation/Plant0Pot",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate8ProductionLayer/FarDepth/House0",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate9SurfaceRebase",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate9SurfaceRebase/FacadeSkins/LeftFrontSkin",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate9SurfaceRebase/Murals/LeftMural",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate9SurfaceRebase/IrregularSilhouettes/LeftRoofline",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate10PresentationRebase",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate10PresentationRebase/Architecture/LeftNearFacade",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate10PresentationRebase/Architecture/RightNearFacade",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate10PresentationRebase/FarDepth/FarCityStrip",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate10PresentationRebase/LivedInStreet/LowerStreetCluster",
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
    if _activation_context != "city" or _activation_object != "district_overlook":
        _fail("R06 City district hotspot did not preserve stable id city/district_overlook.")
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
    if _activation_context != "city" or _activation_object != "community_cluster":
        _fail("R06 City local-event hotspot did not preserve stable id city/community_cluster.")
        return

    var source := FileAccess.get_file_as_string("res://scenes/visual/city_diorama.gd")
    if not source.contains("Candidate8ProductionLayer") or not source.contains("_build_candidate8_production_layer"):
        _fail("R06 City Candidate 8 production layer is not wired into runtime.")
        return
    if not source.contains("Candidate9SurfaceRebase") or not source.contains("_build_candidate9_surface_rebase"):
        _fail("R06 City Candidate 9 authored-surface rebase is not wired into runtime.")
        return
    if not source.contains("TEXTURE_FILTER_NEAREST") or not source.contains("ArrayMesh.new()") or not source.contains("QuadMesh.new()"):
        _fail("R06 City Candidate 9 must use authored pixel-textured surfaces and non-box silhouette geometry.")
        return
    var candidate9_source_index := source.find("func _build_candidate9_surface_rebase")
    if candidate9_source_index < 0:
        _fail("R06 City Candidate 9 construction rebase function missing.")
        return
    var candidate9_source := source.substr(candidate9_source_index)
    if candidate9_source.contains("_c8_box(") or candidate9_source.contains("BoxMesh.new()"):
        _fail("R06 City Candidate 9 regressed to the forbidden more-boxes corrective loop.")
        return
    for texture_path in [
        "res://assets/city/v1/c9-masonry-patch.svg",
        "res://assets/city/v1/c9-paint-wear.svg",
        "res://assets/city/v1/c9-tile-grid.svg",
        "res://assets/city/v1/c9-metal-rib.svg",
        "res://assets/city/v1/c9-mural-crown.svg",
        "res://assets/city/v1/c9-shop-graffiti.svg",
        "res://assets/city/v1/c9-roof-patch.svg",
    ]:
        if not FileAccess.file_exists(texture_path):
            _fail("R06 City Candidate 9 missing authored pixel surface asset: %s" % texture_path)
            return

    if not source.contains("Candidate10PresentationRebase") or not source.contains("_build_candidate10_presentation_rebase"):
        _fail("R06 City Candidate 10 pixel-card presentation rebase is not wired into runtime.")
        return
    if not source.contains("TRANSPARENCY_ALPHA_SCISSOR") or not source.contains("_c10_hide_meshes_except"):
        _fail("R06 City Candidate 10 must use alpha-cut pixel cards and demote primitive architecture.")
        return
    var candidate10_source_index := source.find("func _build_candidate10_presentation_rebase")
    if candidate10_source_index < 0:
        _fail("R06 City Candidate 10 presentation function missing.")
        return
    var candidate10_source := source.substr(candidate10_source_index)
    if candidate10_source.contains("_c8_box(") or candidate10_source.contains("BoxMesh.new()"):
        _fail("R06 City Candidate 10 regressed to the forbidden primitive-box corrective loop.")
        return
    for texture_path in [
        "res://assets/city/v1/c10-building-left-near.svg",
        "res://assets/city/v1/c10-building-right-near.svg",
        "res://assets/city/v1/c10-building-left-mid.svg",
        "res://assets/city/v1/c10-building-right-mid.svg",
        "res://assets/city/v1/c10-far-city-strip.svg",
        "res://assets/city/v1/c10-street-cluster.svg",
    ]:
        if not FileAccess.file_exists(texture_path):
            _fail("R06 City Candidate 10 missing authored pixel-card asset: %s" % texture_path)
            return

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
        "BackdropDepth",
        "Buildings",
        "StreetLife",
        "Laundry",
        "Vegetation",
        "Mat_cyan",
        "Mat_magenta",
        "Mat_amber",
        "city/hotspot/routes",
        "Candidate4AuthoredDensity",
        "MuralFocal",
        "ShopfrontCluster",
        "FarCityLayer2",
        "Candidate5CompositionDensity",
        "MuralReadability",
        "MidfieldActivity",
        "RooftopUtilities",
        "FarCityLayer3",
        "Candidate6TargetRecompose",
        "MuralGateway",
        "StreetLife",
        "StairForeground",
        "DepthSkyline",
        "Candidate7StreetPerspective",
        "ForegroundFacadeLeft",
        "ForegroundFacadeRight",
        "HangingLife",
        "StreetMarket",
        "MuralField",
    ]:
        if not scene_source.contains(required_token):
            _fail("R06 City V1 lost accepted-concept production token: %s" % required_token)
            return

    var candidate9_layer := scene.get_node("ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate9SurfaceRebase")
    var candidate9_mesh_count := _count_nodes_by_class(candidate9_layer, "MeshInstance3D")
    if candidate9_mesh_count < 20:
        _fail("R06 City Candidate 9 authored-surface layer is too sparse: %d meshes." % candidate9_mesh_count)
        return

    var candidate10_layer := scene.get_node("ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate10PresentationRebase")
    var candidate10_mesh_count := _count_nodes_by_class(candidate10_layer, "MeshInstance3D")
    if candidate10_mesh_count < 10:
        _fail("R06 City Candidate 10 presentation layer is too sparse: %d meshes." % candidate10_mesh_count)
        return

    var mesh_count := _count_nodes_by_class(scene, "MeshInstance3D")
    if mesh_count < 650:
        _fail("R06 City Candidate 9 regressed below the production-density floor: %d meshes." % mesh_count)
        return

    print("CITY V1 RUNTIME TEST PASSED: Candidate 10 pixel-card rebase / %d Candidate10 meshes / %d total MeshInstance3D / 3 semantic anchors" % [candidate10_mesh_count, mesh_count])
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
