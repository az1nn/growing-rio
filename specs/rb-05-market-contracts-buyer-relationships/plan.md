# Implementation Plan: Market / Contracts / Buyer Relationships

**Feature:** rb-05-market-contracts-buyer-relationships  
**Spec:** [spec.md](./spec.md)  
**Planning state:** Implemented in PR #72 — delivery closure pending

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

1. Mount Market as a shell destination.
2. Build channel, buyer and contract views from existing state/resources.
3. Route sell/accept/resolve through canonical orchestration.
4. Surface relationship/consequence feedback after transitions.
5. Add compact compliance/demand summaries and links.
6. Add deterministic command/state regressions.

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

## Implemented delivery

PR #72 mounts `scenes/market/market_surface.tscn` as the canonical Market destination, exposes a read-only `GameState.market_snapshot()` boundary, delegates sale/contract previews to the existing `EconomyService`, routes mutations only through existing GameState commands, and adds market presentation parity/save regression coverage. No domain formula, content definition or save-schema change was required.
