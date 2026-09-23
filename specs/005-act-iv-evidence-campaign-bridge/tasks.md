# Tasks: Act IV Evidence Campaign Bridge

## Phase 1 — Presentation and progression foundation

- [x] [T001] Add a read-only `GameState.narrative_event_presentation()` boundary and generalize Main narrative rendering beyond the first hardcoded event.
- [x] [T002] Add deterministic monotonic campaign facts for abstract business scale and council participation readiness.
- [x] [T003] Add explicit GameState event-to-arc completion orchestration without moving mutable arc behavior into NarrativeEventService.

## Phase 2 — Ato II / Ato III bridge

- [x] [T004] Add Resource-backed `event_act_ii_sol_photo_reveal` from the canonical Ato II closing beat and close `arc_o_negocio` on resolution.
- [x] [T005] Materialize canonical `event_bento_fita_farol` with preserved tape/provenance uncertainty.
- [x] [T006] Add Resource-backed `event_act_iii_council_invitation` gated by canonical tape evidence plus abstract business scale and close `arc_dois_mercados`.

## Phase 3 — Ato IV core spine

- [x] [T007] Materialize `event_isa_mesa_sem_palco` and `event_leilao_ferrugem`.
- [x] [T008] Materialize `event_ferrugem_quem_assina_memoria` and preserve mixed-evidence semantics.
- [x] [T009] Materialize `event_audiencia_periodo_verde` with fictional/systemic participation gating.
- [x] [T010] Materialize `event_foto_estrela` so every canonical route emits the three deferred research evidence flags without authenticating provenance/order/lineage.
- [x] [T011] Register the complete minimal spine in GameState and keep all event availability/consequences outside UI code.

## Phase 4 — Regression and persistence

- [x] [T012] Extend narrative service/catalog regressions for all new definitions, duplicate prevention and RNG independence.
- [x] [T013] Extend campaign-state/save-v10 regressions for new event IDs, arc IDs and narrative flags.
- [x] [T014] Add `tests/act_iv_evidence_bridge_test.gd` proving the natural path without manual arc/flag injection.
- [x] [T015] Prove both licensed and parallel abstract market routes remain capable of entering the campaign spine.
- [x] [T016] Extend research regressions to prove `event_foto_estrela` naturally unlocks and persists `research_material_compatibility_review`.

## Phase 5 — Structural/documentation convergence

- [x] [T017] Update `tools/validate_project.py` for feature 005 artifacts, new Resources and generalized narrative presentation.
- [x] [T018] Update `docs/ARCHITECTURE.md` with the minimal campaign spine, derived progression facts and event-to-arc boundary.
- [ ] [T019] Mark the V0.5 research-chain roadmap item complete only if the end-to-end natural path plus fifth research completion pass.
- [ ] [T020] Run/reconcile the full repository validation suite and fix any regression without broad unrelated refactors.
- [ ] [T021] Reconcile implementation against spec/plan/checklist and concurrent PR state.
- [ ] [T022] Persist exact final PR head, validation run, guarded merge result and final default-head evidence in `docs/SIGA-HANDOFF.md`.
