extends SceneTree

const NARRATIVE_DIORAMA := preload("res://scenes/visual/narrative_diorama.tscn")

var _activation_context := ""
var _activation_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene = NARRATIVE_DIORAMA.instantiate()
    root.add_child(scene)
    await process_frame

    var required_paths := [
        "ViewportContainer/Viewport/World/Camera3D",
        "ViewportContainer/Viewport/World/WorldEnvironment",
        "ViewportContainer/Viewport/World/KeyLight",
        "ViewportContainer/Viewport/World/MemoryLamp",
        "ViewportContainer/Viewport/World/EvidenceTable/EvidenceCard",
        "ViewportContainer/Viewport/World/MemoryWall/Board",
        "ViewportContainer/Viewport/World/EvidenceTableInteraction/CollisionShape3D",
        "ObjectActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("CENA-015 Narrative diorama missing required node: %s" % path)
            return

    if not scene.has_pointer_interaction():
        _fail("CENA-015 Narrative diorama lost pointer/touch picking.")
        return
    if not scene.has_accessible_button_fallback():
        _fail("CENA-015 Narrative diorama lost accessible button fallback.")
        return

    var source := FileAccess.get_file_as_string("res://scenes/visual/narrative_diorama.gd")
    for forbidden in [
        "/root/GameState",
        "archive_surface",
        "resolve_narrative_choice",
        "narrative_flags",
        "complete_narrative",
        "save_campaign(",
        "load_campaign(",
        "advance_day(",
        "inventory",
        "rng",
        "finale",
    ]:
        if source.contains(forbidden):
            _fail("CENA-015 presentation-only diorama gained forbidden domain reference: %s" % forbidden)
            return

    scene.object_activated.connect(_on_object_activated)
    scene.activate_primary_object()
    await process_frame
    if _activation_context != "narrative" or _activation_object != "evidence_table":
        _fail("CENA-015 interaction did not emit narrative/evidence_table.")
        return

    var mesh_count := _count_nodes_by_class(scene, "MeshInstance3D")
    if mesh_count < 18:
        _fail("CENA-015 Narrative composition regressed below authored geometry floor: %d meshes." % mesh_count)
        return

    print("NARRATIVE 3D DIORAMA TEST PASSED: %d MeshInstance3D nodes" % mesh_count)
    quit(0)

func _count_nodes_by_class(node: Node, type_name: String) -> int:
    var total := 1 if node.is_class(type_name) else 0
    for child in node.get_children():
        total += _count_nodes_by_class(child, type_name)
    return total

func _on_object_activated(context_id: String, object_id: String) -> void:
    _activation_context = context_id
    _activation_object = object_id

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
