extends Control
class_name DalataScreenShell

const Tokens = preload("res://resources/ui/v1/dalata_ui_tokens.gd")

@onready var frame: VBoxContainer = %Frame
@onready var top_region: PanelContainer = %TopRegion
@onready var scene_title_label: Label = %SceneTitle
@onready var status_label: Label = %StatusLine
@onready var action_region: MarginContainer = %ActionRegion
@onready var action_host: VBoxContainer = %ActionHost
@onready var bottom_command_band: PanelContainer = %BottomCommandBand
@onready var command_host: GridContainer = %CommandHost

func _ready() -> void:
    frame.add_theme_constant_override("separation", Tokens.SPACE_3)
    action_host.add_theme_constant_override("separation", Tokens.SPACE_3)
    command_host.add_theme_constant_override("h_separation", Tokens.SPACE_2)
    command_host.add_theme_constant_override("v_separation", Tokens.SPACE_2)
    top_region.custom_minimum_size.y = maxf(
        top_region.custom_minimum_size.y,
        float(Tokens.TOP_REGION_MIN_HEIGHT),
    )
    bottom_command_band.custom_minimum_size.y = maxf(
        bottom_command_band.custom_minimum_size.y,
        float(Tokens.BOTTOM_BAND_MIN_HEIGHT),
    )
    command_host.columns = Tokens.NAV_SLOT_MAX
    apply_layout_for_size(get_viewport_rect().size)

func set_scene_identity(scene_title: String, status_text: String = "") -> void:
    scene_title_label.text = scene_title
    status_label.text = status_text
    status_label.visible = not status_text.is_empty()

func set_status_line(status_text: String) -> void:
    status_label.text = status_text
    status_label.visible = not status_text.is_empty()

func mount_action_content(control: Control, replace_existing := false) -> bool:
    if control == null or control.get_parent() != null:
        return false
    if replace_existing:
        clear_action_content()
    control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    control.size_flags_vertical = Control.SIZE_EXPAND_FILL
    action_host.add_child(control)
    return true

func clear_action_content() -> void:
    for child in action_host.get_children():
        action_host.remove_child(child)
        child.queue_free()

func add_command(control: Control) -> bool:
    if control == null or control.get_parent() != null:
        return false
    if command_host.get_child_count() >= Tokens.NAV_SLOT_MAX:
        return false
    control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    control.focus_mode = Control.FOCUS_ALL
    command_host.add_child(control)
    _refresh_command_focus_chain()
    return true

func clear_commands() -> void:
    for child in command_host.get_children():
        command_host.remove_child(child)
        child.queue_free()

func _refresh_command_focus_chain() -> void:
    var commands := command_host.get_children()
    for index in range(commands.size()):
        var command := commands[index] as Control
        if command == null:
            continue
        command.focus_neighbor_left = (
            command.get_path_to(commands[index - 1])
            if index > 0
            else NodePath("")
        )
        command.focus_neighbor_right = (
            command.get_path_to(commands[index + 1])
            if index + 1 < commands.size()
            else NodePath("")
        )
        command.focus_previous = command.focus_neighbor_left
        command.focus_next = command.focus_neighbor_right

func command_count() -> int:
    return command_host.get_child_count()

func apply_layout_for_size(viewport_size: Vector2) -> void:
    var compact_portrait := viewport_size.x <= 600.0 and viewport_size.y >= viewport_size.x
    var side_margin := Tokens.PORTRAIT_SAFE_MARGIN if compact_portrait else Tokens.SPACE_5
    var vertical_margin := (
        Tokens.PORTRAIT_SAFE_MARGIN
        if compact_portrait
        else Tokens.SPACE_4
    )

    offset_left = side_margin
    offset_top = vertical_margin
    offset_right = -side_margin
    offset_bottom = -vertical_margin

    scene_title_label.add_theme_font_size_override(
        "font_size",
        28 if compact_portrait else 32,
    )
    status_label.add_theme_font_size_override(
        "font_size",
        13 if compact_portrait else 15,
    )
