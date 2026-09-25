# Tasks: Resume Finale

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-15 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Verify RB-14 PASS and current ending state.
- [x] [T005] Implement neutral eligible-ending presentation/selection.
- [x] [T006] Implement finale handoff/coda presentation.
- [x] [T007] Implement idempotent arc completion.
- [x] [T008] Integrate post-ending Campaign/Continue/Load.
- [x] [T009] Add finale neutrality/save regressions.

## Phase 2 — Reconcile, validate, persist

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T010 and T012 are materially complete on PR #89. Implementation head `f48f08620e4e27c12def360c394626a8c638a44f` passed Validate project #427; exact-head visual/post-documentation evidence remains required. T011 stays open for the final exact-head verification. T013 stays open under the guarded merge/provider contract.
