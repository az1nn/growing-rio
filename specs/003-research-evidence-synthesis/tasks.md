# Tasks: Research Evidence Boundary Synthesis

## Phase 1 — Content contract

- [x] [T001] Add the Resource-backed `research_evidence_boundary_synthesis` contract.
- [x] [T002] Register the fourth step in the canonical GameState research catalog.

## Phase 2 — Regression coverage

- [x] [T003] Extend `tests/research_chain_test.gd` to cover four-step ordering, protected uncertainties, RNG stability, duplicate prevention and save round-trip.
- [x] [T004] Extend `tests/research_presentation_test.gd` so the existing UI advances from step three to step four and then completes.

## Phase 3 — Structural/documentation convergence

- [x] [T005] Update `tools/validate_project.py` for the new Resource and four-step contract.
- [x] [T006] Update `docs/ARCHITECTURE.md` with the fourth research step and its chronology boundary.
- [x] [T007] Run/reconcile the full repository validation suite.
- [x] [T008] Reconcile implementation against `spec.md`, `plan.md` and the requirements checklist.
- [x] [T009] Persist verified PR/gate/next-action state in `docs/SIGA-HANDOFF.md`.
