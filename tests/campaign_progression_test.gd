extends SceneTree

const TEST_SEED := 1337
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const EVENT_ID := "event_dalva_lucia_primeiro_depoimento"
const ACT_ONE_ARC_ID := "arc_o_quarto"
const REQUIRED_FLAGS := [
    "contact_char_dalva",
    "introduced_char_lucia",
    "memory_onda_can_received",
]

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    if not _assert_route_unlocks("licensed"):
        return
    if not _assert_route_unlocks("parallel"):
        return

    print("CAMPAIGN PROGRESSION TEST PASSED")
    quit(0)

func _assert_route_unlocks(route: String) -> bool:
    var state := GAME_STATE_SCRIPT.new()
    root.add_child(state)
    state.set_simulation_seed(TEST_SEED)
    state.reset()
    # This regression owns narrative unlock behavior, not economy survivability.
    # Keep the 90-day canonical cycle from tripping the independent cash game-over gate.
    state.cash = 100000

    if not state.available_narrative_event_ids().is_empty():
        _fail("Narrative event was available before ordinary gameplay.")
        return false

    for index in range(state.current_cycle_days()):
        if index % 2 == 0:
            state.care_for_room()
        state.next_day()

    state.harvest()
    if state.inventory <= 0:
        _fail("Ordinary cultivation cycle did not produce sellable inventory.")
        return false
    if state.completed_arc_ids.has(ACT_ONE_ARC_ID):
        _fail("Act I completed before the first successful sale.")
        return false
    if not state.available_narrative_event_ids().is_empty():
        _fail("Narrative event unlocked before the sustainable cycle closed.")
        return false

    if route == "licensed":
        state.sell_legal()
    elif route == "parallel":
        state.sell_parallel()
    else:
        _fail("Unknown test route: %s" % route)
        return false

    if state.inventory != 0:
        _fail("%s route did not complete the first sale." % route)
        return false
    if not state.completed_arc_ids.has(ACT_ONE_ARC_ID):
        _fail("%s route did not complete arc_o_quarto." % route)
        return false
    for flag_id in REQUIRED_FLAGS:
        if not bool(state.narrative_flags.get(flag_id, false)):
            _fail("%s route did not emit narrative fact: %s" % [route, flag_id])
            return false
    if state.available_narrative_event_ids() != [EVENT_ID]:
        _fail("%s route did not naturally unlock the first event." % route)
        return false

    var save_data: Dictionary = state.create_save_data()
    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(save_data):
        _fail("%s route campaign snapshot failed to restore." % route)
        return false
    if restored.available_narrative_event_ids() != [EVENT_ID]:
        _fail("%s route natural unlock did not survive save round-trip." % route)
        return false

    return true

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
