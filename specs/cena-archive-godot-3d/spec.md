# Archive canonical Godot 3D — specification

## User scenario

The Archive / Research destination must read as a distinct 3D game space rather than the generic shared context blockout. The player should immediately recognize a repository/archive workspace while the existing research, completed-record and canon-uncertainty UI remains authoritative.

## Functional requirements

- **FR-001:** `ArchiveSurface` MUST replace the generic `interactive_context_3d.tscn` instance with a dedicated Godot 3D presentation scene.
- **FR-002:** The dedicated scene MUST contain a current `Camera3D`, `WorldEnvironment`, lighting and clearly visible authored `MeshInstance3D` geometry.
- **FR-003:** The composition MUST be context-distinct from Operation, Market and City and must visually read as an archive/research workspace.
- **FR-004:** The composition MUST preserve DA LATA's accepted portrait-first UI-over-3D grammar and reserve a player-visible 3D viewport instead of rendering beneath a full-screen scroll surface.
- **FR-005:** The primary 3D affordance MUST use pointer/touch-pickable `Area3D` + `CollisionShape3D` and MUST have a visible keyboard/assistive `Button` fallback.
- **FR-006:** Activating the 3D affordance MAY navigate/focus the existing Archive UI, but MUST NOT complete research, resolve narrative choices, mutate canon flags, alter RNG, change persistence, or otherwise execute domain gameplay.
- **FR-007:** The existing boundary that preserves `CÂNONE / RUMOR / ABERTO` uncertainty MUST remain visible and semantically unchanged.
- **FR-008:** Runtime visual assets in the first canonical pass SHOULD use repository-authored Godot primitives/materials unless a later CENA research/provenance step explicitly approves external assets.
- **FR-009:** The scene MUST remain compatible with the current Godot Web/mobile renderer and the exact-head Vercel export contract.
- **FR-010:** A dedicated regression MUST lock the visible viewport footprint, required 3D nodes, pointer/fallback interaction contract, presentation-only activation and a minimum authored-geometry floor.

## Visual contract boundary

This specification defines the product/runtime contract, not final art direction. Before implementation, CENA must persist a small reference/provenance decision for the Archive composition. The first pass should favor a fictional evidence desk / shelving / document-lighting grammar that does not visually authenticate any disputed lore fact.

## Success criteria

1. Archive no longer instantiates the generic shared 3D blockout.
2. At 540x960 and 1080x1920, the Archive has an unmistakable 3D composition while research/archive controls remain readable.
3. Clicking/tapping the primary 3D object and pressing its fallback button dispatch the same presentation-only action.
4. Canonical game/research/narrative state is byte-for-byte unchanged by the 3D activation itself.
5. The canonical headless regression suite and exact-head Web export succeed.

## Out of scope

- changing research prerequisites, results or completion semantics;
- resolving narrative choices from the 3D object;
- adding or changing lore canon;
- exposing real cultivation parameters or procedural real-world guidance;
- save-schema changes;
- replacing Godot with Three.js for the canonical runtime;
- introducing license-unknown runtime assets.
