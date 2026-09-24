extends Control

signal city_requested

@onready var game_state = get_node("/root/GameState")
@onready var summary_label: Label = %MarketSummaryLabel
@onready var context_label: Label = %MarketContextLabel
@onready var buyer_list: VBoxContainer = %BuyerList
@onready var feedback_label: Label = %MarketFeedbackLabel

func _ready() -> void:
    game_state.state_changed.connect(_refresh)
    game_state.message_posted.connect(_on_message)
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
    var sale_button := Button.new()
    sale_button.custom_minimum_size = Vector2(0, 52)
    sale_button.text = "Vender lote"
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

    var contract_button := Button.new()
    contract_button.custom_minimum_size = Vector2(0, 52)
    var mode := String(contract_action.get("mode", "none"))
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
