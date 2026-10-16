extends Control
## R06 modular SVG 2.5D foundation. Unmounted until real ARTIST/CENA sprites exist.
## The native Godot semantic hotspots and accessible action buttons remain external.

@export_file("*.json") var manifest_path: String = "res://assets/city/v1/svg25d/layers.json"
@export var probe_distance_px: Vector2 = Vector2(18.0, 12.0)
var _layers: Array[Dictionary] = []

func _ready() -> void:
    mouse_filter = Control.MOUSE_FILTER_IGNORE
    clip_contents = true
    texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
    if FileAccess.file_exists(manifest_path):
        load_manifest()

func load_manifest() -> bool:
    if not FileAccess.file_exists(manifest_path):
        return false
    var raw: Variant = JSON.parse_string(FileAccess.get_file_as_string(manifest_path))
    if typeof(raw) != TYPE_DICTIONARY:
        push_error("R06 2.5D manifest must be a JSON object.")
        return false
    var data: Dictionary = raw
    var rows: Variant = data.get("layers", [])
    if typeof(rows) != TYPE_ARRAY or rows.is_empty():
        push_error("R06 2.5D manifest requires real sprite layers.")
        return false
    var checked: Array[Dictionary] = []
    var seen: Dictionary = {}
    var prev_depth := -1.0
    for row_variant in rows:
        if typeof(row_variant) != TYPE_DICTIONARY:
            return false
        var row: Dictionary = row_variant
        var asset_id := String(row.get("id", ""))
        var path := String(row.get("path", ""))
        var coords: Variant = row.get("rect", [])
        var depth := float(row.get("depth", -1))
        if asset_id.is_empty() or seen.has(asset_id):
            push_error("R06 SVG sprite IDs must be unique.")
            return false
        seen[asset_id] = true
        if not path.begins_with("res://assets/city/v1/svg25d/source/") or not path.ends_with(".svg") or not ResourceLoader.exists(path):
            push_error("R06 SVG sprite missing original imported SVG: " + path)
            return false
        if typeof(coords) != TYPE_ARRAY or coords.size() != 4 or depth < prev_depth or depth > 1.0:
            push_error("R06 SVG layout or back-to-front ordering invalid.")
            return false
        var rect := Rect2(float(coords[0]), float(coords[1]), float(coords[2]), float(coords[3]))
        if rect.size.x <= 0.0 or rect.size.y <= 0.0:
            return false
        var texture := load(path) as Texture2D
        if texture == null:
            return false
        checked.append({"id": asset_id, "rect": rect, "texture": texture, "depth": depth})
        prev_depth = depth
    for item in _layers:
        var old_sprite := item["node"] as TextureRect
        if is_instance_valid(old_sprite):
            old_sprite.queue_free()
    _layers.clear()
    for item in checked:
        var sprite := TextureRect.new()
        sprite.name = String(item["id"])
        sprite.texture = item["texture"] as Texture2D
        sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
        sprite.mouse_filter = Control.MOUSE_FILTER_IGNORE
        sprite.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
        sprite.stretch_mode = TextureRect.STRETCH_SCALE
        var rect: Rect2 = item["rect"]
        sprite.anchor_left = rect.position.x
        sprite.anchor_top = rect.position.y
        sprite.anchor_right = rect.position.x + rect.size.x
        sprite.anchor_bottom = rect.position.y + rect.size.y
        add_child(sprite)
        _layers.append({"node": sprite, "depth": item["depth"]})
    return true

func set_parallax_probe(offset: Vector2) -> void:
    var normalized := Vector2(clampf(offset.x, -1.0, 1.0), clampf(offset.y, -1.0, 1.0))
    for item in _layers:
        var sprite := item["node"] as TextureRect
        var movement := normalized * probe_distance_px * float(item["depth"])
        sprite.offset_left = movement.x
        sprite.offset_right = movement.x
        sprite.offset_top = movement.y
        sprite.offset_bottom = movement.y
