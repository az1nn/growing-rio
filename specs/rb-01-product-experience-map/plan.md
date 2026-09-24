# Implementation Plan: Product Experience Map

**Feature:** rb-01-product-experience-map  
**Spec:** [spec.md](./spec.md)  
**Planning state:** COMPLETE — PR #60 merged and post-merge validated

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

1. Create a surface inventory with purpose, primary actions, global information and transitions.
2. Create a system-to-surface ownership matrix from the re-baseline.
3. Model shell navigation and return semantics independently of scene implementation.
4. Define narrative/campaign interruption semantics.
5. Record portrait-first and wide-layout constraints.
6. Use the accepted map as the architectural input for later RB work.

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

## Implementation result

`docs/PRODUCT-EXPERIENCE-MAP.md` now materializes the proposed design as the canonical product architecture input for RB-02. No runtime implementation is part of RB-01.

## Current MR boundary

PR #60 completed the documentation-only RB-01 implementation and was merged to `master` after exact-head validation.
