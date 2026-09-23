# Tasks: Research Presentation Surface

## Phase 1 — Presentation contract

- [x] [T001] Inspect current Main scene research-adjacent UI structure in `scenes/main/main.tscn` and `scenes/main/main.gd`.
- [x] [T002] Add the smallest read-only research presentation query to `autoload/game_state.gd` only if the UI cannot render human-readable step metadata through existing state.

## Phase 2 — Playable interaction

- [x] [T003] Add research presentation nodes to `scenes/main/main.tscn` without broad unrelated layout refactors.
- [x] [T004] Render only IDs returned by `GameState.available_research_step_ids()` in `scenes/main/main.gd`.
- [x] [T005] Submit completion exclusively through `GameState.complete_research_step()` and refresh canonical availability after every attempt.
- [x] [T006] Render semantic outcome/evidence/canon-guardrail information without resolving protected uncertainty.

## Phase 3 — Regression coverage

- [x] [T007] Add `tests/research_presentation_test.gd` covering availability, ordered progression, completion refresh, stale-action safety and RNG stability.
- [x] [T008] Wire the new regression and required presentation artifacts into `tools/validate_project.py` and the existing validation workflow.

## Phase 4 — Documentation and convergence

- [x] [T009] Update `docs/ARCHITECTURE.md` to describe the research presentation boundary.
- [ ] [T010] Run the full repository validation suite and resolve any regression.
- [x] [T011] Reconcile implementation against `spec.md`, this plan and every requirement in `checklists/requirements.md`.
- [ ] [T012] Update `docs/SIGA-HANDOFF.md` with exact final head, CI evidence and next V0.5 action.
