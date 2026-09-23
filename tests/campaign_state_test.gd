extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const SAVE_SERVICE := preload("res://autoload/save_service.gd")
const EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const CHOICE_ID := "choice_dalva_lucia_parallel_versions"

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.reset()

    if state.narrative_event_count() != 1:
        _fail("GameState did not expose the canonical narrative event catalog.")
        return
    if not state.available_narrative_event_ids().is_empty():
        _fail("Narrative event became available before its canonical gates.")
        return
    if state.complete_narrative_arc("arc_unknown"):
        _fail("Unknown narrative arc was accepted.")
        return
    if state.set_narrative_flag("flag_unknown"):
        _fail("Unknown narrative flag was accepted.")
        return

    if not state.complete_narrative_arc("arc_o_quarto"):
        _fail("Canonical prerequisite arc could not be completed.")
        return
    for flag_id in [
        "contact_char_dalva",
        "introduced_char_lucia",
        "memory_onda_can_received",
    ]:
        if not state.set_narrative_flag(flag_id):
            _fail("Canonical prerequisite flag was rejected: %s" % flag_id)
            return

    if state.available_narrative_event_ids() != [EVENT_ID]:
        _fail("Canonical event did not become available through GameState.")
        return

    var unknown := state.resolve_narrative_choice("event_unknown", CHOICE_ID)
    if bool(unknown.get("changed", false)):
        _fail("Unknown narrative event mutated campaign state.")
        return

    var resolved := state.resolve_narrative_choice(EVENT_ID, CHOICE_ID)
    if not bool(resolved.get("changed", false)):
        _fail("Canonical narrative choice did not resolve through GameState.")
        return
    if state.completed_event_ids != [EVENT_ID]:
        _fail("GameState did not persist the completed event ID.")
        return
    if not bool(state.narrative_flags.get(
        "lore_dalva_lucia_symbol_order_disputed",
        false,
    )):
        _fail("GameState lost the canonical lore dispute flag.")
        return
    if not bool(state.narrative_flags.get(CHOICE_ID, false)):
        _fail("GameState lost the selected narrative choice flag.")
        return
    if not state.available_narrative_event_ids().is_empty():
        _fail("Completed narrative event remained available.")
        return

    var save_data: Dictionary = state.create_save_data()
    if int(save_data.get("schema_version", -1)) != 10:
        _fail("Campaign integration did not produce save schema v10.")
        return
    var campaign: Dictionary = save_data.get("campaign", {})
    if campaign.get("completed_arc_ids", []) != state.completed_arc_ids:
        _fail("Save v10 lost completed narrative arcs.")
        return
    if campaign.get("completed_event_ids", []) != state.completed_event_ids:
        _fail("Save v10 lost completed narrative events.")
        return
    if campaign.get("narrative_flags", {}) != state.narrative_flags:
        _fail("Save v10 lost narrative flags.")
        return

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(save_data):
        _fail("Valid campaign save v10 was rejected.")
        return
    if restored.completed_arc_ids != state.completed_arc_ids:
        _fail("Completed narrative arcs did not round-trip.")
        return
    if restored.completed_event_ids != state.completed_event_ids:
        _fail("Completed narrative events did not round-trip.")
        return
    if restored.narrative_flags != state.narrative_flags:
        _fail("Narrative flags did not round-trip.")
        return

    var invalid_event := save_data.duplicate(true)
    invalid_event["campaign"]["completed_event_ids"] = ["event_unknown"]
    var rejected_event := GAME_STATE_SCRIPT.new()
    root.add_child(rejected_event)
    if rejected_event.load_save_data(invalid_event):
        _fail("Unknown saved narrative event ID was accepted.")
        return

    var invalid_flag := save_data.duplicate(true)
    invalid_flag["campaign"]["narrative_flags"] = {"flag_unknown": true}
    var rejected_flag := GAME_STATE_SCRIPT.new()
    root.add_child(rejected_flag)
    if rejected_flag.load_save_data(invalid_flag):
        _fail("Unknown saved narrative flag ID was accepted.")
        return

    var service := SAVE_SERVICE.new()
    var legacy_v9 := service.create_v9(
        _base_state(state),
        state.rooms,
        state.active_room_id,
        state.hired_staff_ids,
        state.owned_upgrade_ids,
        state.buyer_relationships,
        state.active_contract_id,
        state.compliance_level,
        state.active_district_id,
        state.district_demand,
        state.institution_level,
        state.enacted_policy_ids,
        state.community_support,
        state.simulation_seed,
        state.rng.state,
    )
    var migrated := GAME_STATE_SCRIPT.new()
    root.add_child(migrated)
    if not migrated.load_save_data(legacy_v9):
        _fail("Legacy save v9 was rejected by v10 code.")
        return
    if (
        not migrated.completed_arc_ids.is_empty()
        or not migrated.completed_event_ids.is_empty()
        or not migrated.narrative_flags.is_empty()
    ):
        _fail("Legacy save v9 did not migrate to empty campaign state.")
        return

    print("CAMPAIGN STATE TEST PASSED")
    quit(0)

func _base_state(state: Node) -> Dictionary:
    return {
        "day": state.day,
        "cash": state.cash,
        "heat": state.heat,
        "reputation": state.reputation,
        "influence": state.influence,
        "game_over": state.game_over,
    }

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
