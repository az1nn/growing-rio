# DA LATA — Architecture v0.2

## Target
- Godot 4.7.2 stable.
- GDScript.
- Mobile-first portrait UI, with Web/Desktop compatibility.
- Data-driven content as the project expands.

## Current slice
`GameState` is an Autoload that owns simulation state and emits UI-facing signals.

```text
UI (Main scene)
      |
      v
GameState Autoload
      |
      +--> CultivationService
      |      +-- cycle progression
      |      +-- care transition
      |      +-- harvest transition
      |
      +--> EconomyService
      |      +-- buyer pricing
      |      +-- sale outcome deltas
      |
      +--> SaveService
      |      +-- schema version dispatch
      |      +-- JSON-safe snapshot contract
      |      +-- stable content IDs
      |      +-- deterministic RNG continuation
      |
      +-- Heat / Reputation / Influence
      +-- random events
```

Cultivation and economy transitions live behind domain services. `GameState` remains the UI-facing orchestration boundary, applies returned deltas to canonical state and emits presentation signals. `SaveService` owns the serialized contract and has no dependency on UI nodes.

## Save schema v1
The v1 payload is deliberately explicit:

```text
schema_version: 1
state:
  day / cash / heat / reputation / influence
  active_cultivar_id
  grow_day / grow_health / cared_today
  inventory / batch_quality / game_over
simulation:
  seed
  rng_state
```

Rules:
1. Content is referenced by stable IDs such as `quarto_classica`, never by serialized `Resource` objects.
2. `rng_state` is transported as a decimal string so a JSON round-trip cannot lose 64-bit precision.
3. Loading restores the exact RNG position, so the next stochastic transition is equivalent to uninterrupted play.
4. Schema dispatch rejects unsupported versions. Future migrations must enter through the same version boundary.
5. The current milestone defines the serialization contract only; filesystem/cloud save slots can be added later without changing the domain snapshot shape.

## Planned extraction
```text
res://
  autoload/
    game_state.gd
    event_bus.gd
    save_service.gd
  domain/
    cultivation/
      grow_simulator.gd
      batch_state.gd
    economy/
      economy_service.gd
    politics/
      policy_simulator.gd
    events/
      event_resolver.gd
  resources/
    cultivars/
    buyers/
    policies/
    upgrades/
    events/
  scenes/
    main/
    grow_room/
    market/
    city/
    policy/
```

## State rules
1. Domain state never depends on UI nodes.
2. UI sends commands and renders emitted state.
3. Randomness lives in simulation services, not presentation code.
4. Save format is explicit and versioned before persistence is added.
5. Content IDs are stable `StringName` values once Resources are introduced.

## Next architecture milestone
V0.3 can start on the business layer: multiple rooms, operating costs, staff/upgrades, buyer relationships and compliance progression. Any new persistent state must extend the save contract intentionally and preserve explicit migration/version dispatch.
