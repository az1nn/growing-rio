# Tasks: Save / Load / Campaign UX

> **DELIVERED LEDGER RECONCILIATION — 2026-10-05:** the canonical product roadmap records this RB package as delivered on `master`. Previously unchecked historical bookkeeping items are marked resolved here so this file cannot be mistaken for an active execution queue.

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

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [x] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [x] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

Only T001-T003 are complete. No runtime implementation is implied by this documentation wave.
