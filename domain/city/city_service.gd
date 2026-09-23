extends RefCounted

const MIN_DEMAND := 0.0
const MAX_DEMAND := 100.0
const DAILY_STEP := 5.0

func initial_demand(catalog: Dictionary) -> Dictionary:
    var result := {}
    var district_ids := catalog.keys()
    district_ids.sort()
    for district_id_value in district_ids:
        var district_id := String(district_id_value)
        var definition: DistrictDefinition = catalog[district_id_value]
        result[district_id] = clampf(
            definition.base_demand,
            MIN_DEMAND,
            MAX_DEMAND,
        )
    return result

func advance_day(
    current_demand: Dictionary,
    catalog: Dictionary,
    day: int,
) -> Dictionary:
    var result := current_demand.duplicate(true)
    var district_ids := catalog.keys()
    district_ids.sort()

    for district_id_value in district_ids:
        var district_id := String(district_id_value)
        var definition: DistrictDefinition = catalog[district_id_value]
        var current := float(
            result.get(district_id, definition.base_demand)
        )
        var wave_index := (
            (day + definition.demand_phase_offset) % 5
        ) - 2
        var target := clampf(
            definition.base_demand + float(wave_index) * DAILY_STEP,
            MIN_DEMAND,
            MAX_DEMAND,
        )
        result[district_id] = move_toward(current, target, DAILY_STEP)

    return result

func price_multiplier(
    demand_score: float,
    definition: DistrictDefinition,
) -> float:
    var normalized := (
        clampf(demand_score, MIN_DEMAND, MAX_DEMAND)
        - clampf(definition.base_demand, MIN_DEMAND, MAX_DEMAND)
    ) / 50.0
    return clampf(
        1.0 + normalized * definition.max_price_modifier,
        0.5,
        1.5,
    )
