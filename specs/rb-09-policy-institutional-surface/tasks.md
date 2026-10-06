# Tasks: Policy / Institutional Surface

> **DELIVERED LEDGER RECONCILIATION — 2026-10-05:** the canonical product roadmap records this RB package as delivered on `master`. Previously unchecked historical bookkeeping items are marked resolved here so this file cannot be mistaken for an active execution queue.

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-09 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Implementation

- [x] [T004] Reconcile institution/policy APIs/resources.
- [x] [T005] Implement institutional overview/progression.
- [x] [T006] Implement neutral policy list/detail.
- [x] [T007] Wire participation/enactment.
- [x] [T008] Integrate compliance/community/global context.
- [x] [T009] Add availability/enactment and content-boundary regressions.

## Phase 2 — Reconcile, validate, persist

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [x] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [x] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009, T011 and T012 are complete in PR #79. Implementation head `3082cee5cc570bafc00ac6de3834de39159b0095` passed exact-head `Validate project` #377 and `Visual acceptance capture` #21. The implementation preserves existing policy/compliance persistence and delegates policy gating/enactment to canonical GameState/PolicyService boundaries. T010 remains open for the final pre-merge drift barrier and T013 remains guarded delivery/post-merge closure. The documentation persistence commit created after this evidence must itself be revalidated before any merge claim.
