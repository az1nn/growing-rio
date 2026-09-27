# Implementation Plan: 365-Day Campaign Calendar & Abstract Plant Lifecycle

**Feature:** 009-campaign-calendar-lifecycle  
**Spec:** [spec.md](./spec.md)  
**Dependency:** RESOLVED — lore PR #123 merged to `master`; T004 balance contract is defined; T005 automated invariant validation is complete; T006 is the next implementation task

## Technical Context

Live repository inspection before this spec found (and revalidated after PR #123 merged):

- `autoload/game_state.gd` currently declares `MAX_DAYS := 30`;
- campaign `day` is already canonical persisted state;
- per-room cultivation already persists `grow_day`;
- `domain/cultivation/cultivation_service.gd` already derives readiness from `cycle_days`;
- `resources/cultivars/quarto_classica.tres` currently declares `cycle_days = 8`;
- save schema is currently v11;
- there is no persisted lifecycle-stage field today.

The preferred implementation therefore reuses existing state rather than adding a second clock.

## Constitution Check

- Repository reality first: PASS — this spec branch is stacked from the reconciled exact head of lore PR #123.
- Spec-first: PASS — no runtime mutation is included in this wave.
- Domain/UI separation: REQUIRED — lifecycle-stage derivation belongs in domain logic, not scene code.
- Determinism: REQUIRED — stage derivation must consume no RNG.
- Persistence discipline: EXPECT NO SCHEMA BUMP — stage is derived from existing `grow_day`; revisit only if implementation proves new canonical state is necessary.
- Canon/safety: REQUIRED — lifecycle labels remain abstract and non-operational.
- Small coherent wave: PASS — calendar/lifecycle only.
- Exact-head evidence: REQUIRED for implementation PR.

## Design

### 1. Campaign calendar boundary

Change the prototype campaign maximum from 30 to 365 while preserving the existing semantics that the current day is playable and the next advance beyond the maximum locks the simulation.

Add regression coverage specifically for the Day-365 → closure boundary to avoid an off-by-one implementation.

### 2. Canonical 90-day cycle

Keep `CultivarDefinition.cycle_days` as the current data boundary and make the shipped canonical cultivar conform to 90 days.

The implementation should add structural validation so shipped canonical cultivars cannot accidentally regress away from the 90-day contract without a deliberate spec/canon change.

### 3. Derived lifecycle-stage service

Extend cultivation-domain logic with a pure lifecycle-stage derivation function.

Inputs:
- current `grow_day`;
- canonical `cycle_days`;
- balance-owned pre-ready stage boundaries.

Output:
- exactly one stable stage ID.

The function must be deterministic, monotonic for increasing `grow_day`, and return `pronta` at cycle completion.

Do not persist the returned stage if it is fully derivable.

### 4. Balance-owned stage boundaries

The exact split is balance-owned rather than lore-owned. T004 defines the shipped game-only contract in `balance.md`:

- `seedling [0,22)`
- `Vega [22,45)`
- `flora [45,68)`
- `late flowering [68,90)`
- `pronta >= 90`

The split is intentionally near-even game pacing, not horticultural advice. T005 is implemented by `tools/validate_spec_009_balance.py`, which parses `balance.md` and enforces strict monotonic ordering, complete coverage of days 0–89, span arithmetic and the 90-day terminal boundary before runtime implementation proceeds.

### 5. Yield normalization

Preserve the existing single harvest transition. Stage changes themselves must not grant inventory.

Any existing health/quality/yield calculation remains separate from stage timing. The new regression should prove that lifecycle-state changes do not create extra harvest outputs.

### 6. Persistence

Prefer no schema change:
- `day` already persists;
- each room's `grow_day` already persists;
- lifecycle stage is derived.

Regression must load existing supported save fixtures and confirm the lifecycle derivation works after restoration without new serialized fields.

### 7. Validation and delivery

Expected implementation touch points:

- `autoload/game_state.gd`
- `domain/cultivation/cultivation_service.gd`
- `resources/cultivars/quarto_classica.tres`
- optional balance-only lifecycle configuration under `resources/` or `domain/cultivation/`
- cultivation/calendar regression tests
- `.github/workflows/validate.yml`
- `tools/validate_project.py`
- `docs/ARCHITECTURE.md`
- `docs/SIGA-HANDOFF.md`

No Three.js/CENA work is required by this spec.

## Validation Strategy

1. Validate 365-day campaign boundary including Day 365 and rejection/lock beyond it.
2. Validate 90-day readiness and harvest rejection before readiness.
3. Validate lifecycle stage ID set and monotonic order.
4. Validate stage derivation is RNG-free.
5. Validate stage transitions create no inventory.
6. Validate four serial 90-day cycles equal 360 days with five days remaining.
7. Validate independent room lifecycle derivation.
8. Run existing save schema v1-v11 migration and round-trip coverage.
9. Run full structural + headless Godot regression suite.
10. Reconcile open PR/master drift and require exact-head CI/provider evidence before guarded merge.
