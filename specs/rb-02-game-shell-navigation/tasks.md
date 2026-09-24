# Tasks: Game Shell / Navigation

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-02 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Reconcile RB-01 route IDs and current Main controls.
- [x] [T005] Implement shell/container and destination routing.
- [x] [T006] Move global status into shell-owned presentation.
- [x] [T007] Implement overlay/back/return behavior.
- [x] [T008] Implement portrait/wide navigation layout.
- [x] [T009] Add regressions proving navigation does not mutate simulation.

## Phase 2 — Reconcile, validate, persist

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T010 and T012 are complete. The implementation and closure docs now reflect the live shell architecture and current concurrency state. T011 remains the final exact-current-head validation after all closure-doc writes; T013 remains the guarded merge plus post-merge persistence.
