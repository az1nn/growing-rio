extends SceneTree

const TEST_SEED := 6606
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const INSTITUTIONAL_SCENE := preload(
    "res://scenes/institutional/institutional_surface.tscn"
)
const MARKET_SCENE := preload("res://scenes/market/market_surface.tscn")

var game_state

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)

    _prepare_blocked_state()

    var surface := INSTITUTIONAL_SCENE.instantiate()
    root.add_child(surface)
    await process_frame

    var blocked: Dictionary = game_state.compliance_snapshot()
    if bool(Dictionary(blocked.get("progression", {})).get("available", true)):
        _fail("Blocked compliance state was presented as available.")
        return
    if not surface.get_node("%ComplianceProgressButton").disabled:
        _fail("Institutional surface enabled a blocked compliance action.")
        return
    if "Cadastro básico" not in surface.get_node("%ComplianceNextLabel").text:
        _fail("Institutional surface did not expose the canonical next step.")
        return
    if "Reputação insuficiente" not in String(
        Dictionary(blocked.get("progression", {})).get("message", "")
    ):
        _fail("Blocked reason diverged from ComplianceService.")
        return

    _prepare_available_state()
    await process_frame

    var available: Dictionary = game_state.compliance_snapshot()
    if not bool(Dictionary(available.get("progression", {})).get("available", false)):
        _fail("Eligible compliance state was not presented as available.")
        return
    if surface.get_node("%ComplianceProgressButton").disabled:
        _fail("Institutional surface kept an eligible compliance action disabled.")
        return

    var rng_before := str(game_state.rng.state)
    surface._on_progress_pressed()
    await process_frame

    if game_state.compliance_level != 1:
        _fail("Institutional action did not reach canonical compliance progression.")
        return
    if str(game_state.rng.state) != rng_before:
        _fail("Compliance surface progression consumed RNG state.")
        return
    if "nível 1 / 3" not in surface.get_node("%ComplianceCurrentLabel").text:
        _fail("Institutional current-state presentation did not refresh.")
        return

    var market := MARKET_SCENE.instantiate()
    root.add_child(market)
    await process_frame
    if "Compliance: nível 1" not in market.get_node("%MarketContextLabel").text:
        _fail("Market compliance summary diverged from canonical state.")
        return

    var through_surface: Dictionary = game_state.create_save_data().duplicate(true)

    _prepare_available_state()
    if not game_state.advance_compliance():
        _fail("Could not execute direct canonical compliance comparison.")
        return
    var direct_command: Dictionary = game_state.create_save_data().duplicate(true)

    if through_surface != direct_command:
        _fail("Institutional surface transition diverged from direct GameState command.")
        return

    var saved := direct_command.duplicate(true)
    game_state.reset()
    if not game_state.load_save_data(saved):
        _fail("RB-06 compliance state failed save/load restore.")
        return
    if game_state.create_save_data() != saved:
        _fail("RB-06 compliance state did not round-trip through save schema v11.")
        return

    print("COMPLIANCE SURFACE TEST PASSED")
    quit(0)

func _prepare_blocked_state() -> void:
    game_state.set_simulation_seed(TEST_SEED)
    game_state.reset()
    game_state.cash = 1000
    game_state.reputation = 1.0
    game_state.influence = 4.0
    game_state.heat = 20.0
    game_state.state_changed.emit()

func _prepare_available_state() -> void:
    game_state.set_simulation_seed(TEST_SEED)
    game_state.reset()
    game_state.cash = 1000
    game_state.reputation = 2.0
    game_state.influence = 4.0
    game_state.heat = 20.0
    game_state.state_changed.emit()

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
