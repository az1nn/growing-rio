extends Control

signal object_activated(context_id: String, object_id: String)

const VALID_PHASES := ["selection", "handoff", "coda", "recap"]

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var interactive_object: Area3D = $ViewportContainer/Viewport/World/TableauInteraction
@onready var tableau_core: MeshInstance3D = $ViewportContainer/Viewport/World/Tableau/TableauCore
@onready var action_button: Button = $ObjectActionButton
@onready var interaction_status: Label = $InteractionStatus
@onready var option_a: MeshInstance3D = $ViewportContainer/Viewport/World/EndingOptions/OptionA
@onready var option_b: MeshInstance3D = $ViewportContainer/Viewport/World/EndingOptions/OptionB
@onready var option_c: MeshInstance3D = $ViewportContainer/Viewport/World/EndingOptions/OptionC

var phase_id := "selection"
var activation_count := 0
var _pulse_tween: Tween
var _base_core_position := Vector3.ZERO

func _ready() -> void:
    viewport.physics_object_picking = true
    action_button.accessibility_name = "Inspecionar tableau do desfecho — alternativa ao objeto 3D"
    _base_core_position = tableau_core.position
    set_phase("selection")

func set_phase(next_phase_id: String) -> bool:
    if not VALID_PHASES.has(next_phase_id):
        return false
    phase_id = next_phase_id
    match phase_id:
        "selection":
            interaction_status.text = "DESFECHO 3D • alternativas com peso visual equivalente"
        "handoff":
            interaction_status.text = "DESFECHO 3D • caminho registrado, conclusão permanece abaixo"
        "coda":
            interaction_status.text = "CODA 3D • campanha concluída, mundo segue navegável"
        "recap":
            interaction_status.text = "RECAP 3D • memória do desfecho sem nova mutação"
    return true

func activate_primary_object() -> void:
    activation_count += 1
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    tableau_core.position = _base_core_position + Vector3(0.0, 0.14, 0.0)
    _pulse_tween = create_tween()
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(tableau_core, "position", _base_core_position, 0.30)
    object_activated.emit("finale", "tableau")

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
