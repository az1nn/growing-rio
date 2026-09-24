# Tasks: Community Feedback

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-08 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Reconcile community/Reputation/narrative metadata.
- [x] [T005] Implement district-scoped support presentation.
- [x] [T006] Implement bounded transition feedback.
- [x] [T007] Synchronize with City navigation/state.
- [x] [T008] Add only supported neutral readiness hints.
- [x] [T009] Add consistency/no-formula-duplication regressions.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [ ] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 are implemented in PR #77. The initial T010 concurrency barrier passed against `master@3a3cff67...`, RB-07 head `626e6039...` and the disjoint CENA stack; T010 remains open for the final pre-merge barrier. T011 exact-current-head CI, T012 final verified docs/handoff closure and T013 guarded bottom-up delivery remain pending.
