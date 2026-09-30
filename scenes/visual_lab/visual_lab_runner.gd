extends Control

const SCENES := {
    "operation": "res://scenes/visual/operation_diorama.tscn",
    "market": "res://scenes/visual/market_diorama.tscn",
    "city": "res://scenes/visual/city_diorama.tscn",
    "institutional": "res://scenes/visual/institutional_diorama.tscn",
    "archive": "res://scenes/visual/archive_diorama.tscn",
    "campaign": "res://scenes/visual/campaign_diorama.tscn",
    "narrative": "res://scenes/visual/narrative_diorama.tscn",
    "finale-selection": "res://scenes/visual/finale_diorama.tscn",
    "finale-handoff": "res://scenes/visual/finale_diorama.tscn",
    "finale-coda": "res://scenes/visual/finale_diorama.tscn",
    "finale-recap": "res://scenes/visual/finale_diorama.tscn",
}

@onready var scene_host: Control = $SceneHost
@onready var title_label: Label = $CaptureChrome/Title

var mounted_scene: Node
var orbit_camera: Camera3D
var orbit_target := Vector3.ZERO
var orbit_radius := 1.0
var orbit_height := 0.0
var orbit_angle := 0.0
var orbit_enabled := false


func _ready() -> void:
    var scene_id := _query_param("scene")
    if scene_id.is_empty():
        scene_id = "operation"
    if not SCENES.has(scene_id):
        _fail("unknown scene id: %s" % scene_id)
        return

    var packed := load(String(SCENES[scene_id])) as PackedScene
    if packed == null:
        _fail("could not load scene: %s" % String(SCENES[scene_id]))
        return

    mounted_scene = packed.instantiate()
    scene_host.add_child(mounted_scene)
    if mounted_scene is Control:
        var mounted_control := mounted_scene as Control
        mounted_control.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

    var phase := _query_param("phase")
    if phase.is_empty() and scene_id.begins_with("finale-"):
        phase = scene_id.trim_prefix("finale-")
    if not phase.is_empty():
        if not mounted_scene.has_method("set_phase"):
            _fail("%s does not support phase %s" % [scene_id, phase])
            return
        if not bool(mounted_scene.call("set_phase", phase)):
            _fail("%s rejected phase %s" % [scene_id, phase])
            return

    title_label.text = "LENTE • %s" % scene_id
    if _query_param("chrome") != "on":
        $CaptureChrome.visible = false

    await get_tree().process_frame
    await get_tree().process_frame

    var focus_name := _query_param("focus")
    if not focus_name.is_empty():
        if not _focus_mesh(focus_name):
            _fail("mesh not found for focus: %s" % focus_name)
            return

    if _query_param("motion") == "orbit":
        _prepare_orbit()

    _set_ready(scene_id, phase, focus_name)


func _process(delta: float) -> void:
    if not orbit_enabled or orbit_camera == null:
        return
    orbit_angle += delta * 0.42
    orbit_camera.global_position = orbit_target + Vector3(
        cos(orbit_angle) * orbit_radius,
        orbit_height,
        sin(orbit_angle) * orbit_radius,
    )
    orbit_camera.look_at(orbit_target, Vector3.UP)


func _focus_mesh(mesh_name: String) -> bool:
    var meshes := _find_nodes_by_class(mounted_scene, "MeshInstance3D")
    var target: MeshInstance3D
    for node in meshes:
        var mesh_node := node as MeshInstance3D
        if mesh_node.name == mesh_name:
            target = mesh_node
        else:
            mesh_node.visible = false

    if target == null:
        for node in meshes:
            (node as MeshInstance3D).visible = true
        return false

    target.visible = true
    var cameras := _find_nodes_by_class(mounted_scene, "Camera3D")
    if cameras.is_empty():
        return true

    var camera := cameras[0] as Camera3D
    var local_aabb := target.get_aabb()
    var center := target.global_transform * local_aabb.get_center()
    var scale := target.global_transform.basis.get_scale().abs()
    var max_scale: float = max(scale.x, max(scale.y, scale.z))
    var radius: float = max(0.45, local_aabb.size.length() * max_scale * 0.55)
    var direction := (camera.global_position - center).normalized()
    if direction.length() < 0.1:
        direction = Vector3(1.0, 0.65, 1.0).normalized()

    if camera.projection == Camera3D.PROJECTION_ORTHOGONAL:
        camera.size = max(1.4, radius * 2.8)
        camera.global_position = center + direction * max(radius * 3.0, 2.5)
    else:
        camera.global_position = center + direction * max(radius * 3.5, 2.5)
    camera.look_at(center, Vector3.UP)
    return true


func _prepare_orbit() -> void:
    var cameras := _find_nodes_by_class(mounted_scene, "Camera3D")
    var meshes := _find_nodes_by_class(mounted_scene, "MeshInstance3D")
    if cameras.is_empty() or meshes.is_empty():
        return

    orbit_camera = cameras[0] as Camera3D
    var center_sum := Vector3.ZERO
    var visible_count := 0
    for node in meshes:
        var mesh_node := node as MeshInstance3D
        if not mesh_node.visible:
            continue
        center_sum += mesh_node.global_position
        visible_count += 1

    if visible_count == 0:
        return

    orbit_target = center_sum / float(visible_count)
    var offset := orbit_camera.global_position - orbit_target
    orbit_radius = max(1.0, Vector2(offset.x, offset.z).length())
    orbit_height = offset.y
    orbit_angle = atan2(offset.z, offset.x)
    orbit_enabled = true


func _find_nodes_by_class(node: Node, type_name: String) -> Array[Node]:
    var matches: Array[Node] = []
    if node.is_class(type_name):
        matches.append(node)
    for child in node.get_children():
        matches.append_array(_find_nodes_by_class(child, type_name))
    return matches


func _query_param(name: String) -> String:
    if OS.has_feature("web"):
        return String(
            JavaScriptBridge.eval(
                "new URLSearchParams(window.location.search).get(%s) || ''"
                % JSON.stringify(name)
            )
        )

    for arg in OS.get_cmdline_user_args():
        var prefix := "--%s=" % name
        if arg.begins_with(prefix):
            return arg.trim_prefix(prefix)
    return ""


func _set_ready(scene_id: String, phase: String, focus_name: String) -> void:
    var metadata := {
        "scene": scene_id,
        "phase": phase,
        "focus": focus_name,
        "motion": _query_param("motion"),
    }
    if OS.has_feature("web"):
        JavaScriptBridge.eval(
            "window.__DALATA_VISUAL_LAB_READY__ = %s; "
            % JSON.stringify(scene_id)
            + "window.__DALATA_VISUAL_LAB_META__ = %s;"
            % JSON.stringify(metadata)
        )
    print("VISUAL_LAB:READY:%s" % scene_id)


func _fail(message: String) -> void:
    push_error("LENTE visual lab failed — %s" % message)
    if OS.has_feature("web"):
        JavaScriptBridge.eval(
            "window.__DALATA_VISUAL_LAB_ERROR__ = %s"
            % JSON.stringify(message)
        )
