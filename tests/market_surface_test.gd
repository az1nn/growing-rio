extends SceneTree

const TEST_SEED := 5505
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
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

    _prepare_state()

    var market := MARKET_SCENE.instantiate()
    root.add_child(market)
    await process_frame

    var initial: Dictionary = game_state.market_snapshot()
    if Array(initial.get("buyers", [])).size() != 2:
        _fail("Market snapshot did not expose both canonical buyers.")
        return
    if int(initial.get("inventory", -1)) != 6:
        _fail("Market snapshot did not expose active-room inventory.")
        return
    if int(Dictionary(initial.get("compliance", {})).get("level", -1)) != 0:
        _fail("Market snapshot did not expose canonical compliance summary.")
        return
    if not Dictionary(initial.get("district", {})).has("demand"):
        _fail("Market snapshot did not expose canonical demand summary.")
        return

    var licensed := _buyer_entry(initial, "varejista_licenciado")
    if licensed.is_empty():
        _fail("Licensed buyer was missing from Market.")
        return
    if not bool(Dictionary(licensed.get("sale_action", {})).get("enabled", false)):
        _fail("Sellable inventory was not presented as actionable.")
        return

    market._on_contract_pressed("contrato_licenciado_padrao", "accept")
    await process_frame
    if game_state.active_contract_id != "contrato_licenciado_padrao":
        _fail("Market accept action did not reach canonical GameState.")
        return

    var active: Dictionary = game_state.market_snapshot()
    var parallel := _buyer_entry(active, "rede_paralela")
    if String(Dictionary(parallel.get("contract", {})).get("state", "")) != "blocked":
        _fail("Concurrent contract was not presented as blocked.")
        return

    licensed = _buyer_entry(active, "varejista_licenciado")
    var licensed_contract: Dictionary = Dictionary(licensed.get("contract", {}))
    if String(licensed_contract.get("state", "")) != "active":
        _fail("Accepted contract was not presented as active.")
        return
    if not bool(Dictionary(licensed_contract.get("action", {})).get("enabled", false)):
        _fail("Resolvable active contract was not presented as actionable.")
        return

    market._on_contract_pressed("contrato_licenciado_padrao", "resolve")
    market._on_sale_pressed("varejista_licenciado")
    await process_frame
    var through_surface: Dictionary = game_state.create_save_data().duplicate(true)

    _prepare_state()
    if not game_state.accept_contract("contrato_licenciado_padrao"):
        _fail("Could not prepare direct contract comparison.")
        return
    if not game_state.resolve_active_contract():
        _fail("Could not resolve direct canonical contract comparison.")
        return
    game_state.sell_legal()
    var direct_commands: Dictionary = game_state.create_save_data().duplicate(true)

    if through_surface != direct_commands:
        _fail("Market surface transitions diverged from direct canonical commands.")
        return

    if not is_equal_approx(
        game_state.relationship_for_buyer("varejista_licenciado"),
        20.0,
    ):
        _fail("Buyer relationship feedback diverged from canonical state.")
        return

    var saved := direct_commands.duplicate(true)
    game_state.reset()
    if not game_state.load_save_data(saved):
        _fail("RB-05 canonical market state failed save/load restore.")
        return
    if game_state.create_save_data() != saved:
        _fail("RB-05 market state did not round-trip through save schema v11.")
        return

    print("MARKET SURFACE TEST PASSED")
    quit(0)

func _prepare_state() -> void:
    game_state.set_simulation_seed(TEST_SEED)
    game_state.reset()
    var room: Dictionary = game_state.rooms[0]
    var cultivation: Dictionary = room["cultivation"]
    cultivation["inventory"] = 6
    cultivation["batch_quality"] = 0.80
    room["cultivation"] = cultivation
    game_state.rooms[0] = room
    game_state.switch_active_room("room_1")
    game_state._sync_active_room_cache()

func _buyer_entry(snapshot: Dictionary, buyer_id: String) -> Dictionary:
    for buyer_value in Array(snapshot.get("buyers", [])):
        var buyer: Dictionary = buyer_value
        if String(buyer.get("id", "")) == buyer_id:
            return buyer
    return {}

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
