# Implementation Plan: Save / Load / Campaign UX

**Feature:** rb-11-save-load-campaign-ux  
**Spec:** [spec.md](./spec.md)  
**Planning state:** Runtime implementation active — intentionally stacked on RB-10 PR #81

## Technical Context

- Engine: Godot 4.7.2
- Language: GDScript
- Product source: `docs/SPEC-KIT-PRODUCT-REBASELINE.md`
- Canon/safety: constitution + `docs/lore/*`
- Validation: structural validator, relevant headless Godot regressions, scene/import smoke and exact-head CI as applicable

## Constitution Check

- Repository reality first: **REQUIRED**
- Spec-first: **PASS**
- UI/domain separation: **REQUIRED**
- Determinism/RNG stability: **REQUIRED**
- Persistence versioning/migrations when canonical shape changes: **REQUIRED**
- Canon/fiction/safety boundaries: **REQUIRED**
- Small coherent implementation wave: **REQUIRED**
- Exact-head evidence before implementation completion: **REQUIRED**

## Implemented Design

1. `persistence/campaign_slot_store.gd` owns durable `user://` slot I/O and a small storage envelope; canonical payload shape remains SaveService-owned.
2. `GameState.create_save_data()` remains the only payload creation path used by player controls.
3. `GameState.load_save_data()` remains the load authority, so parsing, migrations, known-content validation and atomic mutation stay centralized.
4. The RB-10 shell overlay hosts startup Continue/New and in-session Save/Load/New flows without persisting shell destination or overlay state.
5. Existing slot overwrite and New Campaign both require explicit confirmation; New Campaign preserves the old slot until a later confirmed overwrite.
6. `tests/campaign_persistence_test.gd` covers current-schema round-trip, v10 migration through the slot path, corrupt JSON feedback and invalid-content atomicity.
7. `.github/workflows/validate.yml` runs the new regression on exact PR heads.

## Expected Touchpoints

Exact paths MUST be reconciled from the live implementation branch. Candidate classes are `scenes/`, `autoload/game_state.gd` only when orchestration exposure is missing, `domain/` only for proven domain gaps, `resources/`, `tests/`, `tools/validate_project.py`, and architecture/roadmap/handoff docs.

## Persistence Impact

Do not assume a schema change from UI scope. Reuse current canonical state where sufficient. If implementation needs new canonical state, amend the spec first, version the save boundary, preserve supported migrations, and add round-trip/migration coverage.

## Validation Strategy

1. Reconcile live master, open PRs, relevant specs and handoffs.
2. Confirm dependencies and Product Experience Map assumptions.
3. Implement the smallest coherent slice.
4. Run structural validation and Godot import/smoke.
5. Run targeted and affected regression suites.
6. Validate portrait Web/mobile behavior for presentation changes.
7. Validate save/load equivalence when canonical state is touched.
8. Reconcile exact current PR head and overlaps.
9. Require repository-defined exact-head evidence before guarded merge.
10. Persist final verified state and next RB action.

## Concurrency / delivery boundary

- Branch: `feat/rb-11-save-load-campaign-ux`.
- Immediate stack base: RB-10 PR #81 head `c7ce8caf8b53afe7184715a5584a6149aca61ca0`.
- Vercel explicit build-rate limiting is inherited as `SOFT_GATE_RATE_LIMIT`; it does not block bounded development but still defers guarded merge/public-delivery claims.
- Before merge, re-read RB-10, master and all open PR overlaps; once #81 merges, reconcile/revalidate RB-11 against its updated base.
