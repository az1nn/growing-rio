extends SceneTree

const BUSINESS_SERVICE := preload("res://domain/business/business_service.gd")
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const DEFAULT_ROOM := preload("res://resources/rooms/quarto_inicial.tres")
const COMPACT_ROOM := preload("res://resources/rooms/sala_compacta.tres")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var service := BUSINESS_SERVICE.new()
    var catalog := {
        String(DEFAULT_ROOM.id): DEFAULT_ROOM,
        String(COMPACT_ROOM.id): COMPACT_ROOM,
    }

    var one_room := [
        {
            "instance_id": "room_1",
            "definition_id": String(DEFAULT_ROOM.id),
        },
    ]
    if service.daily_operating_cost(one_room, catalog) != 15:
        _fail("One-room operating cost compatibility regressed.")
        return

    var two_rooms := one_room.duplicate(true)
    two_rooms.append({
        "instance_id": "room_2",
        "definition_id": String(COMPACT_ROOM.id),
    })
    if service.daily_operating_cost(two_rooms, catalog) != 40:
        _fail("Multi-room daily operating cost aggregation regressed.")
        return

    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.reset()
    if state.room_count() != 1 or state.daily_operating_cost() != 15:
        _fail("GameState default room compatibility regressed.")
        return
    if not state.add_room("room_2", "sala_compacta"):
        _fail("GameState could not add a known second room.")
        return
    if state.room_count() != 2 or state.daily_operating_cost() != 40:
        _fail("GameState did not aggregate two-room operating costs.")
        return
    if state.add_room("room_2", "sala_compacta"):
        _fail("Duplicate room instance IDs were accepted.")
        return
    if state.add_room("room_3", "unknown_room"):
        _fail("Unknown room definitions were accepted.")
        return

    print("BUSINESS SERVICE TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
