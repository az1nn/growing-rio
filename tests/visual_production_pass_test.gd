extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const SHELL_SCENE := preload("res://scenes/shell/game_shell.tscn")

var game_state

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)

    game_state.reset()
    game_state.set_simulation_seed(1313)

    var shell := SHELL_SCENE.instantiate()
    root.add_child(shell)
    await process_frame

    var canonical_before: Dictionary = game_state.create_save_data().duplicate(true)

    if shell.theme == null:
        _fail("RB-13 shared Theme is not applied at the GameShell root.")
        return
    if shell.theme.resource_path != "res://resources/ui/dalata_theme.tres":
        _fail("GameShell does not use the canonical RB-13 shared Theme.")
        return

    shell.apply_layout_for_size(Vector2(540, 960))
    var status := shell.get_node("%GlobalStatus") as GridContainer
    var portrait_nav := shell.get_node("%PortraitNav") as GridContainer
    if status == null or portrait_nav == null:
        _fail("RB-13 responsive containers are missing.")
        return
    if status.columns != 3:
        _fail("Portrait global status must use three columns.")
        return
    if portrait_nav.columns != 3 or not portrait_nav.visible:
        _fail("Portrait navigation must use a visible three-column grid.")
        return
    if shell.get_node("%WideNav").visible:
        _fail("Wide navigation must remain hidden in portrait layout.")
        return
    if not shell.compact_portrait:
        _fail("540px portrait layout did not activate compact shell density.")
        return
    if shell.get_node("%ShellReputationLabel").text.find("REP.\n") != 0:
        _fail("Compact portrait reputation label did not use the short two-line form.")
        return
    if shell.get_node("%ShellInfluenceLabel").text.find("INFL.\n") != 0:
        _fail("Compact portrait influence label did not use the short two-line form.")
        return
    if shell.get_node("%CampaignButton").custom_minimum_size.y < 44.0:
        _fail("Compact Campaign target fell below the 44px minimum height.")
        return

    for button_name in [
        "%OperationButton",
        "%MarketButton",
        "%CityButton",
        "%InstitutionalButton",
        "%ArchiveButton",
    ]:
        var button := shell.get_node(button_name) as Button
        if button == null or button.custom_minimum_size.y < 64.0:
            _fail("Portrait navigation action target fell below 64px: %s" % button_name)
            return

    shell.apply_layout_for_size(Vector2(1280, 720))
    if status.columns != 5:
        _fail("Wide global status must use five columns.")
        return
    if portrait_nav.visible or not shell.get_node("%WideNav").visible:
        _fail("Wide layout did not switch navigation ownership correctly.")
        return
    if shell.compact_portrait:
        _fail("Wide layout incorrectly retained compact portrait density.")
        return

    if game_state.create_save_data() != canonical_before:
        _fail("RB-13 presentation/layout changes mutated canonical campaign state or RNG.")
        return

    print("RB-13 VISUAL PRODUCTION TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
