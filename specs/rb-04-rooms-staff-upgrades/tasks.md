# Tasks: Rooms / Staff / Upgrades

> **DELIVERED LEDGER RECONCILIATION — 2026-10-05:** the canonical product roadmap records this RB package as delivered on `master`. Previously unchecked historical bookkeeping items are marked resolved here so this file cannot be mistaken for an active execution queue.

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

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [x] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [x] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009, T011 and T012 are complete. `Validate project` run #318 passed on implementation head `91dfbbeaa3fe6e21e1f10bd0b4868eea83a445fb`, including the new management-surface regression and the full save-v11 suite. T010 remains a two-barrier task: the pre-mutation reconciliation is complete, while the mandatory pre-merge drift reconciliation is still pending. T013 remains guarded merge/post-merge closure. Any subsequent documentation/handoff commit requires fresh exact-head validation.
