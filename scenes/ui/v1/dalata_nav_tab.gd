extends "res://scenes/ui/v1/dalata_button.gd"
class_name DalataNavTab

const UITokens = preload("res://resources/ui/v1/dalata_ui_tokens.gd")

func _ready() -> void:
    role = Role.NAVIGATION_TAB
    toggle_mode = true
    super._ready()
    queue_redraw()

func set_selected(value: bool) -> void:
    super.set_selected(value)
    queue_redraw()

func _draw() -> void:
    if not is_selected():
        return

    var notch := PackedVector2Array([
        Vector2(size.x - 22.0, 0.0),
        Vector2(size.x, 0.0),
        Vector2(size.x, 22.0),
    ])
    draw_colored_polygon(notch, UITokens.MAGENTA_EVENT)
    draw_rect(
        Rect2(Vector2(8.0, 6.0), Vector2(maxf(0.0, size.x - 30.0), 3.0)),
        UITokens.AMBER_PRIMARY,
    )
    draw_line(
        Vector2(10.0, size.y - 8.0),
        Vector2(size.x - 10.0, size.y - 8.0),
        UITokens.CYAN_SYSTEM,
        2.0,
    )
