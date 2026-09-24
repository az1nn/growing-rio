# Tasks: Compliance Experience

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-06 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Implementation

- [x] [T004] Reconcile compliance states/transitions/dependencies.
- [x] [T005] Finalize detailed owner.
- [x] [T006] Implement current/available/blocked presentation.
- [x] [T007] Wire existing progression actions.
- [x] [T008] Integrate dependent-surface summaries.
- [x] [T009] Add regressions/content-boundary checks.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 and T012 are complete in PR #74. Pre-mutation reconciliation confirmed the intentional product stack #68 -> #70 -> #72 -> #74 and classified the separate CENA stream as safe to continue, with the known additive `tools/validate_project.py` overlap requiring semantic reconciliation before merge. T010 remains open for the mandatory pre-merge barrier. T011 requires exact-current-head CI after the final documentation/handoff write. T013 remains guarded bottom-up merge/post-merge closure.
