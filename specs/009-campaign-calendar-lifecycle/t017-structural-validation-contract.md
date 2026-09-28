# T017 — Structural Validation & Architecture Contract

Feature: `009-campaign-calendar-lifecycle`  
Task: `T017`  
Scope: repository validation + architecture documentation only.

## Structural invariants

The final Feature 009 delivery must keep these repository-owned contracts explicit:

- campaign maximum is `365` in `GameState`;
- `Quarto Clássica` remains a `90`-day canonical cycle;
- lifecycle stage is derived by `CultivationService.lifecycle_stage()`;
- shipped game-only thresholds remain `22 / 45 / 68 / 90`;
- stable stage IDs remain `seedling → Vega → flora → late flowering → pronta`;
- `GameState.current_lifecycle_stage()` exposes the derived stage without duplicating the rule;
- lifecycle stage is not new canonical save state and save schema remains v11;
- stage reads are deterministic/RNG-free and stage transitions do not create inventory;
- room lifecycle state remains independent because each room owns its persisted `grow_day`.

These values are game pacing data only. They are not horticultural guidance.

## Validator changes

`tools/validate_project.py` must fail when any of the following drifts without an explicit Feature 009 contract update:

1. `GameState.MAX_DAYS` is no longer `365`;
2. `GameState.current_lifecycle_stage()` disappears;
3. `CultivationService.lifecycle_stage()` disappears;
4. one of the shipped lifecycle thresholds or stable stage IDs changes;
5. `resources/cultivars/quarto_classica.tres` no longer declares `cycle_days = 90`.

Behavioral invariants remain owned by the existing headless regressions from T012-T016 rather than being reimplemented as text parsing.

## Architecture changes

`docs/ARCHITECTURE.md` must describe the Feature 009 boundary:

- 365-day campaign calendar;
- 90-day canonical cultivation cycle;
- derived, non-persisted lifecycle stage;
- room-local derivation;
- deterministic/RNG-free stage reads;
- one explicit harvest transition;
- four serial cycles consume 360 days, leaving five playable closure-margin days.

## Delivery

T017 is complete only when:

- the validator and architecture documentation are updated;
- `tasks.md` records T017 complete;
- the temporary session claim is removed;
- the PR receives fresh exact-head CI;
- downstream T018 remains responsible for final live PR/default-branch drift reconciliation.

No runtime, save-schema, gameplay, economy, RNG, yield, visual or lore behavior is changed by T017.
