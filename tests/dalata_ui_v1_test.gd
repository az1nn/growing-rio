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
    if shell.get_node("%PortraitNav").get_child_count() > 5:
        _fail("DA LATA UI V1 portrait navigation exceeds five slots.")
        return
    if not shell.navigate_to("market"):
        _fail("DA LATA UI V1 shell could not route to Market.")
        return
    var market_tab = shell.get_node("%MarketButton")
    if not market_tab.has_method("is_selected") or not market_tab.call("is_selected"):
        _fail("Market destination does not expose shared selected navigation state.")
        return
    if market_tab.disabled:
        _fail("Selected navigation was conflated with disabled state.")
        return
    if shell.get_node("Margin/Layout/Header").visible:
        _fail("Market pilot still renders the legacy outer header above the shared UI shell.")
        return
    if shell.get_node("%PortraitNav").visible:
        _fail("Market pilot still renders duplicate legacy portrait navigation.")
        return

    var embedded_market = shell.get_node("%MarketSurface")
    var embedded_ui = embedded_market.get_node_or_null("MarketUIScreen")
    if embedded_ui == null:
        _fail("Market pilot did not mount the shared DA LATA screen shell.")
        return
    if int(embedded_ui.call("command_count")) != 5:
        _fail("Market pilot shared command band does not expose exactly five destinations.")
        return
    var operation_route = _find_semantic_action(embedded_ui, &"nav/operation")
    if operation_route == null:
        _fail("Market pilot shared command band lost the Operation route hook.")
        return
    await _tap_control(operation_route)
    if shell.current_destination != "operation":
        _fail("Market shared command band did not route from a real touch event.")
        return
    shell.navigate_to("market")

    var market := MARKET_SCENE.instantiate()
    root.add_child(market)
    await process_frame
    var market_ui = market.get_node_or_null("MarketUIScreen")
    if market_ui == null:
        _fail("Standalone Market did not instantiate DA LATA shared screen shell.")
        return
    if market_ui.get_node("%SceneTitle").text != "MERCADO":
        _fail("Market shared shell lost canonical scene identity.")
        return
    var market_scroll = market.get_node_or_null("Scroll") as ScrollContainer
    if market_scroll == null:
        _fail("Market action surface lost its canonical owner-local Scroll node.")
        return
    var bottom_band = market_ui.get_node("%BottomCommandBand") as Control
    if market_scroll.get_global_rect().end.y > bottom_band.get_global_rect().position.y + 0.5:
        _fail("Market action surface overlaps the shared bottom command band.")
        return
    var market_diorama = market.get_node("Interactive3D") as Control
    var diorama_viewport = market_diorama.get_node("ViewportContainer") as Control
    if market_scroll.z_index <= diorama_viewport.z_index:
        _fail("Market transactional actions render behind the accepted visual substrate.")
        return
    if market_ui.z_index <= diorama_viewport.z_index:
        _fail("Market shared shell renders behind the accepted visual substrate.")
        return
    if market_ui.frame.mouse_filter != Control.MOUSE_FILTER_IGNORE:
        _fail("Market shared shell frame blocks pointer/touch access to owner-local actions.")
        return
    if not market_diorama.has_method("is_embedded_ui_mode") or not market_diorama.call("is_embedded_ui_mode"):
        _fail("Market did not suppress duplicate diorama chrome in embedded UI mode.")
        return
    if market_diorama.get_node("InteractionStatus").visible:
        _fail("Market embedded mode still exposes duplicate diorama status chrome.")
        return
    if market_diorama.get_node("ContractActionButton").visible or market_diorama.get_node("ObjectActionButton").visible:
        _fail("Market embedded mode still exposes duplicate diorama fallback buttons.")
        return
    var runtime_backdrop = market_diorama.get_node("ConceptBackdrop") as TextureRect
    if runtime_backdrop == null or runtime_backdrop.texture == null:
        _fail("Market runtime lost its production visual substrate.")
        return
    if String(runtime_backdrop.texture.resource_path) != "res://assets/market/v1/market-runtime-backdrop.svg":
        _fail("Market runtime regressed to the low-resolution ARTIST review derivative.")
        return
    var deal_touch = market_diorama.get_node("DealCounterTouchTarget") as Button
    var contract_touch = market_diorama.get_node("ContractTouchTarget") as Button
    if not deal_touch.visible or not contract_touch.visible:
        _fail("Market embedded runtime does not expose direct semantic touch targets.")
        return
    if deal_touch.mouse_filter != Control.MOUSE_FILTER_STOP or contract_touch.mouse_filter != Control.MOUSE_FILTER_STOP:
        _fail("Market semantic touch targets do not accept pointer/touch input.")
        return
    var market_nav = _find_semantic_action(market_ui, &"nav/market")
    if market_nav == null or not market_nav.call("is_selected"):
        _fail("Market shared navigation does not expose explicit selected state.")
        return
    if _find_semantic_action(market, &"shell/campaign") == null:
        _fail("Market shared shell migration removed pointer/touch access to Campaign.")
        return

    var city_action = market.get_node("%CityDetailButton")
    if city_action.get_script() == null or String(city_action.get_script().resource_path) != "res://scenes/ui/v1/dalata_button.gd":
        _fail("Market City action is not using the shared DA LATA button.")
        return

    var buyer_list = market.get_node("%BuyerList")
    var shared_action_count := 0
    for card in buyer_list.get_children():
        for node in _walk(card):
            if node is Button and node.get_script() != null:
                if String(node.get_script().resource_path) == "res://scenes/ui/v1/dalata_button.gd":
                    shared_action_count += 1
                    if node.custom_minimum_size.y < 48.0:
                        _fail("Market shared action regressed below 48px touch target.")
                        return
                    if node.focus_mode != Control.FOCUS_ALL:
                        _fail("Market shared action regressed out of keyboard focus order.")
                        return
                    if node.mouse_filter != Control.MOUSE_FILTER_STOP:
                        _fail("Market shared action stopped accepting pointer/touch input.")
                        return
    if shared_action_count < 2:
        _fail("Market transactional actions were not migrated to shared DA LATA controls.")
        return

    print("DA LATA UI V1 TEST PASSED")
    quit(0)

func _on_touch_probe_pressed() -> void:
    touch_probe_count += 1

func _tap_control(control: Control) -> void:
    var point := control.get_global_rect().get_center()
    var down := InputEventScreenTouch.new()
    down.index = 7
    down.position = point
    down.pressed = true
    Input.parse_input_event(down)
    await process_frame
    var up := InputEventScreenTouch.new()
    up.index = 7
    up.position = point
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
