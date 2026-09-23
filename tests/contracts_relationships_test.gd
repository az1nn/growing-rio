extends SceneTree

const TEST_SEED := 8201
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()

    var rng_before := str(state.rng.state)

    if state.accept_contract("unknown_contract"):
        _fail("Unknown contract ID was accepted.")
        return
    if not state.accept_contract("contrato_licenciado_padrao"):
        _fail("Known licensed contract could not be accepted.")
        return
    if state.accept_contract("acordo_paralelo_padrao"):
        _fail("A second concurrent contract was accepted.")
        return

    _prepare_inventory(state, 6, 0.80)
    var cash_before := state.cash

    if not state.resolve_active_contract():
        _fail("Valid contract could not be resolved.")
        return
    if state.cash != cash_before + 116:
        _fail("Contract cash reward regressed.")
        return
    if not is_equal_approx(
        state.relationship_for_buyer("varejista_licenciado"),
        20.0,
    ):
        _fail("Buyer relationship gain regressed.")
        return
    if not state.active_contract_id.is_empty():
        _fail("Resolved contract remained active.")
        return
    if state.inventory != 3:
        _fail("Contract did not consume only the required abstract units.")
        return
    if not is_equal_approx(state.batch_quality, 0.80):
        _fail("Remaining inventory quality was not preserved.")
        return
    if str(state.rng.state) != rng_before:
        _fail("Contract flow consumed RNG state.")
        return

    var sale_cash_before := state.cash
    state.sell_legal()
    if state.cash != sale_cash_before + 102:
        _fail("Buyer relationship pricing modifier regressed.")
        return

    state.reset()
    if not state.accept_contract("acordo_paralelo_padrao"):
        _fail("Known parallel contract could not be accepted.")
        return
    _prepare_inventory(state, 1, 0.90)
    var failed_cash_before := state.cash
    if state.resolve_active_contract():
        _fail("Contract resolved without enough inventory.")
        return
    if state.cash != failed_cash_before:
        _fail("Failed contract mutated cash.")
        return
    if state.active_contract_id != "acordo_paralelo_padrao":
        _fail("Failed contract was cleared instead of remaining active.")
        return
    if not is_equal_approx(
        state.relationship_for_buyer("rede_paralela"),
        0.0,
    ):
        _fail("Failed contract mutated buyer relationship.")
        return

    print("CONTRACTS + RELATIONSHIPS TEST PASSED")
    quit(0)

func _prepare_inventory(state: Node, units: int, quality: float) -> void:
    var room: Dictionary = state.rooms[0]
    var cultivation: Dictionary = room["cultivation"]
    cultivation["inventory"] = units
    cultivation["batch_quality"] = quality
    room["cultivation"] = cultivation
    state.rooms[0] = room
    state.switch_active_room("room_1")
    state._sync_active_room_cache()

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
