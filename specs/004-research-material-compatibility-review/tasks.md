# Tasks: Research Material Compatibility Review

## Phase 1 — Canonical research contract

- [ ] [T001] Add the Resource-backed `research_material_compatibility_review` contract.
- [ ] [T002] Register the fifth step in the canonical GameState research catalog.
- [ ] [T003] Add readable presentation semantics for limited material compatibility and its lineage guardrail.

## Phase 2 — Regression coverage

- [ ] [T004] Extend `tests/research_chain_test.gd` for deferred Act IV evidence gating, fifth-step completion, protected uncertainty, RNG stability, duplicate prevention and save round-trip.
- [ ] [T005] Extend `tests/research_presentation_test.gd` for automatic no-action -> fifth-step -> complete transitions through canonical state.

## Phase 3 — Structural/documentation convergence

- [ ] [T006] Update `tools/validate_project.py` for the new Resource and five-step research contract.
- [ ] [T007] Update `docs/ARCHITECTURE.md` with the future-Act-IV evidence bridge and keep the research-chain roadmap item open.
- [ ] [T008] Run/reconcile the full repository validation suite.
- [ ] [T009] Reconcile implementation against `spec.md`, `plan.md` and the requirements checklist.
- [ ] [T010] Persist verified PR/gate/next-action state in `docs/SIGA-HANDOFF.md`.
