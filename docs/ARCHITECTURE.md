# DA LATA — Architecture v0.1

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
      +-- time progression
      +-- cultivation abstraction
      +-- market resolution
      +-- Heat / Reputation / Influence
      +-- random events
```

This intentionally keeps the first build small. Domain extraction happens once mechanics stabilize.

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
Extract the current monolithic `GameState` after the first validated gameplay pass, not before. Premature decomposition would add ceremony before the economic loop is proven fun.
