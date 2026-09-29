extends SceneTree

const FINALE_DIORAMA := preload("res://scenes/visual/finale_diorama.tscn")

var _activation_context := ""
var _activation_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene = FINALE_DIORAMA.instantiate()
    root.add_child(scene)
    await process_frame

    var required_paths := [
        "ViewportContainer/Viewport/World/Camera3D",
        "ViewportContainer/Viewport/World/WorldEnvironment",
        "ViewportContainer/Viewport/World/KeyLight",
        "ViewportContainer/Viewport/World/CodaLight",
        "ViewportContainer/Viewport/World/EndingOptions/OptionA",
        "ViewportContainer/Viewport/World/EndingOptions/OptionB",
        "ViewportContainer/Viewport/World/EndingOptions/OptionC",
        "ViewportContainer/Viewport/World/Tableau/TableauCore",
        "ViewportContainer/Viewport/World/TableauInteraction/CollisionShape3D",
        "ObjectActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("CENA-016 Finale diorama missing required node: %s" % path)
            return

    if not scene.has_pointer_interaction():
        _fail("CENA-016 Finale diorama lost pointer/touch picking.")
        return
    if not scene.has_accessible_button_fallback():
        _fail("CENA-016 Finale diorama lost accessible button fallback.")
        return
    if not scene.has_equal_selection_weight():
        _fail("CENA-016 Finale selection alternatives lost equal visual weight.")
        return

    for phase_id in ["selection", "handoff", "coda", "recap"]:
        if not scene.set_phase(phase_id):
            _fail("CENA-016 Finale diorama rejected valid phase: %s" % phase_id)
            return
    if scene.set_phase("unknown"):
        _fail("CENA-016 Finale diorama accepted an unknown presentation phase.")
        return

    var source := FileAccess.get_file_as_string("res://scenes/visual/finale_diorama.gd")
    for forbidden in [
        "/root/GameState",
        "eligible_ending_ids",
        "ending_presentation",
        "choose_finale_path",
        "finish_finale",
        "selected_ending_id",
        "save_campaign(",
        "load_campaign(",
        "advance_day(",
        "inventory",
        "rng",
        "narrative_flags",
    ]:
        if source.contains(forbidden):
            _fail("CENA-016 presentation-only diorama gained forbidden domain reference: %s" % forbidden)
            return

    scene.object_activated.connect(_on_object_activated)
    scene.activate_primary_object()
    await process_frame
    if _activation_context != "finale" or _activation_object != "tableau":
        _fail("CENA-016 interaction did not emit finale/tableau.")
        return

    var mesh_count := _count_nodes_by_class(scene, "MeshInstance3D")
    if mesh_count < 16:
        _fail("CENA-016 Finale composition regressed below authored geometry floor: %d meshes." % mesh_count)
        return

    print("FINALE 3D DIORAMA TEST PASSED: %d MeshInstance3D nodes" % mesh_count)
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
