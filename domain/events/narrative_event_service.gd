extends RefCounted

func is_valid_definition(definition: NarrativeEventDefinition) -> bool:
    if definition == null:
        return false
    if String(definition.id).is_empty() or String(definition.arc_id).is_empty():
        return false
    if definition.choice_ids.is_empty():
        return false

    var seen := {}
    for choice_id_value in definition.choice_ids:
        var choice_id := String(choice_id_value)
        if choice_id.is_empty() or seen.has(choice_id):
            return false
        if not definition.choice_flags.has(choice_id):
            return false
        if not definition.relationship_effects.has(choice_id):
            return false
        if not definition.system_signals.has(choice_id):
            return false
        seen[choice_id] = true

    return true

func is_available(
    definition: NarrativeEventDefinition,
    completed_arc_ids: Array,
    completed_event_ids: Array,
    narrative_flags: Dictionary,
) -> bool:
    if not is_valid_definition(definition):
        return false

    var event_id := String(definition.id)
    if completed_event_ids.has(event_id):
        return false

    var unlock_arc_id := String(definition.unlock_after_arc_id)
    if not unlock_arc_id.is_empty() and not completed_arc_ids.has(unlock_arc_id):
        return false

    for required_flag_value in definition.required_flags:
        if not _flag_is_set(narrative_flags, String(required_flag_value)):
            return false

    for forbidden_flag_value in definition.forbidden_flags:
        if _flag_is_set(narrative_flags, String(forbidden_flag_value)):
            return false

    return true

func resolve_choice(
    definition: NarrativeEventDefinition,
    choice_id: String,
    completed_arc_ids: Array,
    completed_event_ids: Array,
    narrative_flags: Dictionary,
) -> Dictionary:
    if not is_available(
        definition,
        completed_arc_ids,
        completed_event_ids,
        narrative_flags,
    ):
        return _unchanged("Evento narrativo indisponível.")

    if not definition.choice_ids.has(choice_id):
        return _unchanged("Escolha narrativa desconhecida.")

    var next_flags := narrative_flags.duplicate(true)
    var flags_to_set = definition.choice_flags.get(choice_id, PackedStringArray())
    for flag_value in flags_to_set:
        next_flags[String(flag_value)] = true

    var next_completed_events := completed_event_ids.duplicate(true)
    next_completed_events.append(String(definition.id))

    return {
        "changed": true,
        "event_id": String(definition.id),
        "choice_id": choice_id,
        "completed_event_ids": next_completed_events,
        "narrative_flags": next_flags,
        "relationship_effects": _packed_values(
            definition.relationship_effects.get(choice_id, PackedStringArray())
        ),
        "system_signals": _packed_values(
            definition.system_signals.get(choice_id, PackedStringArray())
        ),
        "lore_assertions": Array(definition.lore_assertions),
        "canon_guardrails": Array(definition.canon_guardrails),
    }

func _flag_is_set(narrative_flags: Dictionary, flag_id: String) -> bool:
    return bool(narrative_flags.get(flag_id, false))

func _packed_values(value) -> Array:
    if value is PackedStringArray:
        return Array(value)
    if value is Array:
        return value.duplicate(true)
    return []

func _unchanged(message: String) -> Dictionary:
    return {
        "changed": false,
        "message": message,
    }
