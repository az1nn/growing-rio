# DA LATA — Architecture v0.3

## Target
- Godot 4.7.2 stable.
- GDScript.
- Mobile-first portrait UI, with Web/Desktop compatibility.
- Data-driven content as the project expands.

## Current slice
GameState is an Autoload that owns canonical simulation state and emits UI-facing signals.

UI (Main scene)
  -> GameState Autoload
     -> CultivationService: cycle, care, harvest and abstract stability application
     -> EconomyService: buyer pricing and sale deltas
     -> BusinessService: room/staff/upgrade costs and abstract modifiers
     -> SaveService: schema dispatch, migration and JSON-safe snapshots
     -> Heat / Reputation / Influence / random events

Cultivation, economy and business calculations live behind domain services. GameState remains the orchestration boundary and owns canonical runtime state.

## Room model
V0.3 has explicit room-scoped cultivation state.

Each room stores primitive, save-safe state:

- instance_id: unique runtime/save identity, for example room_1.
- definition_id: stable room content identity, for example quarto_inicial.
- cultivation.active_cultivar_id: stable cultivar content identity.
- cultivation.grow_day.
- cultivation.grow_health.
- cultivation.cared_today.
- cultivation.inventory.
- cultivation.batch_quality.

active_room_id selects which room the existing UI surface renders and commands. GameState keeps a UI-facing compatibility cache for the active room, but rooms[].cultivation is canonical. Switching rooms only changes that projection; it does not copy cultivation state between rooms.

The default state still contains one quarto_inicial room with R$ 15/day operating cost, preserving V0.2 behavior. New rooms begin with the default abstract cultivation state. next_day advances every room independently in stable array order using the shared deterministic RNG stream.

## Staff and upgrades
Staff and upgrades are content-backed business modifiers, not UI state.

Canonical runtime state stores only stable IDs:
- hired_staff_ids[]
- owned_upgrade_ids[]

The first staff definition is assistente_operacional. The existing sensores_basicos UpgradeDefinition is reused directly rather than introducing a parallel upgrade model.

BusinessService resolves:
- staff daily cost;
- upgrade daily upkeep;
- one clamped health_stability_modifier composed from owned staff/upgrades.

CultivationService accepts that modifier as an explicit input to advance_day. No extra random draw is introduced, so identical seeds and modifier state remain deterministic. The modifier is intentionally abstract and does not encode real cultivation parameters.

## Save schema v4
Schema v4 extends the business snapshot with stable staff and upgrade IDs.

schema_version: 4
state:
  day / cash / heat / reputation / influence / game_over
business:
  active_room_id
  rooms[]:
    instance_id
    definition_id
    cultivation:
      active_cultivar_id
      grow_day / grow_health / cared_today
      inventory / batch_quality
  staff_ids[]
  upgrade_ids[]
simulation:
  seed
  rng_state

Rules:
1. Content is referenced by stable IDs, never serialized Resource objects.
2. rng_state remains a decimal string so JSON cannot lose 64-bit precision.
3. V4 restores the exact RNG position, every room cultivation snapshot and owned staff/upgrades.
4. V1 migrates its single legacy cultivation snapshot into room_1 and starts with no staff/upgrades.
5. V2 retains its room list, migrates the legacy global cultivation snapshot into the saved active room, initializes other rooms with default cultivation state and starts with no staff/upgrades.
6. V3 keeps all room-scoped cultivation state and migrates with empty staff/upgrades.
7. Unknown schema versions, room definitions, cultivars, staff IDs and upgrade IDs are rejected.
8. Filesystem/cloud save slots remain outside the domain snapshot contract.

## Planned extraction
res://
  autoload/
    game_state.gd
    event_bus.gd
    save_service.gd
  domain/
    cultivation/
    economy/
    business/
    politics/
    events/
  resources/
    cultivars/
    buyers/
    rooms/
    staff/
    policies/
    upgrades/
    events/
  scenes/
    main/
    grow_room/
    market/
    city/
    policy/

## State rules
1. Domain state never depends on UI nodes.
2. UI sends commands and renders emitted state.
3. Randomness lives in simulation services, not presentation code.
4. Persistent state changes enter through an explicit versioned save boundary.
5. Content IDs are stable StringName values in Resources and plain strings in serialized state.
6. Room switching changes the active projection, never another room's canonical cultivation state.
7. Staff/upgrades apply through deterministic domain modifiers rather than scene-specific behavior.

## Next architecture milestone
With Staff/Upgrades stable, continue V0.3 with Contract Board and buyer relationships. Compliance remains the subsequent business-layer wave.
