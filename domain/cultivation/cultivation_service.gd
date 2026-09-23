extends RefCounted

const CARE_COST := 5
const CARE_HEALTH_GAIN := 0.08

func current_cycle_days(cultivar: CultivarDefinition) -> int:
    return maxi(1, cultivar.cycle_days)

func initial_state(cultivar: CultivarDefinition) -> Dictionary:
    return {
        "grow_day": 0,
        "grow_health": clampf(0.72 + cultivar.health_bias, 0.15, 1.0),
        "cared_today": false,
        "inventory": 0,
        "batch_quality": 0.0,
    }

func care(grow_day: int, grow_health: float, cared_today: bool, cycle_days: int) -> Dictionary:
    if cared_today:
        return {
            "changed": false,
            "message": "O espaço já recebeu os cuidados do dia.",
        }
    if grow_day >= cycle_days:
        return {
            "changed": false,
            "message": "O lote já está pronto para colheita.",
        }

    return {
        "changed": true,
        "grow_health": clampf(grow_health + CARE_HEALTH_GAIN, 0.0, 1.0),
        "cared_today": true,
        "cash_delta": -CARE_COST,
        "message": "Cuidados concluídos: saúde do lote melhorou.",
    }

func advance_day(
    grow_day: int,
    grow_health: float,
    cared_today: bool,
    cycle_days: int,
    rng: RandomNumberGenerator,
    health_stability_delta: float = 0.0,
) -> Dictionary:
    var next_grow_day := grow_day
    var next_health := grow_health

    if next_grow_day < cycle_days:
        next_grow_day += 1
        var neglect_penalty := -0.07 if not cared_today else 0.01
        next_health = clampf(
            next_health
            + neglect_penalty
            + clampf(health_stability_delta, -0.20, 0.20)
            + rng.randf_range(-0.03, 0.03),
            0.15,
            1.0,
        )

    return {
        "grow_day": next_grow_day,
        "grow_health": next_health,
        "cared_today": false,
    }

func harvest(
    grow_day: int,
    grow_health: float,
    inventory: int,
    cultivar: CultivarDefinition,
    rng: RandomNumberGenerator,
) -> Dictionary:
    if grow_day < current_cycle_days(cultivar):
        return {
            "changed": false,
            "message": "O lote ainda não está pronto.",
        }
    if inventory > 0:
        return {
            "changed": false,
            "message": "Venda o estoque atual antes de iniciar outro lote.",
        }

    var batch_quality := clampf(
        grow_health * 0.85 + rng.randf_range(0.05, 0.15),
        0.0,
        1.0,
    )
    var base_units := (8.0 + grow_health * 8.0) * cultivar.yield_scale
    var units := maxi(1, int(round(base_units)))

    return {
        "changed": true,
        "grow_day": 0,
        "grow_health": clampf(
            0.65 + cultivar.health_bias + rng.randf_range(-0.05, 0.05),
            0.4,
            0.9,
        ),
        "cared_today": false,
        "inventory": units,
        "batch_quality": batch_quality,
        "reputation_delta": batch_quality * 2.0,
    }
