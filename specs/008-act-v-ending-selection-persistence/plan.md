# Implementation Plan: Act V Ending Selection Persistence

**Feature:** 008-act-v-ending-selection-persistence  
**Spec:** [spec.md](./spec.md)

## Technical Context

- Engine: Godot 4.7.2
- Language: GDScript
- Eligibility domain: `domain/ending/ending_eligibility_service.gd`
- New selection domain: `domain/ending/ending_selection_service.gd`
- Orchestration: `autoload/game_state.gd`
- Persistence: `autoload/save_service.gd`, schema v11
- Validation: structural validator + headless Godot regressions + exact-head CI
- Delivery: existing Web/Vercel path; do not bypass a failed exact-head gate.

## Constitution Check

- Repository reality first: PASS — branch starts from verified `master@2b51cd4f0d26b1b12745e471d4810f69e61af5e1`.
- Spec-first: PASS — implementation follows this bounded feature.
- UI/domain separation: REQUIRED — selection lives in a pure domain service and GameState.
- Determinism: REQUIRED — no RNG consumption.
- Persistence discipline: schema bump REQUIRED because selection is new canonical state.
- Migration discipline: v10 must load with an empty selection; v1-v9 behavior remains supported.
- Canon/safety: REQUIRED — no ending ranking, winner or moral preference.
- Small coherent wave: PASS — selection + persistence only.
- Exact-head evidence: REQUIRED before merge.

## Design

### 1. Pure ending-selection service

Add `EndingSelectionService` with one transition:

`select_ending(current_ending_id, requested_ending_id, eligible_ending_ids)`

The service:
- rejects requests when a selection already exists;
- rejects empty/ineligible IDs;
- accepts exactly one currently eligible stable ID;
- returns transition data only;
- consumes no RNG and contains no scoring/ranking logic.

### 2. GameState selection boundary

GameState will add:
- `selected_ending_id := ""`;
- `EndingSelectionService` instance;
- `select_ending(ending_id)`;
- known-ending validation based on the existing eligibility service constants.

The command delegates eligibility to `eligible_ending_ids()`; it does not duplicate readiness predicates. Successful selection emits state change but does not complete the final arc or invoke a coda/handoff.

### 3. Save schema v11

Keep `create_v10` as an actual v10 constructor for migration fixtures.

Add `create_v11` that extends v10 with:

`campaign.selected_ending_id`

Parsing behavior:
- versions 1..9 remain unchanged;
- v10 parses the prior campaign shape;
- v11 requires a string `selected_ending_id`;
- GameState validates that any non-empty loaded ID is one of the six known ending-family IDs;
- v10 and earlier load with an empty selected ending.

### 4. Regression coverage

Add `tests/act_v_ending_selection_test.gd` covering:
- ineligible selection rejection;
- eligible selection;
- immutable second selection;
- no RNG consumption;
- schema-v11 round-trip;
- v10 migration to empty selection;
- rejection of unknown persisted ending IDs.

Update the existing save-schema regression to treat v11 as current and add explicit v10 migration coverage.

### 5. Structural/docs convergence

Update:
- `.github/workflows/validate.yml`;
- `tools/validate_project.py`;
- `docs/ARCHITECTURE.md`;
- `docs/SIGA-HANDOFF.md` only from live branch/PR/gate facts.

## Expected Files

- `specs/008-act-v-ending-selection-persistence/*`
- `domain/ending/ending_selection_service.gd`
- `autoload/game_state.gd`
- `autoload/save_service.gd`
- `tests/act_v_ending_selection_test.gd`
- `tests/save_schema_test.gd`
- `.github/workflows/validate.yml`
- `tools/validate_project.py`
- `docs/ARCHITECTURE.md`
- `docs/SIGA-HANDOFF.md`

## Validation Strategy

1. Structural validator.
2. Godot import smoke.
3. Existing simulation/domain/campaign/research regressions.
4. Existing final-form eligibility regression.
5. New ending-selection regression.
6. Save-v11 round-trip plus v10..v1 migration regression.
7. Open-PR overlap scan and latest-master reconciliation.
8. Exact current PR-head CI and Vercel.
9. Guarded merge only if exact-head gates are green.
10. Post-merge default-head validation and final handoff persistence.
