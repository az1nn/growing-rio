extends RefCounted

const CAMPAIGN_SLOT_STORE := preload("res://persistence/campaign_slot_store.gd")

var game_state: Node
var store

func _init(
    canonical_game_state: Node,
    campaign_store = null,
) -> void:
    game_state = canonical_game_state
    store = campaign_store if campaign_store != null else CAMPAIGN_SLOT_STORE.new()

func has_slot() -> bool:
    return store.has_slot()

func save_campaign() -> Dictionary:
    return store.save_slot(game_state.create_save_data())

func load_campaign() -> Dictionary:
    var stored: Dictionary = store.load_slot()
    if not bool(stored.get("ok", false)):
        return stored

    var payload: Dictionary = Dictionary(stored["payload"]).duplicate(true)
    if not game_state.load_save_data(payload):
        return {
            "ok": false,
            "error": "Save inválido. A campanha ativa foi preservada.",
        }

    return {
        "ok": true,
    }

func start_new_campaign() -> Dictionary:
    game_state.reset()
    return {
        "ok": true,
    }
