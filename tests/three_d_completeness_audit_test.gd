extends SceneTree

const SURFACE_ROWS := [
    {
        "id": "operation",
        "path": "res://scenes/main/main.tscn",
        "activation_context": "",
        "phases": [],
    },
    {
        "id": "market",
        "path": "res://scenes/market/market_surface.tscn",
        "activation_context": "",
        "phases": [],
    },
    {
        "id": "city",
        "path": "res://scenes/city/city_surface.tscn",
        "activation_context": "",
        "phases": [],
    },
    {
        "id": "institutional",
        "path": "res://scenes/institutional/institutional_surface.tscn",
        "activation_context": "",
        "phases": [],
    },
    {
        "id": "archive",
        "path": "res://scenes/archive/archive_surface.tscn",
        "activation_context": "",
        "phases": [],
    },
    {
        "id": "campaign",
        "path": "res://scenes/visual/campaign_diorama.tscn",
        "activation_context": "campaign",
        "phases": [],
    },
    {
        "id": "narrative",
        "path": "res://scenes/visual/narrative_diorama.tscn",
        "activation_context": "narrative",
        "phases": [],
    },
    {
        "id": "finale",
        "path": "res://scenes/visual/finale_diorama.tscn",
        "activation_context": "finale",
        "phases": ["selection", "handoff"],
    },
    {
        "id": "coda_recap",
        "path": "res://scenes/visual/finale_diorama.tscn",
        "activation_context": "finale",
        "phases": ["coda", "recap"],
    },
]

var _activation_context := ""
var _activation_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    for row_value in SURFACE_ROWS:
        var row: Dictionary = row_value
        if not await _audit_row(row):
            return

    print(
        "CENA-017 3D COMPLETENESS AUDIT PASSED: %d canonical rows"
        % SURFACE_ROWS.size()
    )
    quit(0)

func _audit_row(row: Dictionary) -> bool:
    var row_id := String(row["id"])
    var scene_path := String(row["path"])
    if not ResourceLoader.exists(scene_path):
        _fail("%s: canonical scene does not exist: %s" % [row_id, scene_path])
        return false

    var packed := load(scene_path) as PackedScene
    if packed == null:
        _fail("%s: canonical scene could not be loaded: %s" % [row_id, scene_path])
        return false

    var scene := packed.instantiate()
    root.add_child(scene)
    await process_frame

    for class_name in [
        "Node3D",
        "Camera3D",
        "WorldEnvironment",
        "Light3D",
        "MeshInstance3D",
        "Area3D",
        "CollisionShape3D",
        "Button",
    ]:
        if _find_nodes_by_class(scene, class_name).is_empty():
            _fail("%s: missing structural 3D contract %s" % [row_id, class_name])
            return false

    if scene.has_method("has_pointer_interaction"):
        if not bool(scene.call("has_pointer_interaction")):
            _fail("%s: pointer/touch interaction contract is inactive." % row_id)
            return false

    if scene.has_method("has_accessible_button_fallback"):
        if not bool(scene.call("has_accessible_button_fallback")):
            _fail("%s: accessible button fallback is inactive." % row_id)
            return false

    var phases: Array = Array(row.get("phases", []))
    if not phases.is_empty():
        if not scene.has_method("set_phase"):
            _fail("%s: required presentation phases have no set_phase contract." % row_id)
            return false
        for phase_value in phases:
            var phase_id := String(phase_value)
            if not bool(scene.call("set_phase", phase_id)):
                _fail("%s: rejected required phase %s." % [row_id, phase_id])
                return false
        if row_id == "finale" and bool(scene.call("set_phase", "unknown")):
            _fail("finale: accepted an unknown presentation phase.")
            return false

    var expected_context := String(row.get("activation_context", ""))
    if not expected_context.is_empty():
        if not scene.has_signal("object_activated"):
            _fail("%s: missing object_activated signal." % row_id)
            return false
        if not scene.has_method("activate_primary_object"):
            _fail("%s: missing presentation-only activation method." % row_id)
            return false
        _activation_context = ""
        _activation_object = ""
        scene.connect(
            "object_activated",
            Callable(self, "_on_object_activated"),
        )
        scene.call("activate_primary_object")
        await process_frame
        if _activation_context != expected_context:
            _fail(
                "%s: activation emitted context %s instead of %s."
                % [row_id, _activation_context, expected_context]
            )
            return false
        if _activation_object.is_empty():
            _fail("%s: activation emitted an empty object id." % row_id)
            return false

    scene.queue_free()
    await process_frame
    return true

func _find_nodes_by_class(node: Node, type_name: String) -> Array[Node]:
    var matches: Array[Node] = []
    if node.is_class(type_name):
        matches.append(node)
    for child in node.get_children():
        matches.append_array(_find_nodes_by_class(child, type_name))
    return matches

func _on_object_activated(context_id: String, object_id: String) -> void:
    _activation_context = context_id
    _activation_object = object_id

func _fail(message: String) -> void:
    push_error("CENA-017 3D completeness audit failed — %s" % message)
    quit(1)
