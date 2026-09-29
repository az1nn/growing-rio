# 3JS-006 — Implementation plan

## Route

SIGA owns repository state, concurrency, exact-head CI and delivery. CENA-023 owns the Archive visual target and rendered acceptance. 3JS-006 owns the isolated Three.js implementation.

## Baseline

- `master@8d60d7255bcd34cf824f04f4a1e692a52981eb0f`;
- no open session overlapped the post-claim barrier;
- PR #176 / `feat/3js-006-archive` owns `CENA-023+3JS-006`;
- canonical Godot Archive already provides the semantic/compositional reference;
- existing 3JS-005 package provides the current implementation/CI pattern.

## Architecture

Create `threejs/archive/` with the established package shape:
- `index.html`;
- exact dependency manifests;
- `scripts/build.mjs`;
- `src/main.js`;
- `src/archive.js`;
- `src/presentationModel.js`;
- `src/styleTokens.js`;
- `src/materials.js`;
- `src/camera.js`;
- `src/lighting.js`;
- `src/props.js`.

The package is isolated from Godot and from gameplay state.

## Visual translation

Translate the canonical Godot Archive semantically, not node-for-node:
- evidence desk/tray = primary focal hierarchy;
- shelves/storage = archival depth/rhythm;
- uncertainty rail = explicit visual boundary, not a claim of truth;
- paper/evidence objects = abstract records with no readable real-world content;
- cool envelope + warm desk practical = evidence-review focal contrast.

Reuse the accepted Three.js visual grammar without cloning another scene layout.

## Validation

Add:
- `tools/validate_archive_threejs.py` for exact version pin, required files, presentation-only invariants, no textures/perpetual loop, metrics/readiness/disposal contracts;
- `.github/workflows/threejs-archive-visual-acceptance.yml` for exact-head build + Playwright portrait captures + budget enforcement + console/page-error evidence.

The Archive workflow should validate previously accepted Three.js baselines before validating the new package.

## Delivery

1. Persist CENA target + 3JS spec.
2. Implement isolated candidate.
3. Run exact-head repository/Archive visual CI.
4. Inspect rendered artifact through CENA and record `ACCEPT` or `REVISE`.
5. Repair only concrete defects if revised.
6. Remove temporary session claim.
7. Reconcile drift and merge only with exact-head guards and applicable gates satisfied.
8. Treat explicit provider quota as a soft delivery gate only when repository/visual validation is green.
