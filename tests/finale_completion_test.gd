extends SceneTree

const TEST_SEED := 20260924
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

    game_state.set_simulation_seed(TEST_SEED)
    game_state.reset()
    if not game_state.set_narrative_flag("lore_final_form_debate_seen"):
        _fail("Could not establish final-form debate state.")
        return

    game_state.cash = 300
    game_state.reputation = 5.0
    game_state.buyer_relationships["varejista_licenciado"] = 1.0

    var eligible: Array = Array(game_state.eligible_ending_ids())
    if eligible.size() < 2:
        _fail("Finale fixture did not expose multiple eligible endings.")
        return
    for ending_id_value in eligible:
        var presentation: Dictionary = game_state.ending_presentation(String(ending_id_value))
        if presentation.is_empty():
            _fail("Eligible ending is missing data-driven presentation.")
            return

    var rng_before_ui: int = int(game_state.rng.state)
    var shell := SHELL_SCENE.instantiate()
    root.add_child(shell)
    await process_frame
    await process_frame
    await process_frame

    if shell.active_overlay_id != "finale:selection":
        _fail("Eligible endings did not open the neutral finale selector.")
        return
    var finale_diorama = shell.get_node("%FinaleDiorama")
    if not finale_diorama.visible or finale_diorama.phase_id != "selection":
        _fail("Runtime finale selector did not activate the selection 3D composition.")
        return
    if shell.get_node("%OverlayCloseButton").visible:
        _fail("Finale selection was dismissible before immutable selection.")
        return

    var selector_body := String(shell.get_node("%OverlayBody").text).to_lower()
    for forbidden in ["melhor", "vencedor", "verdadeiro final", "recomend"]:
        if selector_body.find(forbidden) != -1:
            _fail("Finale selector contains ranking/recommendation language.")
            return

    var choices := shell.get_node("%OverlayChoices")
    if choices.get_child_count() != eligible.size():
        _fail("Finale selector did not expose every eligible ending exactly once.")
        return

    var displayed_names: Array = []
    for child in choices.get_children():
        displayed_names.append(String((child as Button).text))
    var sorted_names := displayed_names.duplicate()
    sorted_names.sort()
    if displayed_names != sorted_names:
        _fail("Finale selector is not presented in neutral alphabetical order.")
        return
    if game_state.rng.state != rng_before_ui:
        _fail("Rendering finale choices consumed RNG.")
        return

    var selected_button := choices.get_child(0) as Button
    selected_button.pressed.emit()
    await process_frame

    if game_state.selected_ending_id.is_empty():
        _fail("Finale selector did not persist an immutable ending selection.")
        return
    if shell.active_overlay_id != "finale:handoff":
        _fail("Ending selection did not advance to the finale handoff.")
        return
    if not finale_diorama.visible or finale_diorama.phase_id != "handoff":
        _fail("Runtime finale handoff did not activate the handoff 3D composition.")
        return
    if game_state.finale_completed():
        _fail("Selecting an ending completed the finale before handoff confirmation.")
        return

    var selected_id := String(game_state.selected_ending_id)
    var rng_before_completion: int = int(game_state.rng.state)
    var handoff_choices := shell.get_node("%OverlayChoices")
    if handoff_choices.get_child_count() != 1:
        _fail("Finale handoff did not expose one explicit completion action.")
        return
    (handoff_choices.get_child(0) as Button).pressed.emit()
    await process_frame

    if not game_state.finale_completed():
        _fail("Finale completion did not complete arc_da_lata.")
        return
    if shell.active_overlay_id != "finale:coda":
        _fail("Completed finale did not render the selected ending coda.")
        return
    if not finale_diorama.visible or finale_diorama.phase_id != "coda":
        _fail("Runtime finale coda did not activate the coda 3D composition.")
        return
    if game_state.rng.state != rng_before_completion:
        _fail("Finale completion consumed RNG.")
        return

    var repeat: Dictionary = game_state.complete_finale()
    if bool(repeat.get("changed", false)):
        _fail("Finale completion was not idempotent.")
        return
    if not bool(repeat.get("completed", false)):
        _fail("Repeated finale completion lost completed state.")
        return
    if game_state.completed_arc_ids.count("arc_da_lata") != 1:
        _fail("arc_da_lata completion was duplicated.")
        return

    var save_data: Dictionary = game_state.create_save_data()
    if int(save_data.get("schema_version", -1)) != 11:
        _fail("RB-15 unexpectedly changed the canonical save schema.")
        return

    var restored := GAME_STATE_SCRIPT.new()
    restored.name = "RestoredGameState"
    root.add_child(restored)
    if not restored.load_save_data(save_data):
        _fail("Completed finale save did not round-trip.")
        return
    if not restored.finale_completed() or restored.selected_ending_id != selected_id:
        _fail("Save/load lost finale selection or completion.")
        return

    var canonical_after_completion: Dictionary = game_state.create_save_data().duplicate(true)
    if not shell.close_overlay():
        _fail("Completed coda could not return to the playable shell.")
        return
    if not shell.open_campaign_menu():
        _fail("Post-ending campaign menu could not be opened.")
        return

    var recap_button: Button = null
    for child in shell.get_node("%OverlayChoices").get_children():
        var button := child as Button
        if button != null and button.text == "Rever desfecho":
            recap_button = button
            break
    if recap_button == null:
        _fail("Post-ending campaign menu does not expose finale inspection.")
        return
    recap_button.pressed.emit()
    await process_frame
    if shell.active_overlay_id != "finale:recap":
        _fail("Finale recap did not open from the post-ending campaign menu.")
        return
    if not finale_diorama.visible or finale_diorama.phase_id != "recap":
        _fail("Runtime finale recap did not activate the recap 3D composition.")
        return
    if game_state.create_save_data() != canonical_after_completion:
        _fail("Inspecting the completed finale mutated canonical campaign state.")
        return

    print("RB-15 FINALE COMPLETION TEST PASSED")
    print("ending=", selected_id)
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
