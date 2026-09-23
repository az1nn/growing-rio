extends RefCounted

const MAX_LEVEL := 3

func available_proposals(
    institution_level: int,
    compliance_level: int,
    enacted_policy_ids: Array,
    catalog: Dictionary,
) -> Array:
    if institution_level < 0 or institution_level >= MAX_LEVEL:
        return []

    var available: Array = []
    var policy_ids := catalog.keys()
    policy_ids.sort()
    for policy_id_value in policy_ids:
        var policy_id := String(policy_id_value)
        var definition: PolicyDefinition = catalog[policy_id_value]
        if enacted_policy_ids.has(policy_id):
            continue
        if definition.required_institution_level != institution_level:
            continue
        if compliance_level < definition.min_compliance_level:
            continue
        available.append(policy_id)
    return available

func resolve_enactment(
    policy_id: String,
    institution_level: int,
    enacted_policy_ids: Array,
    compliance_level: int,
    cash: int,
    influence: float,
    catalog: Dictionary,
) -> Dictionary:
    var definition: PolicyDefinition = catalog.get(policy_id)
    if definition == null:
        return _unchanged("Proposta institucional desconhecida.")
    if institution_level < 0 or institution_level > MAX_LEVEL:
        return _unchanged("Estado institucional inválido.")
    if institution_level == MAX_LEVEL:
        return _unchanged("Progressão institucional máxima já alcançada.")
    if enacted_policy_ids.has(policy_id):
        return _unchanged("Proposta institucional já aprovada.")
    if definition.required_institution_level != institution_level:
        return _unchanged("Proposta indisponível no estágio institucional atual.")
    if compliance_level < definition.min_compliance_level:
        return _unchanged("Conformidade insuficiente para esta proposta.")
    if cash < definition.cash_cost:
        return _unchanged("Capital insuficiente para esta proposta.")
    if influence < definition.influence_cost:
        return _unchanged("Influência insuficiente para esta proposta.")

    var next_ids := enacted_policy_ids.duplicate(true)
    next_ids.append(policy_id)
    return {
        "changed": true,
        "policy_id": policy_id,
        "institution_level": institution_level + 1,
        "enacted_policy_ids": next_ids,
        "cash_delta": -definition.cash_cost,
        "influence_delta": -definition.influence_cost,
        "reputation_delta": definition.reputation_gain,
        "heat_delta": definition.heat_delta,
        "message": "Proposta aprovada: %s." % definition.display_name,
    }

func is_valid_state(
    institution_level: int,
    enacted_policy_ids: Array,
    catalog: Dictionary,
) -> bool:
    if institution_level < 0 or institution_level > MAX_LEVEL:
        return false
    if enacted_policy_ids.size() != institution_level:
        return false

    var seen := {}
    for index in range(enacted_policy_ids.size()):
        var policy_id := String(enacted_policy_ids[index])
        if policy_id.is_empty() or seen.has(policy_id):
            return false
        if not catalog.has(policy_id):
            return false
        var definition: PolicyDefinition = catalog[policy_id]
        if definition.required_institution_level != index:
            return false
        seen[policy_id] = true
    return true

func _unchanged(message: String) -> Dictionary:
    return {
        "changed": false,
        "message": message,
    }
