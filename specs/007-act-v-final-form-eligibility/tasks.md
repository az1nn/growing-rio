# Tasks: Act V Final Form Eligibility

## Phase 1 — Spec and narrative contract

- [ ] [T001] Materialize `event_forma_da_lata` from Ato V canon with four neutral intervention choices.
- [ ] [T002] Preserve protected uncertainty and prohibit direct ending selection in the event Resource.

## Phase 2 — Eligibility domain boundary

- [ ] [T003] Add pure deterministic `EndingEligibilityService` with named maturity constants.
- [ ] [T004] Implement non-ranked predicates for all six ending families.
- [ ] [T005] Expose derived `eligible_ending_ids()` through GameState without changing save schema.

## Phase 3 — Runtime integration and regression

- [ ] [T006] Register `event_forma_da_lata` after the DA LATA naming event.
- [ ] [T007] Update feature-006 regression so naming naturally hands off to the final-form debate.
- [ ] [T008] Update campaign catalog expectations for the thirteenth canonical narrative event.
- [ ] [T009] Add `act_v_final_form_eligibility_test.gd` covering natural unlock, neutrality, all six predicates, composite constraints, RNG and save/restore.

## Phase 4 — Validation and documentation

- [ ] [T010] Add the new regression to GitHub Actions and structural validation.
- [ ] [T011] Update architecture documentation with the final-form/eligibility boundary.
- [ ] [T012] Reconcile live master/open PR drift before exact-head validation.
- [ ] [T013] Validate the exact PR head, merge with an expected-head guard and validate merged master.
- [ ] [T014] Persist final verified state and next action in `docs/SIGA-HANDOFF.md`.
