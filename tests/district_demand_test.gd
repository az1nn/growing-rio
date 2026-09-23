extends SceneTree

const TEST_SEED := 4404
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const CITY_SERVICE := preload("res://domain/city/city_service.gd")
const ORLA := preload("res://resources/districts/orla_vigia.tres")
const MORRO := preload("res://resources/districts/morro_cedro.tres")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var service := CITY_SERVICE.new()
    var catalog := {
        String(MORRO.id): MORRO,
        String(ORLA.id): ORLA,
    }
    var demand := service.initial_demand(catalog)
    if not is_equal_approx(float(demand["district_morro_cedro"]), 55.0):
        _fail("Morro do Cedro base demand regressed.")
        return
    if not is_equal_approx(float(demand["district_orla_vigia"]), 70.0):
        _fail("Orla da Vigia base demand regressed.")
        return

    var advanced := service.advance_day(demand, catalog, 1)
    if not is_equal_approx(float(advanced["district_morro_cedro"]), 50.0):
        _fail("Deterministic Morro demand transition regressed.")
        return
    if not is_equal_approx(float(advanced["district_orla_vigia"]), 75.0):
        _fail("Deterministic Orla demand transition regressed.")
        return

    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()

    if state.district_count() != 7:
        _fail("Canonical district catalog is incomplete.")
        return
    if state.active_district_id != "district_morro_cedro":
        _fail("Default district is not Morro do Cedro.")
        return
    if state.select_district("unknown_district"):
        _fail("Unknown district was accepted.")
        return
    if not state.select_district("district_orla_vigia"):
        _fail("Known district could not be selected.")
        return
    if not is_equal_approx(state.current_demand(), 70.0):
        _fail("Selected district demand is not exposed.")
        return

    state.next_day()
    if not is_equal_approx(state.current_demand(), 75.0):
        _fail("Selected district demand did not advance deterministically.")
        return
    _prepare_inventory(state, 2, 0.80)
    var cash_before := state.cash
    state.sell_legal()
    if state.cash != cash_before + 66:
        _fail("District demand delta did not modify licensed sale pricing.")
        return

    state.reset()
    state.next_day()
    if not is_equal_approx(
        float(state.district_demand["district_orla_vigia"]),
        75.0,
    ):
        _fail("GameState did not advance district demand deterministically.")
        return

    print("DISTRICT DEMAND TEST PASSED")
    quit(0)

func _prepare_inventory(state: Node, units: int, quality: float) -> void:
    var room: Dictionary = state.rooms[0]
    var cultivation: Dictionary = room["cultivation"]
    cultivation["inventory"] = units
    cultivation["batch_quality"] = quality
    room["cultivation"] = cultivation
    state.rooms[0] = room
    state._sync_active_room_cache()

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
