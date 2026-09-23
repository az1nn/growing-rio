extends SceneTree

const TEST_SEED := 7301
const BUSINESS_SERVICE := preload("res://domain/business/business_service.gd")
const CULTIVATION_SERVICE := preload("res://domain/cultivation/cultivation_service.gd")
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const STAFF := preload("res://resources/staff/assistente_operacional.tres")
const UPGRADE := preload("res://resources/upgrades/sensores_basicos.tres")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var service := BUSINESS_SERVICE.new()
    var staff_catalog := {String(STAFF.id): STAFF}
    var upgrade_catalog := {String(UPGRADE.id): UPGRADE}

    if service.daily_staff_cost([String(STAFF.id)], staff_catalog) != 7:
        _fail("Staff daily cost aggregation regressed.")
        return
    if service.daily_upgrade_cost([String(UPGRADE.id)], upgrade_catalog) != 2:
        _fail("Upgrade daily upkeep aggregation regressed.")
        return
    if not is_equal_approx(
        service.health_stability_modifier(
            [String(STAFF.id)],
            [String(UPGRADE.id)],
            staff_catalog,
            upgrade_catalog,
        ),
        0.05,
    ):
        _fail("Staff/upgrade stability modifier aggregation regressed.")
        return

    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()

    if state.hire_staff("unknown_staff"):
        _fail("Unknown staff ID was accepted.")
        return
    if state.purchase_upgrade("unknown_upgrade"):
        _fail("Unknown upgrade ID was accepted.")
        return
    if not state.hire_staff("assistente_operacional"):
        _fail("Known staff could not be hired.")
        return
    if not state.purchase_upgrade("sensores_basicos"):
        _fail("Known upgrade could not be purchased.")
        return
    if state.hire_staff("assistente_operacional"):
        _fail("Duplicate staff ID was accepted.")
        return
    if state.purchase_upgrade("sensores_basicos"):
        _fail("Duplicate upgrade ID was accepted.")
        return
    if state.cash != 10:
        _fail("Acquisition costs were not applied deterministically.")
        return
    if state.daily_operating_cost() != 24:
        _fail("Room + staff + upgrade daily operating cost regressed.")
        return
    if not is_equal_approx(state.health_stability_modifier(), 0.05):
        _fail("GameState modifier surface regressed.")
        return

    if not _verify_modifier_application():
        return
    if not _verify_deterministic_game_state():
        return

    print("STAFF + UPGRADES TEST PASSED")
    quit(0)

func _verify_modifier_application() -> bool:
    var service := CULTIVATION_SERVICE.new()
    var plain_rng := RandomNumberGenerator.new()
    var modified_rng := RandomNumberGenerator.new()
    plain_rng.seed = TEST_SEED
    modified_rng.seed = TEST_SEED

    var plain := service.advance_day(0, 0.72, false, 10, plain_rng)
    var modified := service.advance_day(0, 0.72, false, 10, modified_rng, 0.05)

    if not is_equal_approx(
        float(modified["grow_health"]) - float(plain["grow_health"]),
        0.05,
    ):
        _fail("Abstract stability modifier was not applied deterministically.")
        return false
    return true

func _verify_deterministic_game_state() -> bool:
    var left := GAME_STATE_SCRIPT.new()
    var right := GAME_STATE_SCRIPT.new()
    root.add_child(left)
    root.add_child(right)

    for state in [left, right]:
        state.set_simulation_seed(TEST_SEED)
        state.reset()
        if not state.hire_staff("assistente_operacional"):
            _fail("Could not prepare deterministic staff fixture.")
            return false
        if not state.purchase_upgrade("sensores_basicos"):
            _fail("Could not prepare deterministic upgrade fixture.")
            return false
        state.next_day()

    if _snapshot(left) != _snapshot(right):
        _fail("Staff/upgrade simulation diverged under an identical seed.")
        return false
    return true

func _snapshot(state: Node) -> Array:
    return [
        state.day,
        state.cash,
        state.grow_day,
        state.grow_health,
        state.rooms.duplicate(true),
        state.hired_staff_ids.duplicate(true),
        state.owned_upgrade_ids.duplicate(true),
        str(state.rng.state),
    ]

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
