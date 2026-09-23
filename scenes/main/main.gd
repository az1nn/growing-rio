extends Control

const FIRST_NARRATIVE_EVENT := preload("res://resources/events/dalva_lucia_primeiro_depoimento.tres")

@onready var game_state = get_node("/root/GameState")
@onready var day_label: Label = %DayLabel
@onready var cash_label: Label = %CashLabel
@onready var heat_label: Label = %HeatLabel
@onready var rep_label: Label = %RepLabel
@onready var influence_label: Label = %InfluenceLabel
@onready var health_label: Label = %HealthLabel
@onready var inventory_label: Label = %InventoryLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var log_label: Label = %LogLabel
@onready var harvest_button: Button = %HarvestButton
@onready var legal_button: Button = %LegalButton
@onready var parallel_button: Button = %ParallelButton
@onready var narrative_panel: PanelContainer = %NarrativePanel
@onready var narrative_title: Label = %NarrativeTitle
@onready var narrative_body: Label = %NarrativeBody
@onready var narrative_choices: VBoxContainer = %NarrativeChoices
@onready var narrative_result: Label = %NarrativeResult
@onready var research_panel: PanelContainer = %ResearchPanel
@onready var research_title: Label = %ResearchTitle
@onready var research_body: Label = %ResearchBody
@onready var research_actions: VBoxContainer = %ResearchActions
@onready var research_result: Label = %ResearchResult

func _ready() -> void:
    game_state.state_changed.connect(_refresh)
    game_state.message_posted.connect(_on_message)
    _refresh()
    _on_message("Vertical slice iniciado. Administre o primeiro ciclo de 30 dias.")

func _refresh() -> void:
    day_label.text = "DIA %d / %d" % [game_state.day, game_state.MAX_DAYS]
    cash_label.text = "Caixa\nR$ %d" % game_state.cash
    heat_label.text = "Heat\n%d" % int(round(game_state.heat))
    rep_label.text = "Reputação\n%d" % int(round(game_state.reputation))
    influence_label.text = "Influence\n%d" % int(round(game_state.influence))
    health_label.text = "Saúde do lote: %d%%" % int(round(game_state.grow_health * 100.0))
    inventory_label.text = "Estoque: %d" % game_state.inventory
    progress_bar.value = game_state.progress_ratio() * 100.0
    harvest_button.disabled = game_state.grow_day < game_state.current_cycle_days() or game_state.inventory > 0
    legal_button.disabled = game_state.inventory <= 0
    parallel_button.disabled = game_state.inventory <= 0
    _refresh_narrative()
    _refresh_research()

func _refresh_narrative() -> void:
    var event_id := String(FIRST_NARRATIVE_EVENT.id)
    var available_ids: Array = Array(game_state.available_narrative_event_ids())
    _clear_narrative_choices()

    if available_ids.has(event_id):
        narrative_title.text = FIRST_NARRATIVE_EVENT.display_title
        narrative_body.text = FIRST_NARRATIVE_EVENT.body_text
        narrative_result.text = ""

        for choice_id_value in FIRST_NARRATIVE_EVENT.choice_ids:
            var choice_id := String(choice_id_value)
            var choice_button := Button.new()
            choice_button.custom_minimum_size = Vector2(0, 58)
            choice_button.text = String(
                FIRST_NARRATIVE_EVENT.choice_labels.get(choice_id, choice_id)
            )
            choice_button.pressed.connect(
                _on_narrative_choice_pressed.bind(choice_id)
            )
            narrative_choices.add_child(choice_button)
        return

    narrative_title.text = "Arquivo narrativo"
    if game_state.completed_event_ids.has(event_id):
        narrative_body.text = (
            "O primeiro registro foi concluído. "
            + "A divergência permanece preservada no estado da campanha."
        )
        return

    narrative_body.text = (
        "Nenhum evento narrativo disponível. "
        + "Continue a campanha para abrir novos registros."
    )
    narrative_result.text = ""

func _clear_narrative_choices() -> void:
    for child in narrative_choices.get_children():
        narrative_choices.remove_child(child)
        child.queue_free()

func _on_narrative_choice_pressed(choice_id: String) -> void:
    var result: Dictionary = game_state.resolve_narrative_choice(
        String(FIRST_NARRATIVE_EVENT.id),
        choice_id,
    )
    if not bool(result.get("changed", false)):
        narrative_result.text = String(
            result.get("message", "A escolha não pôde ser registrada.")
        )
        return

    var choice_label := String(
        FIRST_NARRATIVE_EVENT.choice_labels.get(choice_id, choice_id)
    )
    var signals_text := _format_system_signals(
        Array(result.get("system_signals", []))
    )
    var dispute_preserved := bool(
        game_state.narrative_flags.get(
            "lore_dalva_lucia_symbol_order_disputed",
            false,
        )
    )
    var archive_state := (
        "divergência preservada"
        if dispute_preserved
        else "estado narrativo não persistido"
    )
    narrative_result.text = (
        "Escolha registrada: %s.\nSinais: %s.\nArquivo: %s."
        % [choice_label, signals_text, archive_state]
    )

func _format_system_signals(values: Array) -> String:
    var labels := {
        "signal_research_up": "pesquisa ↑",
        "signal_research_down": "pesquisa ↓",
        "signal_memory_up": "memória ↑",
        "signal_community_up": "comunidade ↑",
        "signal_reputation_neutral": "reputação estável",
    }
    var text := ""
    for value in values:
        if not text.is_empty():
            text += ", "
        var signal_id := String(value)
        text += String(labels.get(signal_id, signal_id))
    if text.is_empty():
        return "sem sinal adicional"
    return text

func _refresh_research() -> void:
    var available_ids: Array = Array(game_state.available_research_step_ids())
    _clear_research_actions()

    research_title.text = "Pesquisa DA LATA"
    if available_ids.is_empty():
        research_body.text = (
            "Nenhuma etapa de pesquisa disponível. "
            + "Novas ações aparecem apenas quando o estado canônico libera evidências."
        )
        return

    research_body.text = (
        "Etapas liberadas pelo estado da campanha. "
        + "A pesquisa registra evidências sem transformar incerteza em fato."
    )
    for step_id_value in available_ids:
        var step_id := String(step_id_value)
        var presentation: Dictionary = game_state.research_step_presentation(step_id)
        if presentation.is_empty():
            continue

        var button := Button.new()
        button.custom_minimum_size = Vector2(0, 58)
        button.text = String(presentation.get("display_name", step_id))
        button.pressed.connect(_on_research_step_pressed.bind(step_id))
        research_actions.add_child(button)

func _clear_research_actions() -> void:
    for child in research_actions.get_children():
        research_actions.remove_child(child)
        child.queue_free()

func _on_research_step_pressed(step_id: String) -> void:
    var result: Dictionary = game_state.complete_research_step(step_id)
    if not bool(result.get("changed", false)):
        research_result.text = String(
            result.get("message", "A etapa de pesquisa não pôde ser registrada.")
        )
        _refresh_research()
        return

    var evidence_text := _format_research_values(
        Array(result.get("evidence_tags", [])),
        {
            "evidence_object_memory": "objeto preservado em memória",
            "evidence_provenance_unresolved": "proveniência não autenticada",
            "evidence_symbol_order_disputed": "ordem dos símbolos disputada",
            "evidence_parallel_versions": "versões paralelas registradas",
            "evidence_priority_unresolved": "prioridade entre versões em aberto",
            "evidence_chain_of_custody_gaps": "lacunas de cadeia de custódia registradas",
            "evidence_material_context_only": "contexto material sem autenticação de origem",
        },
    )
    var guardrail_text := _format_research_values(
        Array(result.get("canon_guardrails", [])),
        {
            "research_does_not_authenticate_historical_lineage":
                "não autentica linhagem histórica ou genética",
            "research_records_uncertainty": "incerteza permanece registrada",
            "no_real_cultivation_parameters": "sem parâmetros reais de cultivo",
            "symbol_order_remains_open": "ordem dos símbolos permanece em aberto",
            "onda_can_provenance_remains_open": "procedência da lata Onda permanece em aberto",
        },
    )
    research_result.text = (
        "Pesquisa registrada.\nEvidência: %s.\nSinais: %s.\nLimites de cânone: %s."
        % [
            evidence_text,
            _format_system_signals(Array(result.get("system_signals", []))),
            guardrail_text,
        ]
    )
    _refresh_research()

func _format_research_values(values: Array, labels: Dictionary) -> String:
    var text := ""
    for value in values:
        if not text.is_empty():
            text += ", "
        var item_id := String(value)
        text += String(labels.get(item_id, item_id))
    if text.is_empty():
        return "sem informação adicional"
    return text

func _on_message(text: String) -> void:
    log_label.text = text

func _on_care_pressed() -> void:
    game_state.care_for_room()

func _on_next_day_pressed() -> void:
    game_state.next_day()

func _on_harvest_pressed() -> void:
    game_state.harvest()

func _on_legal_pressed() -> void:
    game_state.sell_legal()

func _on_parallel_pressed() -> void:
    game_state.sell_parallel()

func _on_civic_pressed() -> void:
    game_state.civic_engagement()

func _on_reset_pressed() -> void:
    narrative_result.text = ""
    research_result.text = ""
    game_state.reset()
