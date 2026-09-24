extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const OPERATION_SCENE := preload("res://scenes/operation/operation_surface.tscn")

var game_state
var management_request_count := 0

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
    for action_id in ["care", "advance_day", "harvest"]:
        var button_name: String = str({
            "care": "%CareButton",
            "advance_day": "%NextDayButton",
            "harvest": "%HarvestButton",
        }[action_id])
        var button: Button = operation.get_node(button_name)
        var enabled := bool(Dictionary(availability[action_id]).get("enabled", false))
        if button.disabled == enabled:
            _fail("%s button state diverged from canonical availability." % action_id)
            return

    var initial_snapshot: Dictionary = game_state.create_save_data().duplicate(true)
    operation._on_harvest_pressed()
    if game_state.create_save_data() != initial_snapshot:
        _fail("Blocked harvest mutated canonical state.")
        return
    if not operation.get_node("%FeedbackLabel").text.contains("ainda não está pronto"):
        _fail("Blocked harvest did not expose canonical domain feedback.")
        return

    operation.management_requested.connect(_on_management_requested)
    var before_management: Dictionary = game_state.create_save_data().duplicate(true)
    operation._on_management_pressed()
    if management_request_count != 1:
        _fail("RB-04 management handoff signal was not emitted exactly once.")
        return
    if game_state.create_save_data() != before_management:
        _fail("RB-04 management handoff mutated canonical state.")
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

    game_state.reset()
    game_state.set_simulation_seed(3303)
    operation._on_next_day_pressed()
    through_surface = game_state.create_save_data().duplicate(true)

    game_state.reset()
    game_state.set_simulation_seed(3303)
    game_state.next_day()
    direct_command = game_state.create_save_data().duplicate(true)

    if through_surface != direct_command:
        _fail("Operation surface next-day action diverged from the canonical command.")
        return

    game_state.reset()
    game_state.set_simulation_seed(3303)
    game_state.cash = 10000
    var cycle_days: int = int(game_state.current_cycle_days())
    for _day in range(cycle_days):
        operation._on_next_day_pressed()
    availability = game_state.cultivation_action_availability()
    if not bool(Dictionary(availability["harvest"]).get("enabled", false)):
        _fail("Harvest did not become canonically available after the cycle completed.")
        return
    operation._on_harvest_pressed()
    through_surface = game_state.create_save_data().duplicate(true)

    game_state.reset()
    game_state.set_simulation_seed(3303)
    game_state.cash = 10000
    cycle_days = int(game_state.current_cycle_days())
    for _day in range(cycle_days):
        game_state.next_day()
    game_state.harvest()
    direct_command = game_state.create_save_data().duplicate(true)

    if through_surface != direct_command:
        _fail("Operation surface harvest flow diverged from canonical commands.")
        return

    print("OPERATION SURFACE TEST PASSED")
    quit(0)

func _on_management_requested() -> void:
    management_request_count += 1

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
