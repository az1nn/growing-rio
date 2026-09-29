extends SceneTree

const INSTITUTIONAL_DIORAMA := preload("res://scenes/visual/institutional_diorama.tscn")

var _activation_context := ""
var _activation_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene = INSTITUTIONAL_DIORAMA.instantiate()
    root.add_child(scene)
    await process_frame

    var required_paths := [
        "ViewportContainer/Viewport/World/Camera3D",
        "ViewportContainer/Viewport/World/WorldEnvironment",
        "ViewportContainer/Viewport/World/CoolForumKey",
        "ViewportContainer/Viewport/World/CoolForumRim",
        "ViewportContainer/Viewport/World/WarmForumPractical",
        "ViewportContainer/Viewport/World/Architecture/ForumFloor",
        "ViewportContainer/Viewport/World/ParticipationDesk/DeskBase",
        "ViewportContainer/Viewport/World/Proposals/ProposalA",
        "ViewportContainer/Viewport/World/Proposals/ProposalB",
        "ViewportContainer/Viewport/World/Proposals/ProposalC",
        "ViewportContainer/Viewport/World/ArchiveWall/ArchiveA",
        "ViewportContainer/Viewport/World/ProposalRowInteraction/CollisionShape3D",
        "ObjectActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("CENA-012 Institutional diorama missing required node: %s" % path)
            return

    var viewport_container := scene.get_node("ViewportContainer") as Control
    if viewport_container.anchor_right - viewport_container.anchor_left < 0.85:
        _fail("CENA-012 Institutional 3D viewport is not wide enough for player-visible framing.")
        return
    if viewport_container.anchor_bottom - viewport_container.anchor_top < 0.30:
        _fail("CENA-012 Institutional 3D viewport is not tall enough for player-visible framing.")
        return

    if not scene.has_pointer_interaction():
        _fail("CENA-012 Institutional diorama lost pointer/touch picking.")
        return
    if not scene.has_accessible_button_fallback():
        _fail("CENA-012 Institutional diorama lost accessible button fallback.")
        return

    var proposal_a := scene.get_node("ViewportContainer/Viewport/World/Proposals/ProposalA") as MeshInstance3D
    var proposal_b := scene.get_node("ViewportContainer/Viewport/World/Proposals/ProposalB") as MeshInstance3D
    var proposal_c := scene.get_node("ViewportContainer/Viewport/World/Proposals/ProposalC") as MeshInstance3D
    if (
        not proposal_a.scale.is_equal_approx(proposal_b.scale)
        or not proposal_b.scale.is_equal_approx(proposal_c.scale)
        or proposal_a.material_override != proposal_b.material_override
        or proposal_b.material_override != proposal_c.material_override
    ):
        _fail("CENA-012 proposal objects lost equal scale/material treatment.")
        return

    if (
        not is_zero_approx(proposal_b.position.x)
        or not is_equal_approx(absf(proposal_a.position.x), absf(proposal_c.position.x))
    ):
        _fail("CENA-012 proposal spacing is no longer symmetric.")
        return

    var source := FileAccess.get_file_as_string("res://scenes/visual/institutional_diorama.gd")
    for forbidden in ["/root/GameState", "enact_policy(", "civic_engagement(", "advance_compliance("]:
        if source.contains(forbidden):
            _fail("CENA-012 presentation-only diorama gained forbidden domain mutation reference: %s" % forbidden)
            return

    scene.object_activated.connect(_on_object_activated)
    scene.activate_primary_object()
    await process_frame
    if _activation_context != "institutional" or _activation_object != "proposal_row":
        _fail("CENA-012 interaction did not emit the canonical institutional/proposal_row activation.")
        return

    var mesh_count := _count_nodes_by_class(scene, "MeshInstance3D")
    if mesh_count < 30:
        _fail("CENA-012 Institutional composition regressed below the authored geometry floor: %d meshes." % mesh_count)
        return

    print("INSTITUTIONAL 3D DIORAMA TEST PASSED: %d MeshInstance3D nodes" % mesh_count)
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
