extends Control

const DESTINATION_OPERATION := "operation"
const DESTINATION_MARKET := "market"
const DESTINATION_CITY := "city"
const DESTINATION_INSTITUTIONAL := "institutional"
const DESTINATION_ARCHIVE := "archive"
const DESTINATION_IDS := [
    DESTINATION_OPERATION,
    DESTINATION_MARKET,
    DESTINATION_CITY,
    DESTINATION_INSTITUTIONAL,
    DESTINATION_ARCHIVE,
]

@onready var game_state = get_node("/root/GameState")
@onready var day_label: Label = %ShellDayLabel
@onready var cash_label: Label = %ShellCashLabel
@onready var heat_label: Label = %ShellHeatLabel
@onready var reputation_label: Label = %ShellReputationLabel
@onready var influence_label: Label = %ShellInfluenceLabel
@onready var destination_label: Label = %DestinationLabel

@onready var operation_surface: Control = %OperationSurface
@onready var market_surface: Control = %MarketSurface
@onready var city_surface: Control = %CitySurface
@onready var institutional_surface: Control = %InstitutionalSurface
@onready var archive_surface: Control = %ArchiveSurface

@onready var portrait_nav: HBoxContainer = %PortraitNav
@onready var wide_nav: VBoxContainer = %WideNav

@onready var operation_button: Button = %OperationButton
@onready var market_button: Button = %MarketButton
@onready var city_button: Button = %CityButton
@onready var institutional_button: Button = %InstitutionalButton
@onready var archive_button: Button = %ArchiveButton

@onready var wide_operation_button: Button = %WideOperationButton
@onready var wide_market_button: Button = %WideMarketButton
@onready var wide_city_button: Button = %WideCityButton
@onready var wide_institutional_button: Button = %WideInstitutionalButton
@onready var wide_archive_button: Button = %WideArchiveButton

@onready var overlay_host: PanelContainer = %OverlayHost
@onready var overlay_title: Label = %OverlayTitle
@onready var overlay_body: Label = %OverlayBody
@onready var overlay_choices: VBoxContainer = %OverlayChoices
@onready var overlay_result: Label = %OverlayResult
@onready var overlay_close_button: Button = %OverlayCloseButton

var current_destination := DESTINATION_OPERATION
var active_overlay_id := ""
var overlay_return_destination := DESTINATION_OPERATION
var overlay_requires_resolution := false
var wide_layout := false

func _ready() -> void:
    game_state.state_changed.connect(_on_game_state_changed)
    if market_surface.has_signal("city_requested"):
        market_surface.connect(
            "city_requested",
            Callable(self, "_on_market_city_requested"),
        )
    get_viewport().size_changed.connect(_on_viewport_size_changed)
    _refresh_global_status()
    apply_layout_for_size(get_viewport_rect().size)
    _apply_destination()
    call_deferred("_refresh_narrative_interruption")

func destination_ids() -> Array:
    return DESTINATION_IDS.duplicate()

func navigate_to(destination_id: String) -> bool:
    if not active_overlay_id.is_empty():
        return false
    if not DESTINATION_IDS.has(destination_id):
        return false
    if current_destination == destination_id:
        return true

    current_destination = destination_id
    _apply_destination()
    return true

func open_overlay(
    overlay_id: String,
    title: String = "",
    body: String = "",
) -> bool:
    if overlay_id.is_empty() or not active_overlay_id.is_empty():
        return false

    active_overlay_id = overlay_id
    overlay_return_destination = current_destination
    overlay_requires_resolution = false
    overlay_title.text = title if not title.is_empty() else "DA LATA"
    overlay_body.text = body
    overlay_result.text = ""
    _clear_overlay_choices()
    overlay_close_button.visible = true
    overlay_host.visible = true
    _refresh_nav_state()
    return true

func close_overlay() -> bool:
    if active_overlay_id.is_empty() or overlay_requires_resolution:
        return false

    active_overlay_id = ""
    overlay_requires_resolution = false
    overlay_host.visible = false
    overlay_result.text = ""
    _clear_overlay_choices()
    if DESTINATION_IDS.has(overlay_return_destination):
        current_destination = overlay_return_destination
    overlay_return_destination = current_destination
    _apply_destination()
    call_deferred("_refresh_narrative_interruption")
    return true

func handle_back_request() -> bool:
    if not active_overlay_id.is_empty():
        return close_overlay()
    return false

func apply_layout_for_size(viewport_size: Vector2) -> void:
    wide_layout = viewport_size.x >= 900.0 and viewport_size.x > viewport_size.y
    wide_nav.visible = wide_layout
    portrait_nav.visible = not wide_layout
    _refresh_nav_state()

func _on_game_state_changed() -> void:
    _refresh_global_status()
    if archive_surface.has_method("refresh_from_state"):
        archive_surface.call("refresh_from_state")
    call_deferred("_refresh_narrative_interruption")

func _refresh_global_status() -> void:
    day_label.text = "DIA %d / %d" % [game_state.day, game_state.MAX_DAYS]
    cash_label.text = "Caixa\nR$ %d" % game_state.cash
    heat_label.text = "Heat\n%d" % int(round(game_state.heat))
    reputation_label.text = "Reputação\n%d" % int(round(game_state.reputation))
    influence_label.text = "Influence\n%d" % int(round(game_state.influence))

func _apply_destination() -> void:
    operation_surface.visible = current_destination == DESTINATION_OPERATION
    market_surface.visible = current_destination == DESTINATION_MARKET
    city_surface.visible = current_destination == DESTINATION_CITY
    institutional_surface.visible = current_destination == DESTINATION_INSTITUTIONAL
    archive_surface.visible = current_destination == DESTINATION_ARCHIVE

    destination_label.text = _destination_display_name(current_destination)
    _refresh_nav_state()

func _refresh_nav_state() -> void:
    var modal_active := not active_overlay_id.is_empty()

    operation_button.disabled = modal_active or current_destination == DESTINATION_OPERATION
    market_button.disabled = modal_active or current_destination == DESTINATION_MARKET
    city_button.disabled = modal_active or current_destination == DESTINATION_CITY
    institutional_button.disabled = (
        modal_active or current_destination == DESTINATION_INSTITUTIONAL
    )
    archive_button.disabled = modal_active or current_destination == DESTINATION_ARCHIVE

    wide_operation_button.disabled = (
        modal_active or current_destination == DESTINATION_OPERATION
    )
    wide_market_button.disabled = modal_active or current_destination == DESTINATION_MARKET
    wide_city_button.disabled = modal_active or current_destination == DESTINATION_CITY
    wide_institutional_button.disabled = (
        modal_active or current_destination == DESTINATION_INSTITUTIONAL
    )
    wide_archive_button.disabled = modal_active or current_destination == DESTINATION_ARCHIVE

func _refresh_narrative_interruption() -> void:
    if not active_overlay_id.is_empty():
        return

    var available_ids: Array = Array(game_state.available_narrative_event_ids())
    if available_ids.is_empty():
        return

    var event_id := String(available_ids[0])
    var presentation: Dictionary = game_state.narrative_event_presentation(event_id)
    if presentation.is_empty():
        return

    active_overlay_id = "narrative:%s" % event_id
    overlay_return_destination = current_destination
    overlay_requires_resolution = true
    overlay_title.text = String(presentation.get("display_title", "Registro narrativo"))
    overlay_body.text = String(presentation.get("body_text", ""))
    overlay_result.text = ""
    overlay_close_button.visible = false
    _clear_overlay_choices()

    var choice_labels: Dictionary = Dictionary(presentation.get("choice_labels", {}))
    for choice_id_value in Array(presentation.get("choice_ids", [])):
        var choice_id := String(choice_id_value)
        var button := Button.new()
        button.custom_minimum_size = Vector2(0, 54)
        button.text = String(choice_labels.get(choice_id, choice_id))
        button.pressed.connect(
            _on_narrative_choice_pressed.bind(event_id, choice_id)
        )
        overlay_choices.add_child(button)

    overlay_host.visible = true
    _refresh_nav_state()

func _on_narrative_choice_pressed(event_id: String, choice_id: String) -> void:
    var presentation: Dictionary = game_state.narrative_event_presentation(event_id)
    var choice_labels: Dictionary = Dictionary(presentation.get("choice_labels", {}))
    var result: Dictionary = Dictionary(
        archive_surface.call("resolve_narrative_choice", event_id, choice_id)
    )
    if not bool(result.get("changed", false)):
        overlay_result.text = String(
            result.get("message", "A escolha não pôde ser registrada.")
        )
        return

    _clear_overlay_choices()
    overlay_requires_resolution = false
    overlay_close_button.visible = true

    var choice_label := String(choice_labels.get(choice_id, choice_id))
    overlay_result.text = (
        "Escolha registrada: %s.\nSinais: %s.\nLimites: %s."
        % [
            choice_label,
            _format_system_signals(Array(result.get("system_signals", []))),
            _format_canon_guardrails(Array(result.get("canon_guardrails", []))),
        ]
    )

func _clear_overlay_choices() -> void:
    for child in overlay_choices.get_children():
        overlay_choices.remove_child(child)
        child.queue_free()

func _format_system_signals(values: Array) -> String:
    var labels := {
        "signal_research_up": "pesquisa ↑",
        "signal_research_down": "pesquisa ↓",
        "signal_memory_up": "memória ↑",
        "signal_community_up": "comunidade ↑",
        "signal_reputation_neutral": "reputação estável",
    }
    var parts: Array = []
    for value in values:
        var item_id := String(value)
        parts.append(String(labels.get(item_id, item_id)))
    return "sem sinal adicional" if parts.is_empty() else ", ".join(parts)

func _format_canon_guardrails(values: Array) -> String:
    var labels := {
        "symbol_order_remains_open": "ordem dos símbolos permanece em aberto",
        "onda_can_provenance_remains_open":
            "procedência da lata Onda permanece em aberto",
        "material_compatibility_does_not_prove_lineage":
            "compatibilidade material não prova linhagem",
        "influence_is_access_not_control": "Influence representa acesso, não controle",
        "no_targeted_persuasion": "sem persuasão política direcionada",
    }
    var parts: Array = []
    for value in values:
        var item_id := String(value)
        parts.append(String(labels.get(item_id, item_id)))
    return "sem limite adicional" if parts.is_empty() else ", ".join(parts)

func _destination_display_name(destination_id: String) -> String:
    match destination_id:
        DESTINATION_OPERATION:
            return "Operação"
        DESTINATION_MARKET:
            return "Mercado"
        DESTINATION_CITY:
            return "Cidade"
        DESTINATION_INSTITUTIONAL:
            return "Institucional"
        DESTINATION_ARCHIVE:
            return "Arquivo"
        _:
            return destination_id

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel") and handle_back_request():
        get_viewport().set_input_as_handled()

func _on_viewport_size_changed() -> void:
    apply_layout_for_size(get_viewport_rect().size)

func _on_overlay_close_pressed() -> void:
    close_overlay()

func _on_operation_pressed() -> void:
    navigate_to(DESTINATION_OPERATION)

func _on_market_pressed() -> void:
    navigate_to(DESTINATION_MARKET)

func _on_city_pressed() -> void:
    navigate_to(DESTINATION_CITY)

func _on_institutional_pressed() -> void:
    navigate_to(DESTINATION_INSTITUTIONAL)

func _on_archive_pressed() -> void:
    navigate_to(DESTINATION_ARCHIVE)

func _on_market_city_requested() -> void:
    navigate_to(DESTINATION_CITY)
