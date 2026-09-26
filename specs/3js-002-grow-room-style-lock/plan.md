# Implementation Plan — 3JS-002 Grow Room Style Lock

## Verified baseline

- repository: `az1nn/growing-rio`;
- default branch at final spec reconciliation: `master`;
- 3JS-001 is delivered and merged;
- canonical runtime remains Godot;
- Three.js version to reuse initially: exact `three@0.186.1`;
- no open pull request owned an overlapping 3JS/CENA runtime surface when this spec wave was reconciled;
- user-provided reference pack is stored under `docs/visual-references/3js-grow-room/`.

## Delivery strategy

Keep 3JS-001 as the parity proof/archive. Implement 3JS-002 as a separate bounded scene under:

`threejs/grow-room/`

Do not hand-edit generated `web/` output and do not replace the canonical Godot boot path.

## Visual architecture

Suggested module boundaries:

- `src/main.js` — renderer lifecycle, resize, acceptance signals;
- `src/growRoom.js` — scene graph composition;
- `src/camera.js` — fixed orthographic/near-isometric framing;
- `src/styleTokens.js` — palette, material ranges, scale/grid, edge/pixel policy;
- `src/materials.js` — reusable authored materials;
- `src/props.js` — repository-authored abstract prop families;
- `src/lighting.js` — dark-envelope + warm-practical/cool-fill grammar;
- `src/presentationModel.js` — immutable/read-only presentation data;
- explicit disposal for renderer, geometries, materials, textures and listeners.

The exact file graph may be adjusted during implementation, but renderer/domain separation is mandatory.

## Reference translation

Translate only high-level traits:

1. **isometric/pixel references:** room-box readability, chunky silhouettes, dense-but-readable object clusters, disciplined edges;
2. **soft low-poly references:** miniature scale read, simple massing, depth layering;
3. **cozy/dark references:** selective warm light, cool/dark envelope, focal contrast;
4. **DA LATA baseline:** concrete/plaster/metal/wood/terracotta/green family, Rio-adjacent reuse/repair character, portrait UI readability.

Avoid literal source palettes, branded shapes, copied props or source-specific layouts.

## Style-token decisions to prove in the scene

The accepted grow room must yield concrete reusable values/rules for:

- camera yaw/pitch and orthographic scale;
- world-unit/grid convention;
- minimum silhouette size at 540px width;
- palette roles rather than source colors;
- roughness/metalness bands;
- flat/smooth shading policy;
- optional low-resolution atlas/pixel-density rule;
- outline/edge policy;
- warm key / cool fill intensities and falloff;
- prop-cluster density and negative-space ratio;
- foreground/midground/background contrast separation;
- ambient animation amplitude and rate;
- UI-over-3D contrast reserve.

## Performance budget

- draw calls: <= 65;
- triangles: <= 35,000;
- material families: <= 10;
- authored runtime textures: <= 2 small textures, only if the style proof requires them;
- DPR: <= 1.5;
- dynamic shadows: disabled for this style-lock wave;
- avoid perpetual work when the scene is static; render on demand unless animation is deliberately introduced;
- repeated geometry should use instancing when it materially reduces cost.

## Validation

1. structural validation for scene package and exact Three.js pin;
2. `npm ci` + deterministic build;
3. Chromium/SwiftShader render at 540x960 and 1080x1920;
4. empty console/page-error artifact;
5. renderer metrics inside budget;
6. disposal/listener teardown validation;
7. rendered visual review against the reference synthesis and DA LATA baseline;
8. exact-head evidence only.

## Style-lock rule

Rendered acceptance is the design decision gate.

If result is **REVISE**, continue on the grow room only.

If result is **ACCEPT**, update `docs/VISUAL-DIRECTION.md` with the exact reusable style tokens proven by the accepted head; only then may the next 3JS scene inherit the definitive style.

## Concurrency

Before implementation and merge:
- re-read master and open PRs;
- treat any changes to 3JS architecture, CENA visual contracts, grow-room scene contracts or shared acceptance workflows as semantic overlap;
- preserve current SIGA/LORE/CENA state;
- never merge from stale CI or stale visual evidence.
