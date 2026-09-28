# 3JS HANDOFF v1

## Identity

Repository:

```text
az1nn/growing-rio
```

Skill:

```text
.agents/skills/3js/SKILL.md
```

Architecture contract:

```text
docs/3JS-ARCHITECTURE.md
```

## Verified bootstrap state — 2026-09-26

Verified default branch:

```text
master
```

Verified base HEAD used to claim this bootstrap wave:

```text
56f05518a0dd6a9e4c898851be7cd99c40416b4c
```

Open PRs observed immediately before branch claim:

- #97 — `feat/cena-016-foreground-floor-depth` -> `master`
- #98 — `feat/cena-017-foreground-apron-transition` -> PR #97 branch
- #100 — `docs/siga-20260925-live-reconciliation` -> `master`
- #101 — `feat/cena-018-foreground-service-plinth` -> PR #98 branch

The active CENA stack owns `docs/CENA-HANDOFF.md`, `docs/VISUAL-DIRECTION.md`, `scenes/visual/operation_diorama.tscn`, related scene tests and validator changes. This 3JS bootstrap intentionally does **not** edit those files.

PR #102 (Act I lore event library) was verified merged into `master` before this branch was created.

## Bootstrap branch

```text
feat/3js-scene-workflow
```

## Route

```text
3JS-ADVANCE
```

There was no existing Three.js implementation, branch, PR or indexed Three.js code in the verified repository at bootstrap time.

The requested capability is therefore initialized as a new repo-local continuation discipline rather than treated as unfinished runtime work.

## User direction encoded

- create a standalone command/skill named **3js**;
- use **SIGA + LORE + CENA** as coordinated authorities;
- implement and refine 3D scenes with Three.js;
- preserve the visual style already present because the current direction is accepted;
- do not use the existence of Three.js as permission for an unbounded redesign or engine migration.

## Style lock

Until CENA explicitly changes direction, 3JS preserves:

- orthographic diorama composition;
- 2D/3D hybrid presentation;
- portrait-first 540x960 and 1080x1920 framing;
- concrete / warm plaster / dark metal / teal / terracotta palette;
- restrained low-poly foliage;
- cool/warm lighting grammar;
- strong silhouette and architectural rhythm;
- UI legibility over the 3D scene.

## Architecture decision

Godot remains the canonical runtime at bootstrap.

Three.js starts through an **additive parity proof**. No stable boot path, gameplay state, persistence contract or generated Godot Web export is replaced in 3JS-000.

This follows the engineering constitution: the first player-facing Three.js runtime capability must receive a bounded Spec Kit feature before implementation.

## Delivered in 3JS-000

- `.agents/skills/3js/SKILL.md`
- `docs/3JS-ARCHITECTURE.md`
- `docs/3JS-HANDOFF.md`

No runtime dependency is added in this bootstrap wave.

## Next bounded wave

```text
3JS-001 — OperationDiorama parity proof
```

On the next standalone `3js` invocation:

1. reconcile live repository state and the active CENA stack;
2. classify RESUME/WATCH/ADVANCE/BLOCKED from live evidence;
3. create/select the bounded 3JS-001 Spec Kit feature before runtime code;
4. define the Three.js integration path without hand-editing generated `web/` export artifacts;
5. reproduce the accepted OperationDiorama visual grammar in an additive/reversible Three.js proof;
6. connect only through a read-only presentation model;
7. validate 540x960 + 1080x1920 captures, console/page errors and Web performance;
8. do not discuss runtime replacement until parity and performance evidence exist.

## Dependencies

### SIGA
Required for repository identity, Spec Kit, concurrency, CI, Web delivery and merge safety.

### CENA
Required for visual target, visual acceptance, asset/provenance decisions and any future art-direction change.

### LORE
Required only when a Three.js scene depicts narrative facts not already safely derivable from canonical documents.

## Known debt

- Three.js is not yet an installed runtime dependency.
- No 3JS Spec Kit feature exists yet.
- No Three.js scene exists yet.
- No parity/performance evidence exists yet.
- The CENA foreground stack is still active and must be reconciled before 3JS-001 derives its final OperationDiorama geometry/composition baseline.

These are expected bootstrap facts, not failures.


## Delivery PR

Bootstrap delivery PR:

```text
#103 — feat(3js): add Three.js scene continuation workflow
```

The PR targets `master` and contains only the 3JS skill/architecture/handoff bootstrap paths. Its pre-persistence head was `9cc8d6735816952ff78f1ad98231c9e2f85ab1d8`.

This handoff persistence changes the PR head, so any exact-head validation must use the resulting current PR head rather than the pre-persistence SHA.

## 3JS-001 — OperationDiorama parity proof — 2026-09-26

### Verified repository / concurrency
- repository: `az1nn/growing-rio`;
- route at entry: **3JS-ADVANCE**;
- master at initial 3JS-001 claim: `851bd50de53540af84dd9e651aebc7b70201c55b`;
- accepted CENA Wave 019 baseline at claim: PR **#104** / `35ebf05c5dec4a59a99207b73fee25c541629b04`;
- CENA #104 exact-head Validate project: **SUCCESS**;
- CENA #104 exact-head Visual acceptance: **SUCCESS**;
- CENA #104 Vercel: **SUCCESS**;
- dedicated branch: `feat/3js-001-operation-diorama-parity`;
- branch first reconciled the Wave 019 tree with then-current master through merge commit `63f4782d33f5d1a592746afa73a003694b0b051a`, without force update;
- while implementation was in progress, master advanced to `e25d5626697971bce27504defa0739a97e564cda` through CENA Wave 016/017 delivery;
- PR #101 moved onto current master and began fresh exact-head validation;
- PR #104 became temporarily **dirty** against the moved #101 base. This is an explicit ancestry gate, not permission to discard the accepted Wave 019 target.

### Spec / implementation
Active Spec Kit package:

`specs/3js-001-operation-diorama-parity/`

Implemented:
- isolated proof under `threejs/operation-diorama/`;
- exact `three@0.186.1` dependency pin;
- local package/lock/build path with no unpinned CDN and no authored change under generated `web/`;
- immutable presentation model;
- orthographic OperationDiorama translation using CENA material/palette values, room masses, props, planters and Wave 016-019 foreground progression;
- repeated plant geometry uses `THREE.InstancedMesh` to stay inside the Web draw-call budget;
- renderer DPR capped at 1.5;
- shadows disabled;
- no perpetual animation loop;
- deterministic resize plus explicit scene/renderer/listener disposal;
- renderer metrics exposed only for acceptance evidence;
- structural validator at `tools/validate_threejs.py`;
- exact-head workflow `.github/workflows/threejs-visual-acceptance.yml`.

### Performance contract
- draw calls <= 55;
- triangles <= 25,000;
- material families <= 8;
- runtime textures = 0;
- device pixel ratio <= 1.5;
- dynamic shadows disabled.

### Delivery PR
- PR **#107** — `feat(3js): add OperationDiorama parity proof`;
- base: `feat/cena-019-foreground-service-landing` / PR #104;
- pre-handoff implementation head: `5c37aa0ab3f3877198944be914ee221fbbc83034`.

### Route
**3JS-WATCH**

The implementation is dispatched. Completion now requires exact-head repository/build/render evidence plus parent-ancestry reconciliation. The parent movement is expected concurrent CENA delivery, not a reason to duplicate or redesign the 3JS scene.

### Active gates / next action
1. Require **Validate project** on the exact final PR #107 head.
2. Require **Three.js visual acceptance** on that same head at 540x960 and 1080x1920.
3. Require empty browser console/page-error evidence and passing renderer budget metrics.
4. Inspect the rendered artifacts against the accepted CENA-019 hierarchy before calling parity accepted.
5. Reconcile PR #107 after PR #104 absorbs the delivered parent ancestry; any head/base movement invalidates stale completion evidence.
6. Do not merge #107 ahead of #104 and do not interpret successful parity as authorization to replace Godot.


## 3JS-001 live reconciliation — 2026-09-26

### Verified live state
- CENA PR **#104** is merged; merge commit: `ea846f109843d309e200a78037961d7e1c8658ee`.
- generated Web refresh advanced `master` to `300c1ccb770bd2fc3919343cb8489b29fd9d9306`.
- stale PR #107 head `ffc5e56d0554e17702c265a68e0f9d9b00286ab5` was 17 commits behind master and reported `mergeable_state=dirty`.
- parent drift was reconciled without force update through merge commit `fff974611df75d2cb9abfb6bf8cdef60a642dd89`, with current master as second parent and master tree as the semantic base.
- reconciliation reapplied only the bounded 3JS-001 paths; current SIGA, LORE, CENA and generated Web state from master was preserved.
- after reconciliation PR #107 reports `mergeable=true` against `master`.

### Route
**3JS-WATCH**

Parent ancestry is now reconciled. Completion is gated only by exact-final-head evidence and rendered CENA parity inspection.

### Exact-head gates after persistence
1. require `Validate project` success on the final PR #107 head;
2. require `Three.js visual acceptance` success on that same head;
3. require 540x960 and 1080x1920 captures, empty browser console/page-error evidence and renderer budgets within contract;
4. inspect the rendered artifacts against the accepted CENA-019 visual hierarchy;
5. merge #107 with an expected-head guard only after all above evidence is green;
6. verify the resulting master merge commit and persist final completion state if repository policy requires a post-merge handoff.



## 3JS-001 acceptance repair — 2026-09-26

### Failed exact-head evidence
- exact head `440b7d44c7e0751a82dcb9b4321882b2b8f0f6a4`;
- `Validate project #499`: **SUCCESS**;
- Vercel: **SUCCESS**;
- `Three.js visual acceptance #5`: **FAILURE** at the renderer budget assertion;
- observed failure: `portrait-540x960 budget failed: textures=1`;
- structural validation, npm install/build and Chromium setup passed before the budget assertion.

### Root cause
The parity scene binds no runtime textures to scene materials, but the gate measured `renderer.info.memory.textures`. Three.js may allocate renderer-internal texture resources that are not authored scene/material textures, so the metric did not represent the 3JS-001 product budget.

### Repair
- `textures` counts unique `THREE.Texture` instances actually bound to scene materials;
- `rendererTextures` retains `renderer.info.memory.textures` as a non-gating diagnostic;
- the implementation plan defines the budget as **0 scene/material textures**;
- structural validation locks the scene-texture accounting contract.

### Route
**3JS-RESUME -> 3JS-WATCH**

The defect is repaired. Completion requires fresh exact-head validation, rendered parity inspection and guarded merge.


## 3JS-001 delivery closure — 2026-09-26

### Final exact-head evidence
PR **#107** final head:

`e919631fc010451945deff638049a8c95124a69d`

Required gates:
- `Validate project` run **36258708457: SUCCESS**;
- `Three.js visual acceptance` run **36258708401: SUCCESS**;
- repository `Visual acceptance capture` run **36258708378: SUCCESS**;
- Vercel: **SUCCESS**.

Three.js rendered artifact:
- artifact **10911532182**;
- browser console/page-error evidence: **empty**;
- 540x960: 49 draw calls, 1,932 triangles, 8 material families, 0 authored textures, DPR 1, shadows disabled;
- 1080x1920: 49 draw calls, 1,932 triangles, 8 material families, 0 authored textures, DPR 1, shadows disabled;
- Three.js renderer-internal texture allocation remained visible separately as `rendererTextures=1` and is not an authored asset.

### Visual parity inspection
The 540x960 and 1080x1920 Three.js captures were inspected against the accepted CENA Wave 019 captures. The parity proof preserves:
- orthographic diorama read and portrait hierarchy;
- warm plaster / concrete room masses;
- dark-metal structural rhythm;
- teal architectural accents;
- terracotta planter + restrained foliage silhouette family;
- cool/warm light grammar;
- foreground apron -> service plinth -> service landing progression.

The proof is intentionally isolated from the canonical shell UI, so pixel identity with the Godot composite is not an acceptance requirement. No redesign or runtime migration is inferred.

### Merge
- PR **#107** merged with expected-head guard;
- merge commit: `274f6a74a0fe676d4e2065a55eeda66effc8f22f`;
- post-merge `Validate project` run **36258925733: SUCCESS**;
- Vercel on the merge commit: **SUCCESS**.

### Final route
**3JS-ADVANCE**

3JS-001 is delivered. Godot remains the canonical runtime. The next standalone `3js` invocation must reconcile live state first and may select 3JS-002 only from a bounded, evidence-driven visual/renderer need. Do not begin a renderer migration merely because this parity proof passed.


## 3JS-002 — Grow Room style-lock specification — 2026-09-26

### Verified live state at specification
- repository: `az1nn/growing-rio`;
- 3JS-001 is delivered through merged PR #107;
- live master was reconciled through `22cb255d0a6ca484a00a0bdf9d51693777b2e1af` before this write;
- the previously parallel SIGA documentation PR #106 is merged;
- no open PR remained at final scope claim;
- dedicated branch: `spec/3js-002-grow-room-style-lock`.

### Route
**3JS-ADVANCE -> 3JS-RESUME**

3JS-001 is complete, so the project advances into the next bounded capability. After this specification/reference commit, runtime implementation remains incomplete and the route becomes RESUME.

### User direction encoded
- this chat/session is now a Spec Kit session focused on Three.js 3D scene creation;
- project-owner references are persisted for consultation;
- the **grow room** is the first and most important scene because it is expected to carry the highest player dwell time;
- the grow room must reach rendered visual acceptance before other screens inherit a definitive Three.js style.

### Active package
- spec: `specs/3js-002-grow-room-style-lock/`;
- references: `docs/visual-references/3js-grow-room/`;
- implementation target: `threejs/grow-room/` (not yet created by this spec-only wave).

### Visual status
**CANDIDATE**, not definitive.

The reference synthesis points toward an original fixed isometric/orthographic miniature interior with chunky low-poly silhouettes, pixel-art discipline, authored clutter, soft depth hierarchy and selective warm/cool lighting. The exact reusable tokens become canonical only after grow-room exact-head rendered acceptance returns ACCEPT.

### Next action
Reconcile live repository state again, then implement the bounded grow-room scene under 3JS-002, capture 540x960 and 1080x1920, enforce renderer/lifecycle budgets, and run the visual ACCEPT/REVISE gate. Do not propagate the candidate style to other screens before ACCEPT.


## 3JS-002 grow-room implementation dispatch — 2026-09-26

### Reconciled delivery state
- specification/reference PR **#110** merged into `master` as `c87a96e8f4237ba1906d9aea98d687f2bd2601be`;
- the five project-owner reference images are versioned under `docs/visual-references/3js-grow-room/`;
- implementation branch: `feat/3js-002-grow-room-implementation`;
- implementation PR: **#111**;
- pre-handoff implementation head: `9c2f0fdb86851335a2753b2657a61b8e22d62ffb`;
- this handoff write changes the exact PR head, so all completion evidence must target the resulting newer SHA.

### Route
**3JS-WATCH**

3JS-002 Phase 1 is implemented and dispatched. The grow-room visual direction is still **CANDIDATE** until exact-head rendered review returns ACCEPT or REVISE.

### Implemented candidate
- isolated `threejs/grow-room/` package pinned to exact `three@0.186.1`;
- fixed orthographic miniature/cutaway scene;
- reusable candidate style tokens for camera, palette, material response, scale/grid and lighting;
- flat-shaded repository-authored procedural architecture and prop clusters;
- instanced abstract living silhouettes;
- cool/dark envelope with selective warm practical focus;
- immutable presentation model only;
- deterministic resize/render lifecycle and explicit resource/listener teardown;
- zero authored runtime textures in this candidate;
- dynamic shadows disabled;
- dedicated `tools/validate_grow_room_threejs.py`;
- dedicated exact-head `.github/workflows/threejs-grow-room-visual-acceptance.yml`.

### Acceptance contract
Require on the exact final PR #111 head:
1. `Validate project` success;
2. existing `Three.js visual acceptance` regression success;
3. `Three.js grow room visual acceptance` success;
4. 540x960 and 1080x1920 grow-room captures;
5. empty browser console/page-error evidence;
6. renderer budget: <=65 draw calls, <=35,000 triangles, <=10 material families, 0 authored scene textures, DPR <=1.5, shadows disabled;
7. Vercel success;
8. rendered CENA-style review records exactly **ACCEPT** or **REVISE**.

On **REVISE**, continue only on the grow room. On **ACCEPT**, persist the proven reusable style tokens in `docs/VISUAL-DIRECTION.md` before any later screen inherits them.

Do not merge #111 from stale checks or before visual review.


## 3JS-002 rendered review 1 — REVISE + Revision 1 dispatch — 2026-09-26

### Evidence reviewed
The first rendered review used PR **#111** head `3ffb95d3dee6f01f17f6f9235788bd021099cf5b`. All required automated gates were green and artifact **10912625364** had empty browser console/page-error evidence with 36 draw calls, 2,648 triangles, 9 material families, 0 authored textures, DPR 1 and shadows disabled at both portrait sizes.

Concurrent work then advanced the same branch to `d8b6a07e43efb85fb2772937c11adbf3589f6f78` with portrait camera recentering only. Its fresh grow-room capture was inspected before this revision and confirmed that framing improved while the density/light-hierarchy concerns remained.

### Rendered review result
**REVISE**

The candidate already satisfies the structural direction: fixed orthographic miniature read, chunky low-poly silhouettes, cool/dark envelope, selective warm practical light and foreground/work/background layering.

It is not yet accepted as the definitive cross-screen style because the rendered room still reads too close to a clean blockout relative to the project-owner synthesis, especially around authored clutter/lived-in density, secondary wall story clusters, empty floor/wall rhythm, silhouette separation around dark utility masses and warm focal hierarchy beyond the central bars.

### Revision 1 scope
Revision 1 stays bounded to the grow room and preserves the concurrent `verticalBias` framing change. It does not alter gameplay, economy, persistence, lore, cultivation parameters or the canonical Godot runtime.

Dispatched changes:
- denser generic back-shelf, conduit, wall-card and side-workshop clusters;
- foreground utility-cart, floor-pad and loose-dressing composition;
- readable vent rim and additional small-form silhouette accents;
- warmer material tuning within the same palette family;
- lower flat ambient contribution plus a cool rim separator;
- second restrained warm practical focus at the back work zone;
- 0 authored textures and dynamic shadows still disabled.

### Route
**3JS-RESUME -> 3JS-WATCH**

This revision changes the PR head. Require fresh exact-head validation and a new 540x960 + 1080x1920 rendered review. Do not merge #111 and do not propagate its style tokens until Revision 1 returns **ACCEPT**.


## 3JS-002 Revision 1 acceptance — 2026-09-26

### Rendered decision
**ACCEPT**

The first candidate was correctly classified REVISE. Revision 1 was then reviewed on exact runtime head `d4822fd6b5edc2c6634c22838bbc5ec771422313` using grow-room artifact `10912912460` at 540x960 and 1080x1920.

Accepted evidence:
- `Validate project` #521: **SUCCESS**;
- existing `Three.js visual acceptance` #20: **SUCCESS**;
- `Three.js grow room visual acceptance` #8: **SUCCESS**;
- Vercel preview: **Ready**;
- browser console/page-error artifact: **empty**;
- both portrait sizes: 50 draw calls, 3,236 triangles, 9 material families, 0 authored scene textures, DPR 1, dynamic shadows disabled.

The accepted render preserves the original fixed orthographic miniature while materially improving authored room density, work/storage storytelling, dark-envelope contrast and warm/cool focal separation. The plant/equipment language remains abstract and non-operational.

### Style lock
The proven reusable tokens are now ratified in `docs/VISUAL-DIRECTION.md`. Runtime/presentation status and the grow-room acceptance chrome are updated from CANDIDATE to ACCEPT. Later Three.js scenes may inherit this grammar only through their own bounded specs; this is not permission for a runtime migration or global unspecced redesign.

### Current route
**3JS-WATCH**

The ACCEPT persistence itself changes PR #111 beyond the reviewed runtime head. Therefore the historical green evidence above proves the visual decision, but it is stale for delivery merge safety.

### Final delivery gate
1. use the exact PR #111 head produced by this handoff persistence;
2. require fresh `Validate project`, existing `Three.js visual acceptance`, `Three.js grow room visual acceptance` and any repository-required visual gate on that exact head;
3. require Vercel Ready/success on that exact head;
4. confirm PR #111 is still open, mergeable and based on the current `master` ancestry;
5. guarded-merge with expected-head protection only when all required evidence is green;
6. verify the resulting default-branch merge commit and persist delivery closure before advancing to another scene.


## 3JS-002 delivery closure — 2026-09-26

### Final guarded delivery
PR **#111** final exact head:

`04909078f07241cc3f509f2d950f25597d883e6a`

Final-head gates:
- Validate project **#528**: **SUCCESS**;
- Three.js visual acceptance **#27**: **SUCCESS**;
- Three.js grow room visual acceptance **#15**: **SUCCESS** with `styleStatus=ACCEPT`;
- Visual acceptance capture **#149**: **SUCCESS**;
- Vercel: **SUCCESS**;
- PR mergeability: **true**.

PR #111 was merged with expected-head protection.
Merge commit:

`060f265ce860247996ca43663b63e50a5048c757`

Post-merge reconciliation:
- live `master` resolved exactly to the merge commit above;
- post-merge `Validate project` run **36263269964: SUCCESS**;
- Vercel on the merge commit: **SUCCESS**;
- no open PR remained at the initial post-merge reconciliation.

### Delivered style lock
3JS-002 is delivered with **ACCEPT** status. The grow room is the definitive reusable Three.js visual baseline recorded in `docs/VISUAL-DIRECTION.md`, while Godot remains the canonical runtime.

The accepted implementation preserves:
- original/procedural runtime geometry;
- reference-only treatment of the five project-owner images;
- fixed orthographic miniature/cutaway language;
- explicit camera/material/lighting/scale tokens;
- abstract, non-operational plant/equipment depiction;
- Web/mobile budget discipline and explicit lifecycle disposal.

### Final route
**3JS-ADVANCE**

3JS-002 has no unresolved implementation, visual, CI, provider or merge gate. A future standalone `3js` invocation must reconcile live repository state first and select the next bounded scene/spec from current product priorities. Do not reopen the grow-room style lock unless new rendered evidence shows a regression.


## 3JS-003 Market implementation candidate — 2026-09-26

### Reconciliation / classification
- Repository verified: `az1nn/growing-rio`.
- Default branch at work claim: `master@bd4ef780649ee48fca91e2147872e06b3f1586d1`.
- 3JS-002 Grow Room remains delivered with visual status **ACCEPT**.
- CENA-020 Market visual target remains PR **#114** at exact head `8fb5760c7154af22f26038fb99419f85d2ed9001`.
- #114 internal repository/visual checks are green; Vercel reports explicit build-rate limiting, classified `SOFT_GATE_RATE_LIMIT`.
- Per SIGA stacking rules, 3JS-003 is based directly on #114 rather than waiting on provider quota.

### Active wave
- Spec: `specs/3js-003-market-style-continuity/`.
- Branch: `feat/3js-003-market`.
- Intended PR base: `feat/cena-020-market-visual-target`.
- Runtime package: `threejs/market/`.
- Three.js: exact `0.186.1`.
- Runtime geometry/assets: repository-authored procedural primitives only.

### Candidate implementation
- fixed orthographic miniature inherited from the accepted Grow Room grammar;
- foreground deal counter;
- mid-ground vendor/storage bay with instanced abstract crates;
- background loading/shutter plus roof/aisle rhythm;
- one trolley silhouette;
- cool industrial ambient/key/rim with restrained warm practicals;
- no dynamic shadows or authored textures;
- immutable presentation-only placements;
- explicit lifecycle disposal and deterministic resize;
- no gameplay/economy/persistence/canon mutation;
- no real-world routing, concealment, distribution or market-operating detail.

### Evidence contract
- <=60 draw calls;
- <=22,000 triangles;
- <=9 material families;
- 0 authored textures;
- DPR <=1.5;
- 540x960 + 1080x1920 exact-head captures;
- empty browser console/page-error evidence.

### Current route
**3JS-WATCH**

Implementation and Spec Kit are persisted. Require exact-head `Validate project` plus `Three.js market visual acceptance`, then route the rendered artifact to CENA for exactly `ACCEPT` or `REVISE`.

Do not merge on automated green alone: 3JS-003 remains **CANDIDATE** until CENA rendered review is recorded, and parent CENA-020 still carries inherited provider-rate-limit delivery debt.


## 3JS-003 rendered acceptance — 2026-09-26

### Exact implementation evidence
Accepted implementation head: `eb19bae48edbd5698ac09872e718dea9932cf810`.

Exact-head checks:
- `Validate project` run `36267671834`: **SUCCESS**;
- `Three.js market visual acceptance` run `36267671810`: **SUCCESS**;
- rendered artifact: `10914735544`;
- browser console/page-error artifact: **empty**;
- 540x960 and 1080x1920: 36 draw calls, 944 triangles, 8 material families, 0 authored scene textures, DPR 1, dynamic shadows disabled.

### CENA decision
**ACCEPT**.

Rendered inspection confirms that Mercado reads through the deal counter, vendor/storage bay, aisle/roof rhythm, loading shutter and trolley without real-world signage; Grow Room camera/material/lighting continuity remains recognizable without cloning its layout; portrait hierarchy and quiet UI reserve are preserved; and no obvious clipping, z-fighting or operational logistics detail is present.

### Current route
**3JS-WATCH**

This ACCEPT persistence changes PR #116 beyond the accepted runtime head, so the evidence above is historical visual-decision evidence rather than final delivery evidence. Require fresh exact-head repository + Market capture validation on the resulting head.

PR #116 remains stacked on CENA-020 PR #114. Parent Vercel remains explicit `SOFT_GATE_RATE_LIMIT`; do not merge #116 ahead of its dependency or without final exact-head gates.


## 3JS-003 delivery closure — 2026-09-26

### Delivered default-branch state
- CENA decision: **ACCEPT**.
- Original stacked runtime PR **#116** passed its final exact-head repository, Three.js Market, Three.js regression, repository visual-capture and Vercel gates.
- Delivery anomaly discovered by SIGA: #116 had been merged into its stacked base branch after #114 was already merged into `master`, so its runtime delta was not yet present on the default branch.
- Recovery PR **#118 — feat(3js): deliver accepted Market scene to master** re-exposed exactly that accepted delta against `master`.
- #118 exact head `f63594b494b1640e9bd5c508e7b4be05bb8018c1` passed: Validate project, Three.js visual acceptance, Three.js grow room visual acceptance, Three.js market visual acceptance, Visual acceptance capture and Vercel.
- #118 merged with expected-head protection as `7f5c1d890f82296f9ea4ceab771a7154253b5a9f`.
- Post-merge Validate project run `36270971536`: **SUCCESS**.
- Post-merge Vercel on the merge commit is currently explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`; this is public-delivery proof debt, not a repository/runtime regression.

### Final route
**3JS-ADVANCE** for implementation scope. 3JS-003 is present on `master` and internally validated. Do not reopen Mercado without new regression evidence. Public post-merge parity must be rechecked when Vercel capacity returns.


## 3JS-004 City implementation candidate — 2026-09-27

### Reconciliation / classification
- Repository verified: `az1nn/growing-rio`.
- CENA-021 visual contract head `92a7e07f553244ea8643a420310469555ab3efe0` passed repository, visual-capture and Vercel gates.
- PR #120 merged to `master` as `473cef46e4dd9926c1033318b7ad97cc05c68c41`.
- `feat/3js-004-city` was created from the exact CENA-021 contract head and was subsequently reconciled with delivered `master` through a normal non-force merge.
- Grow Room remains the accepted style lock; Mercado remains delivered.

### Active wave
- Spec: `specs/3js-004-city-topographic-continuity/`.
- Branch: `feat/3js-004-city`.
- Intended PR base: `master`.
- Runtime package: `threejs/city/`.
- Three.js: exact `0.186.1`.
- Runtime assets: repository-authored procedural geometry only.
- Visual status: **CANDIDATE** pending CENA rendered review.

### Candidate implementation
- fixed orthographic portrait miniature;
- foreground overlook / retaining edge;
- three stepped elevation bands;
- instanced fictional low-rise clusters;
- restrained background skyline silhouettes;
- vegetation breaks and non-map district separation;
- cool structural ambient/key/rim with one restrained warm practical cluster;
- inherited concrete / plaster / teal / dark metal / wood / terracotta vocabulary;
- deliberate quiet/dark UI reserve;
- zero authored textures and dynamic shadows disabled;
- immutable presentation-only placements;
- deterministic resize, on-demand rendering, explicit disposal;
- no gameplay/domain/save-schema mutation;
- no real map, road, route, address, district geometry, political institution or civic guidance.

### Evidence contract
- `Validate project` must succeed on the exact PR head;
- `Three.js city visual acceptance` must succeed on that same head;
- 540x960 and 1080x1920 captures;
- empty browser console/page-error evidence;
- <=60 draw calls;
- <=22,000 triangles;
- <=9 material families;
- 0 authored textures;
- DPR <=1.5;
- dynamic shadows disabled.

### Current route
**3JS-WATCH**

The implementation candidate and exact-head capture workflow are persisted. Automated green is necessary but not sufficient: rendered evidence must return to CENA for exactly **ACCEPT** or **REVISE** before delivery.


## 3JS-004 CENA review — Revision 1 required — 2026-09-27

### First-candidate evidence
- exact head reviewed: `6d44fd5470d326c026d999832fcb0c99916e50c3`;
- Validate project #564: **SUCCESS**;
- Three.js City capture workflow #2: **SUCCESS**;
- artifact: `10928517376`;
- both portrait sizes: 23 draw calls, 708 triangles, 8 material families, 0 authored textures, DPR 1, shadows disabled;
- browser console/page-error evidence: empty.

### CENA decision
**REVISE**

The city massing, stepped terraces, skyline and warm/cool continuity read correctly, but `QuietZoneFrame` renders as a large near-black vertical slab on the left. It reads as an occluding wall rather than a quiet UI reserve and weakens the topographic-city silhouette.

### Revision 1
Replace the tall quiet-zone slab with a low edge marker only. Preserve camera, massing, lighting, materials, budget and all gameplay/safety boundaries.

Because Revision 1 changes the PR head, the first-candidate green evidence is historical. Require fresh exact-head Validate + City capture and then return the new render to CENA.


## 3JS-004 Revision 1 acceptance — 2026-09-27

### Exact rendered evidence
- reviewed runtime head: `7f25b29cee5f57e99526ef63cd1e9d47e923bd98`;
- Validate project #566: **SUCCESS**;
- Three.js city visual acceptance #4: **SUCCESS**;
- artifact: `10928746311`;
- 540x960 + 1080x1920 both render the revised composition;
- renderer evidence at both sizes: 23 draw calls, 708 triangles, 8 material families, 0 authored textures, DPR 1, shadows disabled;
- browser console/page-error artifact: empty.

### CENA decision
**ACCEPT**

Revision 1 removes the blocking frame-left slab while preserving the accepted orthographic grammar, stepped terrain, fictional urban massing, vegetation breaks, restrained skyline and quiet UI reserve. No new visual defect was identified in the target captures.

### Style status
The City presentation is promoted from `CANDIDATE` to `ACCEPT`. The acceptance persistence changes the PR head, so the rendered evidence above proves the visual decision but is stale for merge safety.

### Final delivery gate
Require fresh exact-head Validate project, all applicable Three.js visual workflows, repository Visual acceptance capture and Vercel success on the final acceptance head. Then guarded-merge PR #121 with expected-head protection and verify `master`.

## 3JS-004 delivery reconciliation — City merged — 2026-09-27

### Verified live evidence
- PR #121 `feat(3js): add City topographic visual candidate` is merged.
- Final PR head: `a65d6f22cdd1834e9fc029ec1361ded914d57423`.
- Guarded delivery merge commit: `673da3f0158061537fb633a5e64fee77ae02036d`.
- Exact final PR-head workflows were all **SUCCESS**: Validate project, Three.js visual acceptance, Three.js grow room visual acceptance, Three.js market visual acceptance, Three.js city visual acceptance and Visual acceptance capture.
- Vercel status on the merge commit is **SUCCESS**.
- Current default branch `master@2cf90ce4d99198575212f1e42706eb2e8b694370` still contains `threejs/city/`, proving the delivered City implementation remains in default-branch ancestry.
- Current default-branch Vercel is provider-throttled (`SOFT_GATE_RATE_LIMIT`) because of later unrelated work; this does not reopen the accepted City runtime.

### Classification
**3JS-RESUME → closure reconciliation**

The runtime/visual scope of 3JS-004 is complete. The remaining debt is repository bookkeeping: issue #122 was left open and `docs/SIGA-HANDOFF.md` is concurrently owned by PRs #132/#133.

### Concurrency decision
- PR #134 owns only this 3JS/CENA closure persistence.
- PRs #132/#133 are **PARALLEL_SAFE** for runtime semantics but both touch `docs/SIGA-HANDOFF.md`.
- Therefore PR #134 intentionally does **not** mutate `docs/SIGA-HANDOFF.md`; issue #122 stays open until SIGA can reconcile that same-path handoff without discarding newer Feature 009 facts.

### Next action
Validate PR #134 on its exact head. When its applicable gates are green, merge it. Then SIGA should append the City closure fact to the latest `docs/SIGA-HANDOFF.md`, verify the live provider state under repository policy, and close issue #122. Do not reopen City implementation unless new regression evidence appears.



## 3JS-005 — Institutional continuity candidate — 2026-09-28

### Reconciliation / ownership
- repository: `az1nn/growing-rio`;
- base at claim: `master@a8d1c3efae578e1325cd69783108a4f0aa5747b9`;
- owner PR: **#148** / `feat/3js-005-institutional`;
- task key: `3JS-005`;
- post-claim barrier: **CLEAR / PARALLEL_SAFE**;
- Feature 009 PRs #137→#147 remain disjoint for runtime semantics; their shared `docs/SIGA-HANDOFF.md` ownership is respected by excluding that path.

### Product / CENA route
RB-01 orders top-level surfaces as Operação → Mercado → Cidade → Institucional → Arquivo/Pesquisa. With Operation, Market and City already delivered in Three.js, Institucional is the next bounded presentation gap. CENA-022 defines the target; 3JS owns renderer implementation.

### Candidate implementation
- isolated package: `threejs/institutional/`;
- exact `three@0.186.1`;
- fixed orthographic portrait miniature;
- public threshold / waiting bench;
- generic participation desk;
- three proposal pedestals implemented as one equal instanced geometry/material family;
- archive/storage rhythm and abstract process rails;
- symmetric warm practicals plus cool structural ambient/key/rim;
- repository-authored procedural geometry only;
- immutable presentation model;
- deterministic resize, on-demand render and explicit disposal;
- zero authored textures;
- dynamic shadows disabled;
- no gameplay/domain/save-schema/canon mutation.

### Neutrality / political boundary
The scene contains no real institution, government body, party, election, ballot, law, politician, flag, seal, map, advocacy or targeted persuasion. The three proposal placeholders have equal scale/material/lighting and contain no policy semantics, recommendation, ranking or preferred outcome.

### Evidence contract
- dedicated validator: `tools/validate_institutional_threejs.py`;
- dedicated workflow: `.github/workflows/threejs-institutional-visual-acceptance.yml`;
- 540x960 + 1080x1920 exact-head captures;
- empty browser console/page-error evidence;
- <=60 draw calls;
- <=20,000 triangles;
- <=9 material families;
- 0 authored textures;
- DPR <=1.5;
- dynamic shadows disabled;
- proposal count exactly 3 with candidate visual status.

### Route
**3JS-WATCH**

The implementation is dispatched but remains **CANDIDATE**. Automated green is necessary but not sufficient. Inspect exact-head rendered evidence and return it to CENA for exactly **ACCEPT** or **REVISE** before delivery. Do not merge #148 from source/CI alone.
