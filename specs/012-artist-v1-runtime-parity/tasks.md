# Feature 012 — Tasks: ARTIST V1 runtime parity

## SIGA strict sequential execution lock

Feature 012 is governed by [SIGA-ROADMAP.md](./SIGA-ROADMAP.md) with execution mode `STRICT_SEQUENTIAL`.

- Exactly one roadmap item may be active.
- Tasks below are a dependency ledger, **not** permission to execute later phases/scenes in parallel.
- `Siga` MUST execute the earliest non-`PASS` roadmap item only.
- A `WATCH`/running-CI state does not unlock the next roadmap item.
- Later scene work starts only after the preceding roadmap item has persisted `PASS`.
- Per-scene ARTIST concept acceptance is obtained just-in-time when that scene becomes current; do not bulk-implement or bulk-accept later scenes.

**Current roadmap item:** `R04 — Operation V1 production scene`.


## Phase 0 — Baseline and decision package

- [x] [T001] Reconcile current Godot runtime, Three.js reference packages, Feature 010/011, CENA-017 and PR #190.
- [x] [T002] Define operational meaning of V1 "1:1" without permitting flat-image substitution.
- [x] [T003] Record initial architecture recommendation: Godot-native production, Three.js gated by evidence.
- [x] [T004] Record user decision: strict approved style guide; retain intentional compliant details, but resolve conflicting incidental generated content through ARTIST revision and review (not unilateral copying or redesign).
- [x] [T005] Merge/reconcile PR #190 and lock the 11 reference SHAs on the implementation base.
- [x] [T006] Update ARTIST approval/status ledger to distinguish global board approval, generated per-scene candidate, per-scene concept acceptance and runtime acceptance.
- [x] [T007] Run 11-scene board↔candidate visual-conformance audit; record concrete differences (camera/crop, chunky pixel density, graffiti, palette, geometry, approved crown identity and fictional urban setting). See `board-candidate-audit.md`.
- [x] [T008] For the current roadmap scene only, revise/regenerate a divergent candidate in its own ARTIST round with the original board as image reference; get human scene concept ACCEPT before locking its implementation SHA. Operation is accepted; see `operation-concept-acceptance.md`.
- [x] [T009] Attach the current scene's style-conformance report and accepted concept SHA to the ARTIST ledger before implementation. Operation ledger is synchronized in `docs/art-direction/v1/SCENE-STATUS.json` and the run manifest.

## Phase 1 — Renderer decision

- [x] [T010] Capture current exact-head Operation in Godot at 540x960 and 1080x1920; pair it with the approved global board and the individually accepted Operation concept. See `R01-RENDERER-EVIDENCE.md`.
- [x] [T011] Capture the current Three.js Operation/Grow Room reference at the same portrait targets. See `R01-RENDERER-EVIDENCE.md`.
- [x] [T012] Produce a renderer integration diagram covering state, input, accessibility, build and deployment ownership. See `renderer-integration.md` (evidence pending T010/T011/T013/T014).
- [x] [T013] Build the smallest V1 material/pixel-treatment spike needed to test both candidate paths without rebuilding the scene twice. See PR #193 + `R01-RENDERER-EVIDENCE.md`.
- [x] [T014] Record measured visual/performance/build evidence. See `R01-RENDERER-EVIDENCE.md`.
- [x] [T015] Persist `renderer-decision.md` as `GODOT_NATIVE_V1`, `THREEJS_PRODUCTION_V1` or `BLOCKED_NEEDS_PRODUCT_DECISION`. **Locked: `GODOT_NATIVE_V1` in R02.**
- [x] [T016] Reconcile plan/tasks with the selected renderer. No renderer reversal was required; the preliminary Godot-native path is now the final R02 architecture lock.

## Phase 2 — Shared V1 visual system

- [x] [T020] Define scene-only pixel rendering strategy while keeping UI full resolution. Implemented by `scenes/visual/v1/v1_pixel_render_policy.gd`; contract and rationale in `v1-visual-system.md`.
- [x] [T021] Create reusable V1 material/texture/decal vocabulary. Implemented by `resources/visual/v1/material-vocabulary.json` + `v1_material_vocabulary.gd`.
- [x] [T022] Add asset provenance manifest for V1 runtime assets. Implemented by `resources/visual/v1/provenance.json` with project-owned/shared runtime entries and locked ARTIST references.
- [x] [T023] Define reusable graffiti/stencil surface pipeline. Implemented by `graffiti-pipeline.json` + nearest-sampled `v1_graffiti_stencil.gdshader`.
- [x] [T024] Define per-scene composition-anchor metadata and hotspot screen zones. Implemented by `resources/visual/v1/composition-anchors.json`, covering exactly the 11 canonical scenes without granting scene acceptance.
- [x] [T025] Add structural/visual validator coverage for V1 resources. Implemented by `tools/validate_v1_visual_system.py`, exercised through `tests/test_artist.py` and therefore existing canonical CI.
- [x] [T026] Establish measured Web/mobile performance budget from Operation spike. Persisted in `v1-performance-budget.md`; only measured R01 facts are used and missing Godot frame instrumentation is explicitly deferred to R04.

## Phase 3 — Operation vertical slice

- [x] [T030] Produce Operation decomposition/build sheet from the V1 reference. See `operation-build-sheet.md`.
- [x] [T031] Implement V1 architectural shell and camera. Existing real 3D shell/camera now binds to the shared R03 pixel/material system; covered by `tests/operation_v1_diorama_test.gd`.
- [x] [T032] Implement V1 workbench cluster. Existing 3D counter/worktop cluster is restyled through the shared V1 vocabulary.
- [x] [T033] Implement V1 abstract plant cluster. Existing fictional 3D plant silhouettes now use the V1 foliage/painted-metal roles.
- [x] [T034] Implement V1 inventory-shelf cluster. Existing shelf/bin/crate geometry now uses the V1 repaired-wood/metal/accent roles.
- [x] [T035] Implement graffiti/pixel material treatment and lighting. Shared scene-only pixel policy, V1 material roles, cyan/amber lighting and the evidence-backed physical crown geometry are wired.
- [x] [T036] Map all three V1 interaction anchors to existing semantic hotspot/fallback behavior. Workbench reuses the existing management semantic action/fallback; plant and storage keep their canonical contracts.
- [ ] [T037] Run exact-head repository and interaction regression gates.
- [ ] [T038] Run LENTE before/after capture at both portrait targets.
- [ ] [T039] Record ARTIST/CENA Operation `ACCEPT` or `REVISE`.
- [ ] [T040] Do not unlock the remaining scene batch until Operation is accepted.

## Phase 4 — Remaining scenes — strict order, no waves

These tasks execute strictly T050 → T059. A later scene remains locked until the previous scene has ARTIST/CENA runtime `ACCEPT` and its SIGA roadmap item is `PASS`.

- [ ] [T050] Market V1 implementation + visual/hotspot acceptance.
- [ ] [T051] City V1 implementation + visual/hotspot acceptance.
- [ ] [T052] Institutional V1 implementation + visual/hotspot acceptance.
- [ ] [T053] Archive V1 implementation + visual/hotspot acceptance.
- [ ] [T054] Campaign V1 implementation + visual acceptance.
- [ ] [T055] Narrative V1 implementation + visual acceptance.
- [ ] [T056] Finale Selection V1 implementation + visual/choice acceptance.
- [ ] [T057] Finale Handoff V1 implementation + visual/transition acceptance.
- [ ] [T058] Finale Coda V1 implementation + visual acceptance.
- [ ] [T059] Finale Recap V1 implementation + visual acceptance.

## Phase 5 — Final certification

- [ ] [T070] Verify all 11 runtime targets are `IMPLEMENTATION_ACCEPTED`.
- [ ] [T071] Verify all exact-head 540x960/1080x1920 captures exist and are linked.
- [ ] [T072] Verify semantic hotspots/accessibility remain green.
- [ ] [T073] Verify Web/mobile performance and payload budgets.
- [ ] [T074] Verify asset provenance/licenses.
- [ ] [T075] Remove only proven-obsolete V1-predecessor blockout assets.
- [ ] [T076] Decide historical Three.js package disposition in a separate bounded cleanup decision.
- [ ] [T077] Persist final ARTIST/CENA/LENTE/SIGA handoffs and exact certified master SHA.
