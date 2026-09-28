# Implementation Plan — 3JS-005 Institutional Continuity

## Verified baseline
- repository: `az1nn/growing-rio`;
- claim base: `master@a8d1c3efae578e1325cd69783108a4f0aa5747b9`;
- dedicated branch: `feat/3js-005-institutional`;
- claim PR: #148;
- post-claim barrier: CLEAR / PARALLEL_SAFE relative to Feature 009 PRs #137→#147;
- 3JS-002 Grow Room remains the accepted style lock;
- 3JS-003 Mercado and 3JS-004 Cidade are delivered;
- exact dependency remains `three@0.186.1`;
- canonical runtime remains Godot.

## Product selection
RB-01 defines the top-level surface order as Operação → Mercado → Cidade → Institucional → Arquivo/Pesquisa. The first three now have bounded Three.js presentations; `scenes/institutional/institutional_surface.tscn` remains Control-only. Therefore Institutional is the next evidence-driven visual gap.

## Visual architecture
The candidate uses a fictional administrative/civic forum rather than a recognizable legislature or government chamber:
- foreground public threshold / low bench;
- side participation desk with no voting or ballot symbolism;
- three equal proposal pedestals rendered as one instanced neutral family;
- archive/storage wall rhythm;
- restrained structural frame and teal process rails;
- balanced warm practicals that do not spotlight any proposal;
- dark portrait UI reserve.

## Scene architecture
- `src/main.js`: renderer lifecycle, resize, metrics and signals;
- `src/institutional.js`: scene graph and disposal;
- `src/camera.js`: fixed orthographic portrait framing;
- `src/styleTokens.js`: inherited DA LATA grammar with bounded Institutional framing;
- `src/materials.js`: reusable procedural materials;
- `src/props.js`: threshold, desk, equal proposal pedestals, archive rhythm, rails and abstract decor;
- `src/lighting.js`: cool structural light plus balanced warm practicals;
- `src/presentationModel.js`: immutable fictional placements only.

## Performance budget
- draw calls <= 60;
- triangles <= 20,000;
- material families <= 9;
- authored textures = 0;
- DPR <= 1.5;
- shadows = false;
- render on demand;
- instancing for repeated proposal/archive/decor forms.

## Validation
1. dedicated structural validator;
2. `npm ci` + deterministic build;
3. Chromium/SwiftShader at 540x960 and 1080x1920;
4. empty console/page-error evidence;
5. renderer metrics inside budget;
6. structural neutrality checks for equal proposal presentation;
7. CENA exact-head review: ACCEPT or REVISE;
8. on ACCEPT only, reconcile current `master` and perform guarded delivery.

## Concurrency
PR #148 owns `3JS-005`. Feature 009 owns `docs/SIGA-HANDOFF.md` and shared Feature 009/workflow paths, so 3JS-005 deliberately does not edit that handoff or `.github/workflows/validate.yml`. Its visual workflow is dedicated and disjoint. No force update.
