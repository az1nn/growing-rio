extends Control

signal object_activated(context_id: String, object_id: String)

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var district_interaction: Area3D = $ViewportContainer/Viewport/World/DistrictOverlookInteraction
@onready var route_interaction: Area3D = $ViewportContainer/Viewport/World/RouteNodesInteraction
@onready var local_event_interaction: Area3D = $ViewportContainer/Viewport/World/CommunityClusterInteraction
@onready var district_marker: MeshInstance3D = $ViewportContainer/Viewport/World/RooftopV1/DistrictMarker
@onready var route_marker: MeshInstance3D = $ViewportContainer/Viewport/World/RouteMarkers/RouteMarkerB
@onready var local_event_marker: MeshInstance3D = $ViewportContainer/Viewport/World/NeighborhoodNode/LocalEventMarker
@onready var action_button: Button = $ObjectActionButton
@onready var route_button: Button = $RouteActionButton
@onready var community_button: Button = $CommunityActionButton
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween
var _base_district_scale := Vector3.ONE
var _base_route_scale := Vector3.ONE
var _base_local_event_scale := Vector3.ONE

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Abrir distritos — alternativa ao hotspot de telhados 3D"
    route_button.accessibility_name = "Abrir rotas — alternativa ao hotspot da escadaria 3D"
    community_button.accessibility_name = "Abrir evento local — alternativa ao hotspot do bairro 3D"
    _base_district_scale = district_marker.scale
    _base_route_scale = route_marker.scale
    _base_local_event_scale = local_event_marker.scale

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
