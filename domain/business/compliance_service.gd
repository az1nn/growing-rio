extends RefCounted

const MAX_LEVEL := 3

const REQUIREMENTS := {
    1: {
        "cash_cost": 60,
        "reputation_min": 2.0,
        "influence_min": 4.0,
        "heat_max": 60.0,
        "reputation_gain": 1.0,
        "heat_delta": -4.0,
        "label": "Cadastro básico",
    },
    2: {
        "cash_cost": 100,
        "reputation_min": 6.0,
        "influence_min": 8.0,
        "heat_max": 45.0,
        "reputation_gain": 2.0,
        "heat_delta": -6.0,
        "label": "Operação auditada",
    },
    3: {
        "cash_cost": 160,
        "reputation_min": 12.0,
        "influence_min": 14.0,
        "heat_max": 30.0,
        "reputation_gain": 3.0,
        "heat_delta": -8.0,
        "label": "Operação certificada",
    },
}

func requirement_for(current_level: int) -> Dictionary:
    var target_level := current_level + 1
    if target_level > MAX_LEVEL:
        return {}
    return Dictionary(REQUIREMENTS[target_level]).duplicate(true)

func resolve_progression(
    current_level: int,
    cash: int,
    reputation: float,
    influence: float,
    heat: float,
) -> Dictionary:
    if current_level < 0 or current_level > MAX_LEVEL:
        return {
            "changed": false,
            "message": "Estado de conformidade inválido.",
        }
    if current_level == MAX_LEVEL:
        return {
            "changed": false,
            "message": "Conformidade máxima já alcançada.",
        }

    var target_level := current_level + 1
    var requirement: Dictionary = REQUIREMENTS[target_level]
    var cash_cost := int(requirement["cash_cost"])

    if cash < cash_cost:
        return {
            "changed": false,
            "message": "Capital insuficiente para avançar a conformidade.",
        }
    if reputation < float(requirement["reputation_min"]):
        return {
            "changed": false,
            "message": "Reputação insuficiente para avançar a conformidade.",
        }
    if influence < float(requirement["influence_min"]):
        return {
            "changed": false,
            "message": "Influência insuficiente para avançar a conformidade.",
        }
    if heat > float(requirement["heat_max"]):
        return {
            "changed": false,
            "message": "Heat alto demais para avançar a conformidade.",
        }

    return {
        "changed": true,
        "compliance_level": target_level,
        "cash_delta": -cash_cost,
        "reputation_delta": float(requirement["reputation_gain"]),
        "influence_delta": 0.0,
        "heat_delta": float(requirement["heat_delta"]),
        "message": "Conformidade avançou para %s." % String(requirement["label"]),
    }
