# Feature Specification — 3JS-001 OperationDiorama Parity Proof

## Status
Drafted and implemented for exact-head validation.

## User value
DA LATA needs a reversible Three.js proof that reproduces the accepted OperationDiorama visual grammar before any renderer migration is discussed. The proof gives the project concrete visual and performance evidence while preserving the shipped Godot runtime.

## Functional requirements
- **FR-001 — isolated proof:** provide an isolated Three.js OperationDiorama proof without replacing or mutating the canonical Godot boot path, save path, gameplay state or generated `web/` export.
- **FR-002 — accepted CENA baseline:** derive composition from CENA Wave 019, including orthographic diorama read, room masses, concrete/warm-plaster/dark-metal/teal/terracotta families, planter/foliage silhouettes, cool/warm lighting and stepped foreground progression.
- **FR-003 — portrait parity:** render deterministically at 540x960 and 1080x1920 without clipping, z-fighting, page errors or console errors that invalidate the scene.
- **FR-004 — read-only model:** Three.js consumes presentation-only state and owns no gameplay, economy, campaign, persistence or RNG rules.
- **FR-005 — lifecycle:** deterministic resize plus explicit renderer/geometry/material/listener disposal; no continuous animation loop is required.
- **FR-006 — pinned dependency:** exact Three.js dependency in a local package manifest/lockfile; no unpinned CDN path.
- **FR-007 — Web budget:** draw calls <= 55, triangles <= 25,000, materials <= 8, textures 0, shadows disabled and DPR <= 1.5.

## Acceptance scenarios
- **AS-001 — 540x960:** room, planters, counter, foreground steps and material/light hierarchy remain recognizable and fully framed.
- **AS-002 — 1080x1920:** the same hierarchy remains coherent without introducing a new art direction.
- **AS-003 — renderer evidence:** browser error artifact is empty and FR-007 passes.
- **AS-004 — runtime safety:** no generated `web/`, Godot boot/gameplay or persistence-schema change is authored by 3JS-001.

## Out of scope
Godot replacement, gameplay/economy/campaign/save changes, new canon, CENA redesign, asset packs, post-processing/shadows/textures and stable public deployment of the proof.

## Success criteria
The exact final PR head passes repository validation, Three.js build validation, both portrait captures, browser-error checks, renderer-budget checks and CENA parity review.
