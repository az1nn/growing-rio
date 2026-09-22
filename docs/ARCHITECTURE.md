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
     -> CultivationService: cycle, care and harvest transitions
     -> EconomyService: buyer pricing and sale deltas
     -> BusinessService: room operating-cost aggregation
     -> SaveService: schema dispatch, migration and JSON-safe snapshots
     -> Heat / Reputation / Influence / random events

Cultivation, economy and business calculations live behind domain services. GameState remains the orchestration boundary and owns the canonical state used by the current UI.

## Room model
V0.3 starts replacing the old implicit single room with explicit room state.

Room definitions are Resources with stable IDs and daily operating costs. Runtime/save state stores only primitive IDs:

- instance_id: unique runtime/save identity, for example room_1.
- definition_id: stable content identity, for example quarto_inicial.
- active_room_id: identifies the room associated with the current cultivation surface.

The default save/runtime state still contains exactly one quarto_inicial room, whose daily cost is R$ 15. This preserves V0.2 behavior. Additional rooms increase the aggregated daily operating cost through BusinessService. Per-room cultivation batches and UI switching are deliberately deferred to later V0.3 work.

## Save schema v2
Schema v2 extends persistence intentionally instead of mutating v1 in place.

schema_version: 2
state:
  day / cash / heat / reputation / influence
  active_cultivar_id
  grow_day / grow_health / cared_today
  inventory / batch_quality / game_over
business:
  active_room_id
  rooms[]:
    instance_id
    definition_id
simulation:
  seed
  rng_state

Rules:
1. Content is referenced by stable IDs, never serialized Resource objects.
2. rng_state remains a decimal string so JSON cannot lose 64-bit precision.
3. V2 restores the exact RNG position.
4. SaveService still accepts v1 and migrates it at the GameState boundary to one default room with the original R$ 15 upkeep.
5. Unknown schema versions and unknown room definitions are rejected.
6. Filesystem/cloud save slots remain outside the domain snapshot contract.

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

## Next architecture milestone
Continue V0.3 by deciding how cultivation state becomes per-room before adding staff/upgrades. Contract Board and Compliance remain subsequent business-layer waves.
