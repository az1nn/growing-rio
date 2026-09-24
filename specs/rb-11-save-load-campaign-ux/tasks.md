# Tasks: Save / Load / Campaign UX

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-11 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [ ] [T004] Reconcile SaveService migrations/storage hooks.
- [ ] [T005] Define storage adapter/slot metadata.
- [ ] [T006] Implement Continue/Save/Load flows.
- [ ] [T007] Implement safe error handling.
- [ ] [T008] Implement confirmed New/Reset flow.
- [ ] [T009] Add round-trip/migration/corruption regressions.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [ ] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

Only T001-T003 are complete. No runtime implementation is implied by this documentation wave.
