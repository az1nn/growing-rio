extends RefCounted

func daily_operating_cost(
    rooms: Array,
    room_definitions: Dictionary,
) -> int:
    var total := 0
    for room_value in rooms:
        if typeof(room_value) != TYPE_DICTIONARY:
            continue
        var room: Dictionary = room_value
        var definition_id := String(room.get("definition_id", ""))
        var definition: RoomDefinition = room_definitions.get(definition_id)
        if definition == null:
            continue
        total += maxi(0, definition.daily_operating_cost)
    return total

func daily_staff_cost(
    staff_ids: Array,
    staff_definitions: Dictionary,
) -> int:
    var total := 0
    for staff_id_value in staff_ids:
        var staff_id := String(staff_id_value)
        var definition: StaffDefinition = staff_definitions.get(staff_id)
        if definition == null:
            continue
        total += maxi(0, definition.daily_cost)
    return total

func daily_upgrade_cost(
    upgrade_ids: Array,
    upgrade_definitions: Dictionary,
) -> int:
    var total := 0
    for upgrade_id_value in upgrade_ids:
        var upgrade_id := String(upgrade_id_value)
        var definition: UpgradeDefinition = upgrade_definitions.get(upgrade_id)
        if definition == null:
            continue
        total += maxi(0, definition.daily_upkeep_delta)
    return total

func health_stability_modifier(
    staff_ids: Array,
    upgrade_ids: Array,
    staff_definitions: Dictionary,
    upgrade_definitions: Dictionary,
) -> float:
    var total := 0.0

    for staff_id_value in staff_ids:
        var staff_id := String(staff_id_value)
        var staff: StaffDefinition = staff_definitions.get(staff_id)
        if staff != null:
            total += staff.health_stability_delta

    for upgrade_id_value in upgrade_ids:
        var upgrade_id := String(upgrade_id_value)
        var upgrade: UpgradeDefinition = upgrade_definitions.get(upgrade_id)
        if upgrade != null:
            total += upgrade.health_stability_delta

    return clampf(total, -0.20, 0.20)
