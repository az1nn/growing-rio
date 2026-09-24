# Tasks: Game Shell / Navigation

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-02 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Reconcile RB-01 route IDs and current Main controls.
- [x] [T005] Implement shell/container and destination routing.
- [x] [T006] Move global status into shell-owned presentation.
- [ ] [T007] Implement overlay/back/return behavior.
- [ ] [T008] Implement portrait/wide navigation layout.
- [ ] [T009] Add regressions proving navigation does not mutate simulation.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [ ] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T006 are complete on the active RB-02 implementation branch. The shell owns canonical destination routing and global status; the legacy Main remains embedded under Operação so existing playable actions stay reachable during staged migration. T007-T009 remain before RB-02 implementation can be considered functionally complete.
