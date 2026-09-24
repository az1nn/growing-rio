# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Truth order: live repository / CI > constitution > active spec/plan/tasks > this handoff > chat/model memory.

## Current route
**WATCH — RB-12 validation defect was repaired and persisted. Require fresh exact-head Validate project + Visual acceptance evidence for this handoff head. Vercel remains an explicit SOFT_GATE_RATE_LIMIT: guarded merge/public delivery is deferred, but bounded development is not globally locked.**

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
