extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const SHELL_SCENE := preload("res://scenes/shell/game_shell.tscn")

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
    game_state.set_simulation_seed(2202)

    var shell := SHELL_SCENE.instantiate()
    root.add_child(shell)
    await process_frame

    var expected_destinations := [
        "operation",
        "market",
        "city",
        "institutional",
        "archive",
    ]
    if shell.destination_ids() != expected_destinations:
        _fail("Shell destination IDs diverged from the RB-01 contract.")
        return

    var canonical_before: Dictionary = game_state.create_save_data().duplicate(true)

    for destination_id in expected_destinations:
        if not shell.navigate_to(destination_id):
            _fail("Could not navigate to canonical destination: %s" % destination_id)
            return
        if shell.current_destination != destination_id:
            _fail("Shell did not retain the selected presentation destination.")
            return
        if game_state.create_save_data() != canonical_before:
            _fail("Top-level navigation mutated canonical campaign state or RNG.")
            return

    if shell.navigate_to("not-a-destination"):
        _fail("Shell accepted an unknown destination ID.")
        return
    if game_state.create_save_data() != canonical_before:
        _fail("Rejected navigation mutated canonical campaign state.")
        return

    if not shell.navigate_to("city"):
        _fail("Could not establish overlay return context.")
        return
    if not shell.open_overlay(
        "test-overlay",
        "Teste de overlay",
        "Contexto temporário de apresentação.",
    ):
        _fail("Could not open the presentation overlay.")
        return
    if not shell.get_node("%OverlayHost").visible:
        _fail("Overlay host did not become visible.")
        return
    if shell.navigate_to("market"):
        _fail("Top-level navigation remained active while overlay owned input.")
        return
    if shell.current_destination != "city":
        _fail("Overlay changed the return destination.")
        return
    if game_state.create_save_data() != canonical_before:
        _fail("Opening an overlay mutated canonical campaign state or RNG.")
        return

    if not shell.handle_back_request():
        _fail("Back did not close the active overlay.")
        return
    if not shell.active_overlay_id.is_empty():
        _fail("Overlay ID remained active after back.")
        return
    if shell.get_node("%OverlayHost").visible:
        _fail("Overlay remained visible after back.")
        return
    if shell.current_destination != "city":
        _fail("Back did not return to the exact pre-overlay destination.")
        return
    if shell.handle_back_request():
        _fail("Back at a surface root should defer to the platform.")
        return
    if game_state.create_save_data() != canonical_before:
        _fail("Overlay/back flow mutated canonical campaign state or RNG.")
        return

    shell.apply_layout_for_size(Vector2(540, 960))
    if not shell.get_node("%PortraitNav").visible:
        _fail("Portrait navigation is not visible in a portrait viewport.")
        return
    if shell.get_node("%WideNav").visible:
        _fail("Wide navigation should be hidden in a portrait viewport.")
        return

    shell.apply_layout_for_size(Vector2(1280, 720))
    if shell.get_node("%PortraitNav").visible:
        _fail("Portrait navigation should be hidden in a wide viewport.")
        return
    if not shell.get_node("%WideNav").visible:
        _fail("Wide navigation rail is not visible in a wide viewport.")
        return
    if game_state.create_save_data() != canonical_before:
        _fail("Responsive layout switching mutated canonical campaign state or RNG.")
        return

    print("GAME SHELL NAVIGATION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
