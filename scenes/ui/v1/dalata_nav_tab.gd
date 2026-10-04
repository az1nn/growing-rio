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
    var accent := UITokens.NEON_MINT if is_selected() else UITokens.CYAN_SYSTEM
    _draw_destination_icon(accent)

    if not is_selected():
        return

    draw_line(Vector2(10.0, 5.0), Vector2(size.x - 10.0, 5.0), UITokens.NEON_MINT, 2.0, true)
    draw_line(Vector2(10.0, size.y - 6.0), Vector2(size.x - 10.0, size.y - 6.0), UITokens.CYAN_SYSTEM, 2.0, true)
    draw_line(Vector2(8.0, 8.0), Vector2(8.0, 18.0), UITokens.NEON_MINT, 2.0, true)
    draw_line(Vector2(8.0, 8.0), Vector2(18.0, 8.0), UITokens.NEON_MINT, 2.0, true)

func _draw_destination_icon(color: Color) -> void:
    var id := String(semantic_action_id)
    var c := Vector2(18.0, size.y * 0.5)
    if id.ends_with("operation"):
        draw_line(c + Vector2(-8, 7), c + Vector2(-8, -7), color, 2.0, true)
        draw_line(c + Vector2(-8, 7), c + Vector2(8, 7), color, 2.0, true)
        draw_polyline(PackedVector2Array([c + Vector2(-6, 3), c + Vector2(-1, -2), c + Vector2(3, 0), c + Vector2(8, -7)]), color, 2.0, true)
    elif id.ends_with("market"):
        draw_line(c + Vector2(-8, -6), c + Vector2(-5, 5), color, 2.0, true)
        draw_line(c + Vector2(-6, -3), c + Vector2(8, -3), color, 2.0, true)
        draw_line(c + Vector2(-4, 5), c + Vector2(6, 5), color, 2.0, true)
        draw_circle(c + Vector2(-2, 9), 1.8, color)
        draw_circle(c + Vector2(6, 9), 1.8, color)
    elif id.ends_with("city"):
        draw_circle(c + Vector2(0, -3), 6.0, Color.TRANSPARENT, false, 2.0)
        draw_circle(c + Vector2(0, -3), 2.0, color)
        draw_line(c + Vector2(-4, 2), c + Vector2(0, 9), color, 2.0, true)
        draw_line(c + Vector2(4, 2), c + Vector2(0, 9), color, 2.0, true)
    elif id.ends_with("institutional"):
        draw_polyline(PackedVector2Array([c + Vector2(-9,-4), c + Vector2(0,-9), c + Vector2(9,-4)]), color, 2.0, true)
        for x in [-6.0, 0.0, 6.0]:
            draw_line(c + Vector2(x,-2), c + Vector2(x,7), color, 2.0, true)
        draw_line(c + Vector2(-9,8), c + Vector2(9,8), color, 2.0, true)
    elif id.ends_with("archive"):
        draw_rect(Rect2(c + Vector2(-9,-5), Vector2(18,13)), Color.TRANSPARENT, false, 2.0)
        draw_line(c + Vector2(-8,-5), c + Vector2(-3,-9), color, 2.0, true)
        draw_line(c + Vector2(-3,-9), c + Vector2(3,-9), color, 2.0, true)
        draw_line(c + Vector2(3,-9), c + Vector2(6,-5), color, 2.0, true)
