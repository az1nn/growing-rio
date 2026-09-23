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

func _refresh_narrative() -> void:
    var event_id := String(FIRST_NARRATIVE_EVENT.id)
    var available_ids := game_state.available_narrative_event_ids()
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
    game_state.reset()
