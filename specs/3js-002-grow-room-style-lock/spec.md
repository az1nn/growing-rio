# Feature Specification — 3JS-002 Grow Room Style Lock

## Status
Specified for implementation. Visual direction is **CANDIDATE** until rendered acceptance.

## User value
The grow room is the place where the player is expected to spend the most time. It therefore becomes the first scene that must establish a distinctive, durable and performance-safe DA LATA Three.js visual language before other screens are redesigned.

3JS-002 turns the grow room into the visual style gate for later scenes.

## Functional requirements

- **FR-001 — one-scene scope:** 3JS-002 owns only the player-facing grow-room scene. Other screens/locations do not adopt a new style in this wave.
- **FR-002 — reference synthesis:** use the project-owner reference pack in `docs/visual-references/3js-grow-room/` as high-level visual input only. Do not reproduce proprietary assets, UI, logos, characters, typography or exact source layouts.
- **FR-003 — original visual target:** test an original DA LATA synthesis of fixed isometric/orthographic diorama readability, chunky low-poly silhouettes, pixel-art discipline, miniature depth, authored prop density and warm/cool interior lighting.
- **FR-004 — fixed camera:** use a fixed orthographic or near-isometric Three.js camera. Free-roaming camera movement is out of scope.
- **FR-005 — gameplay boundary:** Three.js consumes presentation-only/read-only state. It owns no economy, progression, persistence, RNG, availability or cultivation rules.
- **FR-006 — portrait-first acceptance:** the grow room must remain coherent and fully readable at 540x960 and 1080x1920.
- **FR-007 — style-token output:** implementation must make camera, scale/grid, palette, material response, texture/pixel density, edge policy, lighting, prop density, depth separation and ambient-animation limits explicit enough to reuse after acceptance.
- **FR-008 — definitive-style gate:** no later screen may treat this visual direction as canonical until the exact-head grow-room render receives ACCEPT status through CENA-style visual review. Before that point the status is CANDIDATE.
- **FR-009 — asset provenance:** begin with repository-authored procedural/primitive geometry and authored materials. Any third-party runtime asset requires explicit source/license/provenance review.
- **FR-010 — Web/mobile budget:** target <= 65 draw calls, <= 35,000 triangles, <= 10 material families, <= 2 small authored textures only when justified by the style pass, DPR <= 1.5 and no dynamic shadows in this wave.
- **FR-011 — lighting discipline:** use at most the minimum small light set needed to prove the warm-practical/cool-fill read; do not make photoreal lighting or shadow complexity the style.
- **FR-012 — abstract cultivation:** plants, containers and room dressing stay visually abstract and non-operational; do not encode real-world cultivation measurements, labels, recipes or equipment instructions.

## Acceptance scenarios

### AS-001 — grow-room identity
At 540x960, a player can immediately read the room shell, primary work zone, plant zone and storage/service zone without relying on labels.

### AS-002 — high-resolution portrait
At 1080x1920, the same composition remains coherent rather than revealing empty prototype space or excessive detail noise.

### AS-003 — reference convergence without copying
A visual review can identify the intended high-level traits from the reference pack while the scene remains recognizably original DA LATA work.

### AS-004 — atmosphere
The room reads as a compact, lived-in miniature interior with darker envelope, selective warm focal light and cooler separation, while focal objects remain legible.

### AS-005 — engineering acceptance
The exact final head builds, captures both portrait sizes, emits no page/console errors, remains inside the renderer budget and tears down renderer resources/listeners cleanly.

### AS-006 — style decision
Visual review returns exactly one state:
- **ACCEPT** — grow-room style tokens become the reusable baseline for subsequent screens;
- **REVISE** — grow room remains the only active visual target and later screens stay blocked from style propagation.

## Success criteria

- an original grow-room Three.js scene exists as the highest-fidelity visual target in the project;
- both portrait captures are visually accepted;
- the style system is explicit and reusable;
- performance and lifecycle gates pass on the exact head;
- no gameplay/persistence/canon semantics change;
- later-screen visual work remains gated until grow-room ACCEPT.

## Out of scope

- other rooms, city screens or menus;
- Godot runtime replacement;
- persistence/gameplay/economy changes;
- free-roam camera;
- operational cultivation simulation or instructions;
- broad external asset-pack import;
- copied reference-game assets, UI or branding;
- definitive global style declaration before rendered grow-room acceptance.
