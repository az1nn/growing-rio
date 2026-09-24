extends SceneTree

const TEST_SEED := 20260923
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()

    if not state.set_narrative_flag("lore_final_form_debate_seen"):
        _fail("Could not prepare final-form debate state.")
        return

    var rng_before_rejection := state.rng.state
    var rejected: Dictionary = state.select_ending("ending_marca_nacional")
    if bool(rejected.get("changed", false)):
        _fail("Ineligible ending selection was accepted.")
        return
    if not state.selected_ending_id.is_empty():
        _fail("Rejected selection mutated canonical ending state.")
        return
    if state.rng.state != rng_before_rejection:
        _fail("Rejected ending selection consumed RNG.")
        return

    state.cash = 300
    state.reputation = 5.0
    state.buyer_relationships["varejista_licenciado"] = 1.0

    if not state.eligible_ending_ids().has("ending_marca_nacional"):
        _fail("Marca Nacional fixture did not become eligible.")
        return

    var rng_before_selection := state.rng.state
    var selected: Dictionary = state.select_ending("ending_marca_nacional")
    if not bool(selected.get("changed", false)):
        _fail("Eligible ending selection was rejected.")
        return
    if state.selected_ending_id != "ending_marca_nacional":
        _fail("Selected ending ID was not persisted in GameState.")
        return
    if state.rng.state != rng_before_selection:
        _fail("Ending selection consumed RNG.")
        return

    var second: Dictionary = state.select_ending("ending_rede_viva")
    if bool(second.get("changed", false)):
        _fail("A second ending selection replaced the immutable first choice.")
        return
    if state.selected_ending_id != "ending_marca_nacional":
        _fail("Immutable ending selection changed after a second request.")
        return

    var save_data: Dictionary = state.create_save_data()
    if int(save_data.get("schema_version", -1)) != 11:
        _fail("Ending selection did not produce schema-v11 save data.")
        return
    var campaign: Dictionary = save_data.get("campaign", {})
    if String(campaign.get("selected_ending_id", "")) != "ending_marca_nacional":
        _fail("Schema v11 did not persist selected_ending_id.")
        return

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(save_data):
        _fail("Valid schema-v11 ending-selection save was rejected.")
        return
    if restored.selected_ending_id != "ending_marca_nacional":
        _fail("Schema-v11 round-trip lost selected ending.")
        return

    var legacy_v10: Dictionary = save_data.duplicate(true)
    legacy_v10["schema_version"] = 10
    var legacy_campaign: Dictionary = Dictionary(legacy_v10["campaign"]).duplicate(true)
    legacy_campaign.erase("selected_ending_id")
    legacy_v10["campaign"] = legacy_campaign

    var migrated := GAME_STATE_SCRIPT.new()
    root.add_child(migrated)
    if not migrated.load_save_data(legacy_v10):
        _fail("Valid schema-v10 fixture was rejected by v11 code.")
        return
    if not migrated.selected_ending_id.is_empty():
        _fail("Schema-v10 migration invented an ending selection.")
        return
    if migrated.narrative_flags != state.narrative_flags:
        _fail("Schema-v10 migration did not preserve campaign flags.")
        return

    var invalid: Dictionary = save_data.duplicate(true)
    var invalid_campaign: Dictionary = Dictionary(invalid["campaign"]).duplicate(true)
    invalid_campaign["selected_ending_id"] = "ending_unknown"
    invalid["campaign"] = invalid_campaign

    var rejected_save := GAME_STATE_SCRIPT.new()
    root.add_child(rejected_save)
    if rejected_save.load_save_data(invalid):
        _fail("Unknown persisted ending ID was accepted.")
        return

    print("ACT V ENDING SELECTION TEST PASSED")
    print("selected=", state.selected_ending_id)
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
