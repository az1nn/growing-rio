# Implementation Plan: Community Feedback

**Feature:** rb-08-community-feedback  
**Spec:** [spec.md](./spec.md)  
**Planning state:** Implemented in stacked PR #77 — exact-head validation and guarded delivery pending

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

1. Keep Cidade as the detailed owner and read one `GameState.community_snapshot()` presentation boundary.
2. Expose active-district support and global Reputation as separate values without changing `CommunityService`.
3. Track only presentation-local previous readings to describe observed deltas; never duplicate or infer the domain formula.
4. Reset transition context when the canonical active district changes so old district state is never presented as current.
5. Keep campaign linkage static, coarse and neutral; do not expose ending predicates, thresholds, rankings or preferred outcomes.
6. Extend the existing City/community regression suite and structural validator; reserve campaign-gate changes for RB-14.

## Reconciled Touchpoints

- `autoload/game_state.gd` — adds presentation-only `community_snapshot()`.
- `scenes/city/city_surface.gd` / `.tscn` — renders district support, global Reputation and bounded transition feedback.
- `tests/city_surface_test.gd` / `tests/community_feedback_test.gd` — lock synchronization, separation and no-formula behavior.
- `tools/validate_project.py` — requires the community presentation boundary.
- Spec Kit, architecture, roadmap and SIGA handoff docs — record verified delivery state.

No `domain/`, Resource catalog or save-service mutation is required.

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

## Current PR boundary

PR #77 is intentionally stacked on RB-07 PR #76. Vercel rate limiting is `SOFT_GATE_RATE_LIMIT`: it defers merge/provider proof but does not permit bypassing exact-head repository validation. No CENA files are changed.
