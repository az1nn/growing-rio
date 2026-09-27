# Implementation Plan — 3JS-004 City Topographic Continuity

## Verified baseline
- repository: `az1nn/growing-rio`;
- delivered closure base: `master@f402713d2e3b9003aa49bcefb944e1bbc91dd903`;
- visual dependency: CENA-021 / PR #120 head `92a7e07f553244ea8643a420310469555ab3efe0`;
- 3JS-002 Grow Room remains the accepted style lock;
- 3JS-003 Mercado is delivered;
- exact dependency remains `three@0.186.1`;
- canonical runtime remains Godot.

## Stack
`feat/3js-004-city` is based directly on CENA-021 and targets `feat/cena-021-city-visual-target`.

## Scene architecture
- `src/main.js`: renderer lifecycle, resize, metrics and signals;
- `src/city.js`: scene graph and disposal;
- `src/camera.js`: fixed orthographic portrait framing;
- `src/styleTokens.js`: inherited DA LATA grammar with bounded City framing;
- `src/materials.js`: reusable procedural materials;
- `src/props.js`: terrain bands, retaining edges, urban clusters, skyline and vegetation;
- `src/lighting.js`: cool structural light plus restrained warm neighborhood practical;
- `src/presentationModel.js`: immutable fictional placements only.

## Composition
Foreground is an overlook/retaining edge. Mid-ground is three stepped urban bands with clustered low-rise massing and vegetation breaks. Background is a restrained skyline/ridge. The scene is not a route map and encodes no real geography.

## Performance budget
- draw calls <= 60;
- triangles <= 22,000;
- material families <= 9;
- authored textures = 0;
- DPR <= 1.5;
- shadows = false;
- render on demand;
- instancing for repeated buildings/windows/vegetation.

## Validation
1. structural validator;
2. `npm ci` + deterministic build;
3. Chromium/SwiftShader at 540x960 and 1080x1920;
4. empty console/page-error evidence;
5. renderer metrics inside budget;
6. CENA exact-head review: ACCEPT or REVISE;
7. guarded delivery only after dependency/base reconciliation.

## Concurrency
CENA-021 owns visual direction; 3JS owns runtime implementation. Same-contract drift in #120 is RECONCILE. No force update.
