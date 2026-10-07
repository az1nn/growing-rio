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
    if viewport_container.anchor_bottom - viewport_container.anchor_top < 0.60:
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
    var ready_start := source.find("func _ready()")
    var ready_end := source.find("func _prepare_runtime_recovery_after_human_freeze", ready_start)
    if ready_start < 0 or ready_end < 0:
        _fail("R06 City runtime recovery bootstrap missing after human freeze report.")
        return
    var ready_source := source.substr(ready_start, ready_end - ready_start)
    if not ready_source.contains("_prepare_runtime_recovery_after_human_freeze()"):
        _fail("R06 City runtime recovery is not invoked before active visual construction.")
        return
    for retired_builder in [
        "_build_candidate8_production_layer()",
        "_build_candidate9_surface_rebase()",
        "_build_candidate10_presentation_rebase()",
        "_build_candidate11_authored_detail()",
        "_build_candidate12_final_polish()",
        "_build_candidate13_volumetric_rebase()",
        "_build_candidate14_night_graffiti_depth_alignment()",
        "_build_candidate15_graffiti_far_depth_detail()",
        "_build_candidate16_vertical_neighborhood_rebase()",
    ]:
        if ready_source.contains(retired_builder):
            _fail("R06 City still synchronously constructs rejected historical layer: %s" % retired_builder)
            return

    var structural_host := scene.get_node("ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails") as Node3D
    for retired_runtime in [
        "Candidate8ProductionLayer",
        "Candidate9SurfaceRebase",
        "Candidate10PresentationRebase",
    ]:
        if structural_host.get_node_or_null(retired_runtime) != null:
            _fail("R06 City kept rejected historical runtime node alive: %s" % retired_runtime)
            return

    for retired_static in [
        "Candidate4AuthoredDensity",
        "Candidate5CompositionDensity",
        "Candidate6TargetRecompose",
        "Candidate7StreetPerspective",
        "Candidate11AuthoredDetail",
        "Candidate12FinalPolish",
    ]:
        var retired_node := structural_host.get_node_or_null(retired_static) as Node3D
        if retired_node != null:
            if retired_node.visible:
                _fail("R06 City left rejected static layer visible: %s" % retired_static)
                return
            if retired_node.process_mode != Node.PROCESS_MODE_DISABLED:
                _fail("R06 City left rejected static layer processing enabled: %s" % retired_static)
                return
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

    if not source.contains("Candidate11AuthoredDetail") or not source.contains("_build_candidate11_authored_detail"):
        _fail("R06 City Candidate 11 authored-detail pass is not wired into runtime.")
        return
    if not source.contains("SHADING_MODE_UNSHADED"):
        _fail("R06 City Candidate 11 pixel cards must preserve authored palette independently of low-poly lighting.")
        return
    var candidate11_source_index := source.find("func _build_candidate11_authored_detail")
    if candidate11_source_index < 0:
        _fail("R06 City Candidate 11 authored-detail function missing.")
        return
    var candidate11_source := source.substr(candidate11_source_index)
    if candidate11_source.contains("_c8_box(") or candidate11_source.contains("BoxMesh.new()"):
        _fail("R06 City Candidate 11 regressed to primitive-box visual construction.")
        return
    for texture_path in [
        "res://assets/city/v1/c11-skyline.svg",
        "res://assets/city/v1/c11-player.svg",
        "res://assets/city/v1/c11-resident-a.svg",
        "res://assets/city/v1/c11-resident-b.svg",
        "res://assets/city/v1/c11-shop-detail.svg",
        "res://assets/city/v1/c11-balcony-life.svg",
        "res://assets/city/v1/c11-cable-layer.svg",
    ]:
        if not FileAccess.file_exists(texture_path):
            _fail("R06 City Candidate 11 missing authored detail asset: %s" % texture_path)
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

    if not source.contains("Candidate12FinalPolish") or not source.contains("_build_candidate12_final_polish"):
        _fail("R06 City Candidate 12 final-polish layer is not wired into runtime.")
        return
    var candidate12_source_index := source.find("func _build_candidate12_final_polish")
    if candidate12_source_index < 0:
        _fail("R06 City Candidate 12 final-polish function missing.")
        return
    var candidate12_source := source.substr(candidate12_source_index)
    if candidate12_source.contains("_c8_box(") or candidate12_source.contains("BoxMesh.new()"):
        _fail("R06 City Candidate 12 regressed to primitive-density visual construction.")
        return
    for texture_path in [
        "res://assets/city/v1/c12-facade-weather.svg",
        "res://assets/city/v1/c12-mural-overlay.svg",
        "res://assets/city/v1/c12-street-props.svg",
        "res://assets/city/v1/c12-vegetation-cluster.svg",
        "res://assets/city/v1/c12-resident-cluster.svg",
    ]:
        if not FileAccess.file_exists(texture_path):
            _fail("R06 City Candidate 12 missing final-polish authored asset: %s" % texture_path)
            return

    # Candidate 12 remains historical source/asset evidence only; it is no
    # longer required to exist as a live runtime layer after Candidate 17 consolidation.

    if not source.contains("Candidate13VolumetricRebase") or not source.contains("_build_candidate13_volumetric_rebase"):
        _fail("R06 City Candidate 13 historical construction evidence was lost.")
        return
    if not source.contains("_c13_extruded_polygon") or not source.contains("SurfaceTool.new()"):
        _fail("R06 City authored custom-mesh helpers were lost.")
        return
    var candidate13_source_index := source.find("func _build_candidate13_volumetric_rebase")
    if candidate13_source_index < 0:
        _fail("R06 City Candidate 13 historical rebase function missing.")
        return
    var candidate13_source := source.substr(candidate13_source_index)
    if candidate13_source.contains("_c10_card(") or candidate13_source.contains("_c8_box(") or candidate13_source.contains("BoxMesh.new()"):
        _fail("R06 City Candidate 13 historical record regressed to flat-card/primitive construction.")
        return

    var camera := scene.get_node("ViewportContainer/Viewport/World/Camera3D") as Camera3D
    if not candidate13_source.contains("camera.projection = Camera3D.PROJECTION_PERSPECTIVE"):
        _fail("R06 City Candidate 13 historical construction record lost its perspective-depth correction.")
        return

    if structural_host.get_node_or_null("Candidate13VolumetricRebase") != null:
        _fail("R06 City runtime recovery still instantiates superseded Candidate 13 geometry.")
        return

    for legacy_path in [
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate11AuthoredDetail/Commerce",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate11AuthoredDetail/BalconyLife",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate12FinalPolish/FacadeFinish",
        "ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate12FinalPolish/MuralFinish",
    ]:
        var legacy_group := scene.get_node_or_null(legacy_path) as Node3D
        if legacy_group != null and legacy_group.visible:
            _fail("R06 City runtime recovery left superseded flat-card group visible: %s" % legacy_path)
            return

    # Candidates 14-16 remain historical source evidence only after the human
    # low-poly rejection. They must not be instantiated by the live bootstrap.
    for historical_token in [
        "func _build_candidate14_night_graffiti_depth_alignment",
        "func _build_candidate15_graffiti_far_depth_detail",
        "func _build_candidate16_vertical_neighborhood_rebase",
    ]:
        if not source.contains(historical_token):
            _fail("R06 City lost historical construction evidence: %s" % historical_token)
            return

    for retired_runtime in [
        "Candidate14NightGraffitiDepth",
        "Candidate15GraffitiFarDepthDetail",
        "Candidate16VerticalNeighborhoodRebase",
    ]:
        if structural_host.get_node_or_null(retired_runtime) != null:
            _fail("R06 City rebuilt rejected historical runtime layer: %s" % retired_runtime)
            return

    if not source.contains("Candidate17AuthoredNeighborhood") or not source.contains("_build_candidate17_authored_neighborhood"):
        _fail("R06 City Candidate 17 authored-neighborhood production stack is not wired into runtime.")
        return
    var candidate17_source_index := source.find("func _build_candidate17_authored_neighborhood")
    if candidate17_source_index < 0:
        _fail("R06 City Candidate 17 production function missing.")
        return
    var candidate17_source := source.substr(candidate17_source_index)
    if candidate17_source.contains("_c10_card(") or candidate17_source.contains("_c8_box(") or candidate17_source.contains("BoxMesh.new()"):
        _fail("R06 City Candidate 17 regressed to flat-card/primitive-box visual construction.")
        return
    for texture_path in [
        "res://assets/city/v1/c17-facade-warm.svg",
        "res://assets/city/v1/c17-facade-cool.svg",
        "res://assets/city/v1/c17-shopfront.svg",
        "res://assets/city/v1/c17-mural-pixo.svg",
        "res://assets/city/v1/c17-pixo-ladder.svg",
        "res://assets/city/v1/c17-mural-fragments.svg",
        "res://assets/city/v1/c17-far-neighborhood.svg",
    ]:
        if not FileAccess.file_exists(texture_path):
            _fail("R06 City Candidate 17 missing authored production asset: %s" % texture_path)
            return

    var candidate17_layer := scene.get_node_or_null("ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails/Candidate17AuthoredNeighborhood") as Node3D
    if candidate17_layer == null:
        _fail("R06 City Candidate 17 authored-neighborhood runtime layer missing.")
        return
    for required_candidate17_node in [
        "FarNeighborhood/UpperRidge",
        "FarNeighborhood/LeftDepth",
        "FarNeighborhood/RightDepth",
        "Architecture/LeftNear/Body",
        "Architecture/LeftNear/Shopfront",
        "Architecture/RightNear/MuralRelief",
        "Architecture/TopCenter/Body",
        "StairSpine/AuthoredStep01",
        "StairSpine/AuthoredStep22",
        "ForegroundDepth/LowerLanding",
        "ForegroundDepth/ForegroundStep06",
        "ForegroundDepth/LowerApron",
        "ForegroundDepth/LeftForecourtWall",
        "ForegroundDepth/RightForecourtWall",
        "ForegroundDepth/LeftKiosk",
        "ForegroundDepth/LeftKioskMural",
        "ForegroundDepth/RightKiosk",
        "ForegroundDepth/RightKioskPixo",
        "Activity/Shopfront",
        "Activity/MuralGateway",
        "Activity/LeftStairShop",
        "Activity/LeftStairAwning",
        "Activity/RightStairShop",
        "Activity/RightStairAwning",
        "StreetLife/Resident01/Silhouette",
        "StreetLife/Resident06/Silhouette",
        "StreetLife/Resident10/Silhouette",
        "StreetLife/Resident14/Silhouette",
        "StreetLife/Resident18/Silhouette",
        "Vegetation/LeftPlant/Leaf1",
        "Vegetation/FrontCenterPlant/Leaf1",
        "Vegetation/UpperPlant/Leaf5",
        "Vegetation/LowerRightPlant/Leaf5",
        "Vegetation/MidRightPlant/Leaf1",
        "CableLayer/Cable1",
        "CableLayer/Cable5",
        "PracticalLights/ActivityWarm",
        "DepthSeparation/LeftCool",
        "DepthSeparation/FarCool",
        "DepthSeparation/MidCool",
    ]:
        if candidate17_layer.get_node_or_null(required_candidate17_node) == null:
            _fail("R06 City Candidate 17 missing production node: %s" % required_candidate17_node)
            return

    if camera.projection != Camera3D.PROJECTION_ORTHOGONAL:
        _fail("R06 City Candidate 17 must preserve the locked orthographic three-quarter camera contract.")
        return
    if camera.size > 6.8:
        _fail("R06 City Candidate 17 portrait composition regressed to a loose framing after ARTIST occupancy review.")
        return
    if camera.position.y < 6.3:
        _fail("R06 City Candidate 17 camera regressed above the large lower-portrait void.")
        return

    var c17_left_body := candidate17_layer.get_node("Architecture/LeftNear/Body") as MeshInstance3D
    var c17_far := candidate17_layer.get_node("FarNeighborhood/UpperRidge") as MeshInstance3D
    var c17_lower_landing := candidate17_layer.get_node("ForegroundDepth/LowerLanding") as MeshInstance3D
    if c17_left_body.mesh == null or not (c17_left_body.mesh is ArrayMesh):
        _fail("R06 City Candidate 17 facade body must be authored ArrayMesh geometry.")
        return
    if c17_far.mesh == null or not (c17_far.mesh is ArrayMesh):
        _fail("R06 City Candidate 17 far neighborhood must remain authored volumetric ArrayMesh geometry.")
        return
    if c17_lower_landing.mesh == null or not (c17_lower_landing.mesh is ArrayMesh):
        _fail("R06 City Candidate 17 bounded polish foreground must remain authored ArrayMesh geometry.")
        return
    if viewport_container.anchor_bottom < 0.76:
        _fail("R06 City Candidate 17 bounded polish did not extend portrait scene occupancy.")
        return
    if candidate17_source.count("c17-mural-pixo.svg") > 1:
        _fail("R06 City Candidate 17 must keep the crown mural as one signature focal, not a repeated facade stamp.")
        return

    if not ready_source.contains("_build_candidate17_authored_neighborhood()"):
        _fail("R06 City live bootstrap does not build Candidate 17.")
        return

    print("CITY V1 RUNTIME TEST PASSED: Candidate 17 authored stair-life convergence preserved")
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
