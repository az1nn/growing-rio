extends SceneTree

const TEST_SEED := 7707
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const CITY_SCENE := preload("res://scenes/city/city_surface.tscn")
const MARKET_SCENE := preload("res://scenes/market/market_surface.tscn")

var game_state
var market_city_requested := false

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)

    game_state.set_simulation_seed(TEST_SEED)
    game_state.reset()

    var initial: Dictionary = game_state.city_snapshot()
    var districts := Array(initial.get("districts", []))
    if districts.size() != 7:
        _fail("City snapshot does not expose all seven canonical districts.")
        return
    if String(initial.get("active_district_id", "")) != "district_morro_cedro":
        _fail("City snapshot default active district diverged from GameState.")
        return

    var city := CITY_SCENE.instantiate()
    root.add_child(city)
    await process_frame
    if city.get_node("%CityDistrictList").get_child_count() != 7:
        _fail("City surface did not render the full district catalog.")
        return

    var rng_before := str(game_state.rng.state)
    city._on_district_pressed("district_orla_vigia")
    await process_frame
    if game_state.active_district_id != "district_orla_vigia":
        _fail("City surface did not delegate district selection to GameState.")
        return
    if str(game_state.rng.state) != rng_before:
        _fail("District selection unexpectedly consumed RNG state.")
        return
    if "Orla da Vigia" not in city.get_node("%CityActiveLabel").text:
        _fail("City active-district presentation did not refresh.")
        return
    if "70" not in city.get_node("%CityDemandLabel").text:
        _fail("City demand presentation diverged from canonical demand.")
        return

    var market := MARKET_SCENE.instantiate()
    root.add_child(market)
    market.city_requested.connect(_on_market_city_requested)
    await process_frame
    if "Orla da Vigia" not in market.get_node("%MarketContextLabel").text:
        _fail("Market summary does not share the canonical active district.")
        return
    if "Demanda: 70" not in market.get_node("%MarketContextLabel").text:
        _fail("Market summary demand diverged from City.")
        return

    market._on_city_pressed()
    if not market_city_requested:
        _fail("Market did not emit the City navigation handoff.")
        return

    game_state.next_day()
    await process_frame
    if "75" not in city.get_node("%CityDemandLabel").text:
        _fail("City did not refresh deterministic demand after advancing day.")
        return
    if "Demanda: 75" not in market.get_node("%MarketContextLabel").text:
        _fail("Market retained stale demand after canonical city update.")
        return

    game_state.reset()
    rng_before = str(game_state.rng.state)
    city._on_district_pressed("district_orla_vigia")
    await process_frame
    var through_surface: Dictionary = game_state.create_save_data().duplicate(true)
    if str(game_state.rng.state) != rng_before:
        _fail("City selection changed RNG state.")
        return

    game_state.reset()
    if not game_state.select_district("district_orla_vigia"):
        _fail("Direct canonical district selection failed.")
        return
    var direct_command: Dictionary = game_state.create_save_data().duplicate(true)
    if through_surface != direct_command:
        _fail("City surface selection diverged from direct GameState command.")
        return

    var before_invalid := game_state.create_save_data().duplicate(true)
    city._on_district_pressed("district_unknown")
    if game_state.create_save_data() != before_invalid:
        _fail("Unknown district mutation changed canonical state.")
        return

    print("CITY SURFACE TEST PASSED")
    quit(0)

func _on_market_city_requested() -> void:
    market_city_requested = true

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
