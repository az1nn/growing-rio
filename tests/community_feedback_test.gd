extends SceneTree

const TEST_SEED := 230924
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const COMMUNITY_SERVICE := preload("res://domain/city/community_service.gd")
const MORRO := preload("res://resources/districts/morro_cedro.tres")
const ORLA := preload("res://resources/districts/orla_vigia.tres")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var service := COMMUNITY_SERVICE.new()
    var catalog := {
        String(MORRO.id): MORRO,
        String(ORLA.id): ORLA,
    }
    var support := service.initial_support(catalog)
    if not service.is_valid_state(support, catalog):
        _fail("Initial community support state is invalid.")
        return
    if not is_equal_approx(float(support["district_morro_cedro"]), 50.0):
        _fail("Community support did not start neutral.")
        return

    # Start this comparison away from the shared daily-step saturation point so
    # the demand contribution is observable in a single deterministic transition.
    var comparison_support := support.duplicate(true)
    comparison_support["district_morro_cedro"] = 60.0
    comparison_support["district_orla_vigia"] = 60.0
    var demand := {
        "district_morro_cedro": 80.0,
        "district_orla_vigia": 20.0,
    }
    var advanced := service.advance_day(
        comparison_support,
        30.0,
        1,
        demand,
        catalog,
    )
    if float(advanced["district_morro_cedro"]) <= float(advanced["district_orla_vigia"]):
        _fail("District demand stopped contributing to community feedback.")
        return
    if (
        float(advanced["district_morro_cedro"]) > 100.0
        or float(advanced["district_orla_vigia"]) < 0.0
    ):
        _fail("Community support left its bounded range.")
        return

    if not is_equal_approx(
        service.reputation_delta({"district_morro_cedro": 100.0}, "district_morro_cedro"),
        0.25,
    ):
        _fail("Positive community feedback to Reputation regressed.")
        return
    if not is_equal_approx(
        service.reputation_delta({"district_morro_cedro": 0.0}, "district_morro_cedro"),
        -0.25,
    ):
        _fail("Negative community feedback to Reputation regressed.")
        return

    var invalid := support.duplicate(true)
    invalid["district_unknown"] = 50.0
    if service.is_valid_state(invalid, catalog):
        _fail("Unknown community district state was accepted.")
        return

    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()

    var snapshot: Dictionary = state.community_snapshot()
    if String(snapshot.get("active_district_id", "")) != state.active_district_id:
        _fail("Community snapshot diverged from the active district.")
        return
    if not is_equal_approx(
        float(snapshot.get("support", -1.0)),
        state.current_community_support(),
    ):
        _fail("Community snapshot support diverged from canonical support.")
        return
    if not is_equal_approx(float(snapshot.get("reputation", -1.0)), state.reputation):
        _fail("Community snapshot did not expose global Reputation separately.")
        return

    if state.community_support.size() != 7:
        _fail("Canonical community state does not cover every district.")
        return
    var rng_before := str(state.rng.state)
    state.reputation = 40.0
    state.institution_level = 2
    state.district_demand[state.active_district_id] = 80.0
    state.advance_community_feedback()

    if float(state.community_support[state.active_district_id]) <= 50.0:
        _fail("GameState community support did not react to Reputation/city state.")
        return
    if state.reputation <= 40.0:
        _fail("Community support did not feed back into Reputation.")
        return
    if str(state.rng.state) != rng_before:
        _fail("Community feedback consumed RNG state.")
        return

    print("COMMUNITY FEEDBACK TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
