extends RefCounted

const MIN_SUPPORT := 0.0
const MAX_SUPPORT := 100.0
const NEUTRAL_SUPPORT := 50.0
const MAX_DAILY_SUPPORT_STEP := 2.0
const REPUTATION_WEIGHT := 0.35
const INSTITUTION_WEIGHT := 4.0
const DEMAND_WEIGHT := 0.10
const MAX_REPUTATION_FEEDBACK := 0.25

func initial_support(catalog: Dictionary) -> Dictionary:
    var result := {}
    var district_ids := catalog.keys()
    district_ids.sort()
    for district_id_value in district_ids:
        result[String(district_id_value)] = NEUTRAL_SUPPORT
    return result

func advance_day(
    current_support: Dictionary,
    reputation: float,
    institution_level: int,
    district_demand: Dictionary,
    catalog: Dictionary,
) -> Dictionary:
    var result := {}
    var district_ids := catalog.keys()
    district_ids.sort()
    var bounded_reputation := clampf(reputation, 0.0, 100.0)
    var bounded_institution := clampi(institution_level, 0, 3)

    for district_id_value in district_ids:
        var district_id := String(district_id_value)
        var current := clampf(
            float(current_support.get(district_id, NEUTRAL_SUPPORT)),
            MIN_SUPPORT,
            MAX_SUPPORT,
        )
        var demand := clampf(
            float(district_demand.get(district_id, NEUTRAL_SUPPORT)),
            0.0,
            100.0,
        )
        var target := clampf(
            45.0
            + bounded_reputation * REPUTATION_WEIGHT
            + float(bounded_institution) * INSTITUTION_WEIGHT
            + (demand - 50.0) * DEMAND_WEIGHT,
            MIN_SUPPORT,
            MAX_SUPPORT,
        )
        result[district_id] = move_toward(
            current,
            target,
            MAX_DAILY_SUPPORT_STEP,
        )

    return result

func reputation_delta(
    community_support: Dictionary,
    active_district_id: String,
) -> float:
    var support := clampf(
        float(community_support.get(active_district_id, NEUTRAL_SUPPORT)),
        MIN_SUPPORT,
        MAX_SUPPORT,
    )
    return clampf(
        ((support - NEUTRAL_SUPPORT) / NEUTRAL_SUPPORT)
        * MAX_REPUTATION_FEEDBACK,
        -MAX_REPUTATION_FEEDBACK,
        MAX_REPUTATION_FEEDBACK,
    )

func is_valid_state(values: Dictionary, catalog: Dictionary) -> bool:
    if values.size() != catalog.size():
        return false
    for district_id_value in catalog:
        var district_id := String(district_id_value)
        if not values.has(district_id):
            return false
        var score_value = values[district_id]
        if typeof(score_value) != TYPE_INT and typeof(score_value) != TYPE_FLOAT:
            return false
        var score := float(score_value)
        if score < MIN_SUPPORT or score > MAX_SUPPORT:
            return false
    for district_id_value in values:
        if not catalog.has(String(district_id_value)):
            return false
    return true
