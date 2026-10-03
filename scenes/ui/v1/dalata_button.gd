extends Button
class_name DalataButton

const Tokens = preload("res://resources/ui/v1/dalata_ui_tokens.gd")

enum Role {
    PRIMARY,
    SECONDARY,
    UTILITY,
    DANGER_RISK,
    NAVIGATION_TAB,
}

@export_enum("PRIMARY", "SECONDARY", "UTILITY", "DANGER_RISK", "NAVIGATION_TAB")
var role: int = Role.SECONDARY
@export var semantic_action_id: StringName = &""
@export var progression_locked := false
@export_multiline var lock_reason := ""

var _selected := false
var _base_text := ""

func _ready() -> void:
    _base_text = text
    focus_mode = Control.FOCUS_ALL
    mouse_filter = Control.MOUSE_FILTER_STOP
    mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
    custom_minimum_size.y = maxf(custom_minimum_size.y, float(Tokens.TOUCH_TARGET_MIN))
    if role == Role.NAVIGATION_TAB:
        toggle_mode = true
        clip_text = true
        custom_minimum_size.y = maxf(custom_minimum_size.y, float(Tokens.NAV_HEIGHT))
    else:
        custom_minimum_size.y = maxf(custom_minimum_size.y, float(Tokens.BUTTON_HEIGHT))
    _apply_role_theme()
    _sync_semantic_state()

func configure(
    new_role: int,
    action_id: StringName = &"",
    accessible_label: String = "",
) -> void:
    role = new_role
    semantic_action_id = action_id
    if not accessible_label.is_empty():
        accessibility_name = accessible_label
    if is_inside_tree():
        _apply_role_theme()
        _sync_semantic_state()

func set_selected(value: bool) -> void:
    _selected = value
    if role == Role.NAVIGATION_TAB:
        toggle_mode = true
        button_pressed = value
    if is_inside_tree():
        _apply_role_theme()
    _sync_semantic_state()

func is_selected() -> bool:
    return _selected

func set_progression_lock(value: bool, reason: String = "") -> void:
    progression_locked = value
    lock_reason = reason
    disabled = value
    _sync_semantic_state()

func _sync_semantic_state() -> void:
    if _base_text.is_empty():
        _base_text = text.trim_prefix("> ").trim_prefix("[BLOQ] ")
    if progression_locked:
        text = "[BLOQ] %s" % _base_text
        tooltip_text = lock_reason
        if accessibility_name.is_empty():
            accessibility_name = "%s — bloqueado" % _base_text
        if not lock_reason.is_empty():
            accessibility_description = lock_reason
        return

    # Selected navigation uses physical rails/notch, never ASCII chrome.
    text = _base_text
    if accessibility_name.is_empty():
        accessibility_name = _base_text
    if not lock_reason.is_empty() and tooltip_text == lock_reason:
        tooltip_text = ""

func _apply_role_theme() -> void:
    if role == Role.NAVIGATION_TAB:
        _apply_navigation_theme()
        return

    var palette := Tokens.role_palette(role)
    var surface: Color = palette["surface"]
    var surface_hover: Color = palette["surface_hover"]
    var border: Color = palette["border"]
    var font_color: Color = palette["text"]

    add_theme_stylebox_override("normal", _style(surface, border, Tokens.BORDER_WIDTH))
    add_theme_stylebox_override(
        "hover",
        _style(surface_hover, border.lightened(0.08), Tokens.FOCUS_BORDER_WIDTH)
    )
    add_theme_stylebox_override(
        "pressed",
        _style(surface_hover.darkened(0.08), border, Tokens.FOCUS_BORDER_WIDTH, true)
    )
    add_theme_stylebox_override(
        "focus",
        _focus_style(border if role != Role.PRIMARY else Tokens.CYAN_SYSTEM)
    )
    var disabled_style := _style(
        Tokens.INK_950.darkened(0.08),
        Tokens.LOCKED_GREY,
        Tokens.BORDER_WIDTH,
    )
    # Disabled is not a color-only state: the heavier lower rail changes silhouette.
    disabled_style.border_width_bottom = Tokens.BORDER_WIDTH + 3
    disabled_style.content_margin_bottom = 13.0
    add_theme_stylebox_override("disabled", disabled_style)

    add_theme_color_override("font_color", font_color)
    add_theme_color_override("font_hover_color", font_color)
    add_theme_color_override("font_pressed_color", font_color)
    add_theme_color_override("font_focus_color", font_color)
    add_theme_color_override("font_disabled_color", Tokens.TEXT_MUTED)
    add_theme_font_size_override(
        "font_size",
        17 if role == Role.PRIMARY else 15
    )

func _apply_navigation_theme() -> void:
    var selected_border := Tokens.AMBER_DARK
    var normal_border := Tokens.TEAL_SECONDARY.darkened(0.18)
    var hover_border := Tokens.CYAN_SYSTEM.darkened(0.06)
    var selected_surface := Tokens.INK_900
    var text_color := Tokens.AMBER_PRIMARY if _selected else Tokens.TEXT_PRIMARY

    add_theme_stylebox_override(
        "normal",
        _nav_style(
            selected_surface if _selected else Tokens.INK_950,
            selected_border if _selected else normal_border,
            _selected,
            false,
        ),
    )
    add_theme_stylebox_override(
        "hover",
        _nav_style(
            selected_surface.lightened(0.06) if _selected else Tokens.INK_800,
            selected_border if _selected else hover_border,
            _selected,
            false,
        ),
    )
    add_theme_stylebox_override(
        "pressed",
        _nav_style(
            selected_surface if _selected else Tokens.INK_800,
            selected_border if _selected else hover_border,
            _selected,
            true,
        ),
    )
    add_theme_stylebox_override(
        "focus",
        _focus_style(Tokens.MAGENTA_EVENT if _selected else Tokens.CYAN_SYSTEM),
    )
    var disabled_style := _nav_style(
        Tokens.INK_950,
        Tokens.LOCKED_GREY,
        _selected,
        false,
    )
    disabled_style.border_width_bottom = 4
    add_theme_stylebox_override("disabled", disabled_style)
    add_theme_color_override("font_color", text_color)
    add_theme_color_override("font_hover_color", text_color)
    add_theme_color_override("font_pressed_color", text_color)
    add_theme_color_override("font_focus_color", text_color)
    add_theme_color_override("font_disabled_color", Tokens.TEXT_MUTED)
    add_theme_font_size_override("font_size", 15)

func _nav_style(background: Color, border: Color, selected: bool, pressed: bool) -> StyleBoxFlat:
    var style := StyleBoxFlat.new()
    style.bg_color = background
    style.border_color = border
    style.border_width_left = 4 if selected else 1
    style.border_width_top = 2 if selected else 1
    style.border_width_right = 2 if selected else 1
    style.border_width_bottom = 6 if selected else 4
    style.corner_radius_top_left = 0
    style.corner_radius_top_right = 0
    style.corner_radius_bottom_left = 0
    style.corner_radius_bottom_right = 0
    style.content_margin_left = 6.0 + (1.0 if pressed else 0.0)
    style.content_margin_right = 6.0
    style.content_margin_top = 9.0 + (1.0 if pressed else 0.0)
    style.content_margin_bottom = 9.0
    return style

func _style(
    background: Color,
    border: Color,
    width: int,
    pressed: bool = false,
) -> StyleBoxFlat:
    var style := StyleBoxFlat.new()
    style.bg_color = background
    style.border_color = border

    var left := width
    var top := width
    var right := width
    var bottom := width
    match role:
        Role.PRIMARY:
            bottom += 4
        Role.SECONDARY:
            left += 3
            bottom += 2
        Role.UTILITY:
            left += 3
            bottom += 3
        Role.DANGER_RISK:
            left += 4
            bottom += 3
        _:
            pass

    if pressed:
        top += 2
        bottom = maxi(width, bottom - 2)

    style.border_width_left = left
    style.border_width_top = top
    style.border_width_right = right
    style.border_width_bottom = bottom
    style.corner_radius_top_left = 0
    style.corner_radius_top_right = 0
    style.corner_radius_bottom_left = 0
    style.corner_radius_bottom_right = 0
    style.content_margin_left = 16.0 + (2.0 if pressed else 0.0)
    style.content_margin_right = 16.0
    style.content_margin_top = 12.0 + (2.0 if pressed else 0.0)
    style.content_margin_bottom = 12.0
    return style

func _focus_style(border: Color) -> StyleBoxFlat:
    var style := StyleBoxFlat.new()
    style.draw_center = false
    style.border_color = border
    style.border_width_left = Tokens.FOCUS_BORDER_WIDTH
    style.border_width_top = Tokens.FOCUS_BORDER_WIDTH
    style.border_width_right = Tokens.FOCUS_BORDER_WIDTH
    style.border_width_bottom = Tokens.FOCUS_BORDER_WIDTH
    style.corner_radius_top_left = Tokens.CORNER_RADIUS
    style.corner_radius_top_right = Tokens.CORNER_RADIUS
    style.corner_radius_bottom_left = Tokens.CORNER_RADIUS
    style.corner_radius_bottom_right = Tokens.CORNER_RADIUS
    style.expand_margin_left = 2.0
    style.expand_margin_top = 2.0
    style.expand_margin_right = 2.0
    style.expand_margin_bottom = 2.0
    return style
