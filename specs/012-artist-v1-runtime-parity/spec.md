# Feature 012 — ARTIST V1 runtime parity

**Status:** SPECIFIED / PLAN-ONLY  
**Target maturity:** V1 IMPLEMENTED 1:1  
**Owner route:** SIGA -> ARTIST/CENA -> runtime owner -> LENTE  
**Reference branch:** `feat/artist-isolated-scenes-v1` / PR #190  
**Reference head:** `5ced1c3b7d50f102160eb7f382f0faaf950546e2`

## Problem

DA LATA now has one isolated V1 concept render for each of the 11 canonical player-facing scenes, but the shipped runtime still reflects the previous production-candidate low-poly/primitive visual grammar. Existing Three.js packages were created as isolated reference/parity prototypes, while Godot remains the canonical game runtime and already owns navigation, state, interaction, accessibility, persistence and the shipped Web export.

The product goal is no longer "prove every scene is 3D". It is:

> reproduce the accepted ARTIST V1 scene language in the actual playable game with scene-by-scene visual parity, real 3D geometry and working interactions.

This feature first resolves whether Three.js is useful for that goal, then implements V1 through the smallest architecture that avoids duplicate runtime ownership.

## Canonical V1 references

The source-of-truth scene concepts are:

- `assets/art-direction/v1/scenes/operation.webp`
- `assets/art-direction/v1/scenes/market.webp`
- `assets/art-direction/v1/scenes/city.webp`
- `assets/art-direction/v1/scenes/institutional.webp`
- `assets/art-direction/v1/scenes/archive.webp`
- `assets/art-direction/v1/scenes/campaign.webp`
- `assets/art-direction/v1/scenes/narrative.webp`
- `assets/art-direction/v1/scenes/finale-selection.webp`
- `assets/art-direction/v1/scenes/finale-handoff.webp`
- `assets/art-direction/v1/scenes/finale-coda.webp`
- `assets/art-direction/v1/scenes/finale-recap.webp`

The manifest and locked style contract remain authoritative for provenance and global direction.

## Definition of 1:1

"1:1" means runtime parity with the accepted reference at the level a real interactive 3D scene can preserve:

1. camera/framing and portrait composition;
2. major architectural masses and depth layers;
3. location-specific silhouette;
4. the three primary interaction anchors;
5. dominant palette and warm/cool lighting balance;
6. graffiti/pixel-art surface language;
7. prop density and focal hierarchy;
8. lower UI-safe negative space where present;
9. scene-specific atmosphere and distinguishability.

1:1 MUST NOT be satisfied by placing the generated concept image as a flat full-scene wallpaper. The player-visible environment remains real 3D with physical interactive objects.

Generated incidental details that conflict with repository canon, safety constraints or the locked V1 textual contract are not automatically binding production canon. Their visual role should be preserved with a fictional/canon-safe equivalent unless the user explicitly locks the literal element.

## User scenarios

### US1 — The game looks like V1
When a player opens any canonical destination or finale phase, the runtime reads as the same scene depicted in its V1 isolated concept rather than as the older generic primitive diorama.

### US2 — It remains a game, not a screenshot
The player can identify and activate the scene's physical interaction anchors, with pointer/touch picking and accessible fallback, while the environment preserves real spatial depth.

### US3 — One renderer owns production
The shipped game does not require two independently maintained 3D implementations of the same scene unless a measured product requirement justifies the duplication.

### US4 — V1 stays coherent on mobile Web
At 540x960 and 1080x1920, the scene composition, UI readability, interaction targets and frame-time remain viable in the existing Web/mobile delivery path.

## Functional requirements

- **FR-001:** Perform and persist a renderer decision for V1 before broad runtime implementation.
- **FR-002:** The renderer decision MUST compare current Godot and Three.js architecture against V1 fidelity, integration cost, interaction ownership, build/deploy path, performance, asset pipeline, testability and maintenance duplication.
- **FR-003:** Godot remains canonical gameplay/domain/persistence owner unless a later explicit architecture specification changes it.
- **FR-004:** Every V1 runtime scene MUST use real 3D geometry and retain the existing presentation-only hotspot boundary.
- **FR-005:** Each scene MUST map its ARTIST interaction foci to physical 3D anchors and accessible fallback controls.
- **FR-006:** The runtime MUST support a pixel-art/graffiti material pipeline suitable for nearest-neighbor authored textures/atlases and/or a bounded scene-only pixelation/palette treatment without degrading the full-resolution UI.
- **FR-007:** Runtime art MUST use repository-owned/generated/licensed assets with provenance recorded; no unknown-license asset is allowed.
- **FR-008:** No generated reference image may be treated as proof of implementation.
- **FR-009:** Each scene requires exact-head LENTE before/after evidence at 540x960 and 1080x1920.
- **FR-010:** Each scene requires an ARTIST/CENA visual decision of `ACCEPT` or `REVISE` against its locked V1 reference.
- **FR-011:** Acceptance MUST evaluate composition, silhouette, depth, palette, graffiti/pixel treatment, lighting, focal objects, safe area and interaction affordance.
- **FR-012:** Existing gameplay, save data, economy, campaign, research, narrative rules and domain determinism MUST remain unchanged unless separately specified.
- **FR-013:** Feature 011 semantic hotspot behavior MUST remain compatible; V1 art may reposition hotspots visually but not change their domain semantics.
- **FR-014:** Finale selection, handoff, coda and recap MUST remain visually distinct even if they share reusable implementation primitives.
- **FR-015:** The implementation MUST preserve current Godot Web export and Vercel delivery unless the renderer decision explicitly selects and specifies a replacement.
- **FR-016:** A single vertical slice (Operation) MUST reach V1 parity before the remaining ten scenes are authorized as a batch implementation.
- **FR-017:** If Three.js is not selected for shipped V1, existing Three.js packages are frozen as reference/prototype assets; deletion is out of scope for this feature.

## Renderer decision acceptance

Three.js is selected for shipped V1 only if the evidence shows a material advantage that outweighs duplicated runtime integration. At minimum it must prove:

- equal or better visual parity to the Operation V1 reference;
- a safe bridge to canonical Godot state without duplicating domain rules;
- equivalent pointer/touch/accessibility behavior;
- a production build/deploy path that is not hand-authored inside generated `web/`;
- acceptable Web/mobile performance;
- lower total implementation/maintenance cost than the Godot-native V1 path.

Absent that evidence, the default decision is Godot-native V1 implementation and Three.js remains a non-production reference lane.

## Scene acceptance contract

For every scene:

1. lock reference image SHA;
2. capture current exact-head BEFORE;
3. record a decomposition map: architecture, materials/decals, lights, primary props, interaction anchors, UI-safe area;
4. implement real 3D;
5. capture exact-head AFTER at both portrait sizes;
6. compare reference vs AFTER with LENTE/model review;
7. record ARTIST/CENA `ACCEPT` or `REVISE`;
8. verify hotspot/fallback behavior;
9. verify browser/page console is clean;
10. merge only with exact-head repository gates green.

## Success criteria

- **SC-001:** Renderer decision is explicit and evidence-backed.
- **SC-002:** Operation reaches accepted V1 runtime parity without gameplay/persistence changes.
- **SC-003:** All 11 scene/phase references eventually reach `IMPLEMENTATION_ACCEPTED`.
- **SC-004:** No accepted scene is a flat-image substitute for 3D.
- **SC-005:** 540x960 and 1080x1920 exact-head captures remain readable and interactive.
- **SC-006:** Existing semantic hotspot and regression suites remain green.
- **SC-007:** Runtime asset provenance is complete.
- **SC-008:** Production architecture has one primary renderer owner for the shipped scene layer.

## Out of scope

- new gameplay systems;
- balance changes;
- save schema changes;
- canon expansion;
- real-world operational cultivation/logistics instruction;
- replacing V1 with V2 art direction;
- literal pixel-perfect reproduction of generated text or accidental reference artifacts;
- deleting historical Three.js work during the decision wave;
- broad engine migration before the Operation vertical slice proves the selected path.
