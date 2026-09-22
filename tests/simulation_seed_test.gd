extends SceneTree

const TEST_SEED := 1337
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)

    var first := _simulate_cycle(state)
    var second := _simulate_cycle(state)

    if first != second:
        push_error("Deterministic simulation failed: snapshots differ.")
        print("first=", first)
        print("second=", second)
        quit(1)
        return

    if state.active_cultivar.id != &"quarto_classica":
        push_error("Default cultivar resource was not loaded.")
        quit(1)
        return

    print("SIMULATION SEED TEST PASSED")
    print("snapshot=", first)
    quit(0)

func _simulate_cycle(state: Node) -> Array:
    state.reset()

    for index in range(state.current_cycle_days()):
        if index % 2 == 0:
            state.care_for_room()
        state.next_day()

    state.harvest()

    return [
        state.day,
        state.cash,
        state.heat,
        state.reputation,
        state.influence,
        state.inventory,
        state.batch_quality,
        state.grow_health,
    ]
