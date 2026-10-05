extends Control

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var district_interaction: Area3D = $ViewportContainer/Viewport/World/DistrictOverlookInteraction
@onready var route_interaction: Area3D = $ViewportContainer/Viewport/World/RouteNodesInteraction
@onready var local_event_interaction: Area3D = $ViewportContainer/Viewport/World/CommunityClusterInteraction
@onready var district_marker: MeshInstance3D = $ViewportContainer/Viewport/World/CityV1Environment/RooftopV1/DistrictMarker
@onready var route_marker: MeshInstance3D = $ViewportContainer/Viewport/World/CityV1Environment/RouteMarkers/RouteMarkerB
@onready var local_event_marker: MeshInstance3D = $ViewportContainer/Viewport/World/CityV1Environment/NeighborhoodNode/LocalEventMarker
@onready var action_button: Button = $ObjectActionButton
@onready var route_button: Button = $RouteActionButton
@onready var community_button: Button = $CommunityActionButton
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween
var _base_district_scale := Vector3.ONE
var _base_route_scale := Vector3.ONE
var _base_local_event_scale := Vector3.ONE
var _candidate8_materials: Dictionary = {}

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Abrir distritos — alternativa ao hotspot de telhados 3D"
    route_button.accessibility_name = "Abrir rotas — alternativa ao hotspot da escadaria 3D"
    community_button.accessibility_name = "Abrir evento local — alternativa ao hotspot do bairro 3D"
    _base_district_scale = district_marker.scale
    _base_route_scale = route_marker.scale
    _base_local_event_scale = local_event_marker.scale
    _build_candidate8_production_layer()

func _pulse(marker: MeshInstance3D, base_scale: Vector3) -> void:
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    marker.scale = base_scale * 1.65
    _pulse_tween = create_tween()
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(marker, "scale", base_scale, 0.28)

func activate_primary_object() -> void:
    activation_count += 1
    interaction_status.text = "TELHADOS • foco nos distritos"
    _pulse(district_marker, _base_district_scale)
    object_activated.emit("city", "district_overlook")

func activate_route_object() -> void:
    activation_count += 1
    interaction_status.text = "ROTAS • escadaria e conexões do bairro"
    _pulse(route_marker, _base_route_scale)
    object_activated.emit("city", "route_nodes")

func activate_community_object() -> void:
    activation_count += 1
    interaction_status.text = "EVENTO LOCAL • foco na atividade comunitária"
    _pulse(local_event_marker, _base_local_event_scale)
    object_activated.emit("city", "community_cluster")

func has_pointer_interaction() -> bool:
    return district_interaction.input_ray_pickable and viewport.physics_object_picking

func has_route_pointer_interaction() -> bool:
    return route_interaction.input_ray_pickable and viewport.physics_object_picking

func has_secondary_pointer_interaction() -> bool:
    return local_event_interaction.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func has_route_accessible_button_fallback() -> bool:
    return not route_button.disabled and route_button.visible

func has_secondary_accessible_button_fallback() -> bool:
    return not community_button.disabled and community_button.visible

func _on_district_overlook_input_event(
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

func _on_route_nodes_input_event(
    _camera: Node,
    event: InputEvent,
    _event_position: Vector3,
    _normal: Vector3,
    _shape_idx: int,
) -> void:
    if event is InputEventMouseButton:
        var mouse_event := event as InputEventMouseButton
        if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
            activate_route_object()
    elif event is InputEventScreenTouch:
        var touch_event := event as InputEventScreenTouch
        if touch_event.pressed:
            activate_route_object()

func _on_community_cluster_input_event(
    _camera: Node,
    event: InputEvent,
    _event_position: Vector3,
    _normal: Vector3,
    _shape_idx: int,
) -> void:
    if event is InputEventMouseButton:
        var mouse_event := event as InputEventMouseButton
        if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
            activate_community_object()
    elif event is InputEventScreenTouch:
        var touch_event := event as InputEventScreenTouch
        if touch_event.pressed:
            activate_community_object()

func _on_community_action_button_pressed() -> void:
    activate_community_object()

func _on_route_action_button_pressed() -> void:
    activate_route_object()

func _on_object_action_button_pressed() -> void:
    activate_primary_object()


func _c8_group(parent: Node3D, node_name: String) -> Node3D:
    var group := Node3D.new()
    group.name = node_name
    parent.add_child(group)
    return group

func _c8_material(material_id: String) -> StandardMaterial3D:
    if _candidate8_materials.has(material_id):
        return _candidate8_materials[material_id] as StandardMaterial3D

    var material := StandardMaterial3D.new()
    material.roughness = 0.92
    match material_id:
        "masonry":
            material.albedo_color = Color(0.48, 0.30, 0.24, 1.0)
        "sand":
            material.albedo_color = Color(0.62, 0.42, 0.31, 1.0)
        "navy":
            material.albedo_color = Color(0.055, 0.105, 0.19, 1.0)
        "teal":
            material.albedo_color = Color(0.045, 0.34, 0.36, 1.0)
        "cyan":
            material.albedo_color = Color(0.03, 0.53, 0.61, 1.0)
        "magenta":
            material.albedo_color = Color(0.68, 0.055, 0.31, 1.0)
        "amber":
            material.albedo_color = Color(0.96, 0.39, 0.08, 1.0)
        "green":
            material.albedo_color = Color(0.06, 0.30, 0.13, 1.0)
        "leaf":
            material.albedo_color = Color(0.12, 0.48, 0.20, 1.0)
        "wood":
            material.albedo_color = Color(0.30, 0.14, 0.07, 1.0)
        "skin":
            material.albedo_color = Color(0.64, 0.40, 0.28, 1.0)
        "dark":
            material.albedo_color = Color(0.014, 0.025, 0.038, 1.0)
        "warm":
            material.albedo_color = Color(1.0, 0.76, 0.28, 1.0)
            material.emission_enabled = true
            material.emission = Color(1.0, 0.34, 0.08, 1.0)
            material.emission_energy_multiplier = 1.15
            material.roughness = 0.55
        _:
            material.albedo_color = Color(0.32, 0.32, 0.34, 1.0)

    _candidate8_materials[material_id] = material
    return material

func _c8_box(
    parent: Node3D,
    node_name: String,
    position_3d: Vector3,
    scale_3d: Vector3,
    material_id: String,
    rotation_z: float = 0.0,
) -> MeshInstance3D:
    var node := MeshInstance3D.new()
    node.name = node_name
    node.position = position_3d
    node.scale = scale_3d
    node.rotation.z = rotation_z
    node.mesh = BoxMesh.new()
    node.material_override = _c8_material(material_id)
    parent.add_child(node)
    return node

func _c8_cylinder(
    parent: Node3D,
    node_name: String,
    position_3d: Vector3,
    scale_3d: Vector3,
    material_id: String,
) -> MeshInstance3D:
    var mesh := CylinderMesh.new()
    mesh.top_radius = 0.5
    mesh.bottom_radius = 0.5
    mesh.height = 1.0
    mesh.radial_segments = 8

    var node := MeshInstance3D.new()
    node.name = node_name
    node.position = position_3d
    node.scale = scale_3d
    node.mesh = mesh
    node.material_override = _c8_material(material_id)
    parent.add_child(node)
    return node

func _c8_cone(
    parent: Node3D,
    node_name: String,
    position_3d: Vector3,
    scale_3d: Vector3,
    material_id: String,
) -> MeshInstance3D:
    var mesh := CylinderMesh.new()
    mesh.top_radius = 0.0
    mesh.bottom_radius = 0.5
    mesh.height = 1.0
    mesh.radial_segments = 7

    var node := MeshInstance3D.new()
    node.name = node_name
    node.position = position_3d
    node.scale = scale_3d
    node.mesh = mesh
    node.material_override = _c8_material(material_id)
    parent.add_child(node)
    return node

func _c8_person(parent: Node3D, prefix: String, base: Vector3, shirt: String, hero := false) -> void:
    var body_scale := Vector3(0.30, 0.72, 0.24) if hero else Vector3(0.18, 0.50, 0.16)
    var leg_scale := Vector3(0.11, 0.42, 0.12) if hero else Vector3(0.08, 0.28, 0.09)
    var head_scale := Vector3(0.25, 0.25, 0.25) if hero else Vector3(0.16, 0.16, 0.16)
    var body_y := 0.78 if hero else 0.52
    var head_y := 1.56 if hero else 1.08

    _c8_box(parent, prefix + "LegL", base + Vector3(-0.13 if hero else -0.08, 0.22, 0.0), leg_scale, "dark")
    _c8_box(parent, prefix + "LegR", base + Vector3(0.13 if hero else 0.08, 0.22, 0.0), leg_scale, "dark")
    _c8_box(parent, prefix + "Torso", base + Vector3(0.0, body_y, 0.0), body_scale, shirt)
    _c8_cylinder(parent, prefix + "Head", base + Vector3(0.0, head_y, 0.0), head_scale, "skin")
    _c8_box(parent, prefix + "ArmL", base + Vector3(-0.26 if hero else -0.17, body_y, 0.0), Vector3(0.08, 0.34 if hero else 0.25, 0.08), "skin", 0.08)
    _c8_box(parent, prefix + "ArmR", base + Vector3(0.26 if hero else 0.17, body_y, 0.0), Vector3(0.08, 0.34 if hero else 0.25, 0.08), "skin", -0.08)
    if hero:
        _c8_box(parent, prefix + "Backpack", base + Vector3(0.0, 0.90, -0.28), Vector3(0.25, 0.48, 0.16), "green")

func _c8_plant(parent: Node3D, prefix: String, base: Vector3, large := false) -> void:
    var pot_scale := Vector3(0.34, 0.28, 0.34) if large else Vector3(0.22, 0.20, 0.22)
    var leaf_scale := Vector3(0.48, 0.90, 0.48) if large else Vector3(0.32, 0.62, 0.32)
    _c8_cylinder(parent, prefix + "Pot", base + Vector3(0.0, 0.18, 0.0), pot_scale, "masonry")
    _c8_cone(parent, prefix + "LeafA", base + Vector3(0.0, 0.75 if large else 0.55, 0.0), leaf_scale, "leaf")
    _c8_cone(parent, prefix + "LeafB", base + Vector3(0.20 if large else 0.13, 0.68 if large else 0.50, 0.05), leaf_scale * 0.72, "green")
    _c8_cone(parent, prefix + "LeafC", base + Vector3(-0.18 if large else -0.12, 0.66 if large else 0.48, -0.04), leaf_scale * 0.68, "leaf")

func _build_candidate8_production_layer() -> void:
    var host := get_node_or_null("ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails") as Node3D
    if host == null or host.has_node("Candidate8ProductionLayer"):
        return

    var camera := get_node_or_null("ViewportContainer/Viewport/World/Camera3D") as Camera3D
    if camera != null:
        camera.position = Vector3(0.55, 6.35, 13.55)
        camera.rotation = Vector3(-0.37, 0.02, 0.0)
        camera.size = 6.55

    var world_environment := get_node_or_null("ViewportContainer/Viewport/World/WorldEnvironment") as WorldEnvironment
    if world_environment != null and world_environment.environment != null:
        world_environment.environment.background_color = Color(0.055, 0.095, 0.16, 1.0)
        world_environment.environment.ambient_light_color = Color(0.42, 0.52, 0.66, 1.0)
        world_environment.environment.ambient_light_energy = 1.92

    var cool_key := get_node_or_null("ViewportContainer/Viewport/World/CoolCityKey") as DirectionalLight3D
    if cool_key != null:
        cool_key.light_energy = 2.10
    var warm_fill := get_node_or_null("ViewportContainer/Viewport/World/WarmCityFill") as DirectionalLight3D
    if warm_fill != null:
        warm_fill.light_energy = 0.52

    var layer := _c8_group(host, "Candidate8ProductionLayer")

    var facade_texture := _c8_group(layer, "FacadeTexture")
    var patch_specs := [
        [Vector3(-4.35, 0.86, 3.30), Vector3(0.82, 0.40, 0.035), "sand", -0.04],
        [Vector3(-3.48, 1.42, 1.86), Vector3(0.90, 0.34, 0.035), "masonry", 0.05],
        [Vector3(-4.06, 2.08, 0.05), Vector3(0.94, 0.42, 0.035), "sand", -0.03],
        [Vector3(-3.38, 2.76, -1.68), Vector3(0.86, 0.38, 0.035), "navy", 0.04],
        [Vector3(-2.24, 1.08, 3.40), Vector3(0.82, 0.34, 0.035), "masonry", -0.05],
        [Vector3(-1.90, 2.02, 1.02), Vector3(0.92, 0.40, 0.035), "sand", 0.03],
        [Vector3(-1.78, 2.82, -1.52), Vector3(0.80, 0.34, 0.035), "navy", -0.04],
        [Vector3(2.24, 1.04, 3.34), Vector3(0.84, 0.40, 0.035), "sand", 0.04],
        [Vector3(3.40, 1.58, 1.86), Vector3(0.94, 0.34, 0.035), "masonry", -0.04],
        [Vector3(4.06, 2.08, 0.08), Vector3(0.84, 0.40, 0.035), "sand", 0.03],
        [Vector3(3.38, 2.80, -1.68), Vector3(0.90, 0.34, 0.035), "navy", -0.04],
        [Vector3(1.84, 2.52, -2.02), Vector3(0.92, 0.40, 0.035), "masonry", 0.03],
    ]
    for index in range(patch_specs.size()):
        var spec: Array = patch_specs[index]
        _c8_box(facade_texture, "Patch" + str(index), spec[0], spec[1], spec[2], spec[3])
        var accent := "cyan" if index % 3 == 0 else ("magenta" if index % 3 == 1 else "amber")
        _c8_box(
            facade_texture,
            "PatchAccent" + str(index),
            spec[0] + Vector3(0.18 if index % 2 == 0 else -0.18, 0.10, 0.045),
            Vector3(0.30, 0.08, 0.025),
            accent,
            -0.18 + float(index % 4) * 0.11,
        )

    var graffiti := _c8_group(layer, "GraffitiWalls")
    var left_wall := _c8_box(graffiti, "LeftWall", Vector3(-4.18, 1.58, 3.38), Vector3(1.30, 1.20, 0.055), "dark")
    left_wall.rotation.z = -0.02
    var right_wall := _c8_box(graffiti, "RightWall", Vector3(4.00, 1.82, 2.55), Vector3(1.22, 1.08, 0.055), "dark")
    right_wall.rotation.z = 0.02

    var mural_offsets := [
        Vector3(-0.68, -0.58, 0.07), Vector3(-0.28, -0.42, 0.07), Vector3(0.18, -0.54, 0.07),
        Vector3(0.60, -0.34, 0.07), Vector3(-0.54, -0.05, 0.07), Vector3(-0.08, 0.08, 0.07),
        Vector3(0.42, 0.02, 0.07), Vector3(-0.60, 0.40, 0.07), Vector3(-0.16, 0.50, 0.07),
        Vector3(0.34, 0.44, 0.07), Vector3(0.66, 0.58, 0.07),
    ]
    var mural_materials := ["magenta", "cyan", "amber", "teal"]
    for index in range(mural_offsets.size()):
        var offset: Vector3 = mural_offsets[index]
        var width := 0.44 + float(index % 3) * 0.10
        var height := 0.08 + float(index % 2) * 0.035
        var angle := -0.58 + float(index) * 0.11
        _c8_box(graffiti, "LeftStroke" + str(index), Vector3(-4.18, 1.58, 3.38) + offset, Vector3(width, height, 0.025), mural_materials[index % mural_materials.size()], angle)
        _c8_box(graffiti, "RightStroke" + str(index), Vector3(4.00, 1.82, 2.55) + Vector3(-offset.x, offset.y, offset.z), Vector3(width * 0.92, height, 0.025), mural_materials[(index + 1) % mural_materials.size()], -angle)

    var shops := _c8_group(layer, "ShopfrontDetail")
    var shop_specs := [
        [Vector3(-2.70, 0.32, 3.05), Vector3(0.92, 0.44, 0.12), "warm"],
        [Vector3(-1.12, 0.42, 2.82), Vector3(0.82, 0.40, 0.12), "amber"],
        [Vector3(1.18, 0.54, 2.10), Vector3(0.82, 0.40, 0.12), "cyan"],
        [Vector3(2.82, 0.34, 2.64), Vector3(0.88, 0.42, 0.12), "warm"],
    ]
    for index in range(shop_specs.size()):
        var spec: Array = shop_specs[index]
        _c8_box(shops, "ShopFront" + str(index), spec[0], spec[1], "dark")
        _c8_box(shops, "ShopGlow" + str(index), spec[0] + Vector3(0.0, 0.08, 0.13), Vector3(spec[1].x * 0.58, spec[1].y * 0.48, 0.035), "warm")
        _c8_box(shops, "ShopAwning" + str(index), spec[0] + Vector3(0.0, spec[1].y + 0.18, 0.20), Vector3(spec[1].x * 1.10, 0.10, 0.46), spec[2], -0.10)
        for crate_index in range(3):
            _c8_box(
                shops,
                "Crate" + str(index) + "_" + str(crate_index),
                spec[0] + Vector3(-0.42 + float(crate_index) * 0.40, -0.18, 0.34),
                Vector3(0.16, 0.16 + float(crate_index % 2) * 0.05, 0.16),
                "wood" if crate_index != 1 else "sand",
            )

    var street_life := _c8_group(layer, "StreetLife")
    _c8_person(street_life, "ForegroundHero", Vector3(0.55, -0.02, 3.88), "masonry", true)
    var people := [
        [Vector3(-1.05, 0.18, 2.92), "magenta"],
        [Vector3(-0.20, 0.28, 2.40), "teal"],
        [Vector3(0.74, 0.42, 1.92), "amber"],
        [Vector3(1.28, 0.62, 1.34), "cyan"],
        [Vector3(-0.66, 0.70, 1.06), "navy"],
        [Vector3(0.18, 0.86, 0.42), "magenta"],
        [Vector3(-0.82, 1.08, -0.34), "teal"],
        [Vector3(0.72, 1.30, -1.10), "amber"],
        [Vector3(-0.20, 1.50, -1.82), "cyan"],
    ]
    for index in range(people.size()):
        var spec: Array = people[index]
        _c8_person(street_life, "Resident" + str(index), spec[0], spec[1])

    var vegetation := _c8_group(layer, "Vegetation")
    var plant_positions := [
        Vector3(-4.55, 0.00, 3.48), Vector3(-3.42, 0.02, 3.58), Vector3(-2.08, 0.06, 3.62),
        Vector3(2.10, 0.08, 3.45), Vector3(3.44, 0.02, 3.36), Vector3(4.52, 0.00, 3.20),
        Vector3(-3.86, 0.78, 1.64), Vector3(3.82, 0.92, 1.40),
        Vector3(-3.30, 1.48, -0.10), Vector3(3.34, 1.62, -0.32),
        Vector3(-2.44, 2.05, -1.70), Vector3(2.54, 2.18, -1.84),
    ]
    for index in range(plant_positions.size()):
        _c8_plant(vegetation, "Plant" + str(index), plant_positions[index], index < 6)

    var stair_detail := _c8_group(layer, "StairDetail")
    for index in range(10):
        var y := 0.18 + float(index) * 0.145
        var z := 3.15 - float(index) * 0.43
        _c8_box(stair_detail, "StepWearL" + str(index), Vector3(-0.58, y, z), Vector3(0.28, 0.035, 0.08), "sand", -0.04)
        _c8_box(stair_detail, "StepWearR" + str(index), Vector3(0.78, y, z), Vector3(0.24, 0.035, 0.08), "masonry", 0.04)
        if index % 2 == 0:
            _c8_box(stair_detail, "RouteGlow" + str(index), Vector3(1.08, y + 0.12, z), Vector3(0.10, 0.10, 0.10), "warm")

    var far_depth := _c8_group(layer, "FarDepth")
    for index in range(14):
        var x := -5.85 + float(index) * 0.90
        var y := 3.15 + float((index * 3) % 5) * 0.42
        var z := -8.70 - float(index % 3) * 0.28
        var height := 1.35 + float(index % 4) * 0.42
        var body_material := "navy" if index % 3 == 0 else ("teal" if index % 3 == 1 else "masonry")
        _c8_box(far_depth, "House" + str(index), Vector3(x, y, z), Vector3(0.36, height, 0.34), body_material)
        _c8_box(far_depth, "Roof" + str(index), Vector3(x, y + height + 0.12, z), Vector3(0.42, 0.08, 0.40), "amber" if index % 2 == 0 else "magenta")
        if index % 2 == 0:
            _c8_box(far_depth, "Window" + str(index), Vector3(x, y + 0.25, z + 0.36), Vector3(0.10, 0.12, 0.025), "warm")

    var utility := _c8_group(layer, "UtilityRhythm")
    for index in range(5):
        var cable_y := 3.20 + float(index) * 0.22
        _c8_box(utility, "Cable" + str(index), Vector3(0.0, cable_y, 0.65 - float(index) * 0.18), Vector3(5.20, 0.018, 0.018), "dark", -0.06 + float(index) * 0.03)
