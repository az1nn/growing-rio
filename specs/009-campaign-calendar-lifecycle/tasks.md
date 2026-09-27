# Tasks: 365-Day Campaign Calendar & Abstract Plant Lifecycle

## Phase 1 — Specification and dependency

- [x] [T001] Reconcile live prototype timing: campaign max 30 days, Quarto Clássica cycle 8 days, persisted `day` and per-room `grow_day`.
- [x] [T002] Define the bounded 365-day / 90-day lifecycle specification from lore PR #123 without introducing runtime code.
- [x] [T003] After PR #123 merged, reconcile this spec branch onto current `master` and refresh exact dependency evidence.

## Phase 2 — Balance contract

- [x] [T004] Define the abstract game-only day boundaries for `seedling → Vega → flora → late flowering`, preserving `pronta` at the 90-day completion boundary.
- [x] [T005] Add validation for monotonic stage ordering and the 90-day total; document explicitly that the split is pacing data, not cultivation guidance.

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


## T003 reconciliation evidence

- Lore PR #123 merged to `master` as `2dd01c8d9921b9ddcfdb1d49a390305db63dd6d7`.
- Feature 009 branch was reconciled non-force with that exact master state as `f3e3ed070d1732441abf6de200445c81cb5132a0` before this task-state persistence.
- PR #125 now targets `master` directly; lore dependency is resolved.


## T004 balance-contract evidence

- Added `specs/009-campaign-calendar-lifecycle/balance.md`.
- Shipped game-only ranges are `[0,22)`, `[22,45)`, `[45,68)`, `[68,90)`; `pronta` begins at `grow_day >= 90`.
- The split is deliberately near-even game pacing and is explicitly non-horticultural.
- T005 is now delivered by the machine-readable balance contract plus CI validator; T006 is the next implementation task.


## T005 automated-balance evidence

- Added `specs/009-campaign-calendar-lifecycle/balance.json` as the machine-readable pacing contract.
- Added `tools/validate_lifecycle_balance.py` and wired it into `Validate project` CI.
- Validation enforces exact stage IDs/order, positive contiguous ranges, unique coverage of every integer day 0–89, a 90-day total, and `pronta` beginning exactly at day 90.
- Validation also requires explicit `game_pacing_only` / non-cultivation-guidance markers and checks the human-readable balance disclaimer.
- No gameplay/runtime/save behavior changes in T005. T006 is next: campaign max 30 → 365 with explicit Day-365 closure semantics.
