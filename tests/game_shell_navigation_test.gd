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

    var shortcut_destinations := {
        KEY_1: "operation",
        KEY_2: "market",
        KEY_3: "city",
        KEY_4: "institutional",
        KEY_5: "archive",
    }
    for keycode in shortcut_destinations:
        if not shell.handle_destination_shortcut(int(keycode)):
            _fail("3D capture shortcut was rejected: %s" % keycode)
            return
        if shell.current_destination != String(shortcut_destinations[keycode]):
            _fail("3D capture shortcut selected the wrong destination.")
            return
    if shell.handle_destination_shortcut(KEY_6):
        _fail("Shell accepted an undefined destination shortcut.")
        return
    if game_state.create_save_data() != canonical_before:
        _fail("Destination shortcuts mutated canonical campaign state or RNG.")
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

    if not game_state.complete_narrative_arc("arc_o_quarto"):
        _fail("Could not establish the narrative interruption prerequisite arc.")
        return
    for flag_id in [
        "contact_char_dalva",
        "introduced_char_lucia",
        "memory_onda_can_received",
    ]:
        if not game_state.set_narrative_flag(flag_id):
            _fail("Could not establish narrative interruption prerequisite: %s" % flag_id)
            return

    await process_frame
    if not String(shell.active_overlay_id).begins_with("narrative:"):
        _fail("Available narrative event did not interrupt through the shell overlay.")
        return
    if shell.current_destination != "city":
        _fail("Narrative interruption did not preserve the prior destination.")
        return
    if shell.get_node("%OverlayChoices").get_child_count() == 0:
        _fail("Narrative overlay did not render canonical choices.")
        return
    if shell.handle_back_request():
        _fail("Unresolved narrative interruption was dismissible through back.")
        return
    if shell.navigate_to("archive"):
        _fail("Navigation remained active while narrative interruption owned input.")
        return

    var narrative_choice := shell.get_node("%OverlayChoices").get_child(0) as Button
    if narrative_choice == null:
        _fail("Narrative overlay choice is not a Button.")
        return
    narrative_choice.pressed.emit()
    await process_frame

    if game_state.completed_event_ids.is_empty():
        _fail("Narrative overlay did not resolve through canonical GameState.")
        return
    if shell.overlay_requires_resolution:
        _fail("Resolved narrative overlay remained locked.")
        return
    if not shell.get_node("%OverlayCloseButton").visible:
        _fail("Resolved narrative overlay did not expose the return action.")
        return
    if shell.get_node("%OverlayResult").text.find("Limites:") == -1:
        _fail("Narrative overlay lost canonical guardrail presentation.")
        return

    if not shell.close_overlay():
        _fail("Resolved narrative overlay could not return to prior context.")
        return
    if shell.current_destination != "city":
        _fail("Narrative resolution did not return to the exact prior destination.")
        return

    if not shell.navigate_to("archive"):
        _fail("Could not open Archive after narrative resolution.")
        return
    await process_frame
    if shell.get_node("%ArchiveSurface").get_node("%CompletedNarrativeList").get_child_count() == 0:
        _fail("Resolved narrative material was not archived.")
        return

    print("GAME SHELL NAVIGATION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
