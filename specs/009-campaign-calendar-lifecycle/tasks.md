# Tasks: 365-Day Campaign Calendar & Abstract Plant Lifecycle

## Phase 1 — Specification and dependency

- [x] [T001] Reconcile live prototype timing: campaign max 30 days, Quarto Clássica cycle 8 days, persisted `day` and per-room `grow_day`.
- [x] [T002] Define the bounded 365-day / 90-day lifecycle specification from lore PR #123 without introducing runtime code.
- [ ] [T003] After PR #123 merges, reconcile this stacked spec branch onto current `master` and refresh exact dependency evidence.

## Phase 2 — Balance contract

- [ ] [T004] Define the abstract game-only day boundaries for `seedling → Vega → flora → late flowering`, preserving `pronta` at the 90-day completion boundary.
- [ ] [T005] Add validation for monotonic stage ordering and the 90-day total; document explicitly that the split is pacing data, not cultivation guidance.

## Phase 3 — Domain implementation

- [ ] [T006] Change campaign maximum from 30 to 365 with explicit Day-365 closure semantics.
- [ ] [T007] Change the shipped Quarto Clássica cycle from 8 to 90 days.
- [ ] [T008] Add pure deterministic lifecycle-stage derivation to the cultivation domain.
- [ ] [T009] Expose current stage through GameState/room presentation state without duplicating domain rules.
- [ ] [T010] Preserve one terminal harvest transition and prevent stage changes from awarding inventory.

## Phase 4 — Persistence and regression

- [ ] [T011] Keep lifecycle stage derived from existing persisted `grow_day`; avoid schema bump unless implementation proves unavoidable.
- [ ] [T012] Add regression for Day 365, 90-day readiness, early-harvest rejection and stage monotonicity.
- [ ] [T013] Add regression proving stage derivation consumes no RNG and stage transitions create no inventory.
- [ ] [T014] Add regression for four serial 90-day cycles = 360 days + five-day annual closure margin.
- [ ] [T015] Validate independent lifecycle derivation for multiple rooms.
- [ ] [T016] Re-run supported save v1-v11 migration/round-trip coverage.

## Phase 5 — Delivery

- [ ] [T017] Update structural validation and architecture documentation.
- [ ] [T018] Reconcile live open-PR/default-branch drift before final validation.
- [ ] [T019] Require full exact-head CI and required provider evidence.
- [ ] [T020] Guarded-merge only when exact-head delivery gates pass.
- [ ] [T021] Persist verified completion and next action in `docs/SIGA-HANDOFF.md`.
