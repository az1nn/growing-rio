# Feature 010 — All scenes 3D and interactive

**Status:** COMPLETE — delivered and reconciled 2026-09-29  
**Target maturity:** PRESENTED / interactive 3D coverage  
**Runtime delivery:** PR #152 / merge commit `9619999fce37f50ad823e4c7cb88da50465c9546`  
**Final certification:** CENA-017 / PRs #172 and #174

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


## Delivery reconciliation — 2026-09-29

Feature 010's implementation was delivered by PR #152. Its remaining acceptance tasks are closed from the later canonical CENA-017 completeness certification, which supersedes the earlier incomplete task ledger with stronger repository and rendered evidence.

Verified certification evidence:
- certified runtime master: `33f97bcd8e5fb0e48e36ea67b501631f9290a797`;
- Validate project #818 / run `36596189406`: SUCCESS;
- Visual acceptance #369 / run `36596189548`: SUCCESS;
- rendered artifact `11046242559`: 22 PNGs; browser-console/page-error file empty;
- Vercel: SUCCESS;
- CENA-017 tasks T001-T010 closed and final session claim released;
- closure PR #174 merged into current master `64ca2c2be3fd11ae682691f923b04e7c96bc68be`.

The accepted evidence covers the Feature 010 requirements for exhaustive scene auditing, interactive 3D presence, accessible fallback, Web/rendered acceptance and no canonical-state mutation from presentation interactions.
