extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

const CONTRACTS := [
    {
        "context": "archive",
        "path": "res://scenes/visual/archive_diorama.tscn",
        "primary_id": "evidence_desk",
        "secondary_id": "archive_wall",
        "secondary_method": "activate_history_object",
    },
    {
        "context": "city",
        "path": "res://scenes/visual/city_diorama.tscn",
        "primary_id": "district_overlook",
        "secondary_id": "community_cluster",
        "secondary_method": "activate_community_object",
    },
    {
        "context": "institutional",
        "path": "res://scenes/visual/institutional_diorama.tscn",
        "primary_id": "proposal_row",
        "secondary_id": "compliance_archive",
        "secondary_method": "activate_compliance_object",
    },
    {
        "context": "market",
        "path": "res://scenes/visual/market_diorama.tscn",
        "primary_id": "deal_counter",
        "secondary_id": "contract_tray",
        "secondary_method": "activate_contract_object",
    },
    {
        "context": "operation",
        "path": "res://scenes/visual/operation_diorama.tscn",
        "primary_id": "plant_cluster",
        "secondary_id": "management_storage",
        "secondary_method": "activate_management_object",
    },
]

var game_state
var _activation_events: Array[Dictionary] = []

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)

    game_state.reset()
    game_state.set_simulation_seed(1108)

    for contract_value in CONTRACTS:
        var contract: Dictionary = contract_value
        if not await _audit_contract(contract):
            return

    print(
        "FEATURE 011 SEMANTIC 3D HOTSPOTS TEST PASSED: %d canonical surfaces"
        % CONTRACTS.size()
    )
    quit(0)

func _audit_contract(contract: Dictionary) -> bool:
    var context_id := String(contract["context"])
    var scene_path := String(contract["path"])
    var secondary_method := String(contract["secondary_method"])

    if not ResourceLoader.exists(scene_path):
        _fail("%s: missing diorama scene %s." % [context_id, scene_path])
        return false

    var packed := load(scene_path) as PackedScene
    if packed == null:
        _fail("%s: could not load %s." % [context_id, scene_path])
        return false

    var scene := packed.instantiate()
    root.add_child(scene)
    await process_frame

    for required_method in [
        "activate_primary_object",
        secondary_method,
        "has_pointer_interaction",
        "has_secondary_pointer_interaction",
        "has_accessible_button_fallback",
        "has_secondary_accessible_button_fallback",
    ]:
        if not scene.has_method(required_method):
            _fail("%s: missing method %s." % [context_id, required_method])
            return false

    if not scene.has_signal("object_activated"):
        _fail("%s: missing object_activated signal." % context_id)
        return false

    if not bool(scene.call("has_pointer_interaction")):
        _fail("%s: primary pointer/touch hotspot is inactive." % context_id)
        return false
    if not bool(scene.call("has_secondary_pointer_interaction")):
        _fail("%s: secondary pointer/touch hotspot is inactive." % context_id)
        return false
    if not bool(scene.call("has_accessible_button_fallback")):
        _fail("%s: primary accessible fallback is inactive." % context_id)
        return false
    if not bool(scene.call("has_secondary_accessible_button_fallback")):
        _fail("%s: secondary accessible fallback is inactive." % context_id)
        return false

    if _find_nodes_by_class(scene, "Area3D").size() < 2:
        _fail("%s: fewer than two runtime 3D hit areas." % context_id)
        return false
    if _find_nodes_by_class(scene, "Button").size() < 2:
        _fail("%s: fewer than two accessible button fallbacks." % context_id)
        return false

    var before: Dictionary = game_state.create_save_data().duplicate(true)
    _activation_events.clear()
    scene.connect(
        "object_activated",
        Callable(self, "_on_object_activated"),
    )

    scene.call("activate_primary_object")
    await process_frame
    scene.call(secondary_method)
    await process_frame

    if _activation_events.size() != 2:
        _fail(
            "%s: expected exactly two semantic activation events, got %d."
            % [context_id, _activation_events.size()]
        )
        return false

    var primary_event: Dictionary = _activation_events[0]
    var secondary_event: Dictionary = _activation_events[1]
    if (
        String(primary_event.get("context", "")) != context_id
        or String(primary_event.get("object", "")) != String(contract["primary_id"])
    ):
        _fail(
            "%s: primary stable id drifted to %s/%s."
            % [
                context_id,
                String(primary_event.get("context", "")),
                String(primary_event.get("object", "")),
            ]
        )
        return false
    if (
        String(secondary_event.get("context", "")) != context_id
        or String(secondary_event.get("object", "")) != String(contract["secondary_id"])
    ):
        _fail(
            "%s: secondary stable id drifted to %s/%s."
            % [
                context_id,
                String(secondary_event.get("context", "")),
                String(secondary_event.get("object", "")),
            ]
        )
        return false

    if String(contract["primary_id"]) == String(contract["secondary_id"]):
        _fail("%s: semantic hotspot identifiers are not distinct." % context_id)
        return false

    var after: Dictionary = game_state.create_save_data().duplicate(true)
    if after != before:
        _fail("%s: presentation-only hotspot activation mutated canonical state." % context_id)
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
    _activation_events.append({
        "context": context_id,
        "object": object_id,
    })

func _fail(message: String) -> void:
    push_error("Feature 011 semantic 3D hotspot validation failed — %s" % message)
    quit(1)
