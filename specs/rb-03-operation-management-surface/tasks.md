# Tasks: Operation Management Surface

> **DELIVERED LEDGER RECONCILIATION — 2026-10-05:** the canonical product roadmap records this RB package as delivered on `master`. Previously unchecked historical bookkeeping items are marked resolved here so this file cannot be mistaken for an active execution queue.

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

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [x] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [x] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 and T012 are complete. Operation exposes a presentation-only RB-04 management handoff signal/button; regressions prove care, next-day and harvest parity against canonical GameState commands; architecture, roadmap and SIGA closure state are being persisted from verified repository facts. T010, T011 and T013 remain for final pre-merge drift reconciliation, exact-current-head validation and guarded bottom-up merge/post-merge persistence.
