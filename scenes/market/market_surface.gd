extends Control

const DalataButton = preload("res://scenes/ui/v1/dalata_button.gd")
const DalataNavTab = preload("res://scenes/ui/v1/dalata_nav_tab.gd")
const DALATA_SCREEN_SHELL = preload("res://scenes/ui/v1/dalata_screen_shell.tscn")

signal city_requested
signal destination_requested(destination_id: String)
signal campaign_requested

@onready var game_state = get_node("/root/GameState")
@onready var summary_label: Label = %MarketSummaryLabel
@onready var context_label: Label = %MarketContextLabel
@onready var buyer_list: VBoxContainer = %BuyerList
@onready var feedback_label: Label = %MarketFeedbackLabel
@onready var scroll: ScrollContainer = $Scroll
@onready var market_diorama = $Interactive3D

var contract_focus_target: Control = null
var screen_shell: Control = null
var campaign_utility_button: Button = null
var market_nav_tabs: Dictionary = {}

func _ready() -> void:
    _mount_shared_ui()
    game_state.state_changed.connect(_refresh)
    game_state.message_posted.connect(_on_message)
    market_diorama.object_activated.connect(_on_market_diorama_object_activated)
    get_viewport().size_changed.connect(_on_market_viewport_size_changed)
    _refresh()

func _refresh() -> void:
    var snapshot: Dictionary = game_state.market_snapshot()
    summary_label.text = "Estoque: %d un. • Qualidade: %s" % [
        int(snapshot.get("inventory", 0)),
        String(snapshot.get("quality_label", "Comum")),
    ]

    var district: Dictionary = Dictionary(snapshot.get("district", {}))
    var compliance: Dictionary = Dictionary(snapshot.get("compliance", {}))
    context_label.text = (
        "%s • Demanda: %d • Multiplicador: x%.2f • Compliance: nível %d"
        % [
            String(district.get("display_name", district.get("id", "Distrito"))),
            int(round(float(district.get("demand", 0.0)))),
            float(district.get("price_multiplier", 1.0)),
            int(compliance.get("level", 0)),
        ]
    )

    _clear_buyer_list()
    for buyer_value in Array(snapshot.get("buyers", [])):
        _append_buyer_card(Dictionary(buyer_value))

    _refresh_shared_shell_status()
    _refresh_shared_navigation()

func _mount_shared_ui() -> void:
    screen_shell = DALATA_SCREEN_SHELL.instantiate()
    screen_shell.name = "MarketUIScreen"
    screen_shell.mouse_filter = Control.MOUSE_FILTER_IGNORE
    add_child(screen_shell)

    screen_shell.action_region.mouse_filter = Control.MOUSE_FILTER_IGNORE
    screen_shell.action_host.mouse_filter = Control.MOUSE_FILTER_IGNORE

    var legacy_title := scroll.get_node_or_null("Margin/VBox/Title") as Label
    if legacy_title != null:
        legacy_title.visible = false

    _install_campaign_utility()
    _build_shared_navigation()
    _apply_shared_ui_layout()

func _install_campaign_utility() -> void:
    var content := scroll.get_node_or_null("Margin/VBox") as VBoxContainer
    if content == null:
        return

    campaign_utility_button = DalataButton.new()
    campaign_utility_button.name = "CampaignUtilityButton"
    campaign_utility_button.text = "Campanha"
    campaign_utility_button.role = DalataButton.Role.UTILITY
    campaign_utility_button.semantic_action_id = &"shell/campaign"
    campaign_utility_button.accessibility_name = "Abrir menu de campanha"
    campaign_utility_button.pressed.connect(_on_campaign_utility_pressed)
    content.add_child(campaign_utility_button)
    content.move_child(
        campaign_utility_button,
        mini(5, content.get_child_count() - 1),
    )

func _build_shared_navigation() -> void:
    var specs := [
        ["operation", "OP.", "Operação"],
        ["market", "MERC.", "Mercado"],
        ["city", "CIDADE", "Cidade"],
        ["institutional", "INST.", "Institucional"],
        ["archive", "ARQ.", "Arquivo"],
    ]
    for spec in specs:
        var destination_id := String(spec[0])
        var tab := DalataNavTab.new()
        tab.name = "MarketNav%s" % destination_id.capitalize()
        tab.text = String(spec[1])
        tab.semantic_action_id = StringName("nav/%s" % destination_id)
        tab.accessibility_name = "Ir para %s" % String(spec[2])
        tab.pressed.connect(_on_shared_nav_pressed.bind(destination_id))
        if screen_shell.add_command(tab):
            market_nav_tabs[destination_id] = tab
        else:
            tab.queue_free()

func _refresh_shared_navigation() -> void:
    for destination_id in market_nav_tabs:
        var tab: Button = market_nav_tabs[destination_id]
        if tab.has_method("set_selected"):
            tab.call("set_selected", destination_id == "market")

func _refresh_shared_shell_status() -> void:
    if screen_shell == null:
        return
    screen_shell.set_scene_identity(
        "MERCADO",
        "DIA %d/%d • CAIXA R$ %d • HEAT %d • REP %d • INFL %d"
        % [
            game_state.day,
            game_state.MAX_DAYS,
            game_state.cash,
            int(round(game_state.heat)),
            int(round(game_state.reputation)),
            int(round(game_state.influence)),
        ],
    )

func _apply_shared_ui_layout() -> void:
    if screen_shell == null:
        return

    screen_shell.apply_layout_for_size(get_viewport_rect().size)
    call_deferred("_sync_market_action_region")

func _sync_market_action_region() -> void:
    if screen_shell == null or not is_instance_valid(scroll):
        return

    var viewport_size := get_viewport_rect().size
    var action_rect: Rect2 = screen_shell.action_region.get_global_rect()
    var market_rect: Rect2 = get_global_rect()
    if action_rect.size.x <= 0.0 or action_rect.size.y <= 0.0:
        return

    var action_left: float = action_rect.position.x - market_rect.position.x
    var action_top: float = action_rect.position.y - market_rect.position.y
    var action_right: float = action_rect.end.x - market_rect.position.x
    var action_bottom: float = action_rect.end.y - market_rect.position.y
    var portrait := viewport_size.y >= viewport_size.x
    var desired_height: float = (
        clampf(viewport_size.y * 0.34, 280.0, 420.0)
        if portrait
        else 250.0
    )
    var bottom_gap := 12.0
    var available_height := maxf(0.0, action_bottom - action_top - bottom_gap)
    var scroll_height := minf(desired_height, available_height)
    var dock_bottom := action_bottom - bottom_gap
    var dock_top := maxf(action_top, dock_bottom - scroll_height)

    scroll.anchor_left = 0.0
    scroll.anchor_top = 0.0
    scroll.anchor_right = 0.0
    scroll.anchor_bottom = 0.0
    scroll.offset_left = action_left
    scroll.offset_top = dock_top
    scroll.offset_right = action_right
    scroll.offset_bottom = dock_bottom
    scroll.custom_minimum_size.y = scroll_height

func _on_market_viewport_size_changed() -> void:
    _apply_shared_ui_layout()

func _on_shared_nav_pressed(destination_id: String) -> void:
    _refresh_shared_navigation()
    if destination_id == "market":
        return
    if destination_id == "city":
        city_requested.emit()
        return
    destination_requested.emit(destination_id)

func _on_campaign_utility_pressed() -> void:
    campaign_requested.emit()

func _append_buyer_card(buyer: Dictionary) -> void:
    var card := PanelContainer.new()
    var content := VBoxContainer.new()
    content.add_theme_constant_override("separation", 8)
    card.add_child(content)

    var title := Label.new()
    title.add_theme_font_size_override("font_size", 22)
    title.text = String(buyer.get("display_name", buyer.get("id", "Canal")))
    content.add_child(title)

    var channel := Label.new()
    channel.text = (
        "Canal licenciado"
        if String(buyer.get("channel", "")) == "licensed"
        else "Canal paralelo — risco/recompensa abstratos"
    )
    channel.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    content.add_child(channel)

    var relationship := Label.new()
    relationship.text = "Relacionamento: %d / 100" % int(round(
        float(buyer.get("relationship", 0.0))
    ))
    content.add_child(relationship)

    var sale_preview: Dictionary = Dictionary(buyer.get("sale_preview", {}))
    var sale_info := Label.new()
    sale_info.text = _format_preview("Venda do lote", sale_preview)
    sale_info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    content.add_child(sale_info)

    var sale_action: Dictionary = Dictionary(buyer.get("sale_action", {}))
    var sale_button := DalataButton.new()
    sale_button.role = DalataButton.Role.PRIMARY
    sale_button.semantic_action_id = StringName(
        "market/sale/%s" % String(buyer.get("id", ""))
    )
    sale_button.custom_minimum_size = Vector2(0, 52)
    sale_button.text = "Vender lote"
    sale_button.accessibility_name = "Vender lote para %s" % String(
        buyer.get("display_name", buyer.get("id", "canal"))
    )
    sale_button.disabled = not bool(sale_action.get("enabled", false))
    sale_button.tooltip_text = String(sale_action.get("reason", ""))
    sale_button.pressed.connect(
        _on_sale_pressed.bind(String(buyer.get("id", "")))
    )
    content.add_child(sale_button)

    var contract: Dictionary = Dictionary(buyer.get("contract", {}))
    var contract_info := Label.new()
    contract_info.text = (
        "Contrato: %d un. • qualidade mínima %d%% • bônus R$%d • relação +%d"
        % [
            int(contract.get("units", 0)),
            int(round(float(contract.get("min_quality", 0.0)) * 100.0)),
            int(contract.get("cash_bonus", 0)),
            int(round(float(contract.get("relationship_gain", 0.0)))),
        ]
    )
    contract_info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    content.add_child(contract_info)

    var contract_action: Dictionary = Dictionary(contract.get("action", {}))
    var contract_status := Label.new()
    if contract_focus_target == null:
        contract_focus_target = contract_status
    contract_status.text = "Estado: %s — %s" % [
        String(contract.get("state", "unavailable")),
        String(contract_action.get("reason", "")),
    ]
    contract_status.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    content.add_child(contract_status)

    var completion_preview: Dictionary = Dictionary(
        contract.get("completion_preview", {})
    )
    var completion_info := Label.new()
    completion_info.text = _format_preview(
        "Conclusão",
        completion_preview,
    )
    completion_info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    content.add_child(completion_info)

    var contract_button := DalataButton.new()
    contract_button.custom_minimum_size = Vector2(0, 52)
    var mode := String(contract_action.get("mode", "none"))
    contract_button.role = (
        DalataButton.Role.SECONDARY
        if mode == "resolve"
        else DalataButton.Role.PRIMARY
    )
    contract_button.semantic_action_id = StringName(
        "market/contract/%s/%s" % [String(contract.get("id", "")), mode]
    )
    contract_button.text = "Concluir contrato" if mode == "resolve" else "Aceitar contrato"
    contract_button.disabled = not bool(contract_action.get("enabled", false))
    contract_button.tooltip_text = String(contract_action.get("reason", ""))
    contract_button.pressed.connect(
        _on_contract_pressed.bind(
            String(contract.get("id", "")),
            mode,
        )
    )
    content.add_child(contract_button)

    buyer_list.add_child(card)

func _format_preview(prefix: String, preview: Dictionary) -> String:
    if not bool(preview.get("available", false)):
        return "%s: %s" % [
            prefix,
            String(preview.get("message", "indisponível")),
        ]

    var parts: Array[String] = []
    var cash_delta := int(preview.get("cash_delta", 0))
    var reputation_delta := float(preview.get("reputation_delta", 0.0))
    var influence_delta := float(preview.get("influence_delta", 0.0))
    var heat_delta := float(preview.get("heat_delta", 0.0))
    var relationship_delta := float(preview.get("relationship_delta", 0.0))

    if cash_delta != 0:
        parts.append("Caixa %+d" % cash_delta)
    if not is_zero_approx(reputation_delta):
        parts.append("Reputação %+.1f" % reputation_delta)
    if not is_zero_approx(influence_delta):
        parts.append("Influence %+.1f" % influence_delta)
    if not is_zero_approx(heat_delta):
        parts.append("Heat %+.1f" % heat_delta)
    if not is_zero_approx(relationship_delta):
        parts.append("Relação %+.1f" % relationship_delta)
    if parts.is_empty():
        parts.append("sem delta imediato adicional")

    return "%s: %s" % [prefix, " • ".join(parts)]

func _clear_buyer_list() -> void:
    contract_focus_target = null
    for child in buyer_list.get_children():
        buyer_list.remove_child(child)
        child.queue_free()

func _on_sale_pressed(buyer_id: String) -> void:
    match buyer_id:
        "varejista_licenciado":
            game_state.sell_legal()
        "rede_paralela":
            game_state.sell_parallel()
        _:
            feedback_label.text = "Canal de mercado desconhecido."

func _on_contract_pressed(contract_id: String, mode: String) -> void:
    if mode == "accept":
        if not game_state.accept_contract(contract_id):
            feedback_label.text = "O contrato não pôde ser aceito."
    elif mode == "resolve":
        if not game_state.resolve_active_contract():
            feedback_label.text = "O contrato ainda não pode ser concluído."
    else:
        feedback_label.text = "Ação de contrato indisponível."

func _on_message(text: String) -> void:
    feedback_label.text = text


func _on_city_pressed() -> void:
    city_requested.emit()


func _on_market_diorama_object_activated(context_id: String, object_id: String) -> void:
    if context_id != "market":
        return
    match object_id:
        "deal_counter":
            feedback_label.text = "Balcão 3D selecionado. Compradores e ações de venda estão logo abaixo."
            call_deferred("_focus_market_actions")
        "contract_tray":
            feedback_label.text = (
                "Bandeja 3D selecionada. O hotspot apenas navega a apresentação; "
                + "as informações de contrato estão logo abaixo."
            )
            call_deferred("_focus_market_contracts")

func _focus_market_actions() -> void:
    scroll.ensure_control_visible(buyer_list)

func _focus_market_contracts() -> void:
    if is_instance_valid(contract_focus_target):
        scroll.ensure_control_visible(contract_focus_target)
    else:
        scroll.ensure_control_visible(buyer_list)
