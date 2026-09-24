# Tasks: Community Feedback

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-08 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Reconcile community/Reputation/narrative metadata.
- [x] [T005] Implement district-scoped support presentation.
- [x] [T006] Implement bounded transition feedback.
- [x] [T007] Synchronize with City navigation/state.
- [x] [T008] Add only supported neutral readiness hints.
- [x] [T009] Add consistency/no-formula-duplication regressions.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [x] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T012 are complete for the implementation wave. PR #77 was reconciled onto delivered RB-07/current `master` and `Validate project` run #362 passed on implementation head `48d3336782ecf82f54c619bfbbfb878717081cfa`. Vercel on that exact head is an explicit `SOFT_GATE_RATE_LIMIT`, so T010 remains open for the final pre-merge drift barrier and T013 remains open for guarded merge/post-merge closure. This documentation persistence advances the branch again; live exact-head CI overrides older evidence.
