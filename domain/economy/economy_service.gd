extends RefCounted

func resolve_sale(
    inventory: int,
    batch_quality: float,
    buyer: BuyerDefinition,
    relationship_score: float = 0.0,
) -> Dictionary:
    if inventory <= 0:
        return {
            "changed": false,
            "message": "Não há estoque disponível.",
        }

    var unit_price := _unit_price(batch_quality, buyer, relationship_score)
    var revenue := inventory * unit_price

    return {
        "changed": true,
        "cash_delta": revenue,
        "reputation_delta": (
            buyer.reputation_flat
            + batch_quality * buyer.reputation_quality_bonus
        ),
        "influence_delta": buyer.influence_delta,
        "heat_delta": buyer.heat_flat + inventory * buyer.heat_per_unit,
        "inventory": 0,
        "batch_quality": 0.0,
        "message": "%s: +R$ %d." % [buyer.display_name, revenue],
    }

func resolve_contract(
    inventory: int,
    batch_quality: float,
    buyer: BuyerDefinition,
    relationship_score: float,
) -> Dictionary:
    if String(buyer.contract_id).is_empty() or buyer.contract_units <= 0:
        return {
            "changed": false,
            "message": "Contrato indisponível.",
        }
    if inventory < buyer.contract_units:
        return {
            "changed": false,
            "message": "Estoque insuficiente para cumprir o contrato.",
        }
    if batch_quality < buyer.contract_min_quality:
        return {
            "changed": false,
            "message": "Qualidade insuficiente para cumprir o contrato.",
        }

    var unit_price := _unit_price(batch_quality, buyer, relationship_score)
    var revenue := buyer.contract_units * unit_price + buyer.contract_cash_bonus
    var remaining_inventory := inventory - buyer.contract_units

    return {
        "changed": true,
        "contract_id": String(buyer.contract_id),
        "cash_delta": revenue,
        "reputation_delta": (
            buyer.reputation_flat
            + batch_quality * buyer.reputation_quality_bonus
        ),
        "influence_delta": buyer.influence_delta,
        "heat_delta": buyer.heat_flat + buyer.contract_units * buyer.heat_per_unit,
        "relationship_delta": buyer.contract_relationship_gain,
        "inventory": remaining_inventory,
        "batch_quality": batch_quality if remaining_inventory > 0 else 0.0,
        "message": "Contrato concluído com %s: +R$ %d." % [
            buyer.display_name,
            revenue,
        ],
    }

func _unit_price(
    batch_quality: float,
    buyer: BuyerDefinition,
    relationship_score: float,
) -> int:
    var relationship_bonus := floori(
        clampf(relationship_score, 0.0, 100.0)
        / 10.0
        * buyer.relationship_unit_bonus_per_10
    )
    return int(round(
        buyer.base_unit_price + batch_quality * buyer.quality_unit_bonus
    )) + relationship_bonus
