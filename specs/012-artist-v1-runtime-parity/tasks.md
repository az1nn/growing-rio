# Feature 012 — Tasks: ARTIST V1 runtime parity

## SIGA strict sequential execution lock

Feature 012 is governed by [SIGA-ROADMAP.md](./SIGA-ROADMAP.md) with execution mode `STRICT_SEQUENTIAL`.

- Exactly one roadmap item may be active.
- Tasks below are a dependency ledger, **not** permission to execute later phases/scenes in parallel.
- `Siga` MUST execute the earliest non-`PASS` roadmap item only.
- A `WATCH`/running-CI state does not unlock the next roadmap item.
- Later scene work starts only after the preceding roadmap item has persisted `PASS`.
- Per-scene ARTIST concept acceptance is obtained just-in-time when that scene becomes current; do not bulk-implement or bulk-accept later scenes.

**Current roadmap item:** `R06 — City V1 production scene`.


## Phase 0 — Baseline and decision package

- [x] [T001] Reconcile current Godot runtime, Three.js reference packages, Feature 010/011, CENA-017 and PR #190.
- [x] [T002] Define operational meaning of V1 "1:1" without permitting flat-image substitution.
- [x] [T003] Record initial architecture recommendation: Godot-native production, Three.js gated by evidence.
- [x] [T004] Record user decision: strict approved style guide; retain intentional compliant details, but resolve conflicting incidental generated content through ARTIST revision and review (not unilateral copying or redesign).
- [x] [T005] Merge/reconcile PR #190 and lock the 11 reference SHAs on the implementation base.
- [x] [T006] Update ARTIST approval/status ledger to distinguish global board approval, generated per-scene candidate, per-scene concept acceptance and runtime acceptance.
- [x] [T007] Run 11-scene board↔candidate visual-conformance audit; record concrete differences (camera/crop, chunky pixel density, graffiti, palette, geometry, approved crown identity and fictional urban setting). See `board-candidate-audit.md`.
- [ ] [T008] For the current roadmap scene only, revise/regenerate a divergent candidate in its own ARTIST round with the original board as image reference; get human scene concept ACCEPT before locking its implementation SHA. Operation is first; later scenes remain locked until their roadmap turn.
- [ ] [T009] Attach the current scene's style-conformance report and accepted concept SHA to the ARTIST ledger before implementation. Repeat just-in-time for each later scene when its roadmap item becomes current.

## Phase 1 — Renderer decision

- [x] [T010] Capture current exact-head Operation in Godot at 540x960 and 1080x1920; pair it with the approved global board and the individually accepted Operation concept. See `R01-RENDERER-EVIDENCE.md`.
- [x] [T011] Capture the current Three.js Operation/Grow Room reference at the same portrait targets. See `R01-RENDERER-EVIDENCE.md`.
- [x] [T012] Produce a renderer integration diagram covering state, input, accessibility, build and deployment ownership. See `renderer-integration.md` (evidence pending T010/T011/T013/T014).
- [x] [T013] Build the smallest V1 material/pixel-treatment spike needed to test both candidate paths without rebuilding the scene twice. See PR #193 + `R01-RENDERER-EVIDENCE.md`.
- [x] [T014] Record measured visual/performance/build evidence. See `R01-RENDERER-EVIDENCE.md`.
- [x] [T015] Persist `renderer-decision.md` as `GODOT_NATIVE_V1`, `THREEJS_PRODUCTION_V1` or `BLOCKED_NEEDS_PRODUCT_DECISION`. **Locked: `GODOT_NATIVE_V1` in R02.**
- [x] [T016] Reconcile plan/tasks with the selected renderer. No renderer reversal was required; the preliminary Godot-native path is now the final R02 architecture lock.

### R02 hardening — architecture execution and roadmap fences

- [x] [T017] Persist that `GODOT_NATIVE_V1` is an implementation-source lock: ARTIST target → CENA decomposition → native Godot production; Three.js and superseded blockouts remain evidence, not default visual scaffolds.
- [x] [T018] Enforce the Feature 012 current-item write fence in canonical docs + CI; spec-only/preflight successor work is forbidden while its predecessor is not `PASS`. PR #202 was closed unmerged as invalid R05 preparation while R04 remained current.
- [x] [T019] Consumed Rev13 exact-head evidence: structural `REVISE` persisted as `STRUCTURAL_REBASE_REQUIRED`; the next R04 mutation rebuilds the rejected Operation visual layer from the accepted concept on current `master` guardrails. No additive Rev14 is permitted.

## Phase 2 — Shared V1 visual system

- [x] [T020] Define scene-only pixel rendering strategy while keeping UI full resolution. Implemented by `scenes/visual/v1/v1_pixel_render_policy.gd`; contract and rationale in `v1-visual-system.md`.
- [x] [T021] Create reusable V1 material/texture/decal vocabulary. Implemented by `resources/visual/v1/material-vocabulary.json` + `v1_material_vocabulary.gd`.
- [x] [T022] Add asset provenance manifest for V1 runtime assets. Implemented by `resources/visual/v1/provenance.json` with project-owned/shared runtime entries and locked ARTIST references.
- [x] [T023] Define reusable graffiti/stencil surface pipeline. Implemented by `graffiti-pipeline.json` + nearest-sampled `v1_graffiti_stencil.gdshader`.
- [x] [T024] Define per-scene composition-anchor metadata and hotspot screen zones. Implemented by `resources/visual/v1/composition-anchors.json`, covering exactly the 11 canonical scenes without granting scene acceptance.
- [x] [T025] Add structural/visual validator coverage for V1 resources. Implemented by `tools/validate_v1_visual_system.py`, exercised through `tests/test_artist.py` and therefore existing canonical CI.
- [x] [T026] Establish measured Web/mobile performance budget from Operation spike. Persisted in `v1-performance-budget.md`; only measured R01 facts are used and missing Godot frame instrumentation is explicitly deferred to R04.

## Phase 3 — Operation vertical slice

- [x] [T030] Produce Operation decomposition/build sheet from the V1 reference.
- [x] [T031] Implement V1 architectural shell and camera.
- [x] [T032] Implement V1 workbench cluster.
- [x] [T033] Implement V1 abstract plant cluster.
- [x] [T034] Implement V1 inventory-shelf cluster.
- [x] [T035] Implement graffiti/pixel material treatment and lighting.
- [x] [T036] Map all three V1 interaction anchors to existing semantic hotspot/fallback behavior.
- [x] [T037] Run exact-head repository and interaction regression gates.
- [x] [T038] Run LENTE before/after capture at both portrait targets.
- [x] [T039] Record ARTIST/CENA Operation `ACCEPT` or `REVISE`. Candidate 9: `IMPLEMENTATION_ACCEPTED` on `28c3e3c75042a183e1ac091dc1595b2be009397f`.
- [x] [T040] Operation accepted; persist R04 `PASS` and unlock only R05.

### R04 structural-rebase continuation

- [x] [R04-SR01] Replace the rejected Rev13 visible scaffold with one Godot-native `OperationV1AcceptedRebuild` derived from the accepted Operation concept.
- [x] [R04-SR02] Review exact-head candidate 1 (`109d29f187f248c97bff58df9bf8f3201c0a38fa`) and persist ARTIST/CENA `REVISE`: right supply wall missing from frame, crown clipped, legacy plant-hotspot drift found.
- [x] [R04-SR03] Execute candidate-2 correction: recenter crown, bring supply wall into portrait framing, fence legacy hotspot overwrite and pin the three accepted-rebuild hotspot coordinates in tests.
- [x] [R04-SR04] Candidate 2 exact-head Validate + Visual Acceptance inspected at both portrait targets; persisted `REVISE` for framing/footprint mismatch.
- [x] [R04-SR05] Execute candidate-3 framing correction: wider ortho composition, shorter accepted floor/threshold footprint, no new dressing generation.
- [x] [R04-SR06] Run candidate-3 exact-head Validate + Visual Acceptance + LENTE and inspect both portrait targets.
- [x] [R04-SR07] Persist candidate-3 ARTIST/CENA bounded `REVISE`: lower empty-volume band, HUD-safe-area collision, weak graffiti/shutter focal read and weak warm practical hierarchy; R05 remains locked.
- [x] [R04-SR08] Execute candidate-4 bounded correction inside the existing `OperationV1AcceptedRebuild`: preserve camera size/floor/hotspots, shift vertical framing below HUD safe area, strengthen the central shutter/graffiti field and warm practical contrast.
- [x] [R04-SR09] Run candidate-4 exact-head Validate + Visual Acceptance + LENTE and inspect both portrait targets.
- [x] [R04-SR10] Persist candidate-4 ARTIST/CENA bounded `REVISE`. Candidate 5 and Candidate 6 were subsequently executed under the same R04 lock; only a later `ACCEPT` may complete T039/T040 and unlock R05.

## Phase 4 — Remaining scenes — strict order, no waves

These tasks execute strictly T050 → T059. A later scene remains locked until the previous scene has ARTIST/CENA runtime `ACCEPT` and its SIGA roadmap item is `PASS`.

- [x] [T050] Market V1 implementation + visual/hotspot acceptance.
  - [x] [T050-A] Consume human `REVISE` on low-poly/Three.js-like visual grammar and rebase Market player-facing render to the accepted ARTIST 2.5D concept substrate in Godot.
  - [x] [T050-B] Verify Candidate 10 exact-head 2.5D rebase: Validate + Visual Acceptance + Vercel green; semantic 3D/hotspot layer preserved.
  - [x] [T050-C] Human direction: Candidate 10 is close enough to establish the shared UI language; keep R05 open and move convergence to navigation/actions.
  - [x] [T050-D] Specify **DA LATA UI V1** tokens: grid/spacing, typography, semantic palette, borders/shapes, focus treatment and motion. Plan persisted in `R05-DA-LATA-UI-V1-PLAN.md`.
  - [x] [T050-E] Implement reusable Godot controls for Primary, Secondary, Utility, Danger/Risk and Navigation/Tab roles.
  - [x] [T050-F] Implement canonical states: default, hover/focus, pressed, disabled, active/selected and progression-locked.
  - [x] [T050-G] Implement shared screen shell: top status/title region, scene action region and persistent bottom command/navigation band. Delivered by `scenes/ui/v1/dalata_screen_shell.*` with structural coverage in `tests/dalata_ui_v1_test.gd`.
  - [x] [T050-H] Apply the shared UI system to Market without changing gameplay, economy, persistence or hotspot semantics.
  - [x] [T050-I] Add UI structural/state/accessibility regression: keyboard focus, pointer/touch targets, state legibility without color-only signaling and portrait safe areas.
  - [x] [T050-J] Exact-head Market `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e` passed 540×960 + 1080×1920 review and received explicit human ARTIST/CENA runtime `ACCEPT`.
  - [x] [T050-K] R05 persisted `PASS`; PR #205 merged to `master` as `f73190b89bafca1e05310f4f816c2cdc788bd03d`. DA LATA UI V1 is the reusable R06+ baseline.
- [ ] [T051] City V1 implementation + visual/hotspot acceptance.
  - [x] [T051-A] Reconcile R06 authority: global ARTIST V1 board/style remains locked; City delta is `docs/art-direction/v1/SCENES.json#city`; City status is `BOARD_APPROVED_ONLY`; Godot-native renderer and accepted DA LATA UI V1 baseline remain mandatory.
  - [x] [T051-B] Generate/revise one isolated 9:16 City concept from the locked base prompt + City delta and obtain explicit human concept `ACCEPT`. Accepted run: `20261004T110406Z/city`.
  - [x] [T051-C] Persist the accepted City concept artifact/provenance in the ARTIST ledger before runtime implementation. Manifest: `docs/art-direction/v1/runs/20261004T110406Z-city/MANIFEST.md`; SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`.
  - [x] [T051-D] Produce CENA decomposition/build sheet mapping district rooftops, route nodes and local-event hotspot to real 3D anchors and the portrait UI-safe composition. See `R06-CITY-V1-CENA.md`.
  - [x] [T051-E] Candidate 1 implemented City V1 in native Godot from the accepted concept, reusing DA LATA UI V1 without a scene-local UI fork.
  - [x] [T051-F] Candidate 1 added/refreshed City scene-load, semantic-hotspot, pointer/touch, keyboard/focus, accessibility and portrait-safe-area regressions.
  - [x] [T051-G] Candidate 1 exact-head `02ea25ea35544dafa870b378e4f1f3d10eb6a706` passed Validate + 540×960/1080×1920 Visual Acceptance + bounded LENTE; Vercel preview was Ready.
  - [ ] [T051-H] Obtain human ARTIST/CENA runtime `ACCEPT` against board → accepted City concept → exact-head runtime.
  - [ ] [T051-I] Persist R06 `PASS`; unlock only R07.
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


## Candidate 6 execution evidence — 2026-10-01

- [x] Consume Candidate-5 exact-head ARTIST/CENA `IMPLEMENTATION_REVISE (bounded)`.
- [x] Recompose existing shutter/crown/graffiti cluster for runtime prominence without a new dressing generation.
- [x] Add local garden foliage separation while preserving shared foliage hue.
- [x] Restore cool-night × local-amber lighting hierarchy.
- [x] Add Candidate-6 structural regression assertions.
- [x] Consume fresh exact-head Validate + Visual Acceptance + LENTE on `aa8344ec85f6b68d3f9e3f3c0d228ebabf6632d2`.
- [x] Persist ARTIST/CENA Candidate-6 `IMPLEMENTATION_REVISE (bounded)`: focal crown/graffiti salience and cool-night hierarchy remain below accepted target.
- [ ] Mark R04 PASS only after all exit gates are satisfied.

## Candidate 7 execution evidence — 2026-10-01

- [x] Increase only existing shutter/crown/graffiti readable area inside `OperationV1AcceptedRebuild`; no new dressing generation.
- [x] Strengthen existing cool key and reduce global warm practical while preserving authored local amber pools.
- [x] Extend structural regression coverage with minimum graffiti/crown portrait-readable area bounds.
- [x] Bound Visual Acceptance R04 capture to Operation instead of the full multi-scene suite.
- [x] Consume fresh Candidate-7 exact-head Validate `36917496662` + bounded Visual Acceptance `36917496673` + bounded LENTE `36917496574` on `9774186437bec6f206993d70e82021aa1f0bf9d3`.
- [x] Persist ARTIST/CENA Candidate-7 `IMPLEMENTATION_REVISE (bounded)`: exact-head renders prove the focal geometry is structurally present but still occluded by the garden/supply silhouettes; accepted target keeps the crown readable in the dark wall pocket between those clusters.
- [ ] Mark T039/T040 and R04 PASS only after `IMPLEMENTATION_ACCEPTED`.


## Candidate 8 execution evidence — 2026-10-01

- [x] Consume Candidate-7 exact-head evidence at 540×960 and 1080×1920 plus the accepted Operation target.
- [x] Classify the remaining defect as focal **occlusion**, not insufficient raw mesh area.
- [x] Recompose the existing shutter/crown/graffiti cluster into the exposed back-wall corridor between the accepted garden and supply silhouettes; no new dressing generation.
- [x] Replace raw-area-only regression bounds with explicit no-occlusion corridor bounds.
- [x] Preserve camera `4.70`, camera Y `6.95`, compact floor, all three semantic hotspots, gameplay/persistence and Godot-native renderer lock.
- [x] Consume fresh Candidate-8 exact-head Validate `36920612419` + bounded Visual Acceptance `36920612409` + bounded LENTE `36920612561` on `63d4f798a31d1a777ce975633b679372802670da`.
- [x] Persist ARTIST/CENA Candidate-8 `IMPLEMENTATION_REVISE (bounded)`: the cluster is exposed but reads as a pale non-crown mass because the crown halo clips its authored amber/cyan/magenta contrast and the right pendant still crosses its silhouette.
- [ ] Mark T039/T040 and R04 PASS only after `IMPLEMENTATION_ACCEPTED`.

## Candidate 9 execution evidence — 2026-10-01

- [x] Preserve the existing Candidate-8 focal geometry and stabilize its authored amber/cyan/magenta swatches against light washout; no new dressing generation.
- [x] Reduce only the existing crown halo into a bounded wall-pocket light.
- [x] Move the two existing pendant cord/shade pairs outside the focal corridor.
- [x] Add regression bounds for focal material stability, pendant sightlines and crown halo energy.
- [x] Consume fresh Candidate-9 exact-head Validate `36924774052` + bounded Visual Acceptance `36924773928` + bounded LENTE `36924773924` on `28c3e3c75042a183e1ac091dc1595b2be009397f`.
- [x] Persist ARTIST/CENA Candidate-9 `IMPLEMENTATION_ACCEPTED`: crown readable on the dark petrol field, cyan/magenta separation retained and pendants outside the focal sightline.
- [x] Mark T039/T040 and R04 `PASS`; unlock only R05.


## R06 Candidate 1 target-relative review — 2026-10-04

- [x] Inspect exact-head LENTE run `37199963233` against the accepted City concept `20261004T110406Z/city`.
- [x] Persist ARTIST/CENA `REVISE / STRUCTURAL_REBASE_REQUIRED`: Candidate 1 is technically green but still reads as an isolated toy/blockout; it materially misses the accepted target's dense painted masonry, facade texture/graffiti rhythm, neighborhood activity, depth hierarchy and lived-in stair-spine framing.
- [x] Execute Candidate 2 structural rebase without touching gameplay/state semantics: densify authored 3D facade dressing, street life, vegetation, practicals and distant depth; reduce neon/toy material bias; enable modeled shadows; enlarge the portrait scene field while preserving DA LATA UI V1 and all three semantic anchors.
- [ ] Re-run exact-head Validate + Visual Acceptance + bounded LENTE on Candidate 2 and inspect target-relative output.
- [ ] Only explicit human ARTIST/CENA runtime `ACCEPT` may complete T051-H/I and unlock R07.
