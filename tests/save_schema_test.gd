extends SceneTree

const TEST_SEED := 20260922
const GAME_STATE_SCRIPT := preload("res://autoload/game_state.gd")
const SAVE_SERVICE := preload("res://autoload/save_service.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var original := GAME_STATE_SCRIPT.new()
    root.add_child(original)
    original.set_simulation_seed(TEST_SEED)
    original.reset()

    if not original.add_room("room_2", "sala_compacta"):
        _fail("Could not prepare multi-room save fixture.")
        return
    if not original.hire_staff("assistente_operacional"):
        _fail("Could not prepare staff save fixture.")
        return
    if not original.purchase_upgrade("sensores_basicos"):
        _fail("Could not prepare upgrade save fixture.")
        return
    original.buyer_relationships["varejista_licenciado"] = 20.0
    if not original.accept_contract("contrato_licenciado_padrao"):
        _fail("Could not prepare active contract save fixture.")
        return
    original.compliance_level = 3
    original.cash = 2000
    original.influence = 30.0
    if not original.select_district("district_orla_vigia"):
        _fail("Could not prepare active district save fixture.")
        return
    for policy_id in [
        "policy_participatory_registry",
        "policy_local_market_charter",
        "policy_bay_civic_compact",
    ]:
        if not original.enact_policy(policy_id):
            _fail("Could not prepare policy progression save fixture.")
            return

    original.care_for_room()
    if not original.switch_active_room("room_2"):
        _fail("Could not switch to room_2 for save fixture.")
        return
    original.next_day()
    original.care_for_room()
    if not original.switch_active_room("room_1"):
        _fail("Could not switch back to room_1 for save fixture.")
        return
    original.next_day()

    var save_data: Dictionary = original.create_save_data()

    if int(save_data.get("schema_version", -1)) != 8:
        _fail("Save schema version is not v8.")
        return

    var state_data: Dictionary = save_data.get("state", {})
    if state_data.has("active_cultivar_id") or state_data.has("grow_day"):
        _fail("V8 campaign state still contains room-scoped cultivation fields.")
        return

    var business_data: Dictionary = save_data.get("business", {})
    var saved_rooms: Array = business_data.get("rooms", [])
    if saved_rooms.size() != 2:
        _fail("V8 save did not serialize both room states.")
        return
    if String(business_data.get("active_room_id", "")) != "room_1":
        _fail("V8 save did not serialize the active room ID.")
        return
    if business_data.get("staff_ids", []) != ["assistente_operacional"]:
        _fail("V8 save did not serialize stable staff IDs.")
        return
    if business_data.get("upgrade_ids", []) != ["sensores_basicos"]:
        _fail("V8 save did not serialize stable upgrade IDs.")
        return
    var relationships: Dictionary = business_data.get("buyer_relationships", {})
    if not is_equal_approx(
        float(relationships.get("varejista_licenciado", -1.0)),
        20.0,
    ):
        _fail("V8 save did not serialize buyer relationships.")
        return
    if String(business_data.get("active_contract_id", "")) != "contrato_licenciado_padrao":
        _fail("V8 save did not serialize the active contract ID.")
        return
    if int(business_data.get("compliance_level", -1)) != 2:
        _fail("V8 save did not serialize compliance progression.")
        return

    var city_data: Dictionary = save_data.get("city", {})
    if String(city_data.get("active_district_id", "")) != "district_orla_vigia":
        _fail("V8 save did not serialize the active district ID.")
        return
    var saved_demand: Dictionary = city_data.get("district_demand", {})
    if saved_demand.size() != 7:
        _fail("V8 save did not serialize all district demand state.")
        return
    if not saved_demand.has("district_morro_cedro"):
        _fail("V8 save lost canonical district demand IDs.")
        return

    var policy_data: Dictionary = save_data.get("policy", {})
    if int(policy_data.get("institution_level", -1)) != 3:
        _fail("V8 save did not serialize institutional progression.")
        return
    if policy_data.get("enacted_policy_ids", []) != [
        "policy_participatory_registry",
        "policy_local_market_charter",
        "policy_bay_civic_compact",
    ]:
        _fail("V8 save did not serialize stable policy IDs.")
        return

    for room_value in saved_rooms:
        var room: Dictionary = room_value
        if typeof(room.get("cultivation")) != TYPE_DICTIONARY:
            _fail("V8 room did not persist cultivation state.")
            return
        var cultivation: Dictionary = room["cultivation"]
        if String(cultivation.get("active_cultivar_id", "")) != "quarto_classica":
            _fail("V8 room did not persist a stable cultivar ID.")
            return

    var simulation_data: Dictionary = save_data.get("simulation", {})
    if typeof(simulation_data.get("rng_state")) != TYPE_STRING:
        _fail("RNG state must be serialized as a JSON-safe decimal string.")
        return

    var encoded := JSON.stringify(save_data, "", true, true)
    var decoded_variant = JSON.parse_string(encoded)
    if typeof(decoded_variant) != TYPE_DICTIONARY:
        _fail("JSON round-trip did not produce a Dictionary.")
        return

    var decoded: Dictionary = decoded_variant
    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)

    if not restored.load_save_data(decoded):
        _fail("Valid v8 payload was rejected.")
        return

    if _snapshot(original) != _snapshot(restored):
        print("original=", _snapshot(original))
        print("restored=", _snapshot(restored))
        _fail("V8 save/load round-trip did not restore equivalent state.")
        return

    original.next_day()
    restored.next_day()
    if _snapshot(original) != _snapshot(restored):
        print("continued_original=", _snapshot(original))
        print("continued_restored=", _snapshot(restored))
        _fail("RNG continuation diverged after v8 load.")
        return

    if not _verify_v7_migration(original):
        return
    if not _verify_v6_migration(original):
        return
    if not _verify_v5_migration(original):
        return
    if not _verify_v4_migration(original):
        return
    if not _verify_v3_migration(original):
        return
    if not _verify_v2_migration(original):
        return
    if not _verify_v1_migration(original):
        return

    var unsupported := decoded.duplicate(true)
    unsupported["schema_version"] = 999
    if restored.load_save_data(unsupported):
        _fail("Unsupported schema version was accepted.")
        return

    print("SAVE SCHEMA V8 TEST PASSED")
    print("snapshot=", _snapshot(restored))
    quit(0)

func _verify_v7_migration(source: Node) -> bool:
    var service := SAVE_SERVICE.new()
    var legacy := service.create_v7(
        _campaign_state(source),
        source.rooms,
        source.active_room_id,
        source.hired_staff_ids,
        source.owned_upgrade_ids,
        source.buyer_relationships,
        source.active_contract_id,
        source.compliance_level,
        source.active_district_id,
        source.district_demand,
        source.simulation_seed,
        source.rng.state,
    )

    var legacy_round_trip = JSON.parse_string(JSON.stringify(
        legacy,
        "",
        true,
        true,
    ))
    if typeof(legacy_round_trip) != TYPE_DICTIONARY:
        _fail("Legacy v7 JSON fixture could not round-trip.")
        return false

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(legacy_round_trip):
        _fail("Legacy v7 payload was rejected by v8 code.")
        return false
    if restored.active_district_id != source.active_district_id:
        _fail("Legacy v7 active district state did not remain intact.")
        return false
    if restored.district_demand != source.district_demand:
        _fail("Legacy v7 district demand state did not remain intact.")
        return false
    if restored.institution_level != 0:
        _fail("Legacy v7 unexpectedly migrated institutional progression.")
        return false
    if not restored.enacted_policy_ids.is_empty():
        _fail("Legacy v7 unexpectedly migrated enacted policies.")
        return false
    return true

func _verify_v6_migration(source: Node) -> bool:
    var service := SAVE_SERVICE.new()
    var legacy := service.create_v6(
        _campaign_state(source),
        source.rooms,
        source.active_room_id,
        source.hired_staff_ids,
        source.owned_upgrade_ids,
        source.buyer_relationships,
        source.active_contract_id,
        source.compliance_level,
        source.simulation_seed,
        source.rng.state,
    )

    var legacy_round_trip = JSON.parse_string(JSON.stringify(
        legacy,
        "",
        true,
        true,
    ))
    if typeof(legacy_round_trip) != TYPE_DICTIONARY:
        _fail("Legacy v6 JSON fixture could not round-trip.")
        return false

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(legacy_round_trip):
        _fail("Legacy v6 payload was rejected by v8 code.")
        return false
    if restored.compliance_level != source.compliance_level:
        _fail("Legacy v6 compliance state did not remain intact.")
        return false
    if restored.active_district_id != "district_morro_cedro":
        _fail("Legacy v6 did not migrate to the default district.")
        return false
    if not is_equal_approx(
        float(restored.district_demand.get("district_orla_vigia", -1.0)),
        70.0,
    ):
        _fail("Legacy v6 did not migrate default district demand.")
        return false
    return true

func _verify_v5_migration(source: Node) -> bool:
    var service := SAVE_SERVICE.new()
    var legacy := service.create_v5(
        _campaign_state(source),
        source.rooms,
        source.active_room_id,
        source.hired_staff_ids,
        source.owned_upgrade_ids,
        source.buyer_relationships,
        source.active_contract_id,
        source.simulation_seed,
        source.rng.state,
    )

    var legacy_round_trip = JSON.parse_string(JSON.stringify(
        legacy,
        "",
        true,
        true,
    ))
    if typeof(legacy_round_trip) != TYPE_DICTIONARY:
        _fail("Legacy v5 JSON fixture could not round-trip.")
        return false

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(legacy_round_trip):
        _fail("Legacy v5 payload was rejected by v8 code.")
        return false
    if restored.buyer_relationships != source.buyer_relationships:
        _fail("Legacy v5 buyer relationships did not remain intact.")
        return false
    if restored.active_contract_id != source.active_contract_id:
        _fail("Legacy v5 active contract did not remain intact.")
        return false
    if restored.compliance_level != 0:
        _fail("Legacy v5 unexpectedly migrated compliance progression.")
        return false
    if restored.rooms != source.rooms:
        _fail("Legacy v5 room state did not remain intact.")
        return false
    return true

func _verify_v4_migration(source: Node) -> bool:
    var service := SAVE_SERVICE.new()
    var legacy := service.create_v4(
        _campaign_state(source),
        source.rooms,
        source.active_room_id,
        source.hired_staff_ids,
        source.owned_upgrade_ids,
        source.simulation_seed,
        source.rng.state,
    )

    var legacy_round_trip = JSON.parse_string(JSON.stringify(
        legacy,
        "",
        true,
        true,
    ))
    if typeof(legacy_round_trip) != TYPE_DICTIONARY:
        _fail("Legacy v4 JSON fixture could not round-trip.")
        return false

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(legacy_round_trip):
        _fail("Legacy v4 payload was rejected by v8 code.")
        return false
    if restored.hired_staff_ids != source.hired_staff_ids:
        _fail("Legacy v4 staff IDs did not remain intact.")
        return false
    if restored.owned_upgrade_ids != source.owned_upgrade_ids:
        _fail("Legacy v4 upgrade IDs did not remain intact.")
        return false
    if not is_equal_approx(
        restored.relationship_for_buyer("varejista_licenciado"),
        0.0,
    ):
        _fail("Legacy v4 unexpectedly migrated buyer relationships.")
        return false
    if not restored.active_contract_id.is_empty():
        _fail("Legacy v4 unexpectedly migrated an active contract.")
        return false
    if restored.rooms != source.rooms:
        _fail("Legacy v4 room state did not remain intact.")
        return false
    return true

func _verify_v3_migration(source: Node) -> bool:
    var service := SAVE_SERVICE.new()
    var legacy := service.create_v3(
        _campaign_state(source),
        source.rooms,
        source.active_room_id,
        source.simulation_seed,
        source.rng.state,
    )

    var legacy_round_trip = JSON.parse_string(JSON.stringify(
        legacy,
        "",
        true,
        true,
    ))
    if typeof(legacy_round_trip) != TYPE_DICTIONARY:
        _fail("Legacy v3 JSON fixture could not round-trip.")
        return false

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(legacy_round_trip):
        _fail("Legacy v3 payload was rejected by v8 code.")
        return false
    if not restored.hired_staff_ids.is_empty():
        _fail("Legacy v3 unexpectedly migrated staff.")
        return false
    if not restored.owned_upgrade_ids.is_empty():
        _fail("Legacy v3 unexpectedly migrated upgrades.")
        return false
    if restored.rooms != source.rooms:
        _fail("Legacy v3 room state did not remain intact.")
        return false
    return true

func _verify_v2_migration(source: Node) -> bool:
    var service := SAVE_SERVICE.new()
    var legacy_rooms := [
        {
            "instance_id": "room_1",
            "definition_id": "quarto_inicial",
        },
        {
            "instance_id": "room_2",
            "definition_id": "sala_compacta",
        },
    ]
    var legacy := service.create_v2(
        _legacy_state(source),
        String(source.active_cultivar.id),
        legacy_rooms,
        source.active_room_id,
        source.simulation_seed,
        source.rng.state,
    )

    var legacy_round_trip = JSON.parse_string(JSON.stringify(
        legacy,
        "",
        true,
        true,
    ))
    if typeof(legacy_round_trip) != TYPE_DICTIONARY:
        _fail("Legacy v2 JSON fixture could not round-trip.")
        return false

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(legacy_round_trip):
        _fail("Legacy v2 payload was rejected by v8 code.")
        return false
    if restored.room_count() != 2:
        _fail("Legacy v2 payload did not retain both rooms.")
        return false
    if restored.active_room_id != source.active_room_id:
        _fail("Legacy v2 payload did not retain the active room.")
        return false
    if restored.grow_day != source.grow_day:
        _fail("Legacy v2 active-room cultivation state was not migrated.")
        return false

    var inactive_id := "room_2" if source.active_room_id == "room_1" else "room_1"
    var inactive := _room_cultivation(restored, inactive_id)
    if int(inactive.get("grow_day", -1)) != 0:
        _fail("Legacy v2 room without cultivation state did not migrate to defaults.")
        return false
    return true

func _verify_v1_migration(source: Node) -> bool:
    var service := SAVE_SERVICE.new()
    var legacy := service.create_v1(
        _legacy_state(source),
        String(source.active_cultivar.id),
        source.simulation_seed,
        source.rng.state,
    )

    var legacy_round_trip = JSON.parse_string(JSON.stringify(
        legacy,
        "",
        true,
        true,
    ))
    if typeof(legacy_round_trip) != TYPE_DICTIONARY:
        _fail("Legacy v1 JSON fixture could not round-trip.")
        return false

    var restored := GAME_STATE_SCRIPT.new()
    root.add_child(restored)
    if not restored.load_save_data(legacy_round_trip):
        _fail("Legacy v1 payload was rejected by v8 code.")
        return false
    if restored.room_count() != 1:
        _fail("Legacy v1 payload did not migrate to one default room.")
        return false
    if restored.daily_operating_cost() != 15:
        _fail("Legacy v1 migration did not preserve the original daily upkeep.")
        return false
    if restored.grow_day != source.grow_day:
        _fail("Legacy v1 cultivation state was not migrated into room_1.")
        return false
    return true

func _campaign_state(source: Node) -> Dictionary:
    return {
        "day": source.day,
        "cash": source.cash,
        "heat": source.heat,
        "reputation": source.reputation,
        "influence": source.influence,
        "game_over": source.game_over,
    }

func _legacy_state(source: Node) -> Dictionary:
    var state := _campaign_state(source)
    state["grow_day"] = source.grow_day
    state["grow_health"] = source.grow_health
    state["cared_today"] = source.cared_today
    state["inventory"] = source.inventory
    state["batch_quality"] = source.batch_quality
    return state

func _room_cultivation(state: Node, instance_id: String) -> Dictionary:
    for room_value in state.rooms:
        var room: Dictionary = room_value
        if String(room.get("instance_id", "")) == instance_id:
            return Dictionary(room["cultivation"]).duplicate(true)
    return {}

func _snapshot(state: Node) -> Array:
    return [
        state.day,
        state.cash,
        state.heat,
        state.reputation,
        state.influence,
        String(state.active_cultivar.id),
        state.grow_day,
        state.grow_health,
        state.cared_today,
        state.inventory,
        state.batch_quality,
        state.game_over,
        state.rooms.duplicate(true),
        state.active_room_id,
        state.hired_staff_ids.duplicate(true),
        state.owned_upgrade_ids.duplicate(true),
        state.buyer_relationships.duplicate(true),
        state.active_contract_id,
        state.compliance_level,
        state.active_district_id,
        state.district_demand.duplicate(true),
        state.institution_level,
        state.enacted_policy_ids.duplicate(true),
        state.simulation_seed,
        str(state.rng.state),
    ]

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
