# Tasks: Policy / Institutional Surface

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

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 and T012 are complete in PR #79. The implementation preserves existing policy/compliance persistence and delegates policy gating/enactment to canonical GameState/PolicyService boundaries. T010 remains open for the final pre-merge drift barrier, T011 requires exact-head repository/visual evidence, and T013 remains guarded delivery/post-merge closure.
