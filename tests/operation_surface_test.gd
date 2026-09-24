extends SceneTree

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

    game_state.reset()
    game_state.set_simulation_seed(3303)

    var operation := OPERATION_SCENE.instantiate()
    root.add_child(operation)
    await process_frame

    var availability: Dictionary = game_state.cultivation_action_availability()
    if operation.get_node("%CareButton").disabled == bool(
        Dictionary(availability["care"]).get("enabled", false)
    ):
        _fail("Care button state diverged from canonical availability.")
        return
    if operation.get_node("%HarvestButton").disabled == bool(
        Dictionary(availability["harvest"]).get("enabled", false)
    ):
        _fail("Harvest button state diverged from canonical availability.")
        return

    var initial_snapshot: Dictionary = game_state.create_save_data().duplicate(true)
    operation._on_harvest_pressed()
    if game_state.create_save_data() != initial_snapshot:
        _fail("Blocked harvest mutated canonical state.")
        return
    if not operation.get_node("%FeedbackLabel").text.contains("ainda não está pronto"):
        _fail("Blocked harvest did not expose canonical domain feedback.")
        return

    game_state.reset()
    game_state.set_simulation_seed(3303)
    operation._on_care_pressed()
    var through_surface: Dictionary = game_state.create_save_data().duplicate(true)

    game_state.reset()
    game_state.set_simulation_seed(3303)
    game_state.care_for_room()
    var direct_command: Dictionary = game_state.create_save_data().duplicate(true)

    if through_surface != direct_command:
        _fail("Operation surface care action diverged from the canonical command.")
        return

    availability = game_state.cultivation_action_availability()
    if bool(Dictionary(availability["care"]).get("enabled", true)):
        _fail("Care remained available after canonical care transition.")
        return

    print("OPERATION SURFACE TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
