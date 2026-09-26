# Implementation Plan — 3JS-001 OperationDiorama Parity Proof

## Verified baseline
- repository: `az1nn/growing-rio`;
- canonical runtime: Godot;
- stacked visual base: PR #104 / `feat/cena-019-foreground-service-landing`;
- verified baseline head at claim: `35ebf05c5dec4a59a99207b73fee25c541629b04`;
- exact-head Validate project: success;
- exact-head Visual acceptance capture: success;
- Vercel: success;
- accepted sizes: 540x960 and 1080x1920.

## Integration path
3JS-001 is an additive repository-local browser proof under `threejs/operation-diorama/`. It stays outside generated `web/`, does not change `vercel.json`, and does not change the Godot export path.

## Dependency decision
- `three`: `0.186.1`, exact pin, MIT;
- no CDN dependency;
- no bundler dependency: the build script copies the pinned Three.js ESM module into isolated `dist/vendor/` output.

## Renderer structure
- `src/presentationModel.js` — immutable presentation-only baseline data;
- `src/operationDiorama.js` — scene/material/camera/light/geometry construction and disposal;
- `src/main.js` — renderer lifecycle, resize, metrics and one-shot render;
- `scripts/build.mjs` — isolated copy build;
- `index.html` — proof surface and lightweight UI-over-3D legibility frame.

## Parity translation
Translate CENA-019 rather than Godot internals: fixed-width orthographic camera, repository material values, room/window/door/counter/shelves/planters/crates and Wave 016-019 foreground progression, plus ambient/cool-key/warm-practical lighting. No shadows or textures.

## Performance budget
<=55 draw calls; <=25k triangles; <=8 materials; 0 textures; shadows disabled; DPR <=1.5; no perpetual animation loop; reused geometry/materials.

## Validation
Repository: `python tools/validate_threejs.py`, `npm ci`, `npm run build`, plus existing Godot validation.
Rendered: exact-head Chromium/SwiftShader capture at 540x960 and 1080x1920, explicit ready signal, fail on browser errors, upload metrics/screenshots, fail on budget overrun.

## Concurrency
This wave is stacked on CENA #104 because parity depends on Wave 019 geometry. It does not edit `scenes/visual/operation_diorama.tscn`, CENA docs, lore sources or generated Godot Web artifacts. If #104 moves, evidence becomes stale and parity must be reconciled before completion.
