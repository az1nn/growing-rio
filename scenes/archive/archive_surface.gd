extends Control

const RESEARCH_DEFINITIONS := [
    preload("res://resources/research/onda_evidence_catalog.tres"),
    preload("res://resources/research/symbol_order_comparison.tres"),
    preload("res://resources/research/onda_provenance_gap_map.tres"),
    preload("res://resources/research/evidence_boundary_synthesis.tres"),
    preload("res://resources/research/material_compatibility_review.tres"),
]

@onready var game_state = get_node("/root/GameState")
@onready var research_status: Label = %ResearchStatus
@onready var research_actions: VBoxContainer = %ResearchActions
@onready var research_result: Label = %ResearchResult
@onready var completed_research_list: VBoxContainer = %CompletedResearchList
@onready var completed_narrative_list: VBoxContainer = %CompletedNarrativeList
@onready var scroll: ScrollContainer = $Scroll
@onready var archive_diorama = $Interactive3D

func _ready() -> void:
    game_state.state_changed.connect(_refresh)
    archive_diorama.object_activated.connect(_on_archive_diorama_object_activated)
    _refresh()

func refresh_from_state() -> void:
    _refresh()

func _refresh() -> void:
    _clear_children(research_actions)
    _clear_children(completed_research_list)
    _clear_children(completed_narrative_list)

    var available_ids: Array = Array(game_state.available_research_step_ids())
    research_status.text = (
        "Nenhuma etapa de pesquisa disponível agora."
        if available_ids.is_empty()
        else "Pesquisa disponível — complete apenas ações liberadas pelo estado canônico."
    )

    for definition in RESEARCH_DEFINITIONS:
        var step_id := String(definition.id)
        var presentation: Dictionary = game_state.research_step_presentation(step_id)
        if presentation.is_empty():
            continue

        if _research_completed(definition):
            _add_archive_label(
                completed_research_list,
                _research_archive_text(presentation),
            )
        elif available_ids.has(step_id):
            var button := Button.new()
            button.custom_minimum_size = Vector2(0, 54)
            button.text = String(presentation.get("display_name", step_id))
            button.pressed.connect(_on_research_step_pressed.bind(step_id))
            research_actions.add_child(button)

    if completed_research_list.get_child_count() == 0:
        _add_archive_label(completed_research_list, "Nenhuma pesquisa concluída.")

    for event_id_value in game_state.completed_event_ids:
        var event_id := String(event_id_value)
        var presentation: Dictionary = game_state.narrative_event_presentation(event_id)
        if presentation.is_empty():
            continue

        var text := String(presentation.get("display_title", event_id))
        var selected_choice := _selected_choice_label(presentation)
        if not selected_choice.is_empty():
            text += "\nEscolha registrada: %s" % selected_choice
        _add_archive_label(completed_narrative_list, text)

    if completed_narrative_list.get_child_count() == 0:
        _add_archive_label(completed_narrative_list, "Nenhum registro narrativo resolvido.")

func _research_completed(definition) -> bool:
    var completion_flags: Array = Array(definition.completion_flags)
    if completion_flags.is_empty():
        return false

    for flag_value in completion_flags:
        if not bool(game_state.narrative_flags.get(String(flag_value), false)):
            return false
    return true

func _research_archive_text(presentation: Dictionary) -> String:
    var text := String(presentation.get("display_name", "Pesquisa concluída"))
    var guardrails := _format_values(
        Array(presentation.get("canon_guardrails", [])),
        {
            "research_does_not_authenticate_historical_lineage":
                "não autentica linhagem histórica ou genética",
            "research_records_uncertainty": "incerteza permanece registrada",
            "no_real_cultivation_parameters": "sem parâmetros reais de cultivo",
            "symbol_order_remains_open": "ordem dos símbolos permanece em aberto",
            "onda_can_provenance_remains_open":
                "procedência da lata Onda permanece em aberto",
            "material_compatibility_does_not_prove_lineage":
                "compatibilidade material não prova linhagem",
        },
    )
    if not guardrails.is_empty():
        text += "\nLimites de cânone: %s" % guardrails
    return text

func _selected_choice_label(presentation: Dictionary) -> String:
    var choice_labels: Dictionary = Dictionary(presentation.get("choice_labels", {}))
    for choice_id_value in Array(presentation.get("choice_ids", [])):
        var choice_id := String(choice_id_value)
        if bool(game_state.narrative_flags.get(choice_id, false)):
            return String(choice_labels.get(choice_id, choice_id))
    return ""

func resolve_narrative_choice(event_id: String, choice_id: String) -> Dictionary:
    return game_state.resolve_narrative_choice(event_id, choice_id)

func _on_research_step_pressed(step_id: String) -> void:
    var result: Dictionary = game_state.complete_research_step(step_id)
    if not bool(result.get("changed", false)):
        research_result.text = String(
            result.get("message", "A etapa de pesquisa não pôde ser registrada.")
        )
        _refresh()
        return

    var evidence_text := _format_values(
        Array(result.get("evidence_tags", [])),
        {
            "evidence_object_memory": "objeto preservado em memória",
            "evidence_provenance_unresolved": "proveniência não autenticada",
            "evidence_symbol_order_disputed": "ordem dos símbolos disputada",
            "evidence_parallel_versions": "versões paralelas registradas",
            "evidence_priority_unresolved": "prioridade entre versões em aberto",
            "evidence_chain_of_custody_gaps": "lacunas de cadeia de custódia registradas",
            "evidence_boundary_synthesized": "limites de evidência sintetizados",
            "evidence_material_compatibility_limited":
                "compatibilidade material limitada estabelecida",
        },
    )
    var guardrail_text := _format_values(
        Array(result.get("canon_guardrails", [])),
        {
            "research_does_not_authenticate_historical_lineage":
                "não autentica linhagem histórica ou genética",
            "research_records_uncertainty": "incerteza permanece registrada",
            "no_real_cultivation_parameters": "sem parâmetros reais de cultivo",
            "symbol_order_remains_open": "ordem dos símbolos permanece em aberto",
            "onda_can_provenance_remains_open":
                "procedência da lata Onda permanece em aberto",
            "material_compatibility_does_not_prove_lineage":
                "compatibilidade material não prova linhagem",
        },
    )
    research_result.text = (
        "Pesquisa registrada.\nEvidência: %s.\nLimites de cânone: %s."
        % [evidence_text, guardrail_text]
    )
    _refresh()

func _format_values(values: Array, labels: Dictionary) -> String:
    var parts: Array[String] = []
    for value in values:
        var item_id := String(value)
        parts.append(String(labels.get(item_id, item_id)))
    return ", ".join(parts)

func _add_archive_label(parent: VBoxContainer, text: String) -> void:
    var label := Label.new()
    label.text = text
    label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    parent.add_child(label)

func _clear_children(parent: Node) -> void:
    for child in parent.get_children():
        parent.remove_child(child)
        child.queue_free()

func _on_archive_diorama_object_activated(context_id: String, _object_id: String) -> void:
    if context_id != "archive":
        return
    research_result.text = (
        "Mesa 3D selecionada. A visualização não altera evidências nem cânone; "
        + "as ações de pesquisa estão logo abaixo."
    )
    call_deferred("_focus_research_controls")

func _focus_research_controls() -> void:
    scroll.ensure_control_visible(research_actions)
