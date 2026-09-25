extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const HOST_SCENE := preload("res://scenes/visual/contextual_scene_host.tscn")

var game_state

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)

    game_state.reset()
    game_state.set_simulation_seed(1212)
    var before: Dictionary = game_state.create_save_data().duplicate(true)

    var host = HOST_SCENE.instantiate()
    root.add_child(host)
    await process_frame

    if host.current_context_id != "operation":
        _fail("RB-12 host did not mount OperationDiorama by default.")
        return
    if host.mounted_scene == null:
        _fail("RB-12 host has no mounted presentation scene.")
        return
    if host.transition_policy() != "replace":
        _fail("RB-12 transition policy is not the deterministic replace contract.")
        return
    if host.mouse_filter != Control.MOUSE_FILTER_IGNORE:
        _fail("RB-12 host captured UI input.")
        return

    var viewport_container := host.mounted_scene as SubViewportContainer
    if viewport_container == null or not viewport_container.stretch:
        _fail("RB-12 OperationDiorama stretch container contract is unavailable.")
        return
    if viewport_container.stretch_shrink != host.DEFAULT_RENDER_SHRINK:
        _fail("RB-12 default render-shrink profile diverged from the host contract.")
        return

    var viewport := host.mounted_scene.get_node_or_null("Viewport") as SubViewport
    if viewport == null:
        _fail("RB-12 OperationDiorama viewport is unavailable through the host.")
        return
    if not viewport.gui_disable_input or viewport.handle_input_locally:
        _fail("RB-12 3D viewport owns input that belongs to the UI.")
        return

    var floor := viewport.get_node_or_null("World/Floor") as MeshInstance3D
    if floor == null:
        _fail("CENA-016 foreground floor is unavailable.")
        return
    var floor_mesh := floor.mesh as BoxMesh
    if floor_mesh == null or floor_mesh.size.z < 10.5:
        _fail("CENA-016 foreground floor depth was not extended.")
        return
    if floor.position.z < 1.4:
        _fail("CENA-016 foreground floor extension moved the rear room boundary.")
        return
    if viewport.get_node_or_null("World/FloorJointForeground") == null:
        _fail("CENA-016 foreground floor joint is missing.")
        return

    var apron := viewport.get_node_or_null("World/ForegroundApron") as MeshInstance3D
    if apron == null:
        _fail("CENA-017 foreground apron transition is unavailable.")
        return
    var apron_mesh := apron.mesh as BoxMesh
    if apron_mesh == null or apron_mesh.size.z < 2.3:
        _fail("CENA-017 foreground apron does not provide the bounded transition depth.")
        return
    if apron.position.z < 8.0:
        _fail("CENA-017 foreground apron overlaps the accepted room floor instead of extending it.")
        return
    if viewport.get_node_or_null("World/ForegroundApronEdge") == null:
        _fail("CENA-017 foreground apron termination edge is missing.")
        return

    var service_plinth := viewport.get_node_or_null("World/ForegroundServicePlinth") as MeshInstance3D
    if service_plinth == null:
        _fail("CENA-018 foreground service plinth is unavailable.")
        return
    var service_plinth_mesh := service_plinth.mesh as BoxMesh
    if service_plinth_mesh == null or service_plinth_mesh.size.z < 2.7:
        _fail("CENA-018 foreground service plinth does not provide the bounded continuation depth.")
        return
    if service_plinth.position.z < 10.5:
        _fail("CENA-018 service plinth does not continue beyond the accepted apron.")
        return
    if viewport.get_node_or_null("World/ForegroundServiceRailLeft") == null:
        _fail("CENA-018 left foreground service rail is missing.")
        return
    if viewport.get_node_or_null("World/ForegroundServiceRailRight") == null:
        _fail("CENA-018 right foreground service rail is missing.")
        return
    if viewport.get_node_or_null("World/ForegroundServiceEdge") == null:
        _fail("CENA-018 foreground service terminal edge is missing.")
        return

    host.set_low_resource_mode(true)
    await process_frame
    if viewport_container.stretch_shrink != host.LOW_RESOURCE_RENDER_SHRINK:
        _fail("RB-12 low-resource render-shrink profile was not applied.")
        return

    if not host.mount_context(""):
        _fail("RB-12 optional no-diorama context was rejected.")
        return
    if not host.current_context_id.is_empty() or host.mounted_scene != null:
        _fail("RB-12 no-diorama context retained a 3D dependency.")
        return

    if host.mount_context("unknown"):
        _fail("RB-12 host accepted an unknown context.")
        return

    if not host.mount_context("operation"):
        _fail("RB-12 host could not remount the operation context.")
        return
    await process_frame

    var after: Dictionary = game_state.create_save_data().duplicate(true)
    if after != before:
        _fail("RB-12 mount/unmount/resource-profile transitions mutated canonical simulation.")
        return

    print("DIORAMA SCENE SYSTEM TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
