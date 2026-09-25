extends Control

signal context_changed(context_id: String)

const OPERATION_SCENE := preload("res://scenes/visual/operation_diorama.tscn")
const DEFAULT_RENDER_SHRINK := 1
const LOW_RESOURCE_RENDER_SHRINK := 2
const TRANSITION_POLICY := "replace"

@export var default_context_id := "operation"
@export var low_resource_mode := false

var current_context_id := ""
var mounted_scene: Node = null

func _ready() -> void:
    mouse_filter = Control.MOUSE_FILTER_IGNORE
    if not default_context_id.is_empty():
        mount_context(default_context_id)

func available_context_ids() -> Array[String]:
    return ["operation"]

func has_context(context_id: String) -> bool:
    return available_context_ids().has(context_id)

func transition_policy() -> String:
    return TRANSITION_POLICY

func mount_context(context_id: String) -> bool:
    if context_id == current_context_id and is_instance_valid(mounted_scene):
        _apply_resource_profile()
        return true

    unmount_context()

    if context_id.is_empty():
        context_changed.emit(current_context_id)
        return true
    if not has_context(context_id):
        return false

    match context_id:
        "operation":
            mounted_scene = OPERATION_SCENE.instantiate()
        _:
            return false

    add_child(mounted_scene)
    if mounted_scene is Control:
        var mounted_control := mounted_scene as Control
        mounted_control.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

    current_context_id = context_id
    _apply_resource_profile()
    context_changed.emit(current_context_id)
    return true

func unmount_context() -> void:
    if is_instance_valid(mounted_scene):
        remove_child(mounted_scene)
        mounted_scene.queue_free()
    mounted_scene = null
    current_context_id = ""

func set_low_resource_mode(enabled: bool) -> void:
    low_resource_mode = enabled
    _apply_resource_profile()

func _apply_resource_profile() -> void:
    if not is_instance_valid(mounted_scene):
        return
    if not mounted_scene is SubViewportContainer:
        return
    var viewport_container := mounted_scene as SubViewportContainer
    viewport_container.stretch_shrink = (
        LOW_RESOURCE_RENDER_SHRINK
        if low_resource_mode
        else DEFAULT_RENDER_SHRINK
    )
