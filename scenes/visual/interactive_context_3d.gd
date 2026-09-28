extends Control

signal object_activated(context_id: String, object_id: String)

@export_enum("shell", "operation", "market", "city", "institutional", "archive")
var context_id := "shell"
@export var action_label := "Explorar objeto 3D"

@onready var viewport: SubViewport = $ViewportContainer/Viewport
@onready var focal_object: MeshInstance3D = $ViewportContainer/Viewport/World/FocalObject
@onready var accent_a: MeshInstance3D = $ViewportContainer/Viewport/World/AccentA
@onready var accent_b: MeshInstance3D = $ViewportContainer/Viewport/World/AccentB
@onready var interactive_object: Area3D = $ViewportContainer/Viewport/World/InteractiveObject
@onready var action_button: Button = $ObjectActionButton
@onready var interaction_status: Label = $InteractionStatus

var activation_count := 0
var _pulse_tween: Tween

func _ready() -> void:
    action_button.text = action_label
    action_button.accessibility_name = "%s — alternativa ao objeto 3D" % action_label
    viewport.physics_object_picking = true
    _apply_context_composition()

func activate_primary_object() -> void:
    activation_count += 1
    interaction_status.text = "%s • interação %d" % [action_label, activation_count]
    if _pulse_tween != null and _pulse_tween.is_valid():
        _pulse_tween.kill()
    focal_object.scale = _context_scale() * 1.08
    _pulse_tween = create_tween()
    _pulse_tween.set_trans(Tween.TRANS_BACK)
    _pulse_tween.set_ease(Tween.EASE_OUT)
    _pulse_tween.tween_property(focal_object, "scale", _context_scale(), 0.22)
    object_activated.emit(context_id, "primary")

func has_pointer_interaction() -> bool:
    return interactive_object.input_ray_pickable and viewport.physics_object_picking

func has_accessible_button_fallback() -> bool:
    return not action_button.disabled and action_button.visible

func _on_interactive_object_input_event(
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

func _apply_context_composition() -> void:
    focal_object.scale = _context_scale()
    var palette := _context_palette()
    _set_unique_material(focal_object, palette[0])
    _set_unique_material(accent_a, palette[1])
    _set_unique_material(accent_b, palette[2])

    match context_id:
        "operation":
            focal_object.position = Vector3(0.0, 0.72, 0.15)
            accent_a.position = Vector3(-1.55, 0.42, -0.65)
            accent_b.position = Vector3(1.45, 0.55, 0.5)
        "market":
            focal_object.position = Vector3(0.0, 0.58, 0.0)
            accent_a.position = Vector3(-1.7, 0.38, 0.85)
            accent_b.position = Vector3(1.65, 0.38, -0.75)
        "city":
            focal_object.position = Vector3(0.0, 1.0, 0.0)
            accent_a.position = Vector3(-1.55, 0.55, 0.55)
            accent_b.position = Vector3(1.55, 0.78, -0.5)
        "institutional":
            focal_object.position = Vector3(0.0, 0.88, 0.0)
            accent_a.position = Vector3(-1.65, 0.66, 0.55)
            accent_b.position = Vector3(1.65, 0.66, 0.55)
        "archive":
            focal_object.position = Vector3(0.0, 0.92, 0.0)
            accent_a.position = Vector3(-1.45, 0.5, 0.75)
            accent_b.position = Vector3(1.45, 0.5, 0.75)
        _:
            focal_object.position = Vector3(0.0, 0.7, 0.0)

    interactive_object.position = focal_object.position

func _context_scale() -> Vector3:
    match context_id:
        "operation":
            return Vector3(1.15, 0.9, 1.15)
        "market":
            return Vector3(1.55, 0.55, 0.85)
        "city":
            return Vector3(0.85, 1.45, 0.85)
        "institutional":
            return Vector3(1.35, 1.1, 0.65)
        "archive":
            return Vector3(1.2, 1.25, 0.72)
        _:
            return Vector3(1.15, 0.85, 1.15)

func _context_palette() -> Array[Color]:
    match context_id:
        "operation":
            return [Color("5f8d61"), Color("b56b45"), Color("2e665e")]
        "market":
            return [Color("b57a43"), Color("7a4f34"), Color("356d68")]
        "city":
            return [Color("66869a"), Color("b06d4e"), Color("527a57")]
        "institutional":
            return [Color("71858f"), Color("c29c62"), Color("3e686d")]
        "archive":
            return [Color("8b745d"), Color("4b6660"), Color("b08b58")]
        _:
            return [Color("4d746b"), Color("a96d4f"), Color("607e8e")]

func _set_unique_material(mesh_instance: MeshInstance3D, color: Color) -> void:
    var material := mesh_instance.material_override.duplicate() as StandardMaterial3D
    material.albedo_color = color
    mesh_instance.material_override = material
