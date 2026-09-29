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
const CAMPAIGN_FLOW_CONTROLLER := preload(
    "res://scenes/campaign/campaign_flow_controller.gd"
)

@onready var game_state = get_node("/root/GameState")
@onready var day_label: Label = %ShellDayLabel
@onready var cash_label: Label = %ShellCashLabel
@onready var heat_label: Label = %ShellHeatLabel
@onready var reputation_label: Label = %ShellReputationLabel
@onready var influence_label: Label = %ShellInfluenceLabel
@onready var destination_label: Label = %DestinationLabel
@onready var global_status: GridContainer = %GlobalStatus
@onready var campaign_button: Button = %CampaignButton

@onready var shell_margin: MarginContainer = $Margin
@onready var shell_layout: VBoxContainer = $Margin/Layout
@onready var shell_header: VBoxContainer = $Margin/Layout/Header
@onready var app_title: Label = $Margin/Layout/Header/TitleRow/AppTitle

@onready var operation_surface: Control = %OperationSurface
@onready var market_surface: Control = %MarketSurface
@onready var city_surface: Control = %CitySurface
@onready var institutional_surface: Control = %InstitutionalSurface
@onready var archive_surface: Control = %ArchiveSurface

@onready var portrait_nav: GridContainer = %PortraitNav
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
@onready var campaign_diorama = %CampaignDiorama
@onready var narrative_diorama = %NarrativeDiorama

var current_destination := DESTINATION_OPERATION
var active_overlay_id := ""
var overlay_return_destination := DESTINATION_OPERATION
var overlay_requires_resolution := false
var wide_layout := false
var compact_portrait := false
var campaign_flow
var startup_campaign_prompt_resolved := false
var campaign_operation_message := ""

func _ready() -> void:
    campaign_flow = CAMPAIGN_FLOW_CONTROLLER.new(game_state)
    game_state.state_changed.connect(_on_game_state_changed)
    game_state.message_posted.connect(_on_game_state_message_posted)
    if market_surface.has_signal("city_requested"):
        market_surface.connect(
            "city_requested",
            Callable(self, "_on_market_city_requested"),
        )
    if campaign_diorama.has_signal("object_activated"):
        campaign_diorama.object_activated.connect(_on_campaign_diorama_object_activated)
    if narrative_diorama.has_signal("object_activated"):
        narrative_diorama.object_activated.connect(_on_narrative_diorama_object_activated)
    get_viewport().size_changed.connect(_on_viewport_size_changed)
    _refresh_global_status()
    apply_layout_for_size(_current_window_size())
    _apply_destination()
    call_deferred("_refresh_startup_campaign_prompt")

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

func handle_destination_shortcut(keycode: int) -> bool:
    match keycode:
        KEY_1:
            return navigate_to(DESTINATION_OPERATION)
        KEY_2:
            return navigate_to(DESTINATION_MARKET)
        KEY_3:
            return navigate_to(DESTINATION_CITY)
        KEY_4:
            return navigate_to(DESTINATION_INSTITUTIONAL)
        KEY_5:
            return navigate_to(DESTINATION_ARCHIVE)
        _:
            return false

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
    _sync_overlay_diorama_visibility()
    _refresh_nav_state()
    return true

func close_overlay() -> bool:
    if active_overlay_id.is_empty() or overlay_requires_resolution:
        return false

    active_overlay_id = ""
    overlay_requires_resolution = false
    overlay_host.visible = false
    _sync_overlay_diorama_visibility()
    overlay_result.text = ""
    _clear_overlay_choices()
    if DESTINATION_IDS.has(overlay_return_destination):
        current_destination = overlay_return_destination
    overlay_return_destination = current_destination
    _apply_destination()
    call_deferred("_refresh_narrative_interruption")
    return true

func _sync_overlay_diorama_visibility() -> void:
    campaign_diorama.visible = active_overlay_id.begins_with("campaign:")
    narrative_diorama.visible = active_overlay_id.begins_with("narrative:")

func _on_campaign_diorama_object_activated(context_id: String, _object_id: String) -> void:
    if context_id != "campaign" or not active_overlay_id.begins_with("campaign:"):
        return
    overlay_result.text = (
        "Calendário 3D selecionado. As decisões de campanha continuam nos controles abaixo."
    )
    call_deferred("_focus_campaign_controls")

func _focus_campaign_controls() -> void:
    if overlay_choices.get_child_count() == 0:
        return
    var first_choice = overlay_choices.get_child(0)
    if first_choice is Control:
        first_choice.grab_focus()

func _on_narrative_diorama_object_activated(context_id: String, _object_id: String) -> void:
    if context_id != "narrative" or not active_overlay_id.begins_with("narrative:"):
        return
    overlay_result.text = (
        "Evidência 3D selecionada. A escolha narrativa continua nos controles abaixo."
    )
    call_deferred("_focus_narrative_choices")

func _focus_narrative_choices() -> void:
    if overlay_choices.get_child_count() == 0:
        return
    var first_choice = overlay_choices.get_child(0)
    if first_choice is Control:
        first_choice.grab_focus()

func handle_back_request() -> bool:
    if not active_overlay_id.is_empty():
        return close_overlay()
    return false

func _current_window_size() -> Vector2:
    var window_size := DisplayServer.window_get_size()
    if window_size.x > 0 and window_size.y > 0:
        return Vector2(window_size)
    return get_viewport_rect().size

func apply_layout_for_size(viewport_size: Vector2) -> void:
    wide_layout = viewport_size.x >= 900.0 and viewport_size.x > viewport_size.y
    compact_portrait = not wide_layout and viewport_size.x <= 600.0
    wide_nav.visible = wide_layout
    portrait_nav.visible = not wide_layout
    global_status.columns = 5 if wide_layout else 3
    portrait_nav.columns = 3
    _apply_shell_density()
    _refresh_global_status()
    _refresh_nav_state()

func _apply_shell_density() -> void:
    shell_margin.offset_left = 12.0 if compact_portrait else 16.0
    shell_margin.offset_top = 12.0 if compact_portrait else 18.0
    shell_margin.offset_right = -12.0 if compact_portrait else -16.0
    shell_margin.offset_bottom = -12.0 if compact_portrait else -18.0
    shell_layout.add_theme_constant_override("separation", 8 if compact_portrait else 12)
    shell_header.add_theme_constant_override("separation", 6 if compact_portrait else 8)
    app_title.add_theme_font_size_override("font_size", 26 if compact_portrait else 30)
    destination_label.add_theme_font_size_override("font_size", 18 if compact_portrait else 22)
    campaign_button.custom_minimum_size = (
        Vector2(100, 44) if compact_portrait else Vector2(116, 48)
    )

    for status_label in [
        day_label,
        cash_label,
        heat_label,
        reputation_label,
        influence_label,
    ]:
        if compact_portrait:
            status_label.add_theme_font_size_override("font_size", 16)
        else:
            status_label.remove_theme_font_size_override("font_size")

    if compact_portrait:
        global_status.add_theme_constant_override("h_separation", 4)
        global_status.add_theme_constant_override("v_separation", 4)
    else:
        global_status.remove_theme_constant_override("h_separation")
        global_status.remove_theme_constant_override("v_separation")

func _on_game_state_changed() -> void:
    _refresh_global_status()
    if archive_surface.has_method("refresh_from_state"):
        archive_surface.call("refresh_from_state")
    call_deferred("_refresh_narrative_interruption")

func _refresh_global_status() -> void:
    if compact_portrait:
        day_label.text = "DIA\n%d/%d" % [game_state.day, game_state.MAX_DAYS]
        cash_label.text = "CAIXA\nR$ %d" % game_state.cash
        heat_label.text = "HEAT\n%d" % int(round(game_state.heat))
        reputation_label.text = "REP.\n%d" % int(round(game_state.reputation))
        influence_label.text = "INFL.\n%d" % int(round(game_state.influence))
        return

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
    campaign_button.disabled = modal_active

    wide_operation_button.disabled = (
        modal_active or current_destination == DESTINATION_OPERATION
    )
    wide_market_button.disabled = modal_active or current_destination == DESTINATION_MARKET
    wide_city_button.disabled = modal_active or current_destination == DESTINATION_CITY
    wide_institutional_button.disabled = (
        modal_active or current_destination == DESTINATION_INSTITUTIONAL
    )
    wide_archive_button.disabled = modal_active or current_destination == DESTINATION_ARCHIVE

func has_campaign_slot() -> bool:
    return campaign_flow.has_slot()

func open_campaign_menu() -> bool:
    if not active_overlay_id.is_empty():
        return false
    startup_campaign_prompt_resolved = true
    if not open_overlay(
        "campaign:menu",
        "Campanha",
        "Gerencie o slot local desta campanha.",
    ):
        return false
    _render_campaign_menu()
    return true

func _refresh_startup_campaign_prompt() -> void:
    if startup_campaign_prompt_resolved:
        call_deferred("_refresh_narrative_interruption")
        return
    if not active_overlay_id.is_empty():
        return

    if not campaign_flow.has_slot():
        startup_campaign_prompt_resolved = true
        call_deferred("_refresh_narrative_interruption")
        return

    if not open_overlay(
        "campaign:startup",
        "DA LATA",
        "Uma campanha salva foi encontrada neste dispositivo.",
    ):
        return
    _render_startup_campaign_choices()

func _render_startup_campaign_choices() -> void:
    overlay_title.text = "DA LATA"
    overlay_body.text = (
        "Uma campanha salva foi encontrada. Continue de onde parou ou "
        + "inicie um novo ciclo sem apagar o slot existente."
    )
    overlay_result.text = ""
    overlay_requires_resolution = true
    overlay_close_button.visible = false
    _clear_overlay_choices()
    _add_overlay_action(
        "Continuar campanha",
        Callable(self, "_on_campaign_continue_pressed"),
    )
    _add_overlay_action(
        "Nova campanha",
        Callable(self, "_on_campaign_new_pressed"),
    )

func _render_campaign_menu() -> void:
    overlay_title.text = "Campanha"
    if game_state.finale_completed():
        overlay_body.text = (
            "Campanha concluída. O mundo permanece navegável; salvar e carregar "
            + "preservam o desfecho, e Nova campanha reinicia o estado canônico."
        )
    else:
        overlay_body.text = (
            "O slot local guarda apenas estado canônico do jogo. "
            + "Navegação e overlays não entram no save."
        )
    overlay_result.text = ""
    overlay_requires_resolution = false
    overlay_close_button.visible = true
    _clear_overlay_choices()

    _add_overlay_action(
        "Salvar campanha",
        Callable(self, "_on_campaign_save_pressed"),
    )
    if campaign_flow.has_slot():
        _add_overlay_action(
            "Carregar campanha",
            Callable(self, "_on_campaign_load_pressed"),
        )
    _add_overlay_action(
        "Nova campanha",
        Callable(self, "_on_campaign_new_pressed"),
    )
    if game_state.finale_completed():
        _add_overlay_action(
            "Rever desfecho",
            Callable(self, "_on_finale_recap_pressed"),
        )

func _show_campaign_confirmation(action_id: String) -> void:
    overlay_requires_resolution = true
    overlay_close_button.visible = false
    overlay_result.text = ""
    _clear_overlay_choices()

    match action_id:
        "overwrite":
            overlay_title.text = "Substituir save?"
            overlay_body.text = (
                "O slot atual será substituído pela campanha em memória. "
                + "Essa ação exige confirmação."
            )
            _add_overlay_action(
                "Confirmar substituição",
                Callable(self, "_on_campaign_confirm_save_pressed"),
            )
        "new":
            overlay_title.text = "Nova campanha?"
            overlay_body.text = (
                "O ciclo ativo será reiniciado. O slot salvo não será apagado "
                + "até que você escolha salvar por cima dele."
            )
            _add_overlay_action(
                "Confirmar novo ciclo",
                Callable(self, "_on_campaign_confirm_new_pressed"),
            )
        _:
            _render_campaign_menu()
            return

    _add_overlay_action(
        "Cancelar",
        Callable(self, "_on_campaign_confirmation_cancel_pressed"),
    )

func _add_overlay_action(label: String, callback: Callable) -> void:
    var button := Button.new()
    button.custom_minimum_size = Vector2(0, 54)
    button.text = label
    button.pressed.connect(callback)
    overlay_choices.add_child(button)

func _on_game_state_message_posted(text: String) -> void:
    if active_overlay_id.begins_with("campaign:"):
        campaign_operation_message = text

func _on_campaign_continue_pressed() -> void:
    _perform_campaign_load()

func _on_campaign_load_pressed() -> void:
    _perform_campaign_load()

func _on_campaign_save_pressed() -> void:
    if campaign_flow.has_slot():
        _show_campaign_confirmation("overwrite")
        return
    _perform_campaign_save()

func _on_campaign_new_pressed() -> void:
    _show_campaign_confirmation("new")

func _on_campaign_confirm_save_pressed() -> void:
    _perform_campaign_save()

func _on_campaign_confirm_new_pressed() -> void:
    var result: Dictionary = campaign_flow.start_new_campaign()
    if not bool(result.get("ok", false)):
        overlay_result.text = String(
            result.get("error", "Não foi possível iniciar uma nova campanha.")
        )
        return
    startup_campaign_prompt_resolved = true
    overlay_requires_resolution = false
    close_overlay()

func _on_campaign_confirmation_cancel_pressed() -> void:
    if active_overlay_id == "campaign:startup":
        _render_startup_campaign_choices()
    else:
        _render_campaign_menu()

func _perform_campaign_save() -> Dictionary:
    var result: Dictionary = campaign_flow.save_campaign()
    if not bool(result.get("ok", false)):
        overlay_result.text = String(
            result.get("error", "Não foi possível salvar a campanha.")
        )
        return result

    overlay_requires_resolution = false
    overlay_close_button.visible = true
    _render_campaign_menu()
    overlay_result.text = "Campanha salva neste dispositivo."
    return result

func _perform_campaign_load() -> Dictionary:
    campaign_operation_message = ""
    var result: Dictionary = campaign_flow.load_campaign()
    if not bool(result.get("ok", false)):
        var message := campaign_operation_message
        if message.is_empty():
            message = String(
                result.get(
                    "error",
                    "Não foi possível carregar a campanha; o estado ativo foi preservado.",
                )
            )
        overlay_result.text = message
        return {
            "ok": false,
            "error": message,
        }

    startup_campaign_prompt_resolved = true
    overlay_requires_resolution = false
    close_overlay()
    return result

func _refresh_narrative_interruption() -> void:
    if not active_overlay_id.is_empty():
        return

    var available_ids: Array = Array(game_state.available_narrative_event_ids())
    if available_ids.is_empty():
        call_deferred("_refresh_finale_flow")
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
    _sync_overlay_diorama_visibility()

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

func _refresh_finale_flow() -> void:
    if not active_overlay_id.is_empty() or game_state.finale_completed():
        return

    var selected_ending_id := String(game_state.selected_ending_id)
    if not selected_ending_id.is_empty():
        _render_finale_handoff(selected_ending_id)
        return

    var eligible_ids: Array = Array(game_state.eligible_ending_ids())
    if eligible_ids.is_empty():
        return
    _render_finale_selection(eligible_ids)

func _render_finale_selection(eligible_ids: Array) -> void:
    active_overlay_id = "finale:selection"
    overlay_return_destination = current_destination
    overlay_requires_resolution = true
    overlay_title.text = "Escolha o desfecho"
    overlay_body.text = (
        "Sua campanha tornou estes caminhos elegíveis. "
        + "A ordem é alfabética e não expressa preferência."
    )
    overlay_result.text = ""
    overlay_close_button.visible = false
    _clear_overlay_choices()

    var presentations: Array = []
    for ending_id_value in eligible_ids:
        var ending_id := String(ending_id_value)
        var presentation: Dictionary = game_state.ending_presentation(ending_id)
        if not presentation.is_empty():
            presentations.append(presentation)
    presentations.sort_custom(Callable(self, "_sort_finale_presentations"))

    for presentation_value in presentations:
        var presentation: Dictionary = presentation_value
        var ending_id := String(presentation.get("id", ""))
        _add_overlay_action(
            String(presentation.get("display_name", ending_id)),
            Callable(self, "_on_finale_ending_pressed").bind(ending_id),
        )

    overlay_host.visible = true
    _refresh_nav_state()

func _sort_finale_presentations(left: Dictionary, right: Dictionary) -> bool:
    return (
        String(left.get("display_name", ""))
        < String(right.get("display_name", ""))
    )

func _on_finale_ending_pressed(ending_id: String) -> void:
    if active_overlay_id != "finale:selection":
        return

    var result: Dictionary = campaign_flow.choose_finale_path(ending_id)
    if not bool(result.get("changed", false)):
        overlay_result.text = String(
            result.get("message", "O desfecho não pôde ser registrado.")
        )
        return
    _render_finale_handoff(String(game_state.selected_ending_id))

func _render_finale_handoff(ending_id: String) -> void:
    var presentation: Dictionary = game_state.ending_presentation(ending_id)
    if presentation.is_empty():
        return

    if active_overlay_id.is_empty():
        overlay_return_destination = current_destination
    active_overlay_id = "finale:handoff"
    overlay_requires_resolution = true
    overlay_title.text = "DA LATA — %s" % String(
        presentation.get("display_name", ending_id)
    )
    overlay_body.text = String(presentation.get("handoff_text", ""))
    overlay_result.text = ""
    overlay_close_button.visible = false
    _clear_overlay_choices()
    _add_overlay_action(
        "Concluir campanha",
        Callable(self, "_on_finale_complete_pressed"),
    )
    overlay_host.visible = true
    _refresh_nav_state()

func _on_finale_complete_pressed() -> void:
    var result: Dictionary = campaign_flow.finish_finale()
    if not bool(result.get("completed", false)):
        overlay_result.text = String(
            result.get("message", "O desfecho não pôde ser concluído.")
        )
        return
    _render_finale_coda(String(game_state.selected_ending_id), "finale:coda")

func _render_finale_coda(ending_id: String, overlay_id: String) -> void:
    var presentation: Dictionary = game_state.ending_presentation(ending_id)
    if presentation.is_empty():
        return

    if active_overlay_id.is_empty():
        overlay_return_destination = current_destination
    active_overlay_id = overlay_id
    overlay_requires_resolution = false
    overlay_title.text = String(presentation.get("display_name", "DA LATA"))
    overlay_body.text = (
        String(presentation.get("coda_text", ""))
        + "\n\nCampanha concluída. O mundo permanece navegável. "
        + "Salvar/Carregar preserva este desfecho; Nova campanha inicia outro ciclo."
    )
    overlay_result.text = "DA LATA concluída."
    overlay_close_button.visible = true
    _clear_overlay_choices()
    overlay_host.visible = true
    _refresh_nav_state()

func _on_finale_recap_pressed() -> void:
    if not game_state.finale_completed():
        return
    _render_finale_coda(String(game_state.selected_ending_id), "finale:recap")

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

func _unhandled_key_input(event: InputEvent) -> void:
    if not event is InputEventKey:
        return
    var key_event := event as InputEventKey
    if not key_event.pressed or key_event.echo:
        return
    if key_event.physical_keycode == KEY_C and open_campaign_menu():
        get_viewport().set_input_as_handled()
        return
    if handle_destination_shortcut(key_event.physical_keycode):
        get_viewport().set_input_as_handled()

func _on_viewport_size_changed() -> void:
    apply_layout_for_size(_current_window_size())

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

func _on_campaign_pressed() -> void:
    open_campaign_menu()

func _on_market_city_requested() -> void:
    navigate_to(DESTINATION_CITY)
