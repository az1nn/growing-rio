# Tasks: Rooms / Staff / Upgrades

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-04 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Implementation

- [x] [T004] Reconcile room/staff/upgrade APIs/resources.
- [x] [T005] Implement room list/detail and switching.
- [x] [T006] Implement staff availability/owned/hire UX.
- [x] [T007] Implement upgrade availability/owned/acquire UX.
- [x] [T008] Surface operating-cost feedback.
- [x] [T009] Add transition and save/load parity regressions.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 and T012 are implemented on `feat/rb-04-rooms-staff-upgrades`. T010 remains a two-barrier task: the pre-mutation reconciliation is complete, while the mandatory pre-merge drift reconciliation is still pending. T011 and T013 remain exact-head delivery/merge closure work.
