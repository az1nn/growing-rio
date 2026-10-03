extends SceneTree

const MARKET_DIORAMA := preload("res://scenes/visual/market_diorama.tscn")

var _activation_context := ""
var _activation_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene = MARKET_DIORAMA.instantiate()
    root.add_child(scene)
    await process_frame

    var required_paths := [
        "ViewportContainer/Viewport/World/Camera3D",
        "ViewportContainer/Viewport/World/WorldEnvironment",
        "ViewportContainer/Viewport/World/CoolKey",
        "ViewportContainer/Viewport/World/WarmPractical",
        "ViewportContainer/Viewport/World/MarketShell/Floor",
        "ViewportContainer/Viewport/World/DealCounter/Body",
        "ViewportContainer/Viewport/World/DealCounter/ContractTray",
        "ViewportContainer/Viewport/World/VendorFigure/Torso",
        "ViewportContainer/Viewport/World/VendorFigure/Head",
        "ViewportContainer/Viewport/World/VendorBay/ShelfA",
        "ViewportContainer/Viewport/World/VendorBay/PackageAmberA",
        "ViewportContainer/Viewport/World/Crates/CrateA",
        "ViewportContainer/Viewport/World/LoadingBay/Header",
        "ViewportContainer/Viewport/World/LoadingBay/ChannelRowAmber",
        "ViewportContainer/Viewport/World/Trolley/Deck",
        "ViewportContainer/Viewport/World/DealCounterInteraction/CollisionShape3D",
        "ViewportContainer/Viewport/World/ContractTrayInteraction/CollisionShape3D",
        "ContractActionButton",
        "ObjectActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("CENA-010 Market diorama missing required node: %s" % path)
            return

    var viewport_container := scene.get_node("ViewportContainer") as Control
    if viewport_container.anchor_right - viewport_container.anchor_left < 0.85:
        _fail("CENA-010 Market 3D viewport is not wide enough for player-visible framing.")
        return
    if viewport_container.anchor_bottom - viewport_container.anchor_top < 0.30:
        _fail("CENA-010 Market 3D viewport is not tall enough for player-visible framing.")
        return
    if viewport_container.stretch_shrink != 2:
        _fail("Feature 012 R05 Market lost the shared 2x V1 pixel render policy.")
        return
    if viewport_container.texture_filter != CanvasItem.TEXTURE_FILTER_NEAREST:
        _fail("Feature 012 R05 Market lost nearest-neighbor V1 scene filtering.")
        return

    var camera := scene.get_node("ViewportContainer/Viewport/World/Camera3D") as Camera3D
    if camera.size > 7.2:
        _fail("Feature 012 R05 Market framing regressed to a sparse wide blockout.")
        return

    var r05_focal_anchor_paths := [
        "ViewportContainer/Viewport/World/DealCounter/Body",
        "ViewportContainer/Viewport/World/Crates/CrateA",
        "ViewportContainer/Viewport/World/LoadingBay/Header",
    ]
    var r05_focal_anchors: Array[MeshInstance3D] = []
    for path in r05_focal_anchor_paths:
        var anchor := scene.get_node(path) as MeshInstance3D
        if not anchor.visible:
            _fail("Feature 012 R05 focal anchor is not visible: %s" % path)
            return

        var local_aabb_size := anchor.get_aabb().size
        var authored_size := Vector3(
            absf(local_aabb_size.x * anchor.scale.x),
            absf(local_aabb_size.y * anchor.scale.y),
            absf(local_aabb_size.z * anchor.scale.z)
        )
        var longest_authored_axis := maxf(
            authored_size.x,
            maxf(authored_size.y, authored_size.z)
        )
        if longest_authored_axis < 1.0:
            _fail(
                "Feature 012 R05 focal anchor regressed below portrait-readable physical size: %s (%.2f)."
                % [path, longest_authored_axis]
            )
            return
        r05_focal_anchors.append(anchor)

    for index in range(r05_focal_anchors.size()):
        for other_index in range(index + 1, r05_focal_anchors.size()):
            var separation := r05_focal_anchors[index].global_position.distance_to(
                r05_focal_anchors[other_index].global_position
            )
            if separation < 1.5:
                _fail(
                    "Feature 012 R05 focal anchors are not physically distinct: %s vs %s (%.2f)."
                    % [
                        r05_focal_anchor_paths[index],
                        r05_focal_anchor_paths[other_index],
                        separation,
                    ]
                )
                return

    if not scene.has_pointer_interaction():
        _fail("CENA-010 Market diorama lost pointer/touch picking.")
        return
    if not scene.has_accessible_button_fallback():
        _fail("CENA-010 Market diorama lost accessible button fallback.")
        return
    if not scene.has_secondary_pointer_interaction():
        _fail("Feature 011 Market contract hotspot lost pointer/touch picking.")
        return
    if not scene.has_secondary_accessible_button_fallback():
        _fail("Feature 011 Market contract hotspot lost accessible button fallback.")
        return

    var deal_interaction := scene.get_node("ViewportContainer/Viewport/World/DealCounterInteraction") as Area3D
    var contract_interaction := scene.get_node("ViewportContainer/Viewport/World/ContractTrayInteraction") as Area3D
    if absf(deal_interaction.position.x - contract_interaction.position.x) < 1.0:
        _fail("Feature 011 Market semantic hotspot hitboxes are not spatially distinct.")
        return

    var source := FileAccess.get_file_as_string("res://scenes/visual/market_diorama.gd")
    for forbidden in ["/root/GameState", "sell_", "accept_contract(", "resolve_active_contract("]:
        if source.contains(forbidden):
            _fail("Feature 011 Market diorama gained forbidden domain reference: %s" % forbidden)
            return

    scene.object_activated.connect(_on_object_activated)
    scene.activate_primary_object()
    await process_frame
    if _activation_context != "market" or _activation_object != "deal_counter":
        _fail("CENA-010 Market interaction did not emit the canonical market/deal_counter activation.")
        return

    _activation_context = ""
    _activation_object = ""
    scene.activate_contract_object()
    await process_frame
    if _activation_context != "market" or _activation_object != "contract_tray":
        _fail("Feature 011 Market interaction did not emit market/contract_tray.")
        return

    var mesh_count := _count_nodes_by_class(scene, "MeshInstance3D")
    if mesh_count < 48:
        _fail("Feature 012 R05 Market composition regressed below the accepted-target geometry floor: %d meshes." % mesh_count)
        return

    print("MARKET 3D DIORAMA TEST PASSED: %d MeshInstance3D nodes" % mesh_count)
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
