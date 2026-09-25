# Implementation Plan: Policy / Institutional Surface

**Feature:** rb-09-policy-institutional-surface  
**Spec:** [spec.md](./spec.md)  
**Planning state:** Implemented in PR #79 — validation/delivery closure pending

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

1. Mount Institutional as a shell destination.
2. Build read models from existing policy/institution resources/state.
3. Route participation/enactment through canonical orchestration.
4. Render effects/prerequisites neutrally.
5. Link compliance/community context without duplication.
6. Test enactment plus non-ranking/content boundaries.

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

## Current implementation

- `GameState.institutional_snapshot()` is the presentation read boundary for institution level, all canonical policy definitions/states, Influence, compliance/community context and civic participation.
- Policy availability/reasons come from `PolicyService.resolve_enactment()`; the scene does not reproduce policy gates.
- Civic participation uses centralized GameState constants/read state and the existing `civic_engagement()` command.
- Institucional owns the detailed fictional policy surface while preserving RB-06 compliance behavior in the same destination.
- `tests/policy_progression_test.gd` now covers blocked/available/enacted presentation, surface-command parity, civic participation parity, RNG stability and neutral-content boundaries.
- No save-schema change is required.
- The wave intentionally avoids `tools/validate_project.py`, which is concurrently modified by CENA PR #78.
