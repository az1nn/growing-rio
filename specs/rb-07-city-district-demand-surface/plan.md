# Implementation Plan: City / District / Demand Surface

**Feature:** rb-07-city-district-demand-surface  
**Spec:** [spec.md](./spec.md)  
**Planning state:** Implemented on stacked RB-07 branch — delivery validation pending

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

1. Mount City as a shell destination.
2. Build browse/detail over existing resource/domain state.
3. Route district selection through GameState.
4. Present demand as canonical data.
5. Expose bounded Market/Community links.
6. Test switching/demand consistency.

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

- detailed owner: Cidade;
- presentation read boundary: `GameState.city_snapshot()`;
- mutation boundary: existing `GameState.select_district()`;
- district demand remains owned by the existing deterministic `CityService`;
- Mercado displays the same canonical active district/demand and routes detail to Cidade;
- portrait interaction uses a bounded district list instead of a mandatory spatial map;
- RB-08 community presentation remains a separate follow-on slice;
- no persistence/schema change was required.

## Delivery boundary

Exact-current-head repository validation and provider evidence remain required before guarded delivery. Provider quota/rate limiting is merge-deferred and development-non-blocking under the repository policy.
