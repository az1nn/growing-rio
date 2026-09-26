# 3JS-002 — Technical Plan

## Base and ownership

- repository: `az1nn/growing-rio`
- claim base: `master@22cb255d0a6ca484a00a0bdf9d51693777b2e1af`
- working branch: `feat/3js-002-grow-room-style-lock`
- renderer: exact `three@0.186.1`
- canonical runtime remains Godot
- 3JS owns renderer implementation
- CENA owns visual acceptance
- SIGA owns repository/CI/merge safety

## Architecture

Create an isolated additive surface at:

`threejs/grow-room/`

The previous `threejs/operation-diorama/` parity proof remains intact as historical/technical evidence.

Modules:

- `src/main.js` — renderer bootstrap, deterministic resize/render, metrics, disposal;
- `src/growRoom.js` — scene graph, materials, geometry, lights and camera;
- `src/presentationModel.js` — immutable presentation-only layout data;
- `scripts/build.mjs` — deterministic local build with vendored Three.js module copy;
- `index.html` — minimal acceptance shell.

No domain/game-state decisions move into Three.js.

## Visual implementation strategy

Translate the reference synthesis into original geometry:

1. two-wall cutaway + floor/base establish the orthographic miniature;
2. repeated structural rhythm and modular furniture create readable scale;
3. planter/foliage clusters create the primary living silhouette;
4. abstract suspended/practical fixtures add vertical layering without encoding real cultivation settings;
5. shelves, crates, generic work surfaces and small utility shapes create compact room density;
6. cool key/ambient plus one restrained warm practical establishes the dark-room/warm-pool contrast;
7. flat-shaded low-poly materials reinforce the miniature/toy character;
8. no authored texture sampling in this first style-lock pass.

## Safety abstraction

Fixtures are environmental silhouettes only. Do not encode:

- heights/distances as real-world guidance;
- light cycles/power;
- nutrient/chemical recipes;
- temperature/humidity targets;
- yield optimization;
- operational wiring/ventilation diagrams.

## Performance budget

Exact-head automated acceptance MUST enforce:

- draw calls <= 70;
- triangles <= 35,000;
- material families <= 10;
- authored runtime textures = 0;
- renderer DPR <= 1.5;
- dynamic shadows disabled;
- no perpetual animation loop.

## Validation

Repository:
- extend `tools/validate_threejs.py` without weakening 3JS-001 contracts;
- exact dependency pin/lock consistency;
- deterministic build succeeds.

Renderer:
- ready signal;
- metrics signal;
- deterministic resize;
- explicit teardown/disposal;
- no perpetual loop/listener leak.

Visual:
- dedicated exact-head workflow;
- captures at 540x960 and 1080x1920;
- browser console/page-error artifact empty;
- rendered inspection against the reference ledger and CENA baseline.

## Files expected to change

- `specs/3js-002-grow-room-style-lock/**`
- `docs/references/3js-002-grow-room/**`
- `threejs/grow-room/**`
- `tools/validate_threejs.py`
- `.github/workflows/threejs-grow-room-visual-acceptance.yml`
- `docs/3JS-HANDOFF.md`

No generated `web/` file is hand-authored by this feature.

## Delivery

Open a PR to `master`, require exact-current-head repository and grow-room visual gates, inspect rendered artifacts, then merge only with an expected-head guard after acceptance.
