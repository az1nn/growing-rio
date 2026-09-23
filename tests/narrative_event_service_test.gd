extends SceneTree

const SERVICE_SCRIPT := preload("res://domain/events/narrative_event_service.gd")
const EVENT := preload("res://resources/events/dalva_lucia_primeiro_depoimento.tres")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var service := SERVICE_SCRIPT.new()
    if not service.is_valid_definition(EVENT):
        _fail("Canonical narrative event definition is invalid.")
        return

    var base_flags := {
        "contact_char_dalva": true,
        "introduced_char_lucia": true,
        "memory_onda_can_received": true,
    }
    var completed_arcs := ["arc_o_quarto"]
    var completed_events: Array = []

    if service.is_available(EVENT, [], completed_events, base_flags):
        _fail("Narrative event ignored its arc gate.")
        return

    var missing_contact := base_flags.duplicate(true)
    missing_contact.erase("contact_char_dalva")
    if service.is_available(
        EVENT,
        completed_arcs,
        completed_events,
        missing_contact,
    ):
        _fail("Narrative event ignored a required lore flag.")
        return

    var blocked_flags := base_flags.duplicate(true)
    blocked_flags["lore_dalva_lucia_symbol_order_resolved"] = true
    if service.is_available(
        EVENT,
        completed_arcs,
        completed_events,
        blocked_flags,
    ):
        _fail("Narrative event ignored its canon guard flag.")
        return

    if not service.is_available(
        EVENT,
        completed_arcs,
        completed_events,
        base_flags,
    ):
        _fail("Narrative event did not become available after canonical gates.")
        return

    var unknown := service.resolve_choice(
        EVENT,
        "choice_unknown",
        completed_arcs,
        completed_events,
        base_flags,
    )
    if unknown["changed"]:
        _fail("Unknown narrative choice mutated state.")
        return

    for choice_id_value in EVENT.choice_ids:
        var choice_id := String(choice_id_value)
        var result := service.resolve_choice(
            EVENT,
            choice_id,
            completed_arcs,
            completed_events,
            base_flags,
        )
        if not result["changed"]:
            _fail("Canonical narrative choice failed: %s" % choice_id)
            return
        if result["event_id"] != String(EVENT.id):
            _fail("Narrative resolution returned the wrong event ID.")
            return
        if result["choice_id"] != choice_id:
            _fail("Narrative resolution returned the wrong choice ID.")
            return
        if not result["completed_event_ids"].has(String(EVENT.id)):
            _fail("Narrative resolution did not mark the event complete.")
            return
        if not bool(
            result["narrative_flags"].get(
                "lore_dalva_lucia_symbol_order_disputed",
                false,
            )
        ):
            _fail("Narrative resolution lost the canonical dispute flag.")
            return
        if not bool(result["narrative_flags"].get(choice_id, false)):
            _fail("Narrative resolution did not persist its choice flag.")
            return
        if result["narrative_flags"].has(
            "lore_dalva_lucia_symbol_order_resolved"
        ):
            _fail("Narrative resolution authenticated an open mystery.")
            return
        if Array(result["system_signals"]).is_empty():
            _fail("Narrative resolution lost abstract system signals.")
            return
        if Array(result["canon_guardrails"]).size() < 4:
            _fail("Narrative resolution lost canon guardrails.")
            return

    if base_flags.has("lore_dalva_lucia_symbol_order_disputed"):
        _fail("Narrative service mutated caller-owned flags.")
        return

    var first_result := service.resolve_choice(
        EVENT,
        "choice_dalva_lucia_parallel_versions",
        completed_arcs,
        completed_events,
        base_flags,
    )
    var replay := service.resolve_choice(
        EVENT,
        "choice_dalva_lucia_parallel_versions",
        completed_arcs,
        first_result["completed_event_ids"],
        first_result["narrative_flags"],
    )
    if replay["changed"]:
        _fail("Completed narrative event was resolved twice.")
        return

    print("NARRATIVE EVENT SERVICE TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
