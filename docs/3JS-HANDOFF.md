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


## 3JS-003 — Market diorama style-propagation specification — 2026-09-26

### Verified live state at claim
- repository: `az1nn/growing-rio`;
- default branch: `master@bd4ef780649ee48fca91e2147872e06b3f1586d1`;
- PR #112 is merged and the 3JS-002 Grow Room delivery closure is present on master;
- exact master `Validate project` run **#532 / 36263655679: SUCCESS**;
- 3JS-002 definitive visual status remains **ACCEPT**;
- no open PR existed when the 3JS-003 work claim was created;
- specification branch: `spec/3js-003-market-diorama-propagation`;
- specification PR: **#113**;
- pre-handoff PR head: `0e916e3049b17523dce0069b7bb5c99fd6f143e4`.

### Route
**3JS-ADVANCE -> 3JS-WATCH**

The Grow Room is verifiably closed, so the next bounded scene is specified instead of reopening 3JS-002. Mercado is selected because the canonical Product Experience Map places it immediately after Operação and RB-05 already exposes its selling/contract/buyer-relationship gameplay without requiring new domain behavior.

This handoff persistence changes PR #113 beyond the pre-handoff head above, so any earlier check result is stale for delivery safety.

### Active package
- spec: `specs/3js-003-market-diorama-propagation/`;
- future implementation target: `threejs/market-diorama/`;
- visual authority: the definitive 3JS-002 tokens in `docs/VISUAL-DIRECTION.md`;
- canonical runtime: Godot;
- Three.js remains contextual, read-only presentation.

### Boundaries
- one scene only: Mercado;
- no gameplay, economy, persistence, navigation or canon mutation;
- Mercado must remain complete when 3D is absent/disabled;
- market depiction stays fictional, abstract and non-operational;
- no real-world sourcing, trafficking, concealment, evasion, route or logistics guidance;
- repository-authored procedural geometry/materials are the default;
- no global style token changes without explicit CENA-style review.

### Delivery gate for PR #113
Require fresh exact-head repository-required checks on the final PR head and any provider/deployment status that repository policy requires for this PR. Merge only from the current expected head after re-reading master, PR mergeability and overlap.

### Next action
After guarded delivery of #113, reconcile live master again and implement 3JS-003 on a dedicated implementation branch. The implementation must capture 540x960 and 1080x1920, preserve Grow Room regression behavior, prove Mercado remains usable without 3D and obtain rendered ACCEPT/REVISE evidence before delivery.
