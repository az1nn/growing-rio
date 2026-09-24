# Implementation Plan: Rooms / Staff / Upgrades

**Feature:** rb-04-rooms-staff-upgrades  
**Spec:** [spec.md](./spec.md)  
**Planning state:** Implemented — exact-head validation/merge closure pending

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

## Proposed Design

1. Create an Operation-owned management detail flow.
2. Read room/staff/upgrade catalogs and ownership from current domain/resource boundaries.
3. Use thin command adapters for switch/hire/acquire.
4. Present costs/effects as data, not UI constants.
5. Refresh Operation after room changes.
6. Test transitions and persistence parity.

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

## Implemented design

The implementation consumes the existing RB-03 Operation-owned management handoff.

- `GameState.management_snapshot()` exposes display-safe room/staff/upgrade metadata, ownership/availability state, canonical operating cost and stability modifier.
- `OperationSurface` renders the snapshot and submits only the existing switch/hire/purchase commands.
- `tests/management_surface_test.gd` compares UI-driven transitions with direct canonical commands and verifies save-v11 round-trip parity.
- No persistence schema, resource definition, economy formula or balance value changes in RB-04.

The implementation remains delivery-incomplete until exact-head CI is green and the inherited provider gate permits guarded bottom-up merge.
