# Tasks: Save / Load / Campaign UX

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-11 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Reconcile SaveService migrations/storage hooks.
- [x] [T005] Define storage adapter/slot metadata.
- [x] [T006] Implement Continue/Save/Load flows.
- [x] [T007] Implement safe error handling.
- [x] [T008] Implement confirmed New/Reset flow.
- [x] [T009] Add round-trip/migration/corruption regressions.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 are implemented on `feat/rb-11-save-load-campaign-ux`, stacked on RB-10 PR #81 to preserve one coherent shell history.

T010 remains open as the mandatory final pre-merge drift/overlap barrier. T011 remains open until the final persisted head receives fresh exact-head CI. T012 is complete. T013 remains open until guarded delivery completes.
