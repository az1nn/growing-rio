# Feature 012 — Implementation Plan: ARTIST V1 runtime parity

**Spec:** [spec.md](./spec.md)  
**Planning state:** `GODOT_NATIVE_V1` locked; shared V1 visual system delivered; Operation V1 is next  
**Implementation authority:** SIGA for delivery, ARTIST/CENA for visual acceptance, LENTE for exact-head evidence

**Execution contract:** [SIGA-ROADMAP.md](./SIGA-ROADMAP.md) is `STRICT_SEQUENTIAL`; exactly one roadmap item may be active, and later items remain locked until predecessor `PASS`.


## Reconciled baseline — 2026-09-30

### Canonical runtime
- Godot 4.7.2, GL Compatibility.
- Godot owns gameplay, UI, navigation, state, persistence and current Web export.
- Feature 010/CENA-017 already certifies all canonical destinations as real interactive 3D.
- Feature 011 is the active semantic-hotspot pass.

### Current Three.js state
- isolated packages exist for Operation parity, Grow Room, Market, City, Institutional and Archive;
- all use `three@0.186.1`;
- they are standalone reference/acceptance surfaces, not the shipped game renderer;
- Vercel production output is the Godot-generated `web/` directory;
- current Three.js style contracts deliberately target primitive low-poly geometry, zero authored textures and no shadows;
- the current Three.js lane does not cover Campaign, Narrative or the four Finale references.

### V1 delta
The ARTIST V1 references require a materially different production language:
- chunky pixel-art surface treatment;
- bold graffiti/stencil identity;
- denser authored props and environmental storytelling;
- richer per-scene silhouettes;
- stronger magenta/cyan/amber accent lighting;
- texture/decal language rather than color-only primitive materials;
- deeper location-specific composition.

Therefore existing Three.js parity work is useful as renderer/lifecycle/performance research, but it is not itself V1 implementation.

## Architecture decision — FINAL (`GODOT_NATIVE_V1`)

### Production path: Godot-native V1
Use the existing canonical runtime and replace/refine scene presentation in place.

Reasons:
1. the actual game already renders and interacts in Godot;
2. every player-facing destination already has a 3D/hotspot contract;
3. using Three.js for production would require a second renderer/state/input/accessibility bridge;
4. current Three.js packages are not part of the shipping build;
5. V1 fidelity requires a new art/material pipeline in either engine, so prior Three.js primitive work does not remove the main art-production cost;
6. one renderer minimizes duplicate scene maintenance.

### Three.js role after R02
R01 did not demonstrate a compensating advantage. Freeze Three.js as a reference/prototyping lane for V1; do not create a production state/input bridge and do not expand it to later V1 scenes. PR #193 is evidence only and is closed unmerged. Long-term deletion/archive disposition remains a final hygiene decision.

### Native implementation-source fence

After R02, new V1 production scenes are **not ports of the old Three.js/primitive composition into GDScript**. The accepted ARTIST target is decomposed first and authored natively in Godot. Existing runtime semantics, hotspots, accessibility and shared Godot utilities are reused; rejected visual scaffolds are not preserved merely because they already exist.

When a visual review identifies structural mismatch (composition, massing, focal hierarchy, density or surface language), the next pass must structurally replace/recompose that area. Two consecutive structural REVISE findings trigger `STRUCTURAL_REBASE_REQUIRED` before another additive revision. See [architecture-execution-guardrail.md](./architecture-execution-guardrail.md).

The active strict roadmap also forbids successor preflight/spec work while a predecessor remains non-PASS. Waiting time is spent only on the current item.

## Phase 0 — Lock the visual baseline

1. Merge/reconcile PR #190 or otherwise preserve the exact 11 candidate-file SHAs and board SHA.
2. **Hard style lock:** the original approved board + `docs/art-direction/v1/README.md` + `docs/art-direction/ARTIST-V1-STYLE.md` override any conflicting detail in an individually generated image, renderer prototype or old low-poly scene.
3. **User decision resolved:** faithfully reproduce intentional guide-compliant details; accidental elements that contradict the guide (real postcard landmarks, photoreal/PBR look, fake UI lettering, unsupported symbols) must be revised in ARTIST first, not copied nor silently redesigned by the implementer.
4. Audit all 11 generated candidate images against the canonical board/style guide, but revise/regenerate and obtain explicit concept `ACCEPT` **just-in-time for the current SIGA roadmap scene only**. Operation is first. Later scenes remain locked; do not bulk-implement or use their generated candidates as accepted runtime baselines.
5. Update ARTIST ledger to distinguish `BOARD_APPROVED`, `SCENE_CANDIDATE`, `SCENE_CONCEPT_ACCEPTED` and `RUNTIME_ACCEPTED`; generation, merge and SHA verification are not substitutes for human scene approval.
6. Keep `style-conformance.md` as the operational style invariant/checklist used by CENA, renderer owner and LENTE.

## Phase 1 — Renderer decision spike

### 1A. Evidence inventory
For Operation, gather:
- original approved V1 board, written style guide, and individually accepted (not merely generated) Operation reference;
- current Godot exact-head scene capture;
- current Three.js Operation/Grow Room capture;
- current renderer metrics;
- integration/build ownership diagram.

### 1B. Minimal V1 treatment spike
Implement only enough in a disposable/bounded branch to answer the renderer question:
- nearest-neighbor pixel-art texture/decal support;
- one graffiti surface;
- one revised architectural mass;
- one representative primary prop;
- scene-only pixel treatment or low-resolution render strategy;
- same camera framing target.

Do not rebuild the full scene twice.

### 1C. Decision matrix
Score evidence descriptively, not aesthetically, across:
- V1 parity achievable;
- canonical-state integration;
- input/hotspot integration;
- accessibility fallback;
- build/deploy complexity;
- asset pipeline;
- Web/mobile performance;
- memory/resource lifecycle;
- test/visual-capture support;
- implementation duplication;
- long-term maintenance.

Output: `renderer-decision.md` with one of:
- `GODOT_NATIVE_V1`
- `THREEJS_PRODUCTION_V1`
- `BLOCKED_NEEDS_PRODUCT_DECISION`

**R02 result: `GODOT_NATIVE_V1`.** R01 evidence satisfied this decision gate; `renderer-decision.md` is the architecture lock.

## Phase 2 — Shared V1 render system

Assuming Godot is selected:

### Scene render layer
Keep UI at full resolution. Pixelate only the 3D presentation layer.

Candidate implementation:
- existing scene `SubViewport` remains the 3D boundary;
- render scene at a controlled internal resolution and upscale with nearest filtering, or apply a Compatibility-safe scene-only palette/pixel shader;
- validate which approach reproduces V1 without harming interaction picking or mobile cost.

### Materials
Introduce a reusable V1 material family:
- dark/navy structural base;
- worn concrete/brick/plaster;
- painted/corrugated metal;
- timber/crate surfaces;
- emissive amber practicals;
- cyan/magenta accent emissives;
- vegetation;
- graffiti/stencil decal material.

Use authored low-resolution atlases/decals where required. No requirement to preserve the old zero-texture constraint.

### Asset structure
Recommended paths:
- `assets/visual/v1/<scene>/...`
- `resources/visual/v1/materials/...`
- `resources/visual/v1/textures/...`
- `scenes/visual/v1/<scene>_diorama.tscn` only if side-by-side migration is safer than in-place replacement.

Every source/runtime asset gets provenance metadata.

### Camera and composition
Encode per-scene normalized composition anchors so portrait acceptance can be checked deterministically:
- scene bounds;
- camera position/rotation/orthographic size;
- three interaction-anchor screen zones;
- lower safe-area target.

## Phase 3 — Operation vertical slice

Operation is the architecture proof.

### Decompose V1
Only after ARTIST confirms the Operation candidate conforms to the original board and guide, create a scene build sheet containing:
- shell/open-roof mass;
- floor/stairs/foreground apron;
- shutter/wall graffiti focal surface;
- workbench cluster;
- abstract plant cluster;
- inventory shelving cluster;
- pipes/utility silhouettes;
- warm/cool lighting;
- background/negative-space treatment;
- exact hotspot mapping.

### Implement
Replace the current generic production-candidate look with V1 geometry/material/lighting while preserving:
- Operation surface behavior;
- Feature 011 hotspot semantics;
- accessibility fallback;
- existing domain/state APIs.

### Accept
Require:
- exact-head 540x960 + 1080x1920;
- **global board + accepted Operation concept + AFTER** side-by-side;
- clean console/page errors;
- interaction tests;
- ARTIST/CENA `ACCEPT`;
- LENTE CAVEMAN with remaining parity debt explicitly listed.

Only after Operation is accepted can the architecture be cloned to the remaining scenes.

## Phase 4 — Remaining scenes, strictly one by one

After Operation is accepted, SIGA advances exactly one scene at a time in this immutable order:

1. Market
2. City
3. Institutional
4. Archive
5. Campaign
6. Narrative
7. Finale Selection
8. Finale Handoff
9. Finale Coda
10. Finale Recap

There are **no implementation waves or parallel scene batches** for Feature 012. For each scene, the complete gate is:

`candidate audit → ARTIST revision if needed → human concept ACCEPT → runtime implementation → structural/gameplay/hotspot regression → exact-head LENTE at 540×960 + 1080×1920 → ARTIST/CENA runtime ACCEPT → persist PASS`.

Only that persisted `PASS` unlocks the next scene. If CI/capture/review for the current scene is running, SIGA may advance tests, evidence, diagnostics or documentation for that same scene, but MUST NOT start the next scene.


## R05 — DA LATA UI V1 pilot

Market is now the shared-interface pilot in addition to the active visual-parity scene. The detailed implementation contract is [R05-DA-LATA-UI-V1-PLAN.md](./R05-DA-LATA-UI-V1-PLAN.md).

Execution order inside R05 is fixed:

`tokens/theme → reusable button roles → canonical states → shared portrait shell → Market migration → accessibility/input regressions → exact-head portrait evidence → human ACCEPT`.

The pilot must reuse the accepted Market 2.5D substrate, preserve Market domain/hotspot semantics, and keep R06+ locked. The resulting UI V1 becomes reusable authority for later scenes only after R05 is PASS.

## Phase 5 — Production cleanup

After all 11 scenes are accepted:
- remove/mark obsolete blockout resources only when no runtime reference remains;
- consolidate material/atlas reuse;
- verify no accidental flat reference-image overlay entered production;
- verify provenance;
- update VISUAL-DIRECTION, CENA/ARTIST/LENTE handoffs and architecture docs;
- decide separately whether historical Three.js packages remain, move under a lab/archive path, or are deleted.

## Validation strategy

### Structural
- `tools/validate_project.py`
- ARTIST validators
- 3D completeness audit
- semantic hotspot regression
- per-scene scene-load tests
- no canonical-state mutation from presentation interactions

### Visual
For each exact head (style conformity is a hard gate, not a suggestion):
- original approved board and immutable version/provenance hash;
- per-scene ARTIST concept ACCEPT record with explicit board-conformance review;
- 540x960 full-page capture;
- 1080x1920 full-page capture;
- isolated scene capture;
- optional deterministic diagnostic orbit;
- reference/AFTER compare;
- model-assisted LENTE review;
- human ARTIST/CENA gate.

### Performance
Do not inherit old Three.js budgets blindly.

Operation spike establishes measured Godot V1 budgets for:
- rendered geometry count/triangles;
- material count;
- texture memory;
- internal scene resolution;
- dynamic lights;
- Web frame-time / stability;
- exported payload delta.

Those measured budgets become the ceiling for later waves unless a scene-specific exception is justified.

## Migration and rollback

- Keep V1 scene work bounded behind scene-level commits/branches.
- Prefer side-by-side V1 scene resources until the new scene is visually accepted.
- Preserve the existing accepted scene as a rollback target until its V1 replacement passes exact-head gates.
- No save migration is expected.
- Runtime rollback must not affect gameplay state.

## Key architectural invariant

```
ARTIST V1 reference
        |
        v
CENA decomposition + assets
        |
        v
ONE production 3D renderer
        |
        v
existing gameplay/UI/hotspots
        |
        v
LENTE exact-head comparison
        |
        v
ARTIST/CENA acceptance
```

Three.js is an implementation option only if the evidence proves it improves this pipeline. It is not a product requirement by itself.
