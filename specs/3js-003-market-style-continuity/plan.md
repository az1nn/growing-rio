# Implementation Plan — 3JS-003 Market Style Continuity

## Verified baseline
- repository: `az1nn/growing-rio`;
- default branch at work claim: `master@bd4ef780649ee48fca91e2147872e06b3f1586d1`;
- dependency visual contract: CENA-020 PR #114 head `8fb5760c7154af22f26038fb99419f85d2ed9001`;
- PR #114 internal repository/visual checks are green; Vercel is explicit `SOFT_GATE_RATE_LIMIT`;
- 3JS-002 Grow Room is delivered with CENA ACCEPT;
- exact dependency stays `three@0.186.1`;
- canonical runtime remains Godot.

## Stack
`feat/3js-003-market` is based directly on CENA-020 head and targets `feat/cena-020-market-visual-target`. This preserves the explicit visual dependency while #114 remains provider-rate-limited.

## Scene architecture
- `src/main.js`: renderer lifecycle, resize, metrics and signals;
- `src/market.js`: scene graph and disposal;
- `src/camera.js`: fixed orthographic portrait framing;
- `src/styleTokens.js`: inherited 3JS-002 grammar with bounded Market framing;
- `src/materials.js`: reusable authored materials;
- `src/props.js`: shell, counter, vendor/storage, aisle/loading rhythm and trolley;
- `src/lighting.js`: cool industrial key/ambient with restrained warm practicals;
- `src/presentationModel.js`: immutable presentation-only placements.

## Composition
Foreground is the deal counter; mid-ground is vendor/storage; background is loading/aisle structure. A quiet dark region is deliberately preserved for UI. No signs, brands, products, route information or logistics parameters are encoded.

## Performance budget
- draw calls <= 60;
- triangles <= 22,000;
- material families <= 9;
- authored textures = 0;
- DPR <= 1.5;
- shadows = false;
- render on demand;
- instancing for repeated crates.

## Validation
1. structural validator;
2. `npm ci` + deterministic build;
3. Chromium/SwiftShader at 540x960 and 1080x1920;
4. empty console/page-error evidence;
5. renderer metrics inside budget;
6. CENA exact-head review: ACCEPT or REVISE;
7. guarded delivery only after dependency/base reconciliation.

## Concurrency
CENA-020 owns visual direction; 3JS owns runtime implementation. Same-contract drift in #114 is RECONCILE. Provider rate limiting on #114 is inherited delivery debt, not a development lock.
