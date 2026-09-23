# Tasks: Onda Provenance Gap Research

## Phase 1 — Content contract

- [ ] [T001] Add the Resource-backed `research_onda_provenance_gap_map` contract.
- [ ] [T002] Register the third step in the canonical GameState research catalog.

## Phase 2 — Regression coverage

- [ ] [T003] Extend `tests/research_chain_test.gd` to cover three-step ordering, guardrails, RNG stability, duplicate prevention and save round-trip.
- [ ] [T004] Extend `tests/research_presentation_test.gd` so the existing UI advances from step two to step three and then completes.

## Phase 3 — Structural/documentation convergence

- [ ] [T005] Update `tools/validate_project.py` for the new Resource and Spec Kit artifacts.
- [ ] [T006] Update `docs/ARCHITECTURE.md` with the third research step and preserved uncertainty boundary.
- [ ] [T007] Run/reconcile the full repository validation suite.
- [ ] [T008] Reconcile implementation against `spec.md`, `plan.md` and the requirements checklist.
- [ ] [T009] Persist verified PR/gate/next-action state in `docs/SIGA-HANDOFF.md`.
