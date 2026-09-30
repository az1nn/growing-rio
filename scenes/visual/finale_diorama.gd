extends Control

signal object_activated(context_id: String, object_id: String)

const VALID_PHASES := ["selection", "handoff", "coda", "recap"]

const PHASE_CAMERA := {
    "selection": {
        "position": Vector3(7.6, 5.7, 9.1),
        "rotation_degrees": Vector3(-25.2, 39.0, 0.0),
        "size": 9.1,
        "light_color": Color(0.48, 0.72, 0.95, 1),
        "accent_color": Color(1.0, 0.23, 0.50, 1),
        "accent_energy": 1.45,
        "interaction_position": Vector3(0, 0.52, 1.35),
        "object_id": "crossroads",
        "action": "Inspecionar cruzamento",
        "status": "DESFECHO 3D • três caminhos com peso visual equivalente",
    },
    "handoff": {
        "position": Vector3(7.1, 5.0, 8.2),
        "rotation_degrees": Vector3(-23.0, 39.5, 0.0),
        "size": 8.5,
        "light_color": Color(0.68, 0.78, 0.98, 1),
        "accent_color": Color(1.0, 0.57, 0.08, 1),
        "accent_energy": 1.72,
        "interaction_position": Vector3(0, 0.62, 0.42),
        "object_id": "departure_marker",
        "action": "Inspecionar travessia",
        "status": "DESFECHO 3D • travessia registrada, conclusão permanece abaixo",
    },
    "coda": {
        "position": Vector3(6.6, 5.5, 8.4),
        "rotation_degrees": Vector3(-27.0, 37.0, 0.0),
        "size": 8.8,
        "light_color": Color(0.38, 0.64, 0.90, 1),
        "accent_color": Color(1.0, 0.48, 0.16, 1),
        "accent_energy": 2.05,
        "interaction_position": Vector3(0, 1.10, 0.30),
        "object_id": "legacy_symbol",
        "action": "Inspecionar legado",
        "status": "CODA 3D • legado urbano, campanha concluída e mundo navegável",
    },
    "recap": {
        "position": Vector3(7.7, 5.4, 8.9),
        "rotation_degrees": Vector3(-24.0, 40.0, 0.0),
        "size": 8.9,
        "light_color": Color(0.42, 0.76, 0.92, 1),
        "accent_color": Color(0.02, 0.74, 0.79, 1),
        "accent_energy": 1.72,
        "interaction_position": Vector3(0, 1.78, -0.25),
        "object_id": "results_monitor",
        "action": "Inspecionar resultados",
        "status": "RECAP 3D • resultados e memória sem nova mutação",
    },
}

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var camera: Camera3D = $ViewportContainer/Viewport/World/Camera3D
@onready var key_light: DirectionalLight3D = $ViewportContainer/Viewport/World/KeyLight
@onready var accent_light: OmniLight3D = $ViewportContainer/Viewport/World/AccentLight
@onready var interactive_object: Area3D = $ViewportContainer/Viewport/World/TableauInteraction
@onready var action_button: Button = $ObjectActionButton
@onready var interaction_status: Label = $InteractionStatus

@onready var selection_root: Node3D = $ViewportContainer/Viewport/World/Phases/Selection
@onready var handoff_root: Node3D = $ViewportContainer/Viewport/World/Phases/Handoff
@onready var coda_root: Node3D = $ViewportContainer/Viewport/World/Phases/Coda
@onready var recap_root: Node3D = $ViewportContainer/Viewport/World/Phases/Recap

@onready var option_a: MeshInstance3D = $ViewportContainer/Viewport/World/Phases/Selection/DoorA
@onready var option_b: MeshInstance3D = $ViewportContainer/Viewport/World/Phases/Selection/DoorB
@onready var option_c: MeshInstance3D = $ViewportContainer/Viewport/World/Phases/Selection/DoorC

@onready var selection_primary: MeshInstance3D = $ViewportContainer/Viewport/World/Phases/Selection/SelectionMarker
@onready var handoff_primary: MeshInstance3D = $ViewportContainer/Viewport/World/Phases/Handoff/DepartureMarker
@onready var coda_primary: MeshInstance3D = $ViewportContainer/Viewport/World/Phases/Coda/LegacySymbol
@onready var recap_primary: MeshInstance3D = $ViewportContainer/Viewport/World/Phases/Recap/ResultsMonitor

var phase_id := "selection"
var activation_count := 0
var _pulse_tween: Tween
var _phase_roots: Dictionary = {}
var _phase_primary: Dictionary = {}
var _active_primary: MeshInstance3D
var _active_primary_base_position := Vector3.ZERO
var _active_object_id := "crossroads"

func _ready() -> void:
    viewport.physics_object_picking = true
    _phase_roots = {
        "selection": selection_root,
        "handoff": handoff_root,
        "coda": coda_root,
        "recap": recap_root,
    }
    _phase_primary = {
        "selection": selection_primary,
        "handoff": handoff_primary,
        "coda": coda_primary,
        "recap": recap_primary,
    }
    set_phase("selection")

func set_phase(next_phase_id: String) -> bool:
    if not VALID_PHASES.has(next_phase_id):
        return false

    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()

    phase_id = next_phase_id
    for candidate_id in VALID_PHASES:
        var root_node := _phase_roots.get(candidate_id) as Node3D
        if root_node != null:
            root_node.visible = candidate_id == phase_id

    var config: Dictionary = Dictionary(PHASE_CAMERA[phase_id])
    camera.position = Vector3(config["position"])
    camera.rotation_degrees = Vector3(config["rotation_degrees"])
    camera.size = float(config["size"])
    key_light.light_color = Color(config["light_color"])
    accent_light.light_color = Color(config["accent_color"])
    accent_light.light_energy = float(config["accent_energy"])
    interactive_object.position = Vector3(config["interaction_position"])

    _active_primary = _phase_primary.get(phase_id) as MeshInstance3D
    if _active_primary != null:
        _active_primary_base_position = _active_primary.position

    _active_object_id = String(config["object_id"])
    action_button.text = String(config["action"])
    action_button.accessibility_name = (
        "%s — alternativa ao objeto 3D" % String(config["action"])
    )
    interaction_status.text = String(config["status"])
    return true

func activate_primary_object() -> void:
    activation_count += 1
    if _active_primary != null:
        if _pulse_tween != null and _pulse_tween.is_valid():
            _pulse_tween.kill()
        _active_primary.position = _active_primary_base_position + Vector3(0.0, 0.14, 0.0)
        _pulse_tween = create_tween()
        _pulse_tween.set_trans(Tween.TRANS_BACK)
        _pulse_tween.set_ease(Tween.EASE_OUT)
        _pulse_tween.tween_property(
            _active_primary,
            "position",
            _active_primary_base_position,
            0.30,
        )
    object_activated.emit("finale", _active_object_id)

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func has_equal_selection_weight() -> bool:
    return (
        option_a.scale == option_b.scale
        and option_b.scale == option_c.scale
        and is_equal_approx(option_a.position.y, option_b.position.y)
        and is_equal_approx(option_b.position.y, option_c.position.y)
    )

func visible_phase_count() -> int:
    var count := 0
    for candidate_id in VALID_PHASES:
        var root_node := _phase_roots.get(candidate_id) as Node3D
        if root_node != null and root_node.visible:
            count += 1
    return count

func current_phase_visual_id() -> String:
    return phase_id

func current_primary_object_id() -> String:
    return _active_object_id

func phase_root(lookup_phase_id: String) -> Node3D:
    return _phase_roots.get(lookup_phase_id) as Node3D

func _on_tableau_input_event(
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

func _on_object_action_button_pressed() -> void:
    activate_primary_object()
