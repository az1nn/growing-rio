# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Truth order: live repository / CI > constitution > active spec/plan/tasks > this handoff > chat/model memory.

## Current route
**WATCH — Feature 009 is delivered through guarded merge PR #147 at `master@589e76b693b93f53b5882a661d83e8cb4c16c5b3`. PR #151 is the documentation-only T021 closeout persistence. Parallel sessions #148 (3JS-005 Institutional continuity) and #150 (LORE handoff reconciliation) remain open and disjoint. After #151 delivery, SIGA must resume the oldest still-valid bounded session from live evidence rather than reopen Feature 009.**

## Live reconciliation — 2026-09-24
- Default branch remains `master@468401729addaf9faece48cb250a6a773e089a24`.
- RB-09 PR #79: repository/visual green; Vercel rate-limited.
- RB-10 PR #81: repository/visual green; Vercel rate-limited.
- RB-11 PR #83 at `91fa0903a5e7c3ad0b65151abee0a34c4c01f349`: Validate #395 + Visual #39 green; Vercel rate-limited.
- CENA-008/#78, CENA-009/#80 and CENA-010/#82 remain repository/visual green with the same provider rate-limit classification.
- RB-12 PR #85 targets `feat/cena-010-window-pane-rhythm` and is mergeable against that stack base.
- Initial persisted RB-12 head `f2e1f3567b3c12af59b9b07e7da71fd48a0b66d7`: Visual #42 **SUCCESS**; Validate #398 **FAILURE** only in the new Diorama scene system regression.
- Validate #398 proved static validation, Godot import, Game shell navigation and Operation surface regressions before the RB-12 test all passed.
- Failure cause: the test/host attempted to enforce child `SubViewport.size` while the CENA scene already uses `SubViewportContainer.stretch = true`; Godot owns child viewport sizing in that configuration.
- Repair: resource fallback now uses the container-native `stretch_shrink` contract: `1` normally, `2` for low-resource rendering.
- Corrected pre-handoff head: `409d25fe0b8477e2a225b55d219d26a27a713930`.
- No force update was used.

## Active — RB-12 Diorama Scene System
- Spec: `specs/rb-12-diorama-scene-system/`.
- Branch: `feat/rb-12-diorama-scene-system`.
- PR: **#85 — `feat(rb-12): add contextual diorama scene system`**.
- Immediate base: CENA-010 / PR #82 at `b902cd730480cdfdac076b47a4294ebf0cc71570`.
- `ContextualSceneHost` owns presentation-only mount/unmount, stable visual context identity, deterministic replace transitions and resource profile.
- Existing `OperationDiorama` is the first registered module; CENA retains ownership of authored geometry, camera and lighting.
- Empty context is valid, proving 3D is optional for product surfaces.
- Normal render profile: `SubViewportContainer.stretch_shrink = 1`.
- Low-resource render profile: `stretch_shrink = 2`, reducing effective render resolution while preserving presentation size.
- UI retains input ownership: host uses mouse-ignore and the nested viewport keeps GUI/local input disabled.
- Scene lifecycle calls no GameState/domain command, advances no simulation and consumes no gameplay RNG.
- `tests/diorama_scene_system_test.gd` verifies mount/remount/unmount, optional context, input ownership, render profile and full canonical save-snapshot invariance.
- `.github/workflows/validate.yml` executes that regression for exact pull-request heads.
- Save schema remains v11; no persistence shape changes.

## Spec Kit task state
- T001-T009: complete.
- T010: open for the final live drift/overlap barrier immediately before merge.
- T011: open until the final persisted PR head receives fresh Validate project + applicable visual evidence.
- T012: complete.
- T013: open; guarded merge/post-merge closure requires full provider proof.

## Concurrency classification
- CENA operation diorama + structural validator overlap: **RECONCILED** by stacking directly on #82.
- RB-09 GameState work: **PARALLEL_SAFE**; RB-12 does not touch `autoload/game_state.gd`.
- RB-10/RB-11 canonical shell work: **PARALLEL_SAFE**; RB-12 changes the staged Main visual mount, host/test/validator/CI/docs and does not edit `game_shell.*`.
- Provider state: **SOFT_GATE_RATE_LIMIT** — merge-deferred, development-non-blocking.

## Next engineering action
1. Read PR #85's exact head produced by this handoff persistence.
2. Require `Validate project` and `Visual acceptance capture` success for that exact head.
3. If either repository/visual gate fails, classify **RESUME** and repair only the concrete RB-12 defect.
4. If both succeed while Vercel remains rate-limited, keep #85 open/merge-deferred and classify safe development **ADVANCE**.
5. RB-13 — Visual Production Pass must reconcile with the active CENA stream before mutation; do not fork stale visual assets.
6. When provider capacity returns, validate and merge unresolved dependency stacks bottom-up with exact-head guards and rerun downstream gates invalidated by base transitions.
7. Finale expansion remains frozen until RB-14 explicitly records PASS/unfreeze.

## Persistent boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic.
- No real politicians, parties, elections or targeted persuasion are modeled.
- No faction, institutional form or ending is treated as morally correct or preferred.
- Real-history inspiration remains distinguishable from fictional canon.
- Chat/model memory is not canonical project state.


## SIGA reconciliation — RB-12 + CENA-011 — 2026-09-24

### Verified transition
- RB-12 PR #85 exact head `37dc3250af839ea35620f15fb51f2d348a52bcfc` passed Validate project #402 and Visual acceptance #46.
- Vercel on RB-12 remains explicit `SOFT_GATE_RATE_LIMIT`; therefore RB-12 is internally green but merge-deferred.
- CENA-011 PR #84 was a sibling of RB-12 on CENA-010 and overlaps the visual/validator contract.
- Concurrency classification: **COLLISION -> RECONCILED** by preserving both semantic deltas and rebuilding CENA-011 as a child of RB-12.
- New dependency order: `#82 -> #85 (RB-12) -> #84 (CENA-011)`.
- No force update is used.

### Current route
**WATCH — require fresh exact-head Validate project + Visual acceptance capture on the reconciled CENA-011 head.**

If both succeed, the visual ancestry is safe to classify ADVANCE and RB-13 may begin from the reconciled visual/product base. If either fails, RESUME only the concrete integration defect. Provider quota on the parent remains delivery debt and must not be misreported as an internal failure.


## RB-13 resume — 2026-09-24

### Verified route
**WATCH — RB-13 implementation is persisted; require fresh exact-head Validate project + Visual acceptance capture on the final handoff head.**

### Reconciled ancestry
- RB-12 PR #85 exact head `37dc3250af839ea35620f15fb51f2d348a52bcfc` is repository/visual green; Vercel is explicit `SOFT_GATE_RATE_LIMIT`.
- CENA-011 PR #84 is the direct visual parent of RB-13.
- RB-13 PR #86 targets `feat/cena-011-planter-rim-rhythm`; no force update is used.
- Pre-handoff RB-13 implementation head: `258fd75fea0452710513ba156ff411ddbfedd89c`.

### Implemented RB-13 slice
- T004 visual debt audit: complete.
- T005 shared DA LATA visual system: complete via `resources/ui/dalata_theme.tres`, applied at GameShell and standalone Main.
- T007 responsive/readability/focus slice: complete in source:
  - portrait navigation is a three-column wrapped grid;
  - global status is 3 columns portrait / 5 columns wide;
  - action targets retain 64px minimum height;
  - shared focus styling remains visible without relying on color alone;
  - no motion delay was added to critical navigation;
  - SurfaceHost minimum height is reduced to preserve the 540x960 portrait budget.
- `tests/visual_production_pass_test.gd` verifies theme application, portrait/wide layout contracts, target sizing and canonical save/RNG invariance.
- exact-head CI runs the RB-13 regression.

### Boundaries / concurrency
- No GameState/domain, persistence schema, RNG, navigation destination or canon change.
- No external runtime asset or license dependency is added.
- No new RB-13 OperationDiorama edit is introduced beyond inherited CENA-011 ancestry.
- T006 remains evidence-gated: inherited production-candidate OperationDiorama families are not marked complete until the RB-13 rendered head is accepted.
- T008/T009 remain evidence/documentation-gated.
- T010-T013 remain open for final drift check, exact-head evidence, closure docs and guarded delivery.
- Vercel build-rate-limit remains delivery debt only; it does not lock bounded development.

### Next engineering action
1. Read PR #86 exact head after this handoff persistence.
2. Require Validate project and Visual acceptance capture on that exact head.
3. If either fails, classify RESUME and repair only the concrete RB-13 defect.
4. If both succeed, close T006/T008/T009 from rendered/provenance/performance evidence where justified, then run T010/T012 against live drift.
5. Keep guarded merge deferred while the required provider gate is the explicit Vercel rate limit.


## RB-13 evidence closure — 2026-09-24

### Accepted exact-head evidence
- PR #86 head `c8d1315426ba806995455fe3be707bf8bea1b4e9`.
- Validate project **#412: SUCCESS**.
- Visual acceptance capture **#56: SUCCESS**.
- Visual workflow evidence includes exact-head checkout, Godot Web export, Playwright capture and uploaded rendered artifact.
- Vercel remains the explicit build-rate-limit status, therefore `SOFT_GATE_RATE_LIMIT`.

### Task closure from evidence
- T006: complete by accepting the inherited CENA 002-011 OperationDiorama production-candidate families on the RB-13 rendered head; no redundant geometry churn is required.
- T008: complete; this RB adds only repository-authored Theme/layout resources, no external runtime asset/license dependency and no additional 3D cost. RB-12 low-resource fallback remains unchanged.
- T009: complete; remaining visual debt and intentional placeholders are documented in Visual Direction.
- T012: complete through Architecture/Roadmap/Handoff reconciliation.
- T010 stays open for the final live drift barrier immediately before guarded merge.
- T011 must be rerun against the new post-documentation head created by this persistence batch.
- T013 remains blocked only by required guarded-delivery proof; explicit provider rate limiting is not an internal failure.

### Route after this persistence
**WATCH for exact-head repository/visual evidence on the new documentation head.** If both pass, RB-13 is internally complete and merge-deferred only by the provider soft gate. Do not start RB-14 until RB-13 material completion is preserved and the RB-14 entry reconciliation confirms dependency state.

## RB-15 Resume Finale — implementation handoff — 2026-09-24

### Reconciliation / classification
- Repository verified: `az1nn/growing-rio`.
- Live default branch observed before RB-15 mutation: `master@adefc9dae62d0d29024485584d241d032075a67e`.
- RB-14 PR #88 exact head at branch creation: `b483aa855b910deba5cd49e39ae70c50cea22b1a`.
- RB-14 had recorded campaign revalidation **PASS**, so RB-15 was explicitly unfrozen.
- Vercel continues to report `upgradeToPro=build-rate-limit`; repository policy classifies this as `SOFT_GATE_RATE_LIMIT`: merge-deferred, development-non-blocking.
- SIGA route: **ADVANCE -> RB-15**, now **WATCH** for exact-head delivery evidence.

### Branch / PR
- Branch: `feat/rb-15-resume-finale`.
- PR: **#89 — feat(rb-15): complete resume finale flow**.
- Base: `feat/rb-14-campaign-progression-revalidation` / PR #88.
- No force update was used.
- A concurrent `github-actions[bot]` Web-export commit advanced the branch once; a stale fast-forward write was rejected, then reconciled on the live head.

### Implemented contract
- No ending-family addition and no eligibility-rule rewrite.
- Eligible endings are presented neutrally in alphabetical display-name order; ineligible endings are not selectable in normal UX.
- Immutable selection still delegates to the existing ending selection boundary through GameState.
- Six `EndingPresentationDefinition` Resources contain data-driven handoff/coda copy and canon guardrails.
- `GameState.complete_finale()` completes `arc_da_lata` exactly once using existing `completed_arc_ids`; repeated calls are no-ops.
- Save schema remains **v11**; no duplicate finale-completion field exists.
- Continue/Load restores selection + completion without replaying completion.
- Post-ending shell remains navigable; Campaign exposes read-only `Rever desfecho`.
- Shell mutations stay behind `CampaignFlowController`.

### Evidence before this documentation persistence
- Implementation head: `f48f08620e4e27c12def360c394626a8c638a44f`.
- Validate project **#427: SUCCESS**.
- Visual acceptance at documentation cut: **completed/success (#69)**.
- Initial Validate #425 failed only in the new test because three dynamic values used inferred typing; the product imported and all 32 preceding regressions passed. Explicit types fixed the test, then #427 passed.
- Vercel remains explicit `SOFT_GATE_RATE_LIMIT`, not an internal regression.

### Task state
- T001-T010: complete.
- T011: open until exact post-documentation head receives fresh Validate + Visual evidence.
- T012: complete by this persistence.
- T013: open; guarded merge/post-merge closure remains provider-gated and dependency-ordered.

### Dependency / merge order
- Current bounded chain: `#82 -> #85 -> #84 -> #86 -> #88 -> #89`.
- Do not merge #89 ahead of unresolved ancestors. When provider capacity returns, re-read every live head/base and merge bottom-up only with exact-head required checks green.

### Next SIGA action
1. Read PR #89 exact head after this documentation commit.
2. Require fresh exact-head Validate project + Visual acceptance.
3. Internal failure => **RESUME** only the concrete defect.
4. Both internal gates green while Vercel is rate-limited => **WATCH / internally complete, merge-deferred**.
5. Provider capacity restored => guarded bottom-up reconciliation/merge; never bypass dependency or exact-head checks.


## SIGA reconciliation — product re-baseline closure — 2026-09-25

### Verified live state
- Repository identity: `az1nn/growing-rio`.
- Default branch before this documentation wave: `master@dbeacdf09abb76db5e4800c82109750ca9189223`.
- Open PR scan before mutation: **none**.
- PR #93 / CENA Wave 014 delivery closure merged at `dbeacdf09abb76db5e4800c82109750ca9189223`.
- Post-merge Validate on that exact master head: **SUCCESS**.
- Vercel on that exact master head: **SUCCESS**.
- CENA Wave 014 handoff route is **CENA-ADVANCE** with no unresolved Wave 014 gate.

### Product stack closure
Verified merged PRs:
- RB-09: #79.
- RB-10: #81.
- RB-11: #83.
- RB-12: #85.
- RB-13: #86.
- RB-14: #88.
- RB-15: #89.

RB-15 final PR head `3e764849bbb81ea9dbe9a0c8b0f40219f2456b40` passed exact-head Validate and Visual acceptance. Current master is 92 commits ahead of that head with zero commits behind, so the finale delivery is preserved in the default-branch ancestry.

### Route
**WATCH -> ADVANCE after guarded merge of PR #94**

The re-baseline backlog is materially complete, but this documentation reconciliation must itself pass exact-head gates and merge before the repository handoff is canonical. After that closure there is no documented post-RB-15 product feature to implement automatically. Do not invent a new capability from chat context.

Next SIGA:
1. reconcile current master/open PRs/checks;
2. if a new bounded product spec exists, advance into that spec;
3. if no new spec exists, keep **ADVANCE** and treat specification/roadmap selection as the next engineering boundary;
4. for visual-only continuation, route through repository-local CENA rather than silently converting SIGA into an art wave.

### Persistence update
This reconciliation closes stale roadmap/RB-15 documentation only. It changes no runtime, scene, gameplay, persistence schema, asset, test, CI or deployment behavior.


## SIGA operational closure — post-RB-15 / CENA-015 Web delivery — 2026-09-25

### Verified live state
- Repository identity: `az1nn/growing-rio`.
- Default branch at reconciliation: `master@4b131fcc65ce4f47bd7bbcf90e49b05f4f87189d`.
- Open PR scan: **none**.
- PR #94 (`docs(siga): close RB-15 re-baseline delivery`) is merged; post-merge Validate project **#459: SUCCESS** on `2c036ece78abc0b4b1ab06026b0fc3e3c9b11186`.
- PR #95 (`feat(cena): lighten feedback overlays`) is merged at `17805a5e10ee7883a4670e89dc4c300952d9aac8`.
- Post-merge Validate project **#460: SUCCESS** on the PR #95 merge commit.
- Export Godot Web **#164: SUCCESS** on the PR #95 merge commit.
- The export workflow refreshed the generated Web build at `4b131fcc65ce4f47bd7bbcf90e49b05f4f87189d`.
- Vercel status on the current generated Web-build head is **SUCCESS**.
- RB-01 through RB-15 remain delivered on the reconciled default branch.
- No post-RB-15 product capability is specified in the current roadmap.

### Route
**ADVANCE — specification / roadmap selection boundary.**

The prior WATCH gate is closed. There is no unfinished product delivery and no active CI/deployment gate to wait on. SIGA must not invent a new product capability merely to keep moving.

### Next SIGA action
1. Reconcile live `master`, open PRs and current checks.
2. If a new bounded Spec Kit package exists, advance into that package.
3. If no bounded product spec exists, remain at the specification boundary with zero runtime mutation.
4. Visual-only continuation must route through repository-local CENA rather than silently becoming a SIGA product wave.

### Scope of this persistence
Documentation reconciliation only. No runtime, gameplay, scene, asset, persistence-schema, test, CI or deployment behavior is changed.


## SIGA concurrency reconciliation — CENA 016/017 overlap — 2026-09-25

### Live repository state
- Repository identity: `az1nn/growing-rio`.
- Default branch at the write barrier: `master@4b131fcc65ce4f47bd7bbcf90e49b05f4f87189d`.
- SIGA persistence PR: **#96**, branch `docs/siga-post-rb15-operational-closure`.
- CENA Wave 016: **#97** at `02d6f2642a372a1ab1fed8051d45eb0d959d1347`; Validate project **#463 SUCCESS** and Visual acceptance **#96 SUCCESS**; Vercel is explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`.
- Canonical CENA Wave 017: **#98** at `a0a22b0c3cbab7abd08ffb966042c73bfd173c02`; Validate project **#464 SUCCESS** and Visual acceptance **#97 SUCCESS**; browser-console artifact is empty; Vercel is explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`.
- Competing CENA Wave 017 PR **#99** modified the same diorama/test/validator/visual-doc contract. Its exact-head repository/rendered checks also passed, but artifact comparison against the documented acceptance criterion showed less reduction of the residual lower near-black band than #98 with no compensating acceptance advantage. Classification: **SUPERSEDED**. PR #99 was closed unmerged.

### Concurrency result
- #97 -> #98 remains the only active visual dependency chain.
- #96 is documentation-only and parallel-safe with the CENA runtime/visual paths, but this handoff write changes #96's head and therefore makes its earlier exact-head CI evidence stale.
- Do not merge #97 or #98 while required Vercel provider proof is unavailable.
- Do not reopen or merge #99 as a second Wave 017 implementation unless new repository evidence explicitly supersedes this reconciliation.
- Any later default-branch advancement must be reconciled into the CENA chain before guarded delivery merge, followed by fresh exact-head validation.

### SIGA route
**WATCH** until the updated #96 exact head passes the repository-required gates and is merged with an expected-head guard.

After #96 merge:
- product route: **ADVANCE — specification / roadmap selection boundary**;
- visual route remains owned by repository-local CENA;
- no new product capability should be invented without a bounded Spec Kit package.


## SIGA reconciliation — live-master recovery — 2026-09-26

### Verified live state
- Repository identity: `az1nn/growing-rio`.
- Default branch at reconciliation: `master@1fb34cc0d4e98d83394f3d39b94e547079b25cc7`.
- That default-branch head is the merge of PR #108, which closes the documented 3JS-001 delivery after PR #107 was guarded-merged and post-merge validated.
- Open PR scan at the write barrier: **only PR #106**.
- PR #106's previous head `7bd179fa20e8aa296deff44d070192bf78dff9f3` was based on stale `master@851bd50de53540af84dd9e651aebc7b70201c55b` and became non-mergeable after later delivery merges.
- The #106 branch was therefore reconciled to the exact current master before this fresh persistence. The stale reconciliation commit is not treated as valid delivery evidence.

### Current ownership / route
- Product RB-01 through RB-15 remains delivered.
- There is no bounded post-RB-15 SIGA product capability selected by repository state.
- 3JS-001 is delivered; further standalone `3js` work must reconcile live state and select a bounded renderer/visual need rather than infer a migration.
- With no other open pull requests at this barrier, there is no active cross-PR dependency stack to merge ahead of #106.
- SIGA product route after #106 delivery remains **ADVANCE — specification / roadmap selection boundary**.

### Delivery rule for PR #106
This documentation-only reconciliation must receive fresh required checks on its new exact head after this persistence. Merge only if:
1. PR #106 remains open and mergeable against the then-current `master`;
2. required repository Actions checks are successful on the exact head;
3. required provider/Vercel status is successful on the exact head;
4. no newer default-branch advancement invalidates the evidence.

After guarded merge, verify the resulting default-branch commit and stop at the specification boundary unless repository state contains a new bounded SIGA package.


## SIGA reconciliation — 3JS-002 accepted style-lock delivery gate — 2026-09-26

### Live state
- repository: `az1nn/growing-rio`;
- active delivery: PR **#111** / `feat/3js-002-grow-room-implementation`;
- accepted rendered runtime head: `d4822fd6b5edc2c6634c22838bbc5ec771422313`;
- accepted artifact: **10912912460**;
- rendered review: **ACCEPT**;
- runtime/presentation state is now locked to `styleStatus=ACCEPT`, and the exact-head grow-room workflow enforces that status.

### VERIFY-FIRST reconciliation
The accepted runtime source in `threejs/grow-room/src/styleTokens.js` is the source of truth for the ratified lighting values:
- ambient `0.86`;
- key `1.78`;
- rim `0.72`;
- primary practical `48 / 6.8`;
- secondary practical `18 / 5.4`;
- ACES filmic exposure `1.08`;
- dynamic shadows disabled.

The previous definitive line in `docs/VISUAL-DIRECTION.md` retained stale pre-Revision-1 lighting values. This reconciliation corrects that documentation only; it does not change the accepted render.

### Classification
**WATCH**

This persistence changes PR #111's exact head and touches the visual-direction acceptance surface. Require fresh exact-head Validate project, Three.js visual acceptance, Three.js grow room visual acceptance, repository visual capture where applicable, and Vercel success before guarded merge. Any newer branch movement invalidates stale evidence.


## SIGA closure — 3JS-002 Grow Room delivery — 2026-09-26

### Verified delivery
- PR **#111** final head: `04909078f07241cc3f509f2d950f25597d883e6a`;
- all exact-head delivery gates passed: Validate project, Three.js visual acceptance, Three.js grow room visual acceptance, repository Visual acceptance capture and Vercel;
- fresh grow-room artifact **10912598196** confirmed `styleStatus=ACCEPT`, 50 draw calls, 3,236 triangles, 9 material families, 0 authored textures, DPR 1, shadows disabled and empty browser console/page errors at both portrait sizes;
- PR #111 merged as `060f265ce860247996ca43663b63e50a5048c757`;
- post-merge `Validate project` run **36263269964: SUCCESS**;
- post-merge Vercel: **SUCCESS**.

### Closure persistence
- closure branch: `docs/3js-002-delivery-closure`;
- closure PR: **#112**;
- T018 is complete on this branch;
- this closure is documentation-only and does not mutate runtime, gameplay, renderer, assets or persistence.

### Classification
**WATCH -> ADVANCE after guarded merge of PR #112**

Require fresh exact-head checks and Vercel on the final #112 head, then merge with expected-head protection. After merge, 3JS-002 is closed and the next `Siga` / `3js` invocation must reconcile live state and select a new bounded specification rather than reopen the accepted Grow Room without regression evidence.


## SIGA reconciliation — Market PR stack repair — 2026-09-26

### Verified live state
- repository: `az1nn/growing-rio`;
- default branch: `master@d2386e8f7fa3e0a15f561403a89fd1d6bab85933`;
- open delivery stack: `#114 -> #116`;
- no competing open PR exists at this write barrier.

### Reconciliation performed
- PR #114 / `feat/cena-020-market-visual-target` was reconciled with current `master` using a normal merge commit, without force update;
- reconciled #114 head: `9c6597a0b8e8d79cbeaa094b18a2d0a5833c2328`;
- PR #116 / `feat/3js-003-market` remains based on the #114 branch and was reconciled with the new #114 head using a normal merge commit, without force update;
- pre-persistence reconciled #116 head: `000d66861e3625b391889950173f67f0d0111515`;
- ancestry checks show `master -> #114 -> #116` with both dependent comparisons at `behind_by=0`;
- both PRs are mergeable after reconciliation.

### Gate state before this persistence
- #114 exact-head `Validate project`: SUCCESS;
- #114 exact-head `Three.js grow room visual acceptance`: SUCCESS;
- #116 exact-head `Validate project`: SUCCESS;
- remaining rendered workflows were still running when this record was written;
- Vercel continues to report explicit build-rate-limit and remains `SOFT_GATE_RATE_LIMIT`.

### Classification
**WATCH**

This handoff persistence advances #116 again, so all earlier #116 exact-head evidence becomes historical. Require fresh exact-head repository/rendered validation on the resulting head. Do not merge #116 ahead of #114. When provider capacity returns, deliver bottom-up: validate/merge #114, reconcile #116 against the delivered parent if needed, revalidate #116, then merge #116 and persist closure.


## SIGA closure — 3JS-003 Market delivery recovery — 2026-09-26

### Verified delivery
- Repository: `az1nn/growing-rio`.
- CENA-020 PR #114 merged to `master`.
- SIGA detected that PR #116, although marked merged, had landed into the already-merged stacked base branch rather than the default branch.
- Recovery PR **#118** targeted `master` with the accepted 3JS-003 delta only.
- #118 final head: `f63594b494b1640e9bd5c508e7b4be05bb8018c1`.
- Exact-head gates: Validate project **SUCCESS**; Three.js visual acceptance **SUCCESS**; Three.js grow room visual acceptance **SUCCESS**; Three.js market visual acceptance **SUCCESS**; Visual acceptance capture **SUCCESS**; Vercel **SUCCESS**.
- Guarded merge commit: `7f5c1d890f82296f9ea4ceab771a7154253b5a9f`.
- `master` was verified at that exact commit after merge.
- Post-merge Validate project run `36270971536`: **SUCCESS**.
- Post-merge Vercel reports explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`. This prevents claiming fresh public parity for the merge commit but does not indicate a repository defect.

### Route after this persistence
**WATCH for this documentation closure's exact-head delivery; product route otherwise remains ADVANCE at the specification/roadmap boundary, and visual route is CENA-ADVANCE.**

This persistence is documentation/task-state only. Before merging it, require fresh exact-head repository checks and Vercel success; if the provider again rate-limits, keep the closure merge-deferred without treating it as a product/runtime failure.


## SIGA advance — CENA-021 / 3JS-004 Cidade — 2026-09-27

### Reconciliation
- #119 merged as `f402713d2e3b9003aa49bcefb944e1bbc91dd903`;
- Vercel on that merge commit is **SUCCESS**;
- no open PR remained immediately after closure;
- roadmap has no post-RB-15 product capability, so SIGA remains at the product specification boundary;
- visual continuation is valid through repository-local CENA;
- Cidade is the next canonical top-level surface after delivered Mercado and currently has no dedicated Three.js scene.

### Classification
**ADVANCE**

SIGA routes the bounded visual continuation through **CENA-021** and then **3JS-004**. This is presentation work only, not a new gameplay capability.

### Boundaries
- no gameplay/domain change;
- no save-schema change;
- no real geography or navigation model;
- no real political institution or persuasion content;
- no external runtime asset;
- Godot remains canonical runtime.

### Delivery graph
`master@f402713… → feat/cena-021-city-visual-target → feat/3js-004-city`.

CENA owns the visual target and final rendered decision; 3JS owns the Three.js implementation; SIGA retains exact-head validation, concurrency and delivery authority.


## SIGA reconciliation — CENA-021 delivered / 3JS-004 candidate — 2026-09-27

### Live transition
- CENA-021 PR #120 passed its delivery path and merged to `master` as `473cef46e4dd9926c1033318b7ad97cc05c68c41`.
- Vercel on that default-branch merge commit is **SUCCESS**.
- The 3JS-004 branch was created from the exact CENA-021 contract head, then reconciled non-force with delivered `master`.
- Reconciled City candidate head before this persistence: `ae49cacdd7a6244bfa2ef5c926ca87ae1732f9d3`.
- At the write barrier, no competing open PR exists.

### Classification
**WATCH**

The bounded 3JS-004 Cidade implementation is persisted and its visual-capture workflow exists. It is not deliverable yet: require exact-head `Validate project`, exact-head `Three.js city visual acceptance`, rendered CENA **ACCEPT/REVISE**, provider proof and a final default-branch drift check.

### Delivery topology
The previous temporary stack dependency is resolved because CENA-021 is now on `master`. 3JS-004 must target `master` directly; do not merge into the historical CENA branch.

### Boundaries
No gameplay/domain/save-schema mutation, no real geography/navigation model, no real political institution/persuasion content, no external runtime asset, and no Godot runtime replacement.


## SIGA gate — 3JS-004 City CENA ACCEPT — 2026-09-27

- CENA accepted Revision 1 on runtime head `7f25b29cee5f57e99526ef63cd1e9d47e923bd98` / artifact `10928746311`.
- Acceptance-status persistence advances PR #121 beyond that reviewed runtime head.
- Route remains **WATCH** for fresh exact-head delivery evidence.
- Merge automatically when #121 is still open/mergeable, current head is unchanged, required Actions + Vercel are green, no new overlap/default-branch drift exists, and exact-head guard is available.


## SIGA reconciliation — Feature 009 T004 recovery + T005 — 2026-09-27

### Verified live divergence
- `master` at wave start: `ec5b9dee5a902ea2073dd161c76bc94dd89e63a2`.
- Open PR scan at the write barrier: none.
- PR #125 was already merged to `master`.
- PR #126 then merged into the historical `spec/009-campaign-calendar-lifecycle` branch, so its T004 balance delta was not in default-branch ancestry.
- Top-level classification: **RESUME**.

### Progress executed
- Created master-based branch `spec/009-balance-validation-recovery`.
- Recovered T004's game-only lifecycle ranges: `[0,22)`, `[22,45)`, `[45,68)`, `[68,90)`, then `pronta >= 90`.
- Completed T005 with `tools/validate_spec_009_balance.py`.
- `Validate project` now executes the Feature 009 balance validator on exact PR heads.
- No runtime/domain/save/UI/Three.js behavior changed.

### Active delivery
- PR #127 — `spec(009): recover T004 and automate lifecycle balance validation`.
- Pre-handoff head `e0fb82fd9fa02d0bfe72814406de91e349a456a1` was open and mergeable.
- Validate project #588, Visual acceptance #198 and Three.js visual acceptance #58 were in progress on that pre-handoff head.
- Vercel reported explicit `upgradeToPro=build-rate-limit`; classify **SOFT_GATE_RATE_LIMIT** under repository policy, not as an internal regression.
- Route after this persistence: **WATCH** for fresh exact-head repository checks on the new handoff head. Do not merge until exact-head required internal gates pass and overlap/default-branch drift remains clear.
- Next dependency-ordered runtime task after delivery: T006, campaign maximum 365 with explicit Day-365 closure semantics.


## SIGA Feature 009 recovery — T006/T007 to master — 2026-09-27

### Classification
**RESUME** — GitHub showed PRs #130 and #131 as merged, but both landed into historical feature branches after their parents had already been merged. Default-branch verification proved the runtime deltas were absent: `master` still had `MAX_DAYS = 30`, `cycle_days = 8`, and T006/T007 unchecked.

### Concurrency outcome
- PR #132 owns `009:RECOVER-T006-T007`.
- Base snapshot: `master@2cf90ce4d99198575212f1e42706eb2e8b694370`.
- Draft claim was published before substantive writes; the post-claim barrier found no competing open PR/session.
- No force update was used.

### Recovery executed
- recovered T006 runtime: `GameState.MAX_DAYS = 365` with Day 365 fully playable and closure only after advancing beyond it;
- recovered `tests/campaign_calendar_boundary_test.gd` and its exact-head Validate-project workflow step;
- recovered T007 runtime data: `resources/cultivars/quarto_classica.tres -> cycle_days = 90`;
- recovered Feature 009 task evidence with T006 and T007 complete;
- no T008 lifecycle-stage derivation was introduced in this recovery.

### Live graph
```text
SESSIONS
S132 [OWNER|RECOVERY] 009:RECOVER-T006-T007 -> fix/009-recover-t006-t007-master@f9fc0f4c

TASKS
T004/T005 ✅ (master) -> T006/T007 recovered in #132 -> T008 next

CI/CD
#132@f9fc0f4c -> Validate exact-head required -> Visual n/a -> Three.js n/a -> Provider required by repo policy -> Merge guarded
```

### Next action
Require exact-head CI/provider evidence on the final #132 head and merge it to `master` only when repository policy permits. After default-branch verification, T008 is the next dependency-ordered task: pure deterministic lifecycle-stage derivation in the cultivation domain.


### Recovery CI repair
- First recovery head `4ad174a8793a9f3f661e9cb7cc70823f2a43e287` reached Validate project #609 and failed only at `Campaign natural unlock regression`; all preceding structure, balance, import, shell, visual-production, operation, diorama, deterministic simulation, economy, business, room, management, market, compliance, city, policy, community, narrative and campaign-state steps passed.
- Root cause: after the intentional 8 -> 90 day cycle change, `tests/campaign_progression_test.gd` exhausted the unrelated default cash fixture under 15/day room operating cost and hit the independent cash game-over gate before harvest.
- Repair is test-only: the narrative-unlock fixture now seeds ample cash so it continues to validate narrative progression rather than economy survivability. Runtime economy, yield, operating cost and game-over rules are unchanged.
- Any green evidence before this repair is stale; require exact-head validation after this persistence.


## SIGA #132 repair — campaign revalidation fixture — 2026-09-27

### Classification
**RESUME** — exact-head Validate project #615 failed at `Campaign end-to-end revalidation` after all earlier Feature 009/calendar and campaign-progression checks passed.

### Root cause and bounded repair
- `tests/campaign_revalidation_test.gd` still used the default economy fixture while advancing a now-canonical 90-day cultivation cycle.
- The unrelated cash game-over gate stopped day advancement before harvest, producing `Normal Operation play did not produce inventory.`
- Repair commit `a30b9187c16ef38a24590ae3d28f168465310d3c` seeds ample test cash after reset so this regression continues to own end-to-end campaign progression rather than economy survivability.
- Runtime economy, operating cost, harvest/yield, campaign calendar and save behavior are unchanged.

### Concurrency
- S132 remains owner of `009:RECOVER-T006-T007`.
- S133 / `009:T008` remains stacked on S132 at `4b97c84f996b4e34b083c2c69fcf7dea5dacb5d3`; it shares coordination/workflow/spec paths and must reconcile after S132 advances.
- The substantive repair path `tests/campaign_revalidation_test.gd` is not part of S133's current changed-file set, so the runtime/test intent is non-duplicative.
- No force update was used.

### Delivery
Any green evidence before this persistence is stale. Require fresh exact-head Validate/Visual/Three.js/provider evidence on the final S132 head before guarded merge. Vercel rate-limit status remains a provider soft-gate classification until exact-head provider evidence is refreshed.


## SIGA recovery — T008/T009/T010 default-branch ancestry — 2026-09-27

### Classification
**RESUME** — GitHub marked PRs #133, #135 and #136 merged, but each landed into an already-delivered stacked branch after its parent had reached `master`. Default-branch verification at `master@a8d1c3efae578e1325cd69783108a4f0aa5747b9` proved T008-T010 were still absent.

### Concurrency
- S137 / PR #137 owns `009:RECOVER-T008-T010`, created at 2026-09-27T14:02:16Z from the verified default-branch head.
- S138 claimed the same semantic task at 2026-09-27T14:03:14Z.
- Deterministic ownership rule selected the earlier claim: #137 remains OWNER; #138 was marked **SUPERSEDED** and closed without merge.
- No force update was used. The temporary session-claim file was removed before delivery.

### Recovery executed
- recovered T008 pure deterministic lifecycle-stage derivation in `CultivationService`;
- recovered T009 GameState/room presentation exposure without duplicating thresholds;
- recovered T010 terminal-harvest invariant regression;
- recovered the three exact-head Validate-project steps and Feature 009 task evidence;
- preserved existing 365-day campaign and 90-day cycle semantics from T006/T007;
- introduced no new save schema, economy, yield, CENA, Three.js or lore behavior beyond the already accepted stacked work.

### Live graph before final persistence
```text
SESSIONS
S137 [OWNER|RECOVERY] 009:RECOVER-T008-T010 -> fix/009-recover-t008-t010-master@d1098187
S138 [SUPERSEDED]      009:RECOVER-T008-T010 -> closed, no merge

TASKS
T006/T007 ✅ master -> T008/T009/T010 recovered in #137 -> T011 next

CI/CD
#137 -> Validate fresh exact-head required -> Visual n/a -> Three.js n/a -> Provider per repo policy -> Merge guarded
```

### Next action
This handoff persistence changes the #137 head, so any earlier green evidence is stale. Require fresh exact-head checks on the final #137 head, re-run the open-PR/default-branch barrier, then guarded-merge #137 when required gates pass. After default-branch verification, T011 is the next dependency-ordered task: prove lifecycle stage remains derived from persisted `grow_day` with no schema bump.


## SIGA parallel advance — Feature 009 T011 derived persistence — 2026-09-27

### Classification
**RESUME + PARALLEL_ADVANCE** — #137 remains the recovery owner for T008-T010, while #139 is the dependency-ordered child session for T011.

### Concurrency
- S137 / PR #137 owns `009:RECOVER-T008-T010` on `fix/009-recover-t008-t010-master`.
- S139 / PR #139 owns `009:T011` on `test/009-t011-derived-stage-persistence`, explicitly stacked on #137.
- The post-claim barrier found no competing T011 claim.
- #137 advanced after #139 branched only by removing its temporary claim and persisting its recovery handoff; runtime, workflow and Feature 009 task files did not move in that parent drift.
- This handoff is rebuilt from the latest #137 handoff rather than overwriting it with the older child copy.
- No force update is used.

### T011 executed
- Added `tests/lifecycle_stage_persistence_test.gd`.
- The regression proves save schema remains v11 and rejects any persisted `lifecycle_stage` field.
- Save/load restores canonical `grow_day` and reconstructs `flora` from it.
- An adjusted persisted `grow_day = 68` reloads as `late flowering`, proving lifecycle stage is derived rather than duplicated.
- `.github/workflows/validate.yml` executes the T011 regression on exact PR heads.
- `specs/009-campaign-calendar-lifecycle/tasks.md` records T011 complete.
- No runtime, economy, yield, RNG, visual, lore or save-schema behavior changed.

### Delivery order / next action
1. Require fresh exact-head validation for #137 and deliver it to `master` first when all required gates permit.
2. Reconcile #139 against the delivered #137/master state, then require fresh exact-head validation for #139.
3. Guarded-merge #139 only after its current head and dependency order are verified.
4. T012 is the next dependency-ordered Feature 009 task after T011 delivery.
- PR #139 is ready for review; this post-ready persistence exists to trigger the standard pull-request `synchronize` validation because the prior draft head registered no Actions check-run.


## SIGA parallel advance — Feature 009 T012 core regression — 2026-09-27

### Classification
**WATCH + PARALLEL_ADVANCE** — #137 and #139 are internally green but merge-deferred by the repository's explicit Vercel `SOFT_GATE_RATE_LIMIT`; T012 was therefore created and executed as the next dependency-ordered stacked task instead of idling.

### Concurrency / session ownership
- S137 / PR #137 owns `009:RECOVER-T008-T010` at exact head `23c85ee8ceb7e98c87d93e9ce274741b5bd5415a`.
- S139 / PR #139 owns `009:T011` at exact head `056f97d4dfbb0a1961219717ecf0a01a4c00d69c`, stacked on #137.
- S140 / PR #140 owns `009:T012`, stacked on #139.
- The mandatory post-claim barrier found no competing T012 claim; #140 is the deterministic owner.
- The temporary session-claim file was removed before delivery.
- No force update was used.

### T012 executed
- Added `tests/campaign_lifecycle_core_regression_test.gd`.
- Proves Day 365 remains playable and the following advance closes the campaign.
- Proves the canonical cycle remains exactly 90 days, early harvest at day 89 is rejected without inventory/growth mutation, and day 90 exposes `pronta` with harvest availability.
- Proves lifecycle-stage ordering never moves backward across grow days 0-90.
- Wired the regression into exact-head `Validate project`.
- Marked T012 complete in Feature 009 tasks.
- No runtime, persistence schema, economy, yield, RNG, visual or lore semantics changed.

### Live session/task/CI graph
```text
SESSIONS
S137 [WATCH] 009:RECOVER-T008-T010 -> #137 @ 23c85ee8 -> internal CI ✅ / Vercel ⏳ rate-limit
  └─ S139 [WATCH] 009:T011 -> #139 @ 056f97d4 -> internal CI ✅ / Vercel ⏳ rate-limit
       └─ S140 [OWNER] 009:T012 -> #140 -> final exact-head CI required

TASKS
T008-T010 ✅ #137
      ↓
T011 ✅ #139
      ↓
T012 ✅ source + CI wiring in #140
      ↓
T013 ⏭ prove lifecycle derivation consumes no RNG and stage transitions create no inventory

CI/CD
#137 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⏳ SOFT_GATE_RATE_LIMIT
#139 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⏳ SOFT_GATE_RATE_LIMIT
#140 Validate ⏳ fresh final-head evidence required | provider evidence required by repo policy
```

### Next action
1. Require fresh exact-head validation on #140 after this handoff persistence.
2. If #140 has an internal defect, RESUME only that concrete T012 regression defect.
3. While provider rate limiting persists, keep the dependency chain open and do not bypass merge policy.
4. Next dependency-ordered progress unit is T013; it may advance as a stacked child after a fresh concurrency claim/barrier if T012 is waiting.
5. When provider capacity returns, reconcile and deliver bottom-up with expected-head guards: #137 -> #139 -> #140, refreshing downstream exact-head evidence after each base transition.


## SIGA parallel advance — Feature 009 T013 RNG/inventory invariants — 2026-09-27

### Classification
**WATCH + PARALLEL_ADVANCE** — PRs #137, #139 and #140 are internally green on their exact heads but remain merge-deferred by the explicit Vercel `SOFT_GATE_RATE_LIMIT`. T013 was claimed and executed as the next dependency-ordered stacked task instead of idling.

### Concurrency / session ownership
- S137 / PR #137 owns `009:RECOVER-T008-T010`.
- S139 / PR #139 owns `009:T011`, stacked on #137.
- S140 / PR #140 owns `009:T012`, stacked on #139.
- S141 / PR #141 owns `009:T013`, stacked on #140.
- Mandatory post-claim rescan found no competing `009:T013` claim; #141 is the deterministic owner.
- Temporary session claim was removed before delivery.
- No force update was used.

### T013 executed
- Added `tests/lifecycle_rng_inventory_invariant_test.gd`.
- Repeated `GameState.current_lifecycle_stage()` derivation is asserted to preserve the exact simulation RNG state.
- A full 0-to-90-day scan asserts inventory remains unchanged through every lifecycle-stage transition and remains zero when `pronta` is reached without `harvest()`.
- Wired the new regression into exact-head `Validate project`.
- Marked T013 complete in Feature 009 tasks.
- No runtime, save-schema, economy, yield, visual, lore or balance semantics changed.
- Implementation/claim-release head before this handoff persistence: `e14bc47fdc88a32fcf08cb053b4312d2687b6f29`.

### Live session/task/CI graph
```text
SESSIONS
S137 [WATCH] 009:RECOVER-T008-T010 -> #137 @ 23c85ee8
  └─ S139 [WATCH] 009:T011 -> #139 @ 056f97d4
       └─ S140 [WATCH] 009:T012 -> #140 @ 7525e45e
            └─ S141 [OWNER] 009:T013 -> #141 -> final exact-head CI required

TASKS
T008-T010 ✅ #137
      ↓
T011 ✅ #139
      ↓
T012 ✅ #140
      ↓
T013 ✅ source + CI wiring in #141
      ↓
T014 ⏭ four serial 90-day cycles = 360 days + five-day annual closure margin

CI/CD
#137 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#139 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#140 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#141 Validate ⏳ final-head evidence required | Visual/3JS ⏳ exact-head evidence required | Vercel ✅ exact-head provider success
```

### Next action
1. Require fresh exact-head Validate/Visual/Three.js evidence on the final #141 head produced by this persistence.
2. If an internal gate fails, classify RESUME and repair only the concrete T013 defect.
3. Keep the ancestor provider rate-limit debt (#137/#139/#140) explicit; #141 itself has exact-head Vercel success. Do not bypass merge policy.
4. If #141 is internally green while the provider remains rate-limited, T014 is the next dependency-ordered progress unit after a fresh claim/barrier.
5. When provider capacity returns, reconcile and deliver bottom-up with expected-head guards: #137 -> #139 -> #140 -> #141, refreshing downstream exact-head evidence after each base transition.


## SIGA repair — Feature 009 T013 exact-head parse failure — 2026-09-27

### Classification
**RESUME** — exact-head Validate project run 36346382378 failed specifically in the T013 regression before runtime assertions executed.

### Root cause / repair
- Godot 4.7.2 rejected `var inventory_before := state.inventory` because `state.inventory` is exposed through a dynamically typed Node boundary and the local type could not be inferred.
- Repaired `tests/lifecycle_rng_inventory_invariant_test.gd` by declaring `inventory_before: int` explicitly.
- No runtime, economy, lifecycle, RNG, inventory, persistence, visual or lore behavior changed.

### Verification debt
This repair advances PR #141, so all previous #141 exact-head gate evidence is stale. Require fresh Validate/Visual/Three.js/provider evidence on the repaired exact head before any delivery action. Ancestor PRs #137/#139/#140 remain merge-deferred by explicit Vercel build-rate limiting.


## SIGA parallel advance — Feature 009 T014 four-cycle annual margin — 2026-09-27

### Classification
**RESUME + PARALLEL_ADVANCE** — PR #141 required a bounded T013 compile repair; while its refreshed exact-head gates rerun, T014 advanced as the next dependency-ordered stacked regression.

### Concurrency / ownership
- S137 / PR #137 owns `009:RECOVER-T008-T010`.
- S139 / PR #139 owns `009:T011`, stacked on #137.
- S140 / PR #140 owns `009:T012`, stacked on #139.
- S141 / PR #141 owns `009:T013`, stacked on #140; its prior Validate failure was repaired by explicit `int` typing in the T013 test.
- S142 / PR #142 owns `009:T014`, stacked on #141.
- The mandatory post-claim barrier found no competing `009:T014` claim; #142 is the deterministic owner.
- Temporary session claim removed before delivery; no force update used.

### T014 executed
- Added `tests/campaign_annual_cycle_margin_test.gd`.
- Executes four serial 90-day cycles with terminal `pronta`, explicit harvest and inventory-clearing sale between cycles.
- Proves four cycles consume exactly 360 campaign-day advances and leave playable Days 361-365 as the five-day annual closure margin.
- Proves Day 365 remains playable and the next advance closes at Day 366.
- Wired the regression into exact-head `Validate project` and marked T014 complete in Feature 009 tasks.
- No runtime, save-schema, economy, yield, RNG, visual or lore semantics changed.

### Live dependency graph at persistence
```text
SESSIONS
S137 [WATCH] 009:RECOVER-T008-T010 -> #137 @ 23c85ee8
  └─ S139 [WATCH] 009:T011 -> #139 @ 056f97d4
       └─ S140 [WATCH] 009:T012 -> #140 @ 7525e45e
            └─ S141 [RESUME] 009:T013 -> #141 @ f428089e -> repaired, fresh gates required
                 └─ S142 [OWNER] 009:T014 -> #142 -> final exact-head gates required

TASKS
T008-T010 ✅ #137 -> T011 ✅ #139 -> T012 ✅ #140 -> T013 ✅ repaired #141 -> T014 ✅ source+CI #142 -> T015 ⏭ multi-room lifecycle independence

CI/CD
#137 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#139 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#140 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#141 fresh exact-head gates required after repair
#142 fresh exact-head gates required after T014 persistence
```

### Next action
1. Re-read exact-head gates for #141 and #142; repair only concrete internal failures.
2. Do not bypass ancestor Vercel rate-limit debt; delivery remains bottom-up.
3. If #142 becomes internally green while delivery remains blocked, T015 is the next dependency-ordered task after a fresh claim/barrier.
4. When provider capacity returns, reconcile and deliver bottom-up with expected-head guards, refreshing downstream exact-head evidence after each base transition.


## SIGA parallel advance — Feature 009 T015 multi-room lifecycle derivation — 2026-09-27

### Classification
**WATCH + PARALLEL_ADVANCE** — the oldest delivery dependencies #137/#139/#140 remain internally green but merge-deferred by explicit Vercel `SOFT_GATE_RATE_LIMIT`; T015 therefore advanced as the next dependency-ordered stacked task instead of idling.

### Concurrency / ownership
- S137 / PR #137 owns `009:RECOVER-T008-T010`.
- S139 / PR #139 owns `009:T011`, stacked on #137.
- S140 / PR #140 owns `009:T012`, stacked on #139.
- S141 / PR #141 owns `009:T013`, stacked on #140.
- S142 / PR #142 owns `009:T014`, stacked on #141.
- S143 / PR #143 owns `009:T015`, stacked on #142.
- Mandatory post-claim rescan found no competing `009:T015` claim; #143 is the deterministic owner.
- Temporary session claim was removed before delivery; no force update was used.
- Parent #142 remained at exact head `9b5c517bc12cdae8ccb7931fa846b4c52fb2c949` through the T015 write barrier, matching #143's base SHA.

### T015 executed
- Added `tests/lifecycle_multi_room_derivation_test.gd`.
- Room 1 advances to `Vega` before Room 2 exists; the newly created second room starts independently at `seedling` / `grow_day = 0`.
- After 23 additional campaign advances, Room 1 is independently `flora` at `grow_day = 45` while Room 2 is `Vega` at `grow_day = 23`.
- Switching the active room proves `current_lifecycle_stage()` follows each room's own canonical cultivation state.
- Exact-head Validate wiring was added and T015 was marked complete in Feature 009 tasks.
- No runtime, save-schema, economy, yield, RNG, visual, lore or balance semantics changed.

### Live dependency graph at persistence
```text
SESSIONS
S137 [WATCH] 009:RECOVER-T008-T010 -> #137 @ 23c85ee8
  └─ S139 [WATCH] 009:T011 -> #139 @ 056f97d4
       └─ S140 [WATCH] 009:T012 -> #140 @ 7525e45e
            └─ S141 [WATCH] 009:T013 -> #141 @ f428089e
                 └─ S142 [WATCH] 009:T014 -> #142 @ 9b5c517b
                      └─ S143 [OWNER] 009:T015 -> #143 -> final exact-head gates required

TASKS
T008-T010 ✅ #137 -> T011 ✅ #139 -> T012 ✅ #140 -> T013 ✅ #141 -> T014 ✅ #142 -> T015 ✅ source+CI #143 -> T016 ⏭ save v1-v11 migration/round-trip revalidation

CI/CD
#137 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#139 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#140 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#141 Validate ✅ | Visual ✅ | 3JS ✅ | Vercel ✅
#142 Validate ✅ | 3JS ✅ | Visual ⏳ | Vercel ✅
#143 pre-handoff Validate ✅ | Visual ⏳ | 3JS ⏳ | Vercel ✅
```

### Next action
1. This handoff persistence advances #143, so all pre-handoff #143 green/running evidence becomes stale; require fresh exact-head Validate/Visual/Three.js/provider evidence on the final head.
2. Repair only a concrete internal T015 failure if one appears.
3. Keep ancestor provider debt explicit and do not bypass bottom-up delivery order.
4. If delivery remains provider-blocked after #143 is internally green, T016 is the next dependency-ordered progress unit after a fresh concurrency claim/barrier.
5. When provider capacity returns, reconcile and deliver bottom-up with expected-head guards, refreshing downstream exact-head evidence after each base transition.


## SIGA parallel advance — Feature 009 T016 save compatibility — 2026-09-27

### Classification
**WATCH + PARALLEL_ADVANCE** — the Feature 009 delivery chain remains stacked while ancestor provider debt is unresolved, and T016 was executed instead of idling.

### Concurrency / ownership
- S137 -> S139 -> S140 -> S141 -> S142 -> S143 remains the dependency-ordered Feature 009 chain.
- S144 / PR #144 owns `009:T016`, stacked directly on #143.
- The mandatory post-claim barrier found no competing T016 owner.
- #143 remained at exact head `8a86bccb56e0396a009515973f524c527356cf42` through the T016 write barrier.
- No runtime, save-service, renderer, gameplay, economy, RNG, yield, visual or lore behavior was changed by T016.

### T016 executed
- Reconciled the canonical save compatibility suite instead of creating duplicate tests.
- `tests/save_schema_test.gd` already covers schema-v11 JSON round-trip plus supported legacy v1-v10 migration/load behavior.
- Feature 009 lifecycle state remains derived from persisted `grow_day`; `lifecycle_stage` is not persisted.
- `autoload/save_service.gd` remains schema v11.
- Parent #143 exact-head Validate project run `36346994144` passed and includes the save-schema compatibility regression.
- T016 is complete in the Feature 009 task ledger.

### Live dependency graph at persistence
```text
SESSIONS
S137 [WATCH] 009:RECOVER-T008-T010 -> #137
  └─ S139 [WATCH] 009:T011 -> #139
       └─ S140 [WATCH] 009:T012 -> #140
            └─ S141 [WATCH] 009:T013 -> #141
                 └─ S142 [WATCH] 009:T014 -> #142
                      └─ S143 [WATCH] 009:T015 -> #143
                           └─ S144 [OWNER] 009:T016 -> #144

TASKS
T008-T010 ✅ -> T011 ✅ -> T012 ✅ -> T013 ✅ -> T014 ✅ -> T015 ✅ -> T016 ✅ -> T017 ⏭

CI/CD
#137/#139/#140 internal CI ✅ | Vercel ⚠️ SOFT_GATE_RATE_LIMIT
#141/#142 provider ✅ and internal CI ✅
#143 Validate ✅ | 3JS ✅ | Visual running at last read | Vercel ✅
#144 fresh exact-head gates required after this persistence
```

### Next action
1. Remove the temporary T016 claim and make #144 review-ready.
2. Require fresh exact-head Validate/Visual/Three.js/provider evidence on #144.
3. Keep delivery bottom-up; do not bypass unresolved ancestor provider debt.
4. If delivery remains blocked, T017 is the next dependency-ordered progress unit: structural validation and architecture documentation.


## SIGA parallel advance — Feature 009 T017 structural validation — 2026-09-27

### Classification
**WATCH + PARALLEL_ADVANCE** — Feature 009 remains merge-deferred by ancestor provider debt, so T017 executed on top of completed T016 instead of idling.

### Concurrency / ownership
- PR #145 owns `009:T017`, stacked directly on PR #144.
- The mandatory post-claim barrier found no competing T017 owner.
- Parent #144 remained at `2667a722b15fb4722398d28a1381007b1385b5bc` through the T017 write barrier.
- This wave changes structural validation, architecture/spec documentation and handoff state only; no runtime/save-schema/gameplay/economy/RNG/yield/visual/lore behavior changes.

### T017 executed
- Added `specs/009-campaign-calendar-lifecycle/t017-structural-validation-contract.md`.
- `tools/validate_project.py` now structurally locks the 365-day campaign constant, lifecycle read/derivation APIs, shipped thresholds/stage IDs and the canonical 90-day cultivar duration.
- `docs/ARCHITECTURE.md` now records the Feature 009 timing, derived-state, room-local, RNG/inventory and annual-margin boundaries.
- T017 is complete; T018 is the next dependency-ordered delivery task.

### Delivery state at persistence
- #137/#139/#140 remain internally green but Vercel reports explicit `build-rate-limit` / `SOFT_GATE_RATE_LIMIT`.
- #141/#142/#143 have successful internal exact-head evidence from their current heads.
- #144 completed T016 and remains the immediate parent delivery.
- #145 requires fresh exact-head CI after final claim removal and handoff persistence.
- Delivery remains bottom-up; no descendant may bypass unresolved ancestor provider debt.

### Next action
1. Remove the temporary #145 session claim and make #145 review-ready.
2. Require fresh exact-head validation on the final #145 head.
3. Execute T018 as the next bounded progress unit if delivery remains blocked: reconcile current master/open-PR drift without bypassing the stack.
4. When provider capacity returns, deliver bottom-up with expected-head guards and refresh downstream exact-head evidence after each base transition.


## SIGA Feature 009 — T018 live drift reconciliation — 2026-09-27

### Classification
**WATCH + PARALLEL_ADVANCE** — PR #145/T017 is internally green but provider-deferred by explicit Vercel `build-rate-limit`; SIGA advanced the next safe documented task instead of idling.

### Progress executed
- Created PR #146 as the deterministic owner of `009:T018`, stacked directly on #145.
- Mandatory post-claim barrier found no competing T018 owner.
- Reconciled default branch `master@a8d1c3efae578e1325cd69783108a4f0aa5747b9` against the complete open Feature 009 stack.
- Verified linear ancestry with `behind_by = 0` on every edge: `master -> #137 -> #139 -> #140 -> #141 -> #142 -> #143 -> #144 -> #145`.
- Persisted the reconciliation contract in `specs/009-campaign-calendar-lifecycle/t018-live-drift-reconciliation.md` and marked T018 complete.
- No runtime/save-schema/gameplay/economy/RNG/yield/visual/lore behavior changed.

### Gate state at T018 entry
- #145 head `55e166bcc726deaae65cf5dc1aa9c6b0abeaa2c2`: Validate project SUCCESS; Visual acceptance SUCCESS; Vercel explicit `SOFT_GATE_RATE_LIMIT`.
- Those checks are historical for #146 after T018 persistence; T019 must validate the exact final #146 head and required provider evidence.

### Live graph
```text
SESSIONS
S137 [OWNER|STACK] 009:RECOVER-T008-T010 -> fix/009-recover-t008-t010-master@23c85ee8
S139 [OWNER|STACK] 009:T011 -> test/009-t011-derived-stage-persistence@056f97d4
S140 [OWNER|STACK] 009:T012 -> test/009-t012-core-regression@7525e45e
S141 [OWNER|STACK] 009:T013 -> test/009-t013-rng-inventory-invariants@f428089e
S142 [OWNER|STACK] 009:T014 -> test/009-t014-annual-margin@9b5c517b
S143 [OWNER|STACK] 009:T015 -> test/009-t015-multi-room-lifecycle@8a86bccb
S144 [OWNER|STACK] 009:T016 -> test/009-t016-save-migration-roundtrip@2667a722
S145 [WATCH|STACK] 009:T017 -> docs/009-t017-structural-validation-prep@55e166bc
S146 [OWNER|STACK] 009:T018 -> docs/009-t018-live-drift-reconciliation

TASKS
T001-T017 ✅ -> T018 ✅ -> T019 exact-head delivery evidence -> T020 guarded merge -> T021 closure

CI/CD
#145@55e166bc -> Validate ✅ -> Visual ✅ -> Three.js ⊘ -> Provider ⚠️ SOFT_GATE_RATE_LIMIT -> Merge ⏳
#146@current -> Validate required -> Visual required/applicable -> Three.js n/a -> Provider required -> Merge blocked until T019
```

### Next action
Execute T019 on #146's final persisted head. If provider remains explicit rate-limited, keep delivery merge-deferred but continue only with a safe documented task that does not falsify exact-head delivery evidence. When provider capacity is available, deliver the stack bottom-up with fresh drift scans and expected-head merge guards.


## SIGA Feature 009 closure — 2026-09-28

### Verified delivery
- Repository: `az1nn/growing-rio`.
- PR #149 merged first and established non-blocking rate-limit policy plus provider-neutral recovery for GitHub runner-allocation failure.
- PR #147 was reconciled non-force onto that recovered master and reduced to a documentation-only diff.
- Exact #147 head `a1325e22e4a57600d54b69af12334569132fcae2` had Vercel SUCCESS with checked-in `vercel.json` executing `bash tools/ci_validate.sh`.
- GitHub Actions on that head exposed no executed steps/logs and is therefore infrastructure evidence, not a repository test failure.
- Rendered acceptance was not applicable to the two-file documentation-only diff.
- Guarded merge succeeded; default branch became `589e76b693b93f53b5882a661d83e8cb4c16c5b3`.
- Feature 009 tasks T001-T021 are closed by PR #151 persistence.

### Concurrency state at closeout claim
- S151 / `009:T021` owns Feature 009 closeout documentation.
- S148 / `3JS-005` is parallel-safe and owns Institutional Three.js/CENA delivery.
- S150 / `LORE:HANDOFF-RECONCILE` is parallel-safe and owns only `docs/lore/LORE-HANDOFF.md`.
- No competing Feature 009 closeout claim existed at the post-claim barrier.

### Next action
After PR #151 is validated and merged, recompute live state. Do not reopen Feature 009 absent regression evidence. Resume a still-valid bounded open session (#148 or #150) according to exact-head readiness and specialist ownership.


## SIGA closure — CENA-017 — 2026-09-29

### Real-state reconciliation
- PR #172 is merged.
- Certified master: `33f97bcd8e5fb0e48e36ea67b501631f9290a797`.
- Validate project #818 / `36596189406`: **SUCCESS**.
- Visual acceptance #369 / `36596189548`: **SUCCESS**.
- Rendered artifact `11046242559`: accepted; 22 PNGs; browser-console/page-error file empty.
- Vercel: **SUCCESS** on the certified commit.
- CENA-017 tasks T001-T010: **closed**.
- Final CENA-017 ownership claim: released.

### Classification
**ADVANCE** — the visible interactive 3D completeness certification is delivered and no longer a live blocker. Reconcile the current product backlog before claiming the next task; do not use historical branch count as active-session count.


## SIGA Feature 010 reconciliation — 2026-09-29

### Real-state reconciliation
- Repository identity: `az1nn/growing-rio`.
- Default branch at claim: `master@64ca2c2be3fd11ae682691f923b04e7c96bc68be`.
- Product re-baseline issue #54 was stale and has been reconciled: RB-01 through RB-15 are complete and the issue is closed as completed.
- Feature 010 runtime was delivered by PR #152 / `9619999fce37f50ad823e4c7cb88da50465c9546`.
- Its task ledger still had T007-T010 open even though the later CENA-017 certification supplied stronger completion evidence.
- CENA-017 certified runtime master: `33f97bcd8e5fb0e48e36ea67b501631f9290a797`.
- Validate project #818 / run `36596189406`: SUCCESS.
- Visual acceptance #369 / run `36596189548`: SUCCESS.
- Rendered artifact `11046242559`: 22 PNGs; browser-console/page-error file empty.
- Vercel: SUCCESS.
- CENA-017 tasks T001-T010: closed.
- Final CENA-017 claim: released.
- Closure PR #174 is merged into current master.

### Classification
**RESUME -> WATCH** — the only unfinished Feature 010 work was stale closure bookkeeping. PR #175 now owns `010:T007-T010-CLOSEOUT-RECONCILE` and updates only Feature 010 docs, roadmap and SIGA handoff.

### Progress executed
- closed Feature 010 T007-T010 from verified CENA-017 evidence;
- marked Feature 010 COMPLETE in its spec/plan;
- reconciled the roadmap, including stale Feature 009 status;
- preserved zero runtime/gameplay/domain/save/canon/visual/CI behavior change.

### Delivery gate
PR #175 must remove its temporary session claim, become review-ready and receive fresh exact-head repository validation on its final documentation head. If required checks are green, guarded merge is authorized.

### Next action
After PR #175 delivery, recompute live state. Do not reopen Feature 010 absent regression evidence. If no newer bounded Spec Kit feature exists, remain at the specification/roadmap-selection boundary; specialist visual continuation remains routed through CENA/3JS.


## SIGA advance — Feature 010 closure -> CENA-023 / 3JS-006 — 2026-09-29

### Verified closure
- PR #175 exact head `8d82a5db22f2468083f306d5c7f53b49444fa6b3` had Validate project #825 **SUCCESS**.
- Its only red provider status was explicit Vercel daily deployment quota, classified `SOFT_GATE_RATE_LIMIT`.
- PR #175 was merged with expected-head guard.
- default branch advanced to `master@8d60d7255bcd34cf824f04f4a1e692a52981eb0f`.
- after merge, the repository had no open PRs and no open issues.

### Classification
**ADVANCE** — Features 009 and 010 are closed. The next verified player-facing specialist gap is Three.js continuity for Arquivo: Godot has a dedicated Archive diorama, while the Three.js reference set covers the other canonical top-level visual contexts but has no `threejs/archive/`.

### New bounded session
- task key: `CENA-023+3JS-006`;
- branch: `feat/3js-006-archive`;
- PR: #176 (draft);
- claim base: `8d60d7255bcd34cf824f04f4a1e692a52981eb0f`;
- post-claim overlap barrier: **CLEAR**; #176 is the deterministic owner.
- corrected canonical spec path: `specs/3js-006-archive-continuity/`.

### Progress executed
- T001 live-state/concurrency claim: complete;
- T002 Archive visual/technical contract derived from canonical Godot Archive + accepted 3JS grammar: complete;
- T003 provenance/translation notes: complete;
- no gameplay/domain/save/campaign/lore/canon mutation introduced.

### Next action
Execute 3JS-006 T004-T009 on PR #176: Archive package -> style/camera/lighting -> scene geometry -> metrics/disposal -> structural validation -> exact-head rendered acceptance. CENA then records **ACCEPT** or **REVISE**.


## SIGA WATCH — 3JS-006 rendered ACCEPT — 2026-09-29

PR #176 runtime head `0b2c9b79f0e038a2a87817260c04665095c77619` passed Validate project #841 and Three.js Archive visual acceptance #2. CENA inspected artifact `11059757870` at 540x960 and 1080x1920 and recorded **ACCEPT**. Artifact digest: `sha256:e338a4760d911f50787ccfc574ec5b7b8c1571b7c425d2da3cba860c7fd795ea`. Browser errors were empty; metrics were 21 draw calls / 360 triangles / 7 materials / 0 authored textures / DPR 1 / shadows off.

T010 is complete. Next: remove the temporary claim, rerun exact-head gates on the bookkeeping-only final head, then complete T011 with guarded merge when applicable repository/visual checks are green. Vercel quota remains soft only if it is explicitly the known provider rate limit.


## SIGA Feature 011 — semantic 3D hotspots — 2026-09-29

### Classification
**WATCH + PARALLEL_ADVANCE** — PR #178 owns the Feature 011 root/Archive slice. Exact-head Validate project is green on `1fe241cd96ffc64b8d1941d0514bf274b15beda7`; Visual acceptance capture is still running. Vercel is explicit `SOFT_GATE_RATE_LIMIT` and does not block development.

### Progress executed
- Feature 011 bounded Spec Kit package is present with requirements checklist.
- T003 Archive now exposes two stable presentation interactions: `archive/evidence_desk` -> research and `archive/archive_wall` -> resolved narrative history, each with pointer/touch and visible accessible fallback.
- PR #179 is stacked on #178 and owns T004.
- T004 City now exposes `city/district_overlook` -> district controls and `city/community_cluster` -> community feedback, each with pointer/touch and visible accessible fallback.
- Diorama scripts remain presentation-only and do not call GameState/domain mutation APIs.

### Active graph
```text
#178 011:ROOT+T003  master <- feat/011-semantic-3d-hotspots
  Validate ✅ | Visual running | Vercel ⚠ SOFT_GATE_RATE_LIMIT
  |
  +-- #179 011:T004-CITY  feat/011-semantic-3d-hotspots <- feat/011-t004-city-hotspot
      Validate/Visual pending
```

### Next action
Finish exact-head gates without tight polling. Before delivery, remove temporary claims, reconcile task/handoff bookkeeping on the final heads, then deliver bottom-up. If checks remain active, T005 Institutional is the next dependency-ordered safe slice.


## SIGA Feature 011 T004 City closeout — 2026-09-29

### Verified slice evidence
- PR #179 pre-closeout runtime head `7649bb39d0d2d3bc328d1b41027238906319a50d`.
- Validate project run `36627954202`: **SUCCESS**.
- Visual acceptance capture run `36627954182`: **SUCCESS**.
- T004 City community hotspot is implemented with pointer/touch interaction, visible accessible fallback and presentation-only routing.
- The temporary `011:T004-CITY` session claim is released before delivery.

### Classification
**WATCH** — bookkeeping changed the PR head after the accepted runtime evidence. Require fresh exact-head repository/visual gates on the final closeout head before guarded merge into Feature 011 root (#178).

### Next action
If final #179 exact-head Validate + Visual are green, mark the slice deliverable and merge #179 into its parent branch with expected-head guard. If checks are still running, continue dependency-ordered T005 Institutional work on a stacked branch instead of tight polling.


## SIGA Feature 011 T005 Institutional slice — 2026-09-29

### Classification
**WATCH + PARALLEL_ADVANCE** — #179 remains on final exact-head visual verification; #180 owns the dependency-ordered T005 Institutional slice.

### Progress executed
- Added a distinct `institutional/compliance_archive` 3D hotspot and visible accessible fallback alongside the existing `institutional/proposal_row` hotspot.
- Institutional surface routing now focuses compliance versus proposal/participation presentation without invoking domain mutations.
- Regression coverage locks both stable identifiers, pointer/touch picking, accessible fallbacks and the presentation-only diorama boundary.
- T005 is complete in the Feature 011 ledger.

### Delivery state
- #180 is stacked on #179; temporary session claim is removed before final exact-head validation.
- Required final-head Validate project + Visual acceptance must be green before guarded delivery into #179.

### Next action
Verify #180 final exact head. If gates remain active, T006 Market is the next dependency-ordered safe slice; deliver the stack bottom-up with expected-head guards.