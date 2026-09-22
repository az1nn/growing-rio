extends RefCounted

func resolve_sale(
    inventory: int,
    batch_quality: float,
    buyer: BuyerDefinition,
) -> Dictionary:
    if inventory <= 0:
        return {
            "changed": false,
            "message": "Não há estoque disponível.",
        }

    var unit_price := int(round(
        buyer.base_unit_price + batch_quality * buyer.quality_unit_bonus
    ))
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
