extends RefCounted

func is_valid_definition(definition: ResearchStepDefinition) -> bool:
    if definition == null:
        return false
    if String(definition.id).is_empty() or definition.display_name.is_empty():
        return false
    if definition.completion_flags.is_empty():
        return false

    var seen_completion_flags := {}
    for flag_value in definition.completion_flags:
        var flag_id := String(flag_value)
        if flag_id.is_empty() or seen_completion_flags.has(flag_id):
            return false
        seen_completion_flags[flag_id] = true

    return true

func is_available(
    definition: ResearchStepDefinition,
    completed_event_ids: Array,
    narrative_flags: Dictionary,
) -> bool:
    if not is_valid_definition(definition):
        return false

    var unlock_event_id := String(definition.unlock_after_event_id)
    if not unlock_event_id.is_empty() and not completed_event_ids.has(unlock_event_id):
        return false

    for required_flag_value in definition.required_flags:
        if not _flag_is_set(narrative_flags, String(required_flag_value)):
            return false

    for forbidden_flag_value in definition.forbidden_flags:
        if _flag_is_set(narrative_flags, String(forbidden_flag_value)):
            return false

    for completion_flag_value in definition.completion_flags:
        if _flag_is_set(narrative_flags, String(completion_flag_value)):
            return false

    return true

func resolve(
    definition: ResearchStepDefinition,
    completed_event_ids: Array,
    narrative_flags: Dictionary,
) -> Dictionary:
    if not is_available(definition, completed_event_ids, narrative_flags):
        return {
            "changed": false,
            "message": "Etapa de pesquisa indisponível.",
        }

    var next_flags := narrative_flags.duplicate(true)
    for flag_value in definition.completion_flags:
        next_flags[String(flag_value)] = true

    return {
        "changed": true,
        "research_step_id": String(definition.id),
        "narrative_flags": next_flags,
        "evidence_tags": Array(definition.evidence_tags),
        "system_signals": Array(definition.system_signals),
        "canon_guardrails": Array(definition.canon_guardrails),
    }

func _flag_is_set(narrative_flags: Dictionary, flag_id: String) -> bool:
    return bool(narrative_flags.get(flag_id, false))
