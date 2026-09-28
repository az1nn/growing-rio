# Tasks: 365-Day Campaign Calendar & Abstract Plant Lifecycle

## Phase 1 — Specification and dependency

- [x] [T001] Reconcile live prototype timing: campaign max 30 days, Quarto Clássica cycle 8 days, persisted `day` and per-room `grow_day`.
- [x] [T002] Define the bounded 365-day / 90-day lifecycle specification from lore PR #123 without introducing runtime code.
- [x] [T003] After PR #123 merged, reconcile this spec branch onto current `master` and refresh exact dependency evidence.

## Phase 2 — Balance contract

- [x] [T004] Define the abstract game-only day boundaries for `seedling → Vega → flora → late flowering`, preserving `pronta` at the 90-day completion boundary.
- [x] [T005] Add validation for monotonic stage ordering and the 90-day total; document explicitly that the split is pacing data, not cultivation guidance.

## Phase 3 — Domain implementation

- [x] [T006] Change campaign maximum from 30 to 365 with explicit Day-365 closure semantics.
- [x] [T007] Change the shipped Quarto Clássica cycle from 8 to 90 days.
- [x] [T008] Add pure deterministic lifecycle-stage derivation to the cultivation domain.
- [x] [T009] Expose current stage through GameState/room presentation state without duplicating domain rules.
- [x] [T010] Preserve one terminal harvest transition and prevent stage changes from awarding inventory.

## Phase 4 — Persistence and regression

- [x] [T011] Keep lifecycle stage derived from existing persisted `grow_day`; avoid schema bump unless implementation proves unavoidable.
- [x] [T012] Add regression for Day 365, 90-day readiness, early-harvest rejection and stage monotonicity.
- [x] [T013] Add regression proving stage derivation consumes no RNG and stage transitions create no inventory.
- [x] [T014] Add regression for four serial 90-day cycles = 360 days + five-day annual closure margin.
- [x] [T015] Validate independent lifecycle derivation for multiple rooms.
- [x] [T016] Re-run supported save v1-v11 migration/round-trip coverage.

## Phase 5 — Delivery

- [x] [T017] Update structural validation and architecture documentation.
- [x] [T018] Reconcile live open-PR/default-branch drift before final validation.
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
- T005 remains the next prerequisite: automate monotonic-order and 90-day-total validation before runtime implementation.


## T005 automated-validation evidence

- Added `tools/validate_spec_009_balance.py`, parsing the repository-owned `balance.md` contract rather than relying on horticultural assumptions.
- Validation requires the exact ordered ranges `[0,22)`, `[22,45)`, `[45,68)`, `[68,90)`, contiguous one-stage coverage for every integer day 0–89, and `pronta` at the Day-90 terminal boundary.
- Per-row span arithmetic is verified against each end-exclusive range.
- The validator fails if the explicit game-pacing / non-horticultural safety boundary disappears.
- `.github/workflows/validate.yml` executes the validator for exact pull-request heads.
- T006 is now the next dependency-ordered task; no runtime timing constant was changed in T005.


## T007 canonical-cycle evidence

- `resources/cultivars/quarto_classica.tres` now declares `cycle_days = 90`.
- The change reuses the existing `CultivarDefinition.cycle_days` domain boundary; no second timing source or persisted field was added.
- T006 remains inherited from parent PR #130; this slice does not alter Day-365 campaign closure semantics.
- T008 is the next dependency-ordered task: pure deterministic lifecycle-stage derivation in the cultivation domain.


## T008 lifecycle-stage derivation evidence

- `domain/cultivation/cultivation_service.gd` now owns the pure `lifecycle_stage(grow_day, cycle_days)` function.
- The shipped game-only thresholds remain explicit at 22 / 45 / 68 with `pronta` at cycle completion; no horticultural inference is introduced.
- The function consumes no RNG, performs no mutation and returns only the stable stage IDs from the Feature 009 spec.
- `tests/cultivation_lifecycle_stage_test.gd` covers boundary days, terminal readiness and repeated deterministic calls.
- Exact-head `Validate project` runs the lifecycle-stage regression.
- T009 is next: expose the derived stage through GameState/room presentation state without duplicating domain rules.


## T009 presentation-state evidence

- `GameState.current_lifecycle_stage()` delegates directly to `CultivationService.lifecycle_stage(grow_day, current_cycle_days())`.
- `management_snapshot().rooms[]` now exposes `lifecycle_stage` derived independently from each room's existing cultivation state and cultivar definition.
- No lifecycle thresholds are duplicated in GameState; the cultivation domain remains the single rule owner.
- `tests/lifecycle_stage_presentation_test.gd` verifies the initial `seedling` presentation, the Day-22 `Vega` transition and read-only snapshot behavior.
- Exact-head `Validate project` now runs the T009 presentation regression.
- No save field or schema bump is introduced; T010 is next in dependency order.


## T010 terminal-harvest invariant evidence

- Added `tests/lifecycle_harvest_invariant_test.gd` as a test-only invariant slice; no runtime harvest/yield formula changed.
- The regression keeps inventory at zero across pre-terminal lifecycle progression and confirms an early harvest is rejected without moving `grow_day`.
- Reaching `pronta` alone still awards no inventory; inventory appears only after the explicit terminal `harvest()` transition.
- A repeated harvest attempt cannot create a second batch while the first batch remains in inventory.
- Exact-head `Validate project` now executes this regression.
- T011 is next in dependency order: prove lifecycle stage remains derived across persistence with no schema bump.


## T011 derived-persistence evidence

- Save schema remains v11; no runtime or SaveService schema mutation is introduced.
- `tests/lifecycle_stage_persistence_test.gd` advances to a non-initial stage, saves, reloads and proves the stage is reconstructed from the persisted room `grow_day`.
- The regression explicitly rejects any persisted `lifecycle_stage` field in the room cultivation payload or top-level payload.
- A round-trip remains schema v11 and still omits derived stage state.
- An adjusted persisted `grow_day = 68` reloads as `late flowering`, proving the loaded stage follows canonical persisted timing rather than a duplicate stage field.
- Exact-head `Validate project` now runs this regression.
- T012 is next in dependency order.


## T012 core calendar/lifecycle regression evidence

- Added `tests/campaign_lifecycle_core_regression_test.gd` as a regression-only integration slice.
- Day 364 advances into playable Day 365; the next advance reaches the closure boundary and locks the campaign.
- The canonical cycle remains exactly 90 growth days; `grow_day = 89` is not `pronta`, early harvest is rejected without inventory or growth mutation, and Day 90 exposes `pronta` with harvest availability.
- A full day 0-90 scan asserts lifecycle-stage rank never moves backward and terminates at `pronta`.
- `.github/workflows/validate.yml` executes the T012 regression on exact pull-request heads.
- No runtime, save-schema, economy, yield, RNG, visual or lore semantics changed.
- T013 is next in dependency order: prove lifecycle derivation consumes no RNG and stage transitions create no inventory.


## T013 RNG/inventory invariant evidence

- Added `tests/lifecycle_rng_inventory_invariant_test.gd` as a regression-only integration slice.
- Repeated `GameState.current_lifecycle_stage()` derivation preserves the exact simulation RNG state, proving lifecycle-stage reads consume no RNG.
- A full 0-to-90-day lifecycle scan observes the four ordered stage transitions and asserts inventory remains unchanged across every transition.
- Reaching `pronta` still creates no inventory; inventory remains reserved for the explicit terminal `harvest()` command.
- `.github/workflows/validate.yml` executes the T013 regression on exact pull-request heads.
- No runtime, save-schema, economy, yield, visual, lore or balance semantics changed.
- T014 is next in dependency order: prove four serial 90-day cycles consume 360 days and leave the five-day annual closure margin.


## T014 four-cycle annual-margin evidence

- Added `tests/campaign_annual_cycle_margin_test.gd` as a regression-only integration slice.
- The test executes four serial 90-day cultivation cycles, requiring `pronta` at each terminal boundary, explicit harvest, inventory-clearing sale, and a fresh lifecycle before the next cycle.
- Four cycles consume exactly 360 campaign-day advances, leaving playable days 361-365 as the five-day annual closure margin.
- Day 365 remains playable; the following advance reaches Day 366 and closes the campaign.
- `.github/workflows/validate.yml` executes the T014 regression on exact pull-request heads.
- No runtime, save-schema, economy, yield, RNG, visual or lore semantics changed.
- T015 is next in dependency order: validate independent lifecycle derivation for multiple rooms.


## T015 multi-room lifecycle-derivation evidence

- Added `tests/lifecycle_multi_room_derivation_test.gd` as a regression-only multi-room slice.
- The first room advances to `Vega` before a second room is added, proving a newly created room starts independently at `seedling` / `grow_day = 0`.
- After 23 more campaign advances, room_1 is independently at `grow_day = 45` / `flora` while room_2 is at `grow_day = 23` / `Vega`.
- Switching the active room updates the UI-facing cache to each room's own derived stage without changing either room's canonical cultivation state.
- `.github/workflows/validate.yml` executes the T015 regression on exact pull-request heads.
- No runtime, save-schema, economy, yield, RNG, visual, lore or balance semantics changed.
- T016 is next in dependency order: re-run supported save v1-v11 migration/round-trip coverage.


## T016 save compatibility revalidation evidence

- The canonical `tests/save_schema_test.gd` already exercises JSON round-trip for schema v11 and migration/load compatibility for every supported legacy schema v1 through v10.
- The same regression preserves canonical room cultivation `grow_day` through legacy v1/v2 migration and preserves complete room cultivation state for v3+ payloads; lifecycle stage remains derived and is not added to the persisted schema.
- `autoload/save_service.gd` remains at `SCHEMA_VERSION = 11`; Feature 009 requires no schema bump.
- Exact parent head `#143@8a86bccb56e0396a009515973f524c527356cf42` passed Validate project run `36346994144`, whose workflow includes the canonical save-schema v11 round-trip and v1-v10 migration step.
- PR #144 is a documentation/evidence child only; its own final exact-head validation is still required for delivery.
- T017 is next: update structural validation and architecture documentation for the completed Feature 009 lifecycle contract.


## T017 structural-validation and architecture evidence

- Added `t017-structural-validation-contract.md` to make the Feature 009 structural boundary explicit before delivery closure.
- `tools/validate_project.py` now requires the 365-day campaign constant, the GameState lifecycle read boundary, the domain lifecycle derivation API, the shipped 22/45/68 thresholds, all five stable stage IDs and `Quarto Clássica cycle_days = 90`.
- `docs/ARCHITECTURE.md` now records the 365-day / 90-day timing model, derived non-persisted stage state, room-local derivation, RNG/inventory invariants and the 360+5 annual arithmetic.
- Behavioral correctness remains covered by the T012-T016 headless regressions rather than duplicated as structural text checks.
- No runtime, save-schema, gameplay, economy, RNG, yield, visual or lore behavior changed.
- T018 is next: reconcile live open-PR/default-branch drift before final validation.


## T018 live-drift reconciliation evidence

- Reconciled `master@a8d1c3efae578e1325cd69783108a4f0aa5747b9` against the active Feature 009 stack.
- Verified linear delivery ancestry `master -> #137 -> #139 -> #140 -> #141 -> #142 -> #143 -> #144 -> #145`; every dependency comparison reported `behind_by = 0` at the reconciliation barrier.
- Open-PR session scan found exactly one `009:T018` owner: PR #146; no competing claim exists.
- PR #145 entered T018 with exact-head Validate + Visual success; Vercel remains explicit `SOFT_GATE_RATE_LIMIT`.
- T018 is delivery/documentation-only and changes no runtime, save-schema, gameplay, economy, RNG, yield, visual or lore semantics.
- T019 is next: require full exact-head CI and required provider evidence for the persisted T018 head before guarded delivery.
