extends SceneTree

const TEST_SEED := 1337

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    GameState.set_simulation_seed(TEST_SEED)
    var first := _simulate_cycle()
    var second := _simulate_cycle()

    if first != second:
        push_error("Deterministic simulation failed: snapshots differ.")
        print("first=", first)
        print("second=", second)
        quit(1)
        return

    if GameState.active_cultivar.id != &"quarto_classica":
        push_error("Default cultivar resource was not loaded.")
        quit(1)
        return

    print("SIMULATION SEED TEST PASSED")
    print("snapshot=", first)
    quit(0)

func _simulate_cycle() -> Array:
    GameState.reset()

    for index in range(GameState.current_cycle_days()):
        if index % 2 == 0:
            GameState.care_for_room()
        GameState.next_day()

    GameState.harvest()

    return [
        GameState.day,
        GameState.cash,
        GameState.heat,
        GameState.reputation,
        GameState.influence,
        GameState.inventory,
        GameState.batch_quality,
        GameState.grow_health,
    ]
