extends SceneTree

const TEST_SEED := 4404
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const OPERATION_SCENE := preload("res://scenes/operation/operation_surface.tscn")

var game_state

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)

    _prepare_state()

    var operation := OPERATION_SCENE.instantiate()
    root.add_child(operation)
    await process_frame

    operation._on_management_pressed()
    await process_frame

    var management_panel: PanelContainer = operation.get_node("%ManagementPanel")
    if not management_panel.visible:
        _fail("Management panel did not open from the Operation surface.")
        return

    var before: Dictionary = game_state.management_snapshot()
    if Array(before.get("rooms", [])).size() != 2:
        _fail("Management snapshot did not expose both canonical room instances.")
        return
    if int(before.get("daily_operating_cost", -1)) != 40:
        _fail("Initial management operating cost did not match canonical room costs.")
        return
    if not _entry_action_enabled(before, "rooms", "instance_id", "room_2"):
        _fail("Second room was not selectable before the room-switch transition.")
        return
    if not _entry_action_enabled(before, "staff", "id", "assistente_operacional"):
        _fail("Affordable staff was not presented as available.")
        return
    if not _entry_action_enabled(before, "upgrades", "id", "sensores_basicos"):
        _fail("Affordable upgrade was not presented as available.")
        return

    operation._on_room_selected("room_2")
    operation._on_staff_hire("assistente_operacional")
    operation._on_upgrade_purchase("sensores_basicos")
    await process_frame

    var through_surface: Dictionary = game_state.create_save_data().duplicate(true)
    if game_state.active_room_id != "room_2":
        _fail("Room selection did not reach canonical GameState.")
        return
    if game_state.daily_operating_cost() != 49:
        _fail("Operating cost did not reflect room/staff/upgrade transitions.")
        return
    if not is_equal_approx(game_state.health_stability_modifier(), 0.05):
        _fail("Management stability modifier diverged from canonical domain data.")
        return

    operation._refresh_management()
    var summary_label: Label = operation.get_node("%ManagementSummaryLabel")
    if not summary_label.text.contains("R$49"):
        _fail("Management summary did not surface the canonical operating cost.")
        return

    var after: Dictionary = game_state.management_snapshot()
    if _entry_action_enabled(after, "staff", "id", "assistente_operacional"):
        _fail("Owned staff remained actionable in the management snapshot.")
        return
    if _entry_state(after, "staff", "id", "assistente_operacional") != "owned":
        _fail("Owned staff was not presented with owned state.")
        return
    if _entry_action_enabled(after, "upgrades", "id", "sensores_basicos"):
        _fail("Owned upgrade remained actionable in the management snapshot.")
        return
    if _entry_state(after, "upgrades", "id", "sensores_basicos") != "owned":
        _fail("Owned upgrade was not presented with owned state.")
        return

    _prepare_state()
    if not game_state.switch_active_room("room_2"):
        _fail("Could not prepare canonical room-switch comparison.")
        return
    if not game_state.hire_staff("assistente_operacional"):
        _fail("Could not prepare canonical staff comparison.")
        return
    if not game_state.purchase_upgrade("sensores_basicos"):
        _fail("Could not prepare canonical upgrade comparison.")
        return

    var direct_commands: Dictionary = game_state.create_save_data().duplicate(true)
    if through_surface != direct_commands:
        _fail("Management surface transitions diverged from direct canonical commands.")
        return

    var saved: Dictionary = direct_commands.duplicate(true)
    game_state.reset()
    if not game_state.load_save_data(saved):
        _fail("RB-04 canonical management state failed save/load restore.")
        return
    if game_state.create_save_data() != saved:
        _fail("RB-04 management state did not round-trip through save schema v11.")
        return

    print("MANAGEMENT SURFACE TEST PASSED")
    quit(0)

func _prepare_state() -> void:
    game_state.set_simulation_seed(TEST_SEED)
    game_state.reset()
    game_state.cash = 1000
    if not game_state.add_room("room_2", "sala_compacta"):
        _fail("Could not add the existing compact-room definition for the fixture.")

func _entry_action_enabled(
    snapshot: Dictionary,
    collection_key: String,
    id_key: String,
    target_id: String,
) -> bool:
    for entry_value in Array(snapshot.get(collection_key, [])):
        var entry: Dictionary = entry_value
        if String(entry.get(id_key, "")) != target_id:
            continue
        return bool(Dictionary(entry.get("action", {})).get("enabled", false))
    return false

func _entry_state(
    snapshot: Dictionary,
    collection_key: String,
    id_key: String,
    target_id: String,
) -> String:
    for entry_value in Array(snapshot.get(collection_key, [])):
        var entry: Dictionary = entry_value
        if String(entry.get(id_key, "")) == target_id:
            return String(entry.get("state", ""))
    return ""

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
