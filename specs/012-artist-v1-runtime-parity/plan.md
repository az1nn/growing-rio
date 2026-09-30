# Feature 012 — Implementation Plan: ARTIST V1 runtime parity

**Spec:** [spec.md](./spec.md)  
**Planning state:** architecture decision + Operation vertical slice first  
**Implementation authority:** SIGA for delivery, ARTIST/CENA for visual acceptance, LENTE for exact-head evidence

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

## Architecture recommendation

### Preferred path: Godot-native V1
Use the existing canonical runtime and replace/refine scene presentation in place.

Reasons:
1. the actual game already renders and interacts in Godot;
2. every player-facing destination already has a 3D/hotspot contract;
3. using Three.js for production would require a second renderer/state/input/accessibility bridge;
4. current Three.js packages are not part of the shipping build;
5. V1 fidelity requires a new art/material pipeline in either engine, so prior Three.js primitive work does not remove the main art-production cost;
6. one renderer minimizes duplicate scene maintenance.

### Three.js role after this spec
Freeze as a reference/prototyping lane unless the renderer spike proves a concrete product advantage. Do not expand it to the remaining V1 scenes by default.

## Phase 0 — Lock the visual baseline

1. Merge/reconcile PR #190 or otherwise preserve the exact V1 asset SHAs.
2. Treat all 11 files as immutable implementation references for this feature.
3. Resolve the single product question: whether incidental generated landmarks/text/symbols are literal requirements or must be fictionalized while retaining their visual role.
4. Update the ARTIST scene ledger to distinguish `REFERENCE_LOCKED` from runtime acceptance.

## Phase 1 — Renderer decision spike

### 1A. Evidence inventory
For Operation, gather:
- V1 reference;
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

Default from current evidence: `GODOT_NATIVE_V1`.

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
Create a scene build sheet containing:
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
- reference/AFTER side-by-side;
- clean console/page errors;
- interaction tests;
- ARTIST/CENA `ACCEPT`;
- LENTE CAVEMAN with remaining parity debt explicitly listed.

Only after Operation is accepted can the architecture be cloned to the remaining scenes.

## Phase 4 — Scene waves

Implement in V1 reference order:

1. Operation
2. Market
3. City
4. Institutional
5. Archive
6. Campaign
7. Narrative
8. Finale Selection
9. Finale Handoff
10. Finale Coda
11. Finale Recap

Recommended batching after Operation:
- **Wave A:** Market + City
- **Wave B:** Institutional + Archive
- **Wave C:** Campaign + Narrative
- **Wave D:** four Finale variants

Each scene remains independently reviewable and independently accepted.

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
For each exact head:
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
