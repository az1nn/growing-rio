extends SceneTree

const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const SHELL_SCENE := preload("res://scenes/shell/game_shell.tscn")
const MARKET_SCENE := preload("res://scenes/market/market_surface.tscn")
const DALATA_BUTTON := preload("res://scenes/ui/v1/dalata_button.gd")
const DALATA_NAV_TAB := preload("res://scenes/ui/v1/dalata_nav_tab.gd")
const DALATA_SCREEN_SHELL := preload("res://scenes/ui/v1/dalata_screen_shell.tscn")

var game_state
var touch_probe_count := 0

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    game_state = root.get_node_or_null("GameState")
    if game_state == null:
        game_state = GAME_STATE_SCRIPT.new()
        game_state.name = "GameState"
        root.add_child(game_state)
    game_state.reset()

    var primary = DALATA_BUTTON.new()
    primary.text = "Confirmar"
    primary.role = DALATA_BUTTON.Role.PRIMARY
    root.add_child(primary)
    await process_frame

    if primary.custom_minimum_size.y < 48.0:
        _fail("DA LATA UI V1 primary action regressed below 48px touch target.")
        return
    var primary_style := primary.get_theme_stylebox("normal") as StyleBoxFlat
    if primary_style == null or primary_style.border_width_left < 2:
        _fail("DA LATA UI V1 primary action lost hard-border grammar.")
        return
    if primary.focus_mode != Control.FOCUS_ALL:
        _fail("DA LATA UI V1 shared action is not keyboard-focusable.")
        return
    if primary.mouse_filter != Control.MOUSE_FILTER_STOP:
        _fail("DA LATA UI V1 shared action no longer accepts pointer/touch input.")
        return
    if not bool(ProjectSettings.get_setting("input_devices/pointing/emulate_mouse_from_touch", false)):
        _fail("DA LATA UI V1 does not force touch-to-mouse emulation.")
        return
    primary.position = Vector2(800, 100)
    primary.size = Vector2(220, 64)
    primary.pressed.connect(_on_touch_probe_pressed)
    await _tap_control(primary)
    if touch_probe_count != 1:
        _fail("A real InputEventScreenTouch did not activate a shared button.")
        return
    var focus_style := primary.get_theme_stylebox("focus") as StyleBoxFlat
    if focus_style == null or focus_style.expand_margin_left < 2.0:
        _fail("DA LATA UI V1 focus state lost its non-color external ring.")
        return

    var disabled = DALATA_BUTTON.new()
    disabled.text = "Indisponível"
    disabled.role = DALATA_BUTTON.Role.SECONDARY
    root.add_child(disabled)
    await process_frame
    var secondary_style := disabled.get_theme_stylebox("normal") as StyleBoxFlat
    if secondary_style == null:
        _fail("DA LATA UI V1 secondary action lost its shared style.")
        return
    if secondary_style.corner_radius_top_left < 6:
        _fail("DA LATA UI V1 secondary action lost the approved contemporary edge treatment.")
        return
    if secondary_style.border_width_left < 2 or secondary_style.border_color.a < 0.85:
        _fail("DA LATA UI V1 secondary action lost its structural border.")
        return
    disabled.disabled = true
    var disabled_style := disabled.get_theme_stylebox("disabled") as StyleBoxFlat
    if disabled_style == null or disabled_style.border_width_bottom <= disabled_style.border_width_top:
        _fail("DA LATA UI V1 disabled state relies on color alone.")
        return

    var locked = DALATA_BUTTON.new()
    locked.text = "Destino"
    locked.role = DALATA_BUTTON.Role.SECONDARY
    root.add_child(locked)
    await process_frame
    locked.set_progression_lock(true, "Disponível depois do marco atual.")
    if not locked.disabled or not locked.text.begins_with("[BLOQ]"):
        _fail("DA LATA UI V1 lock state is not explicit beyond color.")
        return
    if locked.tooltip_text.find("marco atual") == -1:
        _fail("DA LATA UI V1 lock state lost its reason.")
        return

    var nav = DALATA_NAV_TAB.new()
    nav.text = "Mercado"
    root.add_child(nav)
    await process_frame
    nav.set_selected(true)
    if not nav.button_pressed or nav.text != "Mercado":
        _fail("DA LATA UI V1 selected navigation mutated its label instead of using physical state.")
        return
    var selected_style := nav.get_theme_stylebox("pressed") as StyleBoxFlat
    if selected_style == null or selected_style.border_width_left <= selected_style.border_width_right:
        _fail("DA LATA UI V1 selected navigation lost the non-color notch.")
        return
    if selected_style.border_width_bottom < 5:
        _fail("DA LATA UI V1 selected navigation lost its bottom rail.")
        return

    var shared_shell = DALATA_SCREEN_SHELL.instantiate()
    root.add_child(shared_shell)
    await process_frame
    shared_shell.apply_layout_for_size(Vector2(540, 960))
    shared_shell.set_scene_identity("Mercado", "DIA 1 • CAIXA R$ 250")

    if shared_shell.offset_top < 16.0 or absf(shared_shell.offset_bottom) < 16.0:
        _fail("DA LATA shared shell violated the 16px portrait safe margin.")
        return
    if shared_shell.get_node("%SceneTitle").text != "Mercado":
        _fail("DA LATA shared shell lost scene identity.")
        return
    if not shared_shell.get_node("%TopRegion").visible:
        _fail("DA LATA shared shell top status/title region is missing.")
        return
    if shared_shell.get_node("%BottomCommandBand").custom_minimum_size.y < 76.0:
        _fail("DA LATA shared shell bottom command band regressed below 76px.")
        return
    if not (shared_shell.get_node("%ActionRegion").size_flags_vertical & Control.SIZE_EXPAND):
        _fail("DA LATA shared shell scene action region is not expandable.")
        return

    var action_fixture := Control.new()
    if not shared_shell.mount_action_content(action_fixture):
        _fail("DA LATA shared shell could not mount scene action content.")
        return
    if action_fixture.get_parent() != shared_shell.get_node("%ActionHost"):
        _fail("DA LATA shared shell mounted action content outside ActionHost.")
        return

    for index in range(5):
        var command = DALATA_NAV_TAB.new()
        command.text = "Nav %d" % (index + 1)
        if not shared_shell.add_command(command):
            _fail("DA LATA shared shell rejected a valid command slot.")
            return
    var commands = shared_shell.get_node("%CommandHost").get_children()
    if commands.size() != 5:
        _fail("DA LATA shared shell focus-chain fixture lost a command.")
        return
    if String(commands[0].focus_neighbor_right).is_empty():
        _fail("DA LATA command band lost explicit keyboard right-neighbor focus.")
        return
    if String(commands[1].focus_neighbor_left).is_empty():
        _fail("DA LATA command band lost explicit keyboard left-neighbor focus.")
        return
    for command in commands:
        if command.focus_mode != Control.FOCUS_ALL:
            _fail("DA LATA command band contains a non-focusable destination.")
            return
        if command.custom_minimum_size.y < 48.0:
            _fail("DA LATA command band regressed below the touch target.")
            return

    var overflow_command = DALATA_NAV_TAB.new()
    overflow_command.text = "Overflow"
    if shared_shell.add_command(overflow_command):
        _fail("DA LATA shared shell accepted more than five command slots.")
        return
    overflow_command.free()
    primary.queue_free()
    disabled.queue_free()
    locked.queue_free()
    nav.queue_free()
    shared_shell.queue_free()
    await process_frame

    var shell := SHELL_SCENE.instantiate()
    root.add_child(shell)
    await process_frame
    shell.apply_layout_for_size(Vector2(540, 960))
    if not shell.navigate_to("market"):
        _fail("DA LATA shell could not route to the restored Market baseline.")
        return
    if not shell.get_node("Margin/Layout/Header").visible:
        _fail("Market baseline lost the canonical outer header.")
        return
    if not shell.get_node("%PortraitNav").visible:
        _fail("Market baseline lost the canonical portrait navigation.")
        return

    var embedded_market = shell.get_node("%MarketSurface")

    var portrait_nav = shell.get_node("%PortraitNav")
    if portrait_nav.get_child_count() != 2:
        _fail("Approved portrait navigation must keep the 3+2 row structure.")
        return
    var market_nav = shell.get_node("%MarketButton") as Button
    if market_nav == null or not market_nav.has_method("is_selected"):
        _fail("Market navigation lost the approved shared nav component.")
        return
    if not bool(market_nav.call("is_selected")) or market_nav.disabled:
        _fail("Active Market navigation must render selected neon state, not disabled chrome.")
        return
    var market_nav_style := market_nav.get_theme_stylebox("normal") as StyleBoxFlat
    if market_nav_style == null or market_nav_style.corner_radius_top_left < 6:
        _fail("Approved navigation lost its contemporary rounded edge treatment.")
        return

    var contract_cta = embedded_market.get_node("Interactive3D/ContractActionButton") as Button
    var buyer_cta = embedded_market.get_node("Interactive3D/ObjectActionButton") as Button
    if contract_cta == null or buyer_cta == null:
        _fail("Market lost the approved paired action CTAs.")
        return
    var contract_style := contract_cta.get_theme_stylebox("normal") as StyleBoxFlat
    var buyer_style := buyer_cta.get_theme_stylebox("normal") as StyleBoxFlat
    if contract_style == null or buyer_style == null:
        _fail("Market CTAs lost the shared approved style.")
        return
    if contract_style.corner_radius_top_left < 6 or buyer_style.corner_radius_top_left < 6:
        _fail("Market CTAs lost the approved modern teal edge chrome.")
        return
    if contract_style.border_color.a < 0.9 or buyer_style.border_color.a < 0.9:
        _fail("Market CTA neon border is no longer legible.")
        return

    if embedded_market.get_node_or_null("MarketUIScreen") != null:
        _fail("Market regressed to the rejected duplicated local UI shell.")
        return
    if embedded_market.get_node_or_null("ActionDeck") != null:
        _fail("Market regressed to the rejected opaque action-deck composition.")
        return

    var market_diorama = embedded_market.get_node("Interactive3D") as Control
    var runtime_backdrop = market_diorama.get_node("ConceptBackdrop") as TextureRect
    if runtime_backdrop == null or runtime_backdrop.texture == null:
        _fail("Market baseline lost its accepted ARTIST visual substrate.")
        return
    if String(runtime_backdrop.texture.resource_path) != "res://artifacts/artist/runs/20261002T091800Z/market/images/concept/concept-v001.webp":
        _fail("Market is not rendering the accepted ARTIST concept baseline.")
        return

    var operation_route = shell.get_node("%OperationButton") as Button
    if operation_route == null:
        _fail("Restored Market shell lost the Operation route.")
        return
    await process_frame
    await process_frame
    await _tap_control(operation_route)
    if shell.current_destination != "operation":
        _fail("Restored shell navigation did not route from a real touch event.")
        return

    shell.navigate_to("market")
    var market := MARKET_SCENE.instantiate()
    root.add_child(market)
    await process_frame
    if market.get_node_or_null("MarketUIScreen") != null or market.get_node_or_null("ActionDeck") != null:
        _fail("Standalone Market still contains rejected UI-composition layers.")
        return
    if market.get_node("%CityDetailButton").custom_minimum_size.y < 48.0:
        _fail("Restored Market action regressed below the touch target.")
        return
    var standalone_diorama = market.get_node("Interactive3D") as Control
    var standalone_backdrop = standalone_diorama.get_node("ConceptBackdrop") as TextureRect
    if String(standalone_backdrop.texture.resource_path) != "res://artifacts/artist/runs/20261002T091800Z/market/images/concept/concept-v001.webp":
        _fail("Standalone Market lost the accepted ARTIST concept baseline.")
        return

    print("DA LATA UI V1 TEST PASSED")
    quit(0)

func _on_touch_probe_pressed() -> void:
    touch_probe_count += 1

func _tap_control(control: Control) -> void:
    var canvas_point := control.get_global_rect().get_center()
    var screen_point := control.get_viewport().get_screen_transform() * canvas_point
    var down := InputEventScreenTouch.new()
    down.index = 7
    down.position = screen_point
    down.pressed = true
    Input.parse_input_event(down)
    await process_frame
    var up := InputEventScreenTouch.new()
    up.index = 7
    up.position = screen_point
    up.pressed = false
    Input.parse_input_event(up)
    await process_frame

func _find_semantic_action(root_node: Node, action_id: StringName):
    for node in _walk(root_node):
        if node is Button and node.get("semantic_action_id") == action_id:
            return node
    return null

func _walk(node: Node) -> Array:
    var result: Array = [node]
    for child in node.get_children():
        result.append_array(_walk(child))
    return result

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
