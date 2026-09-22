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
      +-- market resolution
      +-- Heat / Reputation / Influence
      +-- random events
```

The first domain extraction is now active: cultivation formulas and transitions live outside the Autoload. GameState remains the orchestration boundary consumed by the UI.

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
      economy_simulator.gd
    market/
      market_service.gd
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
4. Save format will be explicit/versioned before persistence is added.
5. Content IDs are stable `StringName` values once Resources are introduced.

## Next architecture milestone
Extract economy / market resolution from `GameState`, keeping the UI contract and deterministic seeded simulation stable. Add save schema v1 only after these state boundaries are stable.
