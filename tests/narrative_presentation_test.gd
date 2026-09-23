extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const MAIN_SCENE := preload("res://scenes/main/main.tscn")
const EVENT := preload("res://resources/events/dalva_lucia_primeiro_depoimento.tres")
const EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const CHOICE_ID := "choice_dalva_lucia_parallel_versions"

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

    if EVENT.display_title != "O primeiro depoimento":
        _fail("Narrative event presentation title is missing from the Resource.")
        return
    if EVENT.body_text.is_empty():
        _fail("Narrative event presentation body is empty.")
        return
    if EVENT.choice_labels.size() != EVENT.choice_ids.size():
        _fail("Narrative event choice labels are incomplete.")
        return
    var presentation := game_state.narrative_event_presentation(EVENT_ID)
    if presentation.is_empty():
        _fail("GameState did not expose generic narrative presentation metadata.")
        return
    if presentation.get("display_title", "") != EVENT.display_title:
        _fail("Generic narrative presentation lost the Resource title.")
        return

    if not game_state.complete_narrative_arc("arc_o_quarto"):
        _fail("Could not complete the canonical prerequisite arc.")
        return
    for flag_id in [
        "contact_char_dalva",
        "introduced_char_lucia",
        "memory_onda_can_received",
    ]:
        if not game_state.set_narrative_flag(flag_id):
            _fail("Could not set canonical prerequisite flag: %s" % flag_id)
            return

    var main := MAIN_SCENE.instantiate()
    root.add_child(main)
    await process_frame

    var title: Label = main.get_node("%NarrativeTitle")
    var body: Label = main.get_node("%NarrativeBody")
    var choices: VBoxContainer = main.get_node("%NarrativeChoices")
    var result: Label = main.get_node("%NarrativeResult")

    if title.text != EVENT.display_title:
        _fail("Main scene did not render the Resource-backed event title.")
        return
    if body.text != EVENT.body_text:
        _fail("Main scene did not render the Resource-backed event body.")
        return
    if choices.get_child_count() != EVENT.choice_ids.size():
        _fail("Main scene did not render all canonical narrative choices.")
        return

    var first_button := choices.get_child(0) as Button
    if first_button == null:
        _fail("First narrative choice is not a Button.")
        return
    if first_button.text != String(EVENT.choice_labels.get(CHOICE_ID, "")):
        _fail("Narrative choice label was not rendered from the Resource.")
        return

    first_button.pressed.emit()
    await process_frame

    if not game_state.completed_event_ids.has(EVENT_ID):
        _fail("UI choice did not resolve through canonical game_state.")
        return
    if not bool(
        game_state.narrative_flags.get(
            "lore_dalva_lucia_symbol_order_disputed",
            false,
        )
    ):
        _fail("UI choice lost the canonical unresolved-dispute flag.")
        return
    if not bool(game_state.narrative_flags.get(CHOICE_ID, false)):
        _fail("UI choice did not persist the selected choice flag.")
        return
    if not game_state.available_narrative_event_ids().is_empty():
        _fail("Completed event remained available after UI resolution.")
        return
    if choices.get_child_count() != 0:
        _fail("Narrative choices remained interactive after completion.")
        return
    if result.text.find("Limites:") == -1:
        _fail("Presentation did not render canonical guardrails.")
        return
    if result.text.find("ordem dos símbolos") == -1:
        _fail("Presentation did not render the unresolved symbol-order guardrail.")
        return
    if result.text.find("pesquisa") == -1 or result.text.find("memória") == -1:
        _fail("Presentation did not render returned semantic system signals.")
        return

    print("NARRATIVE PRESENTATION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
