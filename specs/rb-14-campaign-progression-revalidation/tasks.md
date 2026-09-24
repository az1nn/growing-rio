# Tasks: Campaign Progression Revalidation

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-14 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Build Ato I-V progression matrix.
- [ ] [T005] Run baseline end-to-end playthrough.
- [ ] [T006] Validate save/load continuity.
- [ ] [T007] Correct proven artificial gate mismatches only.
- [ ] [T008] Revalidate specs 005-008.
- [ ] [T009] Publish PASS/blockers and RB-15 unfreeze decision.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [ ] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T004 are complete. RB-14 now has a reconciled integration baseline and an explicit gate-to-player-action matrix. T005-T009 remain evidence-gated until the natural end-to-end regression runs on the integrated branch.
