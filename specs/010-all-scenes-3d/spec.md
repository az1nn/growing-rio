# Feature 010 — All scenes 3D and interactive

## User Scenarios
DA LATA must read and behave as a 3D game throughout the complete playable navigation loop. No shipped Godot scene may fall back to a purely 2D surface.

## Functional Requirements

- **FR-001:** Every `.tscn` under `scenes/` MUST instantiate, directly or through a scene dependency, a `Node3D` world.
- **FR-002:** Every shipped scene MUST expose a current `Camera3D`, a `WorldEnvironment`, at least one `Light3D`, and visible `MeshInstance3D` geometry.
- **FR-003:** Every shipped scene MUST expose at least one pointer/touch-pickable `Area3D` backed by `CollisionShape3D`.
- **FR-004:** Every 3D object action MUST also expose a visible `Button` fallback for keyboard, assistive and deterministic test access.
- **FR-005:** Operação, Mercado, Cidade, Institucional and Arquivo MUST present context-distinct 3D compositions while retaining the accepted DA LATA palette and portrait-first UI-over-3D grammar.
- **FR-006:** 3D presentation interactions MUST NOT mutate canonical game, economy, cultivation, campaign, lore or save state.
- **FR-007:** The complete scene inventory MUST be audited automatically; adding a later Control-only scene MUST fail validation.

## Success Criteria

1. Loading every scene recursively finds world, camera, environment, light and mesh nodes.
2. Loading every scene recursively finds a pickable `Area3D`, collision shape and accessible button.
3. Activating the 3D object and its fallback dispatches the same presentation-only signal.
4. The full existing regression suite remains green and the Web export succeeds.
5. 540x960 and 1080x1920 rendered captures show a 3D composition on every top-level destination without hiding navigation or action controls.

## Out of Scope

- gameplay, balance or save-schema changes;
- engine migration away from Godot;
- external 3D assets or unknown-license content;
- replacement of the bounded Three.js reference/marketing surfaces;
- new lore or real-world operational guidance.
