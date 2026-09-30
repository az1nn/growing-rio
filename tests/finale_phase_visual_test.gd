extends SceneTree

const FINALE_SCENE := preload("res://scenes/visual/finale_diorama.tscn")
const PHASES := ["selection", "handoff", "coda", "recap"]

var _last_context := ""
var _last_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene = FINALE_SCENE.instantiate()
    root.add_child(scene)
    await process_frame

    var expected_primary := {
        "selection": "crossroads",
        "handoff": "departure_marker",
        "coda": "legacy_symbol",
        "recap": "results_monitor",
    }
    var expected_action := {
        "selection": "Inspecionar cruzamento",
        "handoff": "Inspecionar travessia",
        "coda": "Inspecionar legado",
        "recap": "Inspecionar resultados",
    }
    var minimum_meshes := {
        "selection": 10,
        "handoff": 8,
        "coda": 8,
        "recap": 6,
    }

    var camera := scene.get_node("ViewportContainer/Viewport/World/Camera3D") as Camera3D
    var action_button := scene.get_node("ObjectActionButton") as Button
    if camera == null or action_button == null:
        _fail("Finale phase controls are missing.")
        return

    scene.object_activated.connect(_on_object_activated)
    var camera_positions: Dictionary = {}
    var camera_sizes: Dictionary = {}

    for phase_id in PHASES:
        if not scene.set_phase(phase_id):
            _fail("Finale rejected canonical phase: %s" % phase_id)
            return
        if scene.current_phase_visual_id() != phase_id:
            _fail("Finale visual id did not follow phase: %s" % phase_id)
            return
        if scene.visible_phase_count() != 1:
            _fail("Finale must expose exactly one visible phase group: %s" % phase_id)
            return

        var phase_root := scene.phase_root(phase_id)
        if phase_root == null or not phase_root.visible:
            _fail("Expected phase root is not visible: %s" % phase_id)
            return
        for other_id in PHASES:
            if other_id == phase_id:
                continue
            var other_root := scene.phase_root(other_id)
            if other_root == null or other_root.visible:
                _fail("Non-active phase leaked into %s: %s" % [phase_id, other_id])
                return

        var mesh_count := _count_meshes(phase_root)
        if mesh_count < int(minimum_meshes[phase_id]):
            _fail(
                "Phase %s has only %d meshes; expected a distinct composed scene."
                % [phase_id, mesh_count]
            )
            return

        if scene.current_primary_object_id() != String(expected_primary[phase_id]):
            _fail("Primary object did not change for phase: %s" % phase_id)
            return
        if action_button.text != String(expected_action[phase_id]):
            _fail("Accessible action did not change for phase: %s" % phase_id)
            return

        _last_context = ""
        _last_object = ""
        scene.activate_primary_object()
        await process_frame
        if _last_context != "finale":
            _fail("Phase activation lost finale context: %s" % phase_id)
            return
        if _last_object != String(expected_primary[phase_id]):
            _fail("Phase activation emitted the wrong object id: %s" % phase_id)
            return

        camera_positions[phase_id] = camera.position
        camera_sizes[phase_id] = camera.size

    for left_index in range(PHASES.size()):
        for right_index in range(left_index + 1, PHASES.size()):
            var left_id := PHASES[left_index]
            var right_id := PHASES[right_index]
            if (
                Vector3(camera_positions[left_id]).is_equal_approx(Vector3(camera_positions[right_id]))
                and is_equal_approx(
                    float(camera_sizes[left_id]),
                    float(camera_sizes[right_id]),
                )
            ):
                _fail(
                    "Finale phases reused the same camera composition: %s / %s"
                    % [left_id, right_id]
                )
                return

    if not scene.set_phase("selection") or not scene.has_equal_selection_weight():
        _fail("Selection phase lost equal visual weight across the three paths.")
        return

    if scene.set_phase("unknown"):
        _fail("Finale accepted an unknown visual phase.")
        return

    print("CENA-018 FINALE PHASE VISUAL TEST PASSED")
    quit(0)

func _count_meshes(node: Node) -> int:
    var count := 1 if node is MeshInstance3D else 0
    for child in node.get_children():
        count += _count_meshes(child)
    return count

func _on_object_activated(context_id: String, object_id: String) -> void:
    _last_context = context_id
    _last_object = object_id

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
