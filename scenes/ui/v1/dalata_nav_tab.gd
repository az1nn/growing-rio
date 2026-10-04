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

    draw_line(Vector2(10.0, 5.0), Vector2(size.x - 10.0, 5.0), UITokens.NEON_MINT, 2.4, true)
    draw_line(Vector2(10.0, size.y - 6.0), Vector2(size.x - 10.0, size.y - 6.0), UITokens.CYAN_SYSTEM, 2.4, true)
    draw_line(Vector2(8.0, 8.0), Vector2(8.0, 20.0), UITokens.NEON_MINT, 2.0, true)
    draw_line(Vector2(8.0, 8.0), Vector2(20.0, 8.0), UITokens.NEON_MINT, 2.0, true)

func _draw_destination_icon(color: Color) -> void:
    var id := String(semantic_action_id)
    var c := Vector2(32.0, size.y * 0.5)
    var s := clampf(size.y / 64.0, 0.95, 1.35)

    if id.ends_with("operation"):
        draw_line(c + Vector2(-11, 9) * s, c + Vector2(-11, -9) * s, color, 2.4, true)
        draw_line(c + Vector2(-11, 9) * s, c + Vector2(11, 9) * s, color, 2.4, true)
        draw_polyline(PackedVector2Array([c + Vector2(-9, 4) * s, c + Vector2(-3, -2) * s, c + Vector2(2, 1) * s, c + Vector2(10, -8) * s]), color, 2.6, true)
    elif id.ends_with("market"):
        draw_line(c + Vector2(-11, -8) * s, c + Vector2(-7, 6) * s, color, 2.6, true)
        draw_line(c + Vector2(-9, -5) * s, c + Vector2(11, -5) * s, color, 2.6, true)
        draw_line(c + Vector2(-7, 6) * s, c + Vector2(8, 6) * s, color, 2.6, true)
        draw_circle(c + Vector2(-3, 11) * s, 2.2 * s, color, true, -1.0, true)
        draw_circle(c + Vector2(8, 11) * s, 2.2 * s, color, true, -1.0, true)
    elif id.ends_with("city"):
        draw_circle(c + Vector2(0, -4) * s, 8.0 * s, color, false, 2.5, true)
        draw_circle(c + Vector2(0, -4) * s, 2.5 * s, color, true, -1.0, true)
        draw_line(c + Vector2(-5, 2) * s, c + Vector2(0, 12) * s, color, 2.5, true)
        draw_line(c + Vector2(5, 2) * s, c + Vector2(0, 12) * s, color, 2.5, true)
    elif id.ends_with("institutional"):
        draw_polyline(PackedVector2Array([c + Vector2(-12,-5) * s, c + Vector2(0,-12) * s, c + Vector2(12,-5) * s]), color, 2.4, true)
        for x in [-8.0, 0.0, 8.0]:
            draw_line(c + Vector2(x,-3) * s, c + Vector2(x,9) * s, color, 2.4, true)
        draw_line(c + Vector2(-12,10) * s, c + Vector2(12,10) * s, color, 2.4, true)
    elif id.ends_with("archive"):
        draw_rect(Rect2(c + Vector2(-12,-6) * s, Vector2(24,16) * s), color, false, 2.4, true)
        draw_polyline(PackedVector2Array([c + Vector2(-11,-6) * s, c + Vector2(-5,-11) * s, c + Vector2(3,-11) * s, c + Vector2(7,-6) * s]), color, 2.4, true)
