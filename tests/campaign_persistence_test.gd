extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const CAMPAIGN_SLOT_STORE := preload("res://persistence/campaign_slot_store.gd")
const CAMPAIGN_FLOW_CONTROLLER := preload(
    "res://scenes/campaign/campaign_flow_controller.gd"
)

const TEST_ROOT := "user://rb11-campaign-persistence-test"

var game_state

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)

    var store := CAMPAIGN_SLOT_STORE.new(TEST_ROOT)
    store.delete_slot()
    var flow := CAMPAIGN_FLOW_CONTROLLER.new(game_state, store)

    game_state.reset()
    game_state.set_simulation_seed(1111)
    game_state.cash = 777
    game_state.reputation = 23.0
    var canonical: Dictionary = game_state.create_save_data().duplicate(true)

    if store.has_slot():
        _fail("Test slot unexpectedly existed after cleanup.")
        return

    var saved: Dictionary = flow.save_campaign()
    if not bool(saved.get("ok", false)):
        _fail("Current-schema campaign could not be stored: %s" % saved.get("error", ""))
        return
    if not store.has_slot():
        _fail("Stored campaign slot was not discoverable.")
        return

    var loaded: Dictionary = store.load_slot()
    if not bool(loaded.get("ok", false)):
        _fail("Stored campaign could not be read: %s" % loaded.get("error", ""))
        return
    var parsed_transport: Dictionary = game_state.save_service.parse(
        Dictionary(loaded["payload"])
    )
    if not bool(parsed_transport.get("ok", false)):
        _fail(
            "JSON-normalized stored payload no longer satisfied SaveService: %s"
            % parsed_transport.get("error", "")
        )
        return

    game_state.cash = 1234
    game_state.heat = 44.0
    var before_invalid: Dictionary = game_state.create_save_data().duplicate(true)
    var invalid_payload: Dictionary = canonical.duplicate(true)
    var invalid_business: Dictionary = Dictionary(invalid_payload["business"]).duplicate(true)
    var invalid_rooms: Array = Array(invalid_business["rooms"]).duplicate(true)
    var invalid_room: Dictionary = Dictionary(invalid_rooms[0]).duplicate(true)
    invalid_room["definition_id"] = "unknown_room_definition"
    invalid_rooms[0] = invalid_room
    invalid_business["rooms"] = invalid_rooms
    invalid_payload["business"] = invalid_business

    var invalid_saved := store.save_slot(invalid_payload)
    if not bool(invalid_saved.get("ok", false)):
        _fail("Invalid known-content fixture could not enter the storage adapter.")
        return
    var invalid_result: Dictionary = flow.load_campaign()
    if bool(invalid_result.get("ok", false)):
        _fail("Unknown content was accepted by campaign loading.")
        return
    if game_state.create_save_data() != before_invalid:
        _fail("Invalid campaign data partially mutated active state.")
        return

    if not bool(store.save_slot(canonical).get("ok", false)):
        _fail("Could not restore the valid slot after invalid-load coverage.")
        return

    var flow_load: Dictionary = flow.load_campaign()
    if not bool(flow_load.get("ok", false)):
        _fail("Current-schema campaign did not restore through campaign flow.")
        return
    if game_state.create_save_data() != canonical:
        _fail("Current-schema campaign did not round-trip exactly.")
        return

    var service = game_state.save_service
    var legacy_v10: Dictionary = service.create_v10(
        {
            "day": game_state.day,
            "cash": game_state.cash,
            "heat": game_state.heat,
            "reputation": game_state.reputation,
            "influence": game_state.influence,
            "game_over": game_state.game_over,
        },
        game_state.rooms,
        game_state.active_room_id,
        game_state.hired_staff_ids,
        game_state.owned_upgrade_ids,
        game_state.buyer_relationships,
        game_state.active_contract_id,
        game_state.compliance_level,
        game_state.active_district_id,
        game_state.district_demand,
        game_state.institution_level,
        game_state.enacted_policy_ids,
        game_state.community_support,
        game_state.completed_arc_ids,
        game_state.completed_event_ids,
        game_state.narrative_flags,
        game_state.simulation_seed,
        game_state.rng.state,
    )
    var legacy_saved := store.save_slot(legacy_v10)
    if not bool(legacy_saved.get("ok", false)):
        _fail("Legacy v10 fixture could not pass through the slot adapter.")
        return
    var legacy_loaded := store.load_slot()
    if not bool(legacy_loaded.get("ok", false)):
        _fail("Legacy v10 fixture could not be read from the slot adapter.")
        return
    var legacy_flow_load: Dictionary = flow.load_campaign()
    if not bool(legacy_flow_load.get("ok", false)):
        _fail("Legacy v10 fixture did not migrate through the campaign load path.")
        return
    if not game_state.selected_ending_id.is_empty():
        _fail("Legacy v10 migration unexpectedly restored a selected ending.")
        return

    if not bool(store.save_slot(canonical).get("ok", false)):
        _fail("Could not restore current slot before New Campaign coverage.")
        return
    var slot_before_new: Dictionary = store.load_slot()
    if not bool(slot_before_new.get("ok", false)):
        _fail("Could not snapshot the durable slot before New Campaign.")
        return

    var new_result: Dictionary = flow.start_new_campaign()
    if not bool(new_result.get("ok", false)):
        _fail("New Campaign command failed.")
        return
    if not store.has_slot():
        _fail("New Campaign deleted the durable slot.")
        return
    var slot_after_new: Dictionary = store.load_slot()
    if Dictionary(slot_after_new.get("payload", {})) != Dictionary(
        slot_before_new.get("payload", {})
    ):
        _fail("New Campaign rewrote the durable slot without confirmation.")
        return

    var corrupt_file := FileAccess.open(store.slot_path(), FileAccess.WRITE)
    if corrupt_file == null:
        _fail("Could not prepare corrupt JSON fixture.")
        return
    corrupt_file.store_string("{ definitely-not-json")
    corrupt_file.close()

    var corrupt_result: Dictionary = store.load_slot()
    if bool(corrupt_result.get("ok", false)):
        _fail("Corrupt JSON fixture was accepted.")
        return
    if String(corrupt_result.get("error", "")).is_empty():
        _fail("Corrupt JSON failure did not provide readable recovery feedback.")
        return

    store.delete_slot()
    print("CAMPAIGN PERSISTENCE TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
