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
var _candidate9_materials: Dictionary = {}

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Abrir distritos — alternativa ao hotspot de telhados 3D"
    route_button.accessibility_name = "Abrir rotas — alternativa ao hotspot da escadaria 3D"
    community_button.accessibility_name = "Abrir evento local — alternativa ao hotspot do bairro 3D"
    _base_district_scale = district_marker.scale
    _base_route_scale = route_marker.scale
    _base_local_event_scale = local_event_marker.scale
    _build_candidate8_production_layer()
    _build_candidate9_surface_rebase()

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

    var surface_texture_path := ""
    match material_id:
        "masonry", "sand":
            surface_texture_path = "res://assets/city/v1/c9-masonry-patch.svg"
        "navy", "teal", "cyan", "magenta", "amber":
            surface_texture_path = "res://assets/city/v1/c9-paint-wear.svg"
        "wood":
            surface_texture_path = "res://assets/city/v1/c9-metal-rib.svg"
    if not surface_texture_path.is_empty():
        var surface_texture := load(surface_texture_path) as Texture2D
        if surface_texture != null:
            material.albedo_texture = surface_texture
            material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
            material.uv1_scale = Vector3(2.4, 2.4, 2.4)

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


func _c9_material(texture_path: String, tint: Color = Color.WHITE) -> StandardMaterial3D:
    var key := texture_path + "|" + str(tint)
    if _candidate9_materials.has(key):
        return _candidate9_materials[key] as StandardMaterial3D

    var material := StandardMaterial3D.new()
    material.roughness = 0.96
    material.albedo_color = tint
    material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
    material.cull_mode = BaseMaterial3D.CULL_DISABLED
    var texture := load(texture_path) as Texture2D
    if texture != null:
        material.albedo_texture = texture
    _candidate9_materials[key] = material
    return material

func _c9_quad(
    parent: Node3D,
    node_name: String,
    position_3d: Vector3,
    size_2d: Vector2,
    texture_path: String,
    tint: Color = Color.WHITE,
    rotation_y: float = 0.0,
    rotation_z: float = 0.0,
) -> MeshInstance3D:
    var quad := QuadMesh.new()
    quad.size = size_2d
    var node := MeshInstance3D.new()
    node.name = node_name
    node.position = position_3d
    node.rotation = Vector3(0.0, rotation_y, rotation_z)
    node.mesh = quad
    node.material_override = _c9_material(texture_path, tint)
    parent.add_child(node)
    return node

func _c9_polygon_card(
    parent: Node3D,
    node_name: String,
    position_3d: Vector3,
    points: PackedVector2Array,
    texture_path: String,
    tint: Color = Color.WHITE,
) -> MeshInstance3D:
    var triangles := Geometry2D.triangulate_polygon(points)
    var mesh := ArrayMesh.new()
    if triangles.is_empty():
        return _c9_quad(parent, node_name, position_3d, Vector2(1.0, 1.0), texture_path, tint)

    var min_x := points[0].x
    var max_x := points[0].x
    var min_y := points[0].y
    var max_y := points[0].y
    for point in points:
        min_x = min(min_x, point.x)
        max_x = max(max_x, point.x)
        min_y = min(min_y, point.y)
        max_y = max(max_y, point.y)

    var width: float = maxf(max_x - min_x, 0.001)
    var height: float = maxf(max_y - min_y, 0.001)
    var vertices := PackedVector3Array()
    var uvs := PackedVector2Array()
    for point in points:
        vertices.append(Vector3(point.x, point.y, 0.0))
        uvs.append(Vector2((point.x - min_x) / width, 1.0 - ((point.y - min_y) / height)))

    var arrays := []
    arrays.resize(Mesh.ARRAY_MAX)
    arrays[Mesh.ARRAY_VERTEX] = vertices
    arrays[Mesh.ARRAY_TEX_UV] = uvs
    arrays[Mesh.ARRAY_INDEX] = triangles
    mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

    var node := MeshInstance3D.new()
    node.name = node_name
    node.position = position_3d
    node.mesh = mesh
    node.material_override = _c9_material(texture_path, tint)
    parent.add_child(node)
    return node

func _build_candidate9_surface_rebase() -> void:
    var host := get_node_or_null("ViewportContainer/Viewport/World/CityV1Environment/R06StructuralRebaseDetails") as Node3D
    if host == null or host.has_node("Candidate9SurfaceRebase"):
        return

    var candidate8 := host.get_node_or_null("Candidate8ProductionLayer") as Node3D
    if candidate8 != null:
        for obsolete_group in ["FacadeTexture", "GraffitiWalls", "FarDepth"]:
            var obsolete := candidate8.get_node_or_null(obsolete_group) as Node3D
            if obsolete != null:
                obsolete.visible = false

    for obsolete_path in [
        "Candidate7StreetPerspective/ForegroundFacadeLeft",
        "Candidate7StreetPerspective/ForegroundFacadeRight",
        "Candidate6TargetRecompose/MuralGateway",
        "Candidate5CompositionDensity/MuralReadability",
        "Candidate4AuthoredDensity/MuralFocal",
    ]:
        var obsolete := host.get_node_or_null(obsolete_path) as Node3D
        if obsolete != null:
            obsolete.visible = false

    var layer := _c8_group(host, "Candidate9SurfaceRebase")
    var facades := _c8_group(layer, "FacadeSkins")
    var facade_specs := [
        ["LeftFrontSkin", Vector3(-4.18, 1.78, 3.48), Vector2(2.55, 2.62), "res://assets/city/v1/c9-masonry-patch.svg", Color(0.95, 0.73, 0.63, 1.0), -0.04, -0.02],
        ["LeftMidSkin", Vector3(-2.36, 1.92, 2.08), Vector2(2.10, 2.38), "res://assets/city/v1/c9-tile-grid.svg", Color(0.46, 0.82, 0.83, 1.0), -0.03, 0.01],
        ["LeftUpperSkin", Vector3(-3.18, 2.82, 0.22), Vector2(2.35, 1.82), "res://assets/city/v1/c9-paint-wear.svg", Color(0.88, 0.49, 0.44, 1.0), -0.03, -0.01],
        ["RightFrontSkin", Vector3(4.02, 1.92, 2.67), Vector2(2.46, 2.55), "res://assets/city/v1/c9-tile-grid.svg", Color(0.45, 0.76, 0.84, 1.0), 0.04, 0.02],
        ["RightMidSkin", Vector3(2.55, 1.80, 1.18), Vector2(2.16, 2.20), "res://assets/city/v1/c9-masonry-patch.svg", Color(0.94, 0.64, 0.53, 1.0), 0.03, -0.02],
        ["RightUpperSkin", Vector3(3.12, 2.86, -0.78), Vector2(2.26, 1.72), "res://assets/city/v1/c9-paint-wear.svg", Color(0.45, 0.74, 0.76, 1.0), 0.03, 0.01],
        ["StairLeftSkin", Vector3(-1.18, 1.28, 0.88), Vector2(1.34, 2.75), "res://assets/city/v1/c9-masonry-patch.svg", Color(0.67, 0.45, 0.39, 1.0), -0.02, -0.03],
        ["StairRightSkin", Vector3(1.32, 1.42, 0.68), Vector2(1.42, 2.62), "res://assets/city/v1/c9-tile-grid.svg", Color(0.26, 0.61, 0.64, 1.0), 0.02, 0.02],
    ]
    for spec in facade_specs:
        _c9_quad(facades, spec[0], spec[1], spec[2], spec[3], spec[4], spec[5], spec[6])

    var murals := _c8_group(layer, "Murals")
    _c9_quad(
        murals,
        "LeftMural",
        Vector3(-4.18, 1.78, 3.55),
        Vector2(2.12, 1.58),
        "res://assets/city/v1/c9-mural-crown.svg",
        Color.WHITE,
        -0.04,
        -0.02
    )
    _c9_quad(
        murals,
        "RightMural",
        Vector3(4.02, 1.88, 2.74),
        Vector2(1.92, 1.42),
        "res://assets/city/v1/c9-shop-graffiti.svg",
        Color.WHITE,
        0.04,
        0.02
    )

    var shopfronts := _c8_group(layer, "TexturedShopfronts")
    var shutter_specs := [
        ["ShutterA", Vector3(-2.72, 0.72, 3.25), Vector2(1.54, 0.94), Color(0.95, 0.58, 0.36, 1.0)],
        ["ShutterB", Vector3(-1.05, 0.78, 2.96), Vector2(1.34, 0.88), Color(0.48, 0.81, 0.80, 1.0)],
        ["ShutterC", Vector3(1.16, 0.86, 2.24), Vector2(1.32, 0.88), Color(0.95, 0.42, 0.65, 1.0)],
        ["ShutterD", Vector3(2.82, 0.70, 2.80), Vector2(1.48, 0.92), Color(0.92, 0.67, 0.32, 1.0)],
    ]
    for spec in shutter_specs:
        _c9_quad(shopfronts, spec[0], spec[1], spec[2], "res://assets/city/v1/c9-shop-graffiti.svg", spec[3])

    var silhouettes := _c8_group(layer, "IrregularSilhouettes")
    var left_roof := PackedVector2Array([
        Vector2(-1.38, -0.56), Vector2(-1.38, 0.18), Vector2(-1.08, 0.18), Vector2(-1.08, 0.66),
        Vector2(-0.56, 0.66), Vector2(-0.56, 0.44), Vector2(0.10, 0.44), Vector2(0.10, 0.82),
        Vector2(0.62, 0.82), Vector2(0.62, 0.52), Vector2(1.22, 0.52), Vector2(1.38, -0.56)
    ])
    var right_roof := PackedVector2Array([
        Vector2(-1.28, -0.54), Vector2(-1.18, 0.52), Vector2(-0.62, 0.52), Vector2(-0.62, 0.82),
        Vector2(-0.12, 0.82), Vector2(-0.12, 0.34), Vector2(0.42, 0.34), Vector2(0.42, 0.68),
        Vector2(0.98, 0.68), Vector2(1.24, 0.24), Vector2(1.28, -0.54)
    ])
    _c9_polygon_card(silhouettes, "LeftRoofline", Vector3(-3.44, 3.48, 0.38), left_roof, "res://assets/city/v1/c9-roof-patch.svg", Color(0.92, 0.58, 0.48, 1.0))
    _c9_polygon_card(silhouettes, "RightRoofline", Vector3(3.34, 3.52, -0.50), right_roof, "res://assets/city/v1/c9-roof-patch.svg", Color(0.84, 0.42, 0.57, 1.0))

    var depth := _c8_group(layer, "LayeredDepthCards")
    var depth_specs := [
        ["Depth01", Vector3(-4.88, 3.82, -6.28), Vector2(1.48, 2.30), "res://assets/city/v1/c9-masonry-patch.svg", Color(0.40, 0.48, 0.57, 1.0)],
        ["Depth02", Vector3(-3.18, 4.12, -6.86), Vector2(1.56, 2.80), "res://assets/city/v1/c9-tile-grid.svg", Color(0.34, 0.55, 0.60, 1.0)],
        ["Depth03", Vector3(-1.28, 3.72, -7.16), Vector2(1.62, 2.18), "res://assets/city/v1/c9-paint-wear.svg", Color(0.49, 0.42, 0.50, 1.0)],
        ["Depth04", Vector3(0.48, 4.28, -7.42), Vector2(1.72, 3.02), "res://assets/city/v1/c9-masonry-patch.svg", Color(0.44, 0.46, 0.55, 1.0)],
        ["Depth05", Vector3(2.24, 3.78, -7.08), Vector2(1.54, 2.34), "res://assets/city/v1/c9-tile-grid.svg", Color(0.34, 0.52, 0.58, 1.0)],
        ["Depth06", Vector3(4.02, 4.04, -6.62), Vector2(1.48, 2.72), "res://assets/city/v1/c9-paint-wear.svg", Color(0.50, 0.42, 0.48, 1.0)],
    ]
    for spec in depth_specs:
        _c9_quad(depth, spec[0], spec[1], spec[2], spec[3], spec[4])

    var utility_skin := _c8_group(layer, "UtilitySurface")
    _c9_quad(utility_skin, "ServiceGateLeft", Vector3(-2.05, 0.72, 3.31), Vector2(0.86, 1.02), "res://assets/city/v1/c9-metal-rib.svg", Color(0.60, 0.69, 0.72, 1.0))
    _c9_quad(utility_skin, "ServiceGateRight", Vector3(2.08, 0.84, 2.52), Vector2(0.82, 0.98), "res://assets/city/v1/c9-metal-rib.svg", Color(0.58, 0.68, 0.70, 1.0))
