> **2026-10-09 — R06 ARCHITECTURE HUMAN GATE:** Human-approved [ARTIST Review v0.2](./R06-CITY-V1-ARTIST-REVIEW-V02.md) (G1–G25; R1 D, R2 D, R3 D, R4 D, R5 B) conflicts with earlier human-approved Godot SVG-25D exception. R05 PASS / R06 sole CURRENT with architecture B selected but implementation `WATCH / IMPLEMENTATION_PLAN_APPROVAL_PENDING` / R07+ LOCKED. Existing unchecked R06-25D tasks do not authorize visual implementation, sprite scaling, renderer activation or acceptance. Preserve human `REJECT ALL`.

> **R06 ARTIST HARD GATE — 2026-10-08:** Human `REJECT ALL` on exact head `1f799128d9efe33cfdcb8365119fc2eb2371166e` supersedes the former Rebase A/B/C visual plan and the unchecked RC01–RC04 corrective tasks below. Preserve the accepted City concept; do not resume incremental card/sprite/facade polishing. The **only** actionable City art queue now is `R06-REJECT-01…05` in the addendum at end of this ledger. Full decision: [R06-CITY-V1-HUMAN-REJECT-20261008.md](./R06-CITY-V1-HUMAN-REJECT-20261008.md).

> **R06 LEDGER RECONCILIATION — 2026-10-05:** prior Candidate review/gate lines are retained as historical evidence but marked resolved. Only numbered future work plus the latest Candidate 16/responsiveness frontier remains unchecked; an unchecked historical line must not be used to rewind SIGA.

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
  - [ ] [R06-RC01] Rebase C/C1: draw-order and portrait safe-area structural regression implemented; exact-head CI/LENTE verification pending.
  - [ ] [R06-RC02] Rebase C/C2: replace repeated raster mass/read with authored irregular facades/roofs, patched material clusters and distinct scaled shop/resident sprites; provenance and original-source art required.
  - [ ] [R06-RC03] Rebase C/C3: integrate occlusion/depth/parallax and foreground/stair UI-safe composition without changing hotspots, gameplay, runtime delivery or approved DA LATA UI.
  - [ ] [R06-RC04] Rebase C/C4: same-head Validate → Cloudflare/mobile → City Visual → Visual Acceptance → LENTE; ARTIST target-relative verdict before human runtime gate.

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
- [x] Mark R04 PASS only after all exit gates are satisfied.

## Candidate 7 execution evidence — 2026-10-01

- [x] Increase only existing shutter/crown/graffiti readable area inside `OperationV1AcceptedRebuild`; no new dressing generation.
- [x] Strengthen existing cool key and reduce global warm practical while preserving authored local amber pools.
- [x] Extend structural regression coverage with minimum graffiti/crown portrait-readable area bounds.
- [x] Bound Visual Acceptance R04 capture to Operation instead of the full multi-scene suite.
- [x] Consume fresh Candidate-7 exact-head Validate `36917496662` + bounded Visual Acceptance `36917496673` + bounded LENTE `36917496574` on `9774186437bec6f206993d70e82021aa1f0bf9d3`.
- [x] Persist ARTIST/CENA Candidate-7 `IMPLEMENTATION_REVISE (bounded)`: exact-head renders prove the focal geometry is structurally present but still occluded by the garden/supply silhouettes; accepted target keeps the crown readable in the dark wall pocket between those clusters.
- [x] Mark T039/T040 and R04 PASS only after `IMPLEMENTATION_ACCEPTED`.


## Candidate 8 execution evidence — 2026-10-01

- [x] Consume Candidate-7 exact-head evidence at 540×960 and 1080×1920 plus the accepted Operation target.
- [x] Classify the remaining defect as focal **occlusion**, not insufficient raw mesh area.
- [x] Recompose the existing shutter/crown/graffiti cluster into the exposed back-wall corridor between the accepted garden and supply silhouettes; no new dressing generation.
- [x] Replace raw-area-only regression bounds with explicit no-occlusion corridor bounds.
- [x] Preserve camera `4.70`, camera Y `6.95`, compact floor, all three semantic hotspots, gameplay/persistence and Godot-native renderer lock.
- [x] Consume fresh Candidate-8 exact-head Validate `36920612419` + bounded Visual Acceptance `36920612409` + bounded LENTE `36920612561` on `63d4f798a31d1a777ce975633b679372802670da`.
- [x] Persist ARTIST/CENA Candidate-8 `IMPLEMENTATION_REVISE (bounded)`: the cluster is exposed but reads as a pale non-crown mass because the crown halo clips its authored amber/cyan/magenta contrast and the right pendant still crosses its silhouette.
- [x] Mark T039/T040 and R04 PASS only after `IMPLEMENTATION_ACCEPTED`.

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
- [x] Re-run exact-head Validate + Visual Acceptance + bounded LENTE on Candidate 2 and inspect target-relative output.
- [x] Only explicit human ARTIST/CENA runtime `ACCEPT` may complete T051-H/I and unlock R07.


## R06 Candidate 3 target-relative review — 2026-10-04

- [x] Consume Candidate 3 exact-head Validate `37202418611`, Visual Acceptance `37202418673`, LENTE `37202418725` and Vercel success on `07c5256689fa171290de9c9b07c28eb8af4e8797`.
- [x] Inspect actual 540×960 and 1080×1920 page + isolated pixels against accepted City concept `20261004T110406Z/city`.
- [x] Persist `REVISE / STRUCTURAL_REBASE_REQUIRED`: lighting and pixel treatment improved, but primitive facades, weak graffiti/mural identity, sparse neighborhood activity and collapsed far-depth remain materially below target.
- [x] Execute Candidate 4 structural convergence: authored masonry/facade dressing, readable mural/graffiti planes, lived-in people/vegetation/awning/utility clusters and denser fictional far-city depth while preserving semantic IDs, gameplay/state/persistence, camera and DA LATA UI V1.
- [x] Re-run exact-head Validate + Visual Acceptance + LENTE after Candidate 4.
- [x] Only explicit human ARTIST/CENA runtime `ACCEPT` may complete T051-H/I and unlock R07.


## R06 Candidate 4 CENA execution — 2026-10-04

- [x] Reconcile PR #213 and confirm R06 City V1 remains the sole current visual item.
- [x] Consume ARTIST Candidate 4 contract without changing the accepted City concept `20261004T110406Z/city`.
- [x] Implement authored facade relief, a larger mural/graffiti focal system, lived-in shopfront/utility dressing and a second far-city depth layer in native Godot.
- [x] Preserve camera, semantic hotspot IDs, gameplay/state/persistence and DA LATA UI V1.
- [x] Add structural regression coverage for Candidate 4 authored-density nodes and minimum scene-detail floor.
- [x] Consume exact-head Validate `37236151542` + Visual Acceptance `37236151511` + LENTE `37236151577` on `374bc8a7befc62aeb77fbdf6d7fdeeda447ade9a`.
- [x] Return exact-head pixels to ARTIST/CENA target-relative review; persist `REVISE / COMPOSITION_DENSITY_CONVERGENCE_REQUIRED`.
- [x] Only explicit human runtime `ACCEPT` may complete T051-H/I.

## R06 Candidate 5 target convergence — 2026-10-04

- [x] Consume Candidate 4 target-relative `REVISE`.
- [x] Implement bounded Candidate 5 composition/density convergence: closer portrait occupancy, improved cool-night readability, larger mural/facade planes, denser lived-in activity, rooftop utilities and third far-city band.
- [x] Preserve Godot-native real 3D, gameplay/state/persistence, semantic hotspot IDs and DA LATA UI V1.
- [x] Raise structural regression floor and require Candidate 5 density groups.
- [x] Consume Candidate 5 exact-head `8e860843f74209cad8da62f67333ff3d2760d426`: Validate `37237100452`, Visual Acceptance `37237100475`, LENTE `37237100411`, Vercel READY.
- [x] Compare both portrait sizes against accepted City concept `20261004T110406Z/city`; decision `REVISE / TARGET_COMPOSITION_RECOMPOSE_REQUIRED` because the runtime remains miniature/blocky, mural/activity weak, stair read undersized and dark share 81–87% suppresses facade depth.
- [x] Execute Candidate 6 target recompose: closer camera, brighter cool-night readability, large mural gateway, foreground player + street-life cluster, framed stair corridor and stronger far-depth silhouette band.
- [x] Preserve real Godot 3D, gameplay/state/persistence, semantic hotspot IDs and DA LATA UI V1.
- [x] Consume Candidate 6 exact-head `2139ecb087325160ca137aed0aefb796ef127822`: Validate `37240913345`, Visual Acceptance `37240913347`, LENTE `37240913341`; all SUCCESS. Target-relative review remains `REVISE`: the scene is more readable but still materially below the accepted concept in stair-led perspective, facade/graffiti authorship and lived-in foreground density.
- [x] Only explicit human ARTIST/CENA runtime `ACCEPT` may complete T051-H/I and unlock R07.


## R06 Candidate 7 street-perspective convergence — 2026-10-04

- [x] Consume Candidate 6 exact-head 540×960 and 1080×1920 evidence against accepted City concept `20261004T110406Z/city`.
- [x] Persist `REVISE / STREET_PERSPECTIVE_AND_AUTHORED_SURFACE_REQUIRED`: Candidate 6 improved occupancy/readability but still reads as a dark low-poly miniature rather than the accepted stair-led lived-in neighborhood.
- [x] Recompose the native Godot camera from diagonal-isometric toward the stair corridor while preserving all three semantic hotspot IDs and real 3D interaction.
- [x] Lift cool-night material/value readability without converting the scene to daylight or neon.
- [x] Add Candidate 7 authored foreground facades, large mural field, facade patches, balcony/shopfront depth, hanging laundry, market stalls, residents and foreground vegetation.
- [x] Extend structural regression with Candidate 7 production paths/tokens and a higher mesh-density floor.
- [x] Consume Candidate 7 exact-head Validate + Visual Acceptance + LENTE at 540×960 and 1080×1920.
- [x] Compare actual Candidate 7 pixels against the accepted City concept and persist ARTIST/CENA `ACCEPT` or bounded `REVISE`.
- [x] Only explicit human runtime `ACCEPT` may complete T051-H/I and unlock R07.


## R06 Candidate 8 rejection / Candidate 9 construction rebase — 2026-10-05

- [x] Consume Candidate 8 exact-head Validate `37305099781`, Visual Acceptance `37305099787`, LENTE `37305099792` and both portrait captures.
- [x] Persist `REJECT / LOW_POLY_FORBIDDEN`: stronger composition does not override smooth primitive/color-block architecture.
- [x] Replace the corrective strategy: authored pixel-surface assets, nearest filtering, textured facade/mural/shopfront cards, irregular ArrayMesh roof silhouettes and layered textured depth.
- [x] Preserve native Godot 3D, camera corridor, gameplay/state/persistence, semantic hotspot IDs and DA LATA UI V1.
- [x] Add regression that forbids Candidate 9 from calling `_c8_box` / `BoxMesh.new()` and requires authored surface assets.
- [x] Consume Candidate 9 exact-head Validate + Visual Acceptance + LENTE at 540×960 and 1080×1920.
- [x] ARTIST target-relative review: any material low-poly read is immediate `REJECT / LOW_POLY_FORBIDDEN`; otherwise request explicit human runtime ACCEPT/REVISE.
- [x] Only explicit human runtime ACCEPT may complete T051-H/I and unlock R07.


## R06 Candidate 9 rejection / Candidate 10 presentation rebase — 2026-10-05

- [x] Consume Candidate 9 exact-head Validate `37308810278`, Visual Acceptance `37308810007`, Vercel success and portrait artifact `11344518689`.
- [x] Persist `REJECT / LOW_POLY_FORBIDDEN`: texture breakup alone did not remove primitive-box architectural massing.
- [x] Demote player-visible `Buildings`, `BackdropDepth` and Candidate4–9 presentation layers while preserving physical StairSpine/ground and semantic marker/hitbox contracts.
- [x] Add Candidate 10 transparent nearest-filtered pixel-art near/mid facade cards, mural identity, lived-in street clusters and layered far-city strips on distinct 3D planes.
- [x] Add regression forbidding Candidate 10 corrective `_c8_box` / `BoxMesh.new()` use and requiring all authored pixel-card assets.
- [x] Consume Candidate 10 exact-head Validate + Visual Acceptance + LENTE at 540×960 and 1080×1920.
- [x] ARTIST target-relative review; any remaining material low-poly read = `REJECT / LOW_POLY_FORBIDDEN`.
- [x] Only explicit human runtime ACCEPT may complete T051-H/I and unlock R07.


## R06 Candidate 11 exact-head review — 2026-10-05

- [x] Candidate 11 exact head `e9e5b9aed409f8c790d93141de8a980bf80a3e11` passes Validate `37311118312`.
- [x] Visual Acceptance `37311118411` passes; artifact `11345487303` inspected at 540×960 and 1080×1920.
- [x] Vercel exact-head status = SUCCESS.
- [x] Confirm hard low-poly failure is cleared: the player-visible scene now reads as pixel-art/2.5D rather than primitive-box architecture.
- [x] Persist target-relative `IMPLEMENTATION_REVISE / AUTHORED_ASSET_PIPELINE_REQUIRED`: facade, resident, vegetation and commerce detail remain materially too flat/coarse versus the accepted concept.
- [x] Start next append-only ARTIST/CENA City production-asset session using repository tooling.
- [x] Create/source provenance-tracked production assets for facades, residents, vegetation and shop clutter; integrate into the existing 3D depth/hitbox scaffold.
- [x] Re-run exact-head Validate + Visual Acceptance + LENTE after asset integration.
- [x] Only explicit human implementation ACCEPT may complete T051-H/I and unlock R07.


## R06 Candidate 13 volumetric construction rebase — 2026-10-05

- [x] Consume the authoritative Candidate 12 human `REJECT / LOW_POLY_FORBIDDEN` and revoke Candidate 11/12 as accepted runtime baselines.
- [x] Wait for exact-head `0a5ee01c0cb39bb70078ebc68e3dc4253989aa1c` LENTE `37332944888` to reach terminal SUCCESS before moving the shared PR branch.
- [x] Execute Candidate 13 construction rebase: demote dominant flat facade/mural cards; rebuild near/mid City architecture and visible stair treatment as textured, lit, extruded custom meshes with perspective depth; preserve gameplay/state/persistence, semantic IDs and DA LATA UI V1.
- [x] Consume exact-head Candidate 13 Validate + Visual Acceptance + bounded LENTE at 540×960 and 1080×1920.
- [x] ARTIST must inspect actual Candidate 13 pixels against accepted concept `20261004T110406Z/city`; any remaining low-poly read is `REJECT / LOW_POLY_FORBIDDEN`.
- [x] Only explicit human runtime `ACCEPT` may complete T051-H/I and unlock R07.

## R06 Candidate 13 review / Candidate 14 bounded alignment — 2026-10-05

- [x] Consume Candidate 13 exact-head `860120774e3922eee0d5ba75417b431fcf6028f6` gates: Validate `37336604390`, City Visual Acceptance `37336604428`, Visual Acceptance `37336604602`, LENTE `37336604196`, Vercel SUCCESS.
- [x] Persist ARTIST decision `REVISE / V1_NIGHT_GRAFFITI_DEPTH_ALIGNMENT`: volumetric construction is materially improved and must be preserved.
- [x] Execute Candidate 14 as a bounded correction only: inky navy night grammar, authored dark far-city depth, relief graffiti/pixo focal surfaces and local warm practical pools.
- [x] Hide the bright Candidate 11 skyline while preserving Candidate 13 perspective camera, volumetric facades/stairs, gameplay/state/persistence, semantic IDs and DA LATA UI V1.
- [x] Add regression that forbids Candidate 14 flat-card/primitive corrective construction and requires the authored night-depth asset plus mural/light nodes.
- [x] Freeze Candidate 14 exact head and consume Validate + City Visual Acceptance + Visual Acceptance + LENTE + Vercel.
- [x] ARTIST inspects exact-head 540×960 and 1080×1920 pixels against accepted City concept `20261004T110406Z/city`; only explicit human runtime `ACCEPT` may unlock R07.

## R06 Candidate 14 review / Candidate 15 bounded detail — 2026-10-05

- [x] Consume Candidate 14 exact head `e81661175ca9a1c85b8d65b142ccff4521879daf`: Validate `37344152541`, City Visual Acceptance `37344152516`, Visual Acceptance `37344152652`, LENTE `37344152729` / artifact `11359743073`, Vercel SUCCESS.
- [x] ARTIST pixel review: preserve Candidate 14 night grammar and Candidate 13 volumetric construction; classify `REVISE / GRAFFITI_FOCAL_AND_FAR_DEPTH_DETAIL`.
- [x] Execute Candidate 15 only on the two residual deltas: stronger volumetric mid/upper mural-pixo focal hierarchy plus additional extruded lived-in far-neighborhood/window/roof rhythm.
- [x] Preserve camera, stair corridor, gameplay/state/persistence, semantic IDs, DA LATA UI V1 and Candidate 14 global night lighting; no global relight and no primitive/card regression.
- [x] Freeze Candidate 15 exact head and consume Validate + City Visual Acceptance + Visual Acceptance + LENTE + Vercel.
- [x] ARTIST inspects 540×960 and 1080×1920 exact-head pixels. Only explicit human runtime `ACCEPT` may complete R06 and unlock R07.



## R06 Candidate 15 human reject / Candidate 16 vertical rebase — 2026-10-05

- [x] Consume Candidate 15 exact head `4b419c7ab01f69029bb5a31916d1da942a32d1b4`: Validate `37346156386`, City Visual Acceptance `37346156432`, Visual Acceptance `37346156686`, LENTE `37346156444`, Vercel SUCCESS.
- [x] Persist explicit human `REJECT` for Candidate 15 and supersede ARTIST accept recommendations for that exact head.
- [x] Correct parallel-session gate attribution: the latest human decision belongs to Candidate 15, not Candidate 14.
- [x] Classify `VISUAL_CONSTRUCTION_REBASE_REQUIRED`; bounded Candidate 15 polish is not an accepted baseline.
- [x] Execute Candidate 16 first structural slice: restore locked V1 orthographic three-quarter camera, demote Candidate 13 dominant composition, rebuild the player-facing City as tiered authored ArrayMesh architecture around a 19-step vertical stair spine, terraces, roof/utility rhythm and bounded practical lights.
- [ ] Freeze Candidate 16 exact head and consume Validate + City Visual Acceptance + Visual Acceptance + LENTE + Vercel.
- [ ] ARTIST compares exact-head 540×960 and 1080×1920 pixels against accepted concept `20261004T110406Z/city`.
- [ ] Only explicit human runtime `ACCEPT` may complete R06 and unlock R07.

## Candidate 16 runtime recovery addendum — human freeze blocker

- [x] Reclassify the immediate blocker as `GAMEPLAY_REGRESSION / GAME_FROZEN`; visual convergence cannot override a frozen runtime.
- [x] Preserve the concurrent Candidate 16 visual experiment as unaccepted evidence only.
- [x] Stop synchronous live construction of rejected Candidate 8–10 layers and superseded Candidate 13 geometry before the active Candidate 11/12 + 14–16 stack.
- [x] Disable rejected static Candidate 4–7 roots in the player-facing tree.
- [x] Update City regression so rejected Candidate 8–10 and superseded Candidate 13 runtime roots must be absent after initialization.
- [x] Add exact-head Web responsiveness probe: City → Market → City must change rendered frames after keyboard input at both portrait sizes.
- [ ] Do not request human visual acceptance until the runtime responsiveness probe is green and the user confirms the freeze is cleared.



## R06 Candidate 17 authored-neighborhood production consolidation — 2026-10-07

- [x] Consume ARTIST review of exact head `6ea714c1402161b5e4158b62ff86b502aa95c4b5`: `IMPLEMENTATION_REVISE / LOW_POLY_FORBIDDEN / VISUAL_CONSTRUCTION_REBASE_REQUIRED`.
- [x] Stop executing rejected Candidate 11/12/14/15/16 builders from the live City bootstrap.
- [x] Add original Candidate 17 warm/cool facade, shopfront, mural/pixo and far-neighborhood pixel assets.
- [x] Rebuild the visible City as a single authored ArrayMesh production stack with irregular facade silhouettes, patch/material breakup, shopfront depth, balconies/awnings/utilities, residents, vegetation and cable rhythm.
- [x] Replace the 19-step Candidate 16 traversal read with a 22-step authored vertical stair spine and expand portrait scene occupancy without changing semantic interactions.
- [x] Replace Candidate 16 runtime assertions with a Candidate 17 single-stack/no-primitive regression contract.
- [ ] Freeze Candidate 17 exact head and consume Validate + City Visual Acceptance + Visual Acceptance responsiveness + LENTE + Cloudflare preview.
- [ ] ARTIST compares exact-head 540×960 + 1080×1920 page/isolated/orbit evidence against `20261004T110406Z/city`.
- [ ] Only explicit human runtime `ACCEPT` may complete R06 and unlock R07.


## R06 Candidate 17 bounded polish — 2026-10-07

- [x] Consume Candidate 17 exact-head ARTIST review on `b8c06e4eaae2c166e52369bf9c5b95ba73cc60ac`: `LOW_POLY_VETO_CLEARED / TARGET_DENSITY_COMPOSITION_GAP`.
- [x] Extend the authored neighborhood into the lower portrait field while preserving the 22-step stair spine and DA LATA UI V1 controls.
- [x] Diversify dominant graffiti/pixo surfaces with two original Candidate 17 pixel assets instead of cloning the crown motif across every facade.
- [x] Add bounded residents, vegetation, cables, foreground kiosks, far-depth silhouettes and cool side/back separation without generic primitive-box construction.
- [x] Extend City structural regression for the new authored assets, foreground/depth nodes, density nodes and portrait occupancy floor.
- [ ] Freeze the new exact head and consume Validate → City Visual Acceptance → Visual Acceptance → LENTE.
- [ ] Return same-head pixels/orbit to ARTIST; only ARTIST eligibility followed by explicit human runtime `ACCEPT` may complete T051-H/I and unlock R07.

## R06 Candidate 17 portrait-convergence continuation — 2026-10-07

- [x] Consume Candidate 17 bounded-polish exact-head `99aea15c92fac2db053dd65613b2d5b106a08806`: Validate `37636666525`, Visual Acceptance `37636666492`, City visual `37636666775`, Cloudflare preview and LENTE `37636666631` / artifact `11489904244` are terminal green.
- [x] Persist ARTIST `IMPLEMENTATION_REVISE / LOW_POLY_VETO_CLEARED / PORTRAIT_DENSITY_GAP`: lower portrait void, stamped mural repetition and lived-in foreground density remain materially below accepted City concept.
- [x] Execute one bounded Candidate 17 continuation only: tighten portrait camera occupancy, extend authored ArrayMesh stair/forecourt foreground, diversify dominant mural use and add foreground residents/vegetation; preserve gameplay, semantic IDs, DA LATA UI V1 and native Godot ownership.
- [x] Re-run exact-head Validate + City Visual Acceptance + Visual Acceptance + LENTE on `6ca0ac6493cd3152dcc314512ac375e3fd5d0210`; all required gates terminal SUCCESS. ARTIST review remains REVISE, so T051-H is still blocked.

## R06 Candidate 17 stair-life convergence — 2026-10-07

- [x] Consume exact-head `6ca0ac6493cd3152dcc314512ac375e3fd5d0210`: Validate `37639750448`, City visual `37639750880`, Visual Acceptance `37639750606`, LENTE `37639750521` / artifact `11492931874` are terminal green.
- [x] Persist ARTIST `IMPLEMENTATION_REVISE / LOW_POLY_VETO_CLEARED / STAIR_LIFE_DENSITY_GAP` from real target-relative pixels.
- [x] Keep the crown mural as one signature focal and remove the remaining repeated facade use.
- [x] Break up the central 22-step read with authored tile/masonry/paint-wear materials; add bounded side shop/awning activity, four residents, two plants and one cool mid-depth separator without primitive-box construction.
- [x] Extend City regression for the new activity/density nodes and one-signature crown rule.
- [ ] Freeze the new exact head and consume Validate → City Visual Acceptance → Visual Acceptance → LENTE → Cloudflare.
- [ ] ARTIST compares same-head page/isolated/orbit evidence; expose T051-H human runtime gate only if eligible.


## R06 City — human REJECT ALL / full visual-construction replacement — 2026-10-08

**Human verbatim:** “Reject completo, nada parece com o art concept.”  
**Rejected implementation SHA:** `1f799128d9efe33cfdcb8365119fc2eb2371166e` (PR #213).  
**Accepted art target:** `20261004T110406Z/city` — **unchanged**.  
**Classification:** `REJECT_ALL / FULL_VISUAL_REBASE_REQUIRED`; Rebase A/B/C visual architecture **not approved**. R06 CURRENT / R07+ LOCKED / PR DRAFT.

- [x] [R06-REJECT-00] Record and prioritize explicit human rejection over prior ARTIST REVISE/LOW_POLY_VETO_CLEARED and green CI; keep runtime/semantic infrastructure only.
- [x] [R06-REJECT-01] ARTIST + CENA derive a **concept-locked reconstruction sheet** from the existing approved City artwork: scene layout, actual silhouette proportions, facade/roof irregularity, stair scale, lived-in shop/resident clusters, true volumetric depth and 540×960/1080×1920 UI exclusion zones. Identify what earlier visual systems must be disabled, not polished.
- [ ] [R06-REJECT-02] CENA replace dominant billboard/card/flat raster architecture with original coherent isometric pixel-art environment and non-coplanar urban massing/silhouettes. Source-authored surface materials, graffiti and scaled residents/commerce; never use primitive-count/density to claim target parity.
- [ ] [R06-REJECT-03] Fix actual state-panel/action-row/scene region overlap in both mobile portrait targets by geometry/legibility; a z-index-only change is not completion.
- [ ] [R06-REJECT-04] Freeze rebuilt implementation on one exact HEAD; prove City→Market→City interactions, responsive mobile Web boot, accessibility, current CI, LENTE page/isolated captures at both sizes and an orbit free of billboard/card-edge reveals. Compare directly with the approved concept.
- [ ] [R06-REJECT-05] ARTIST supplies explicit target-relative verdict; human sees another acceptance candidate only after an internally cleared reconstruction. Runtime `ACCEPT` remains human-only and is necessary before R06 PASS/unlocking R07.

**Important:** the previous RC01–RC04 tasks and prior source-art strategy remain **history only**; the next work must derive from this rejection decision.


**ARTIST reference decomposition handoff:** [R06-CITY-V1-ARTIST-RECONSTRUCTION-SHEET.md](./R06-CITY-V1-ARTIST-RECONSTRUCTION-SHEET.md). No new concept, CENA implementation remains pending, no new art acceptance.


## R06 City SVG 2.5D production override — human decision 2026-10-08

Binding exception to R06-REJECT-02 **only**: use original modular SVG sprite layers rather than heavy 3D architecture. The previous R06-REJECT-02 phrase "non-coplanar urban massing" is **superseded**, not a new requirement to model surfaces. Old flat-card renderer remains rejected.

- [x] [R06-25D-00] Consume exact-head LENTE 7847188 and preserve ARTIST reference lock / REJECT ALL.
- [x] [R06-25D-01] Amend Spec Kit, plan and reconstruction contract for a **Godot SVG 2.5D scene**.
- [x] [R06-25D-02] Supply the ARTIST→CENA source-sprite prompt/manifest handoff and unmounted compositor seam for implementation.
- [ ] [R06-25D-03] ARTIST/CENA generate original sprite modules from accepted concept; audit first family before batch generation. **PARTIAL:** two separate original upper-building SVG sources and provenance candidate ledger delivered; isolated ARTIST source review remains pending.
- [ ] [R06-25D-04] Wire complete 2.5D City as the **only player-facing visual stack**; hide rejected A/B/C/Candidate17, preserve Godot gameplay/hotspots.
- [ ] [R06-25D-05] Verify mobile UI, input, City→Market→City, exact-head CI/Cloudflare, LENTE 540/1080 stills and 2.5D pan video.
- [ ] [R06-25D-06] ARTIST compares directly against accepted concept. No human gate until truly eligible; no R07 before R06 PASS.

**Unchanged:** R06-REJECT-03 physical UI bands remain unapproved until tested on runtime screenshots; R06-REJECT-04/05 are pending.


### R06 / SVG 2.5D CENA production tranche (2026-10-08)

Task `012:R06:25D-03:UPPER-SPRITES` authored editable original architectural SVG candidates `coral-terrace-house.svg` and `ochre-shop-terrace.svg` in `assets/city/v1/svg25d/source/upper/` with individual front/side/roof silhouettes, local pixel patina, unique window/shop/roof/plant vocabulary, and a normalized placement ledger. These are **UNREVIEWED candidate assets**; no `layers.json` production activation and no player-facing City renderer swap. The previous user REJECT of old A/B/C remains binding. Require true render/import QA + ARTIST reference review before scaling sprite families; preserve R06 only and lock R07+.

## R06 ARTIST Review v0.2 reconciliation — 2026-10-09

- [x] [R06-RECON-01] Verify R05 PASS, accepted Market runtime head `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e` and merged PR #205 `f73190b89bafca1e05310f4f816c2cdc788bd03d`.
- [x] [R06-RECON-02] Preserve all 25 G choices and R1 D/R2 D/R3 D/R4 D/R5 B within Feature 012; R5 B is the objective checklist.
- [x] [R06-RECON-03] Surface conflict between new real-3D visual spec and prior SVG-25D City exception without rewriting or deleting either approval.
- [x] [R06-ARCH-GATE-01] Human selected **B = Godot modular SVG 2.5D**, explicitly superseding the City R06 real-mesh visual-construction requirement of ARTIST Review v0.2.
- [x] [R06-ARCH-GATE-02] Reconcile City R06 spec/plan/task/evidence for SVG 2.5D, including VIS-01 authored-depth/pan criteria and unreviewed source-candidate fence. No runtime/asset change.
- [ ] [R06-ART-ACCEPT-01] With later authorized implementation and exact-head screenshots, record VIS-01..VIS-08 as PASS/FAIL plus independent SIGA runtime verification and explicit human gate.

**STOP:** R06 implementation `WATCH / IMPLEMENTATION_PLAN_APPROVAL_PENDING`; R07+ LOCKED. Architecture B selected, but no sprite production, compositor activation, runtime or visual acceptance without a separately approved implementation plan.

## R06 SVG 2.5D next bounded implementation plan — proposed, NOT authorized (2026-10-09)

- [ ] [R06-B-PLAN-GATE] HUMAN reviews and approves this plan before any code, scene, test or asset work.
- [ ] [R06-B-01] **PARTIAL:** two individual upper-building SVG objects received explicit human `OBJECT_ART_ACCEPTED` after inline source previews. Original assets unchanged; Godot SVG import/pixel-render QA remains `PENDING`. This approval is not a scene/family/runtime acceptance and does not unlock R06-B-02.
  - [x] [R06-B-01A] Display the original SVGs as two independent inline images; record human object-only approval, source blobs and frozen preview evidence.
  - [ ] [R06-B-01B] Verify real Godot import, rasterization, scale/pixel filtering and isolated target-relative QA for these two source objects (requires separate execution authorization).
- [ ] [R06-B-02] ARTIST/CENA create only missing distinct source-sprite families after first-family approval, with per-object provenance, separate facade/roof/side readability, consistent scale and no giant cards.
- [ ] [R06-B-03] CENA wires a single 2.5D player-facing compositor, with coherent z-order, occlusion and bounded parallax; disables old rejected visual stack; preserves Godot semantic anchors and DA LATA UI.
- [ ] [R06-B-04] ARCH verifies real touch/keyboard/menu/hotspots, camera focus/recenter, loading/skip/reduced-motion/retry, City→Market→City, safe UI regions and exact-head regressions.
- [ ] [R06-B-05] LENTE captures same-head 540×960/1080×1920 page/isolated frames plus two-axis pan and interaction video; verify actual Godot Web/Cloudflare preview URL and CI.
- [ ] [R06-B-06] ARTIST records VIS-01..VIS-08 PASS/FAIL against accepted City concept; SIGA produces RELATORIO; explicit human runtime ACCEPT is the only path to R06 PASS.

**No step above is currently executable; plan approval is a separate human gate.**

## 2026-10-09 — R06-B-01 per-object acceptance and missing-preview process fix

- Human verbatim: **"Aprovado como itens individuais, não como cena completa."** The two **source objects** `coral-terrace-house.svg` and `ochre-shop-terrace.svg` now have independent `OBJECT_ART_ACCEPTED` decisions with rendered inline evidence and frozen Git blobs in [upper REVIEW.md](../../assets/city/v1/svg25d/source/upper/REVIEW.md) and `candidate-family.json`.
- Skill contract corrected: ARTIST cannot announce a visual preview without displaying the actual image. Missing image ⇒ `PREVIEW_NOT_DELIVERED`; text-only link, raw SVG/XML or code is not a human visual review. Show one original item at a time before accepting each.
- The previous `UNREVIEWED` status in the 2026-10-08 historical tranche is superseded for these **two individual items only**. The upper family remains `ORIGINAL_SPRITE_CANDIDATE`; actual Godot import/render QA and full scene parity remain unverified.
- `R06-B-01` still partial because Godot QA remains pending. `R06-B-02` and later implementation tasks remain not authorized. No `layers.json`, compositor, new SVGs, scene assembly or merge.
- R05 `PASS`; R06 sole current `WATCH / IMPLEMENTATION_PLAN_APPROVAL_PENDING`; old City player-facing `REJECT_ALL` remains binding; R07+ `LOCKED`.
