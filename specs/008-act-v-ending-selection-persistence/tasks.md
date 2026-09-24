# Tasks: Act V Ending Selection Persistence

## Phase 1 — Spec and persistence contract

- [x] [T001] Define immutable neutral ending-selection behavior and explicit out-of-scope boundaries.
- [x] [T002] Decide and document schema v11 for canonical selected-ending persistence.

## Phase 2 — Domain and GameState

- [x] [T003] Add pure deterministic `EndingSelectionService`.
- [x] [T004] Add `selected_ending_id` and selection command to GameState.
- [x] [T005] Reuse existing eligibility predicates without duplicating ranking/readiness logic.

## Phase 3 — Persistence

- [x] [T006] Add save schema v11 with stable `campaign.selected_ending_id`.
- [x] [T007] Preserve v10 migration with empty selection and all v1-v9 migrations.
- [x] [T008] Reject unknown non-empty selected ending IDs during GameState load.

## Phase 4 — Regression and documentation

- [x] [T009] Add ending-selection regression for eligibility, immutability and RNG stability.
- [x] [T010] Update save-schema regression for v11 round-trip and v10 migration.
- [x] [T011] Add new regression to GitHub Actions and structural validation.
- [x] [T012] Update architecture documentation with the selection/persistence boundary.

## Phase 5 — Reconcile, validate, persist

- [ ] [T013] Reconcile live master/open PR drift and validate the exact current PR head.
- [ ] [T014] Merge only with green exact-head gates and expected-head protection.
- [ ] [T015] Persist final verified state and next action in `docs/SIGA-HANDOFF.md`.
