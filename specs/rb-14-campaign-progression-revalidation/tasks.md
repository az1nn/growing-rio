# Tasks: Campaign Progression Revalidation

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-14 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Build Ato I-V progression matrix.
- [x] [T005] Run baseline end-to-end playthrough.
- [x] [T006] Validate save/load continuity.
- [x] [T007] Correct proven artificial gate mismatches only.
- [x] [T008] Revalidate specs 005-008.
- [x] [T009] Publish PASS/blockers and RB-15 unfreeze decision.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 and T012 are complete. Natural surfaced play reaches pre-finale and ending selection without developer flag/arc shortcuts, with representative save/load round-trips. No artificial gate mismatch was proven, so T007 closes with no domain gate mutation. Feature 005-008 disposition: PASS. RB-15 is unfreezed for bounded implementation. T010 remains a required live-drift barrier immediately before merge; T011 awaits the final post-documentation exact-head rerun; T013 remains guarded-delivery/provider-gated.
