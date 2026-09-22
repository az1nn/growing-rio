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
