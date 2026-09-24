# Tasks: Operation Management Surface

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-03 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Migrate current cultivation controls from Main.
- [x] [T005] Build active-room/cycle readout hierarchy.
- [x] [T006] Wire care/day/harvest through existing orchestration.
- [x] [T007] Implement blocked-state and feedback presentation.
- [x] [T008] Add RB-04 navigation handoff.
- [x] [T009] Prove parity with the pre-migration cultivation loop.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [ ] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 are complete. Operation now exposes a presentation-only RB-04 management handoff signal/button, and the regression proves care, next-day and harvest parity against the canonical GameState commands. T010-T013 remain open for final drift reconciliation, exact-head validation, architecture/handoff closure and guarded merge.
