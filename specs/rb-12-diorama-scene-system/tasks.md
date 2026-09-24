# Tasks: Diorama Scene System

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-12 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Reconcile OperationDiorama ownership/camera/shell integration.
- [x] [T005] Define host contract/lifecycle.
- [x] [T006] Adapt OperationDiorama.
- [x] [T007] Implement camera/transition/input conventions.
- [x] [T008] Implement fallback/performance boundaries.
- [x] [T009] Add presentation-only ownership regressions.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 and T012 are complete on the implementation branch. T010 remains open for the final pre-merge drift barrier, T011 remains open until exact-current-head CI/visual evidence is green, and T013 remains blocked by the required provider gate.
