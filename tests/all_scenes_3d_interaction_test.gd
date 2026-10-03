extends SceneTree

const GENERIC_SCENE := preload("res://scenes/visual/interactive_context_3d.tscn")
const OPERATION_DIORAMA := preload("res://scenes/visual/operation_diorama.tscn")

var _activation_events: Array[String] = []

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene_paths: Array[String] = []
    _collect_scene_paths("res://scenes", scene_paths)
    scene_paths.sort()
    if scene_paths.is_empty():
        _fail("Feature 010 audit found no Godot scenes.")
        return

    for scene_path in scene_paths:
        var packed := load(scene_path) as PackedScene
        if packed == null:
            _fail("Feature 010 could not load %s." % scene_path)
            return
        var instance := packed.instantiate()
        root.add_child(instance)
        await process_frame

        if _find_nodes_by_class(instance, "Node3D").is_empty():
            _fail("Feature 010 scene has no runtime Node3D subtree: %s" % scene_path)
            return
        if _find_nodes_by_class(instance, "Camera3D").is_empty():
            _fail("Feature 010 scene has no Camera3D: %s" % scene_path)
            return
        if _find_nodes_by_class(instance, "WorldEnvironment").is_empty():
            _fail("Feature 010 scene has no WorldEnvironment: %s" % scene_path)
            return
        if _find_nodes_by_class(instance, "Light3D").is_empty():
            _fail("Feature 010 scene has no 3D light: %s" % scene_path)
            return
        if _find_nodes_by_class(instance, "MeshInstance3D").is_empty():
            _fail("Feature 010 scene has no visible 3D geometry contract: %s" % scene_path)
            return
        if _find_nodes_by_class(instance, "Area3D").is_empty():
            _fail("Feature 010 scene has no clickable 3D object: %s" % scene_path)
            return
        if _find_nodes_by_class(instance, "CollisionShape3D").is_empty():
            _fail("Feature 010 scene clickable object has no collision shape: %s" % scene_path)
            return
        if _find_nodes_by_class(instance, "Button").is_empty():
            _fail("Feature 010 scene has no accessible button interaction: %s" % scene_path)
            return

        instance.queue_free()
        await process_frame

    if scene_paths.size() < 10:
        _fail("Feature 010 expected the complete scene inventory, got %d scenes." % scene_paths.size())
        return

    if not await _prove_interaction(GENERIC_SCENE, "shell"):
        return
    if not await _prove_interaction(OPERATION_DIORAMA, "operation"):
        return

    print("ALL SCENES 3D INTERACTION TEST PASSED: %d/%d scenes" % [scene_paths.size(), scene_paths.size()])
    quit(0)

func _prove_interaction(packed: PackedScene, expected_context: String) -> bool:
    var scene = packed.instantiate()
    root.add_child(scene)
    await process_frame
    if not scene.has_method("has_pointer_interaction") or not scene.has_pointer_interaction():
        _fail("Feature 010 %s scene has no live pointer-picking contract." % expected_context)
        return false
    if not scene.has_method("has_accessible_button_fallback") or not scene.has_accessible_button_fallback():
        _fail("Feature 010 %s scene has no accessible button fallback." % expected_context)
        return false
    scene.object_activated.connect(_on_object_activated)
    scene.activate_primary_object()
    await process_frame
    if not _activation_events.has(expected_context):
        _fail("Feature 010 %s interaction did not emit activation." % expected_context)
        return false
    scene.queue_free()
    await process_frame
    return true

func _collect_scene_paths(directory_path: String, output: Array[String]) -> void:
    if directory_path.begins_with("res://scenes/ui"):
        return
    var directory := DirAccess.open(directory_path)
    if directory == null:
        return
    directory.list_dir_begin()
    var entry := directory.get_next()
    while not entry.is_empty():
        if entry != "." and entry != "..":
            var path := directory_path.path_join(entry)
            if directory.current_is_dir():
                _collect_scene_paths(path, output)
            elif entry.ends_with(".tscn"):
                output.append(path)
        entry = directory.get_next()
    directory.list_dir_end()

func _find_nodes_by_class(node: Node, type_name: String) -> Array[Node]:
    var matches: Array[Node] = []
    if node.is_class(type_name):
        matches.append(node)
    for child in node.get_children():
        matches.append_array(_find_nodes_by_class(child, type_name))
    return matches

func _on_object_activated(context_id: String, _object_id: String) -> void:
    _activation_events.append(context_id)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
