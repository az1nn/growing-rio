extends SceneTree

const MAIN_SCENE := preload("res://scenes/main/main.tscn")
const EVENT := preload("res://resources/events/dalva_lucia_primeiro_depoimento.tres")
const EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const CHOICE_ID := "choice_dalva_lucia_parallel_versions"

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    GameState.reset()

    if EVENT.display_title != "O primeiro depoimento":
        _fail("Narrative event presentation title is missing from the Resource.")
        return
    if EVENT.body_text.is_empty():
        _fail("Narrative event presentation body is empty.")
        return
    if EVENT.choice_labels.size() != EVENT.choice_ids.size():
        _fail("Narrative event choice labels are incomplete.")
        return

    if not GameState.complete_narrative_arc("arc_o_quarto"):
        _fail("Could not complete the canonical prerequisite arc.")
        return
    for flag_id in [
        "contact_char_dalva",
        "introduced_char_lucia",
        "memory_onda_can_received",
    ]:
        if not GameState.set_narrative_flag(flag_id):
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

    if not GameState.completed_event_ids.has(EVENT_ID):
        _fail("UI choice did not resolve through canonical GameState.")
        return
    if not bool(
        GameState.narrative_flags.get(
            "lore_dalva_lucia_symbol_order_disputed",
            false,
        )
    ):
        _fail("UI choice lost the canonical unresolved-dispute flag.")
        return
    if not bool(GameState.narrative_flags.get(CHOICE_ID, false)):
        _fail("UI choice did not persist the selected choice flag.")
        return
    if not GameState.available_narrative_event_ids().is_empty():
        _fail("Completed event remained available after UI resolution.")
        return
    if choices.get_child_count() != 0:
        _fail("Narrative choices remained interactive after completion.")
        return
    if result.text.find("divergência preservada") == -1:
        _fail("Presentation did not render persisted narrative completion state.")
        return
    if result.text.find("pesquisa") == -1 or result.text.find("memória") == -1:
        _fail("Presentation did not render returned semantic system signals.")
        return

    print("NARRATIVE PRESENTATION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
