# Implementation Plan: Research Presentation Surface

**Feature:** 001-research-presentation  
**Spec:** [spec.md](./spec.md)

## Technical Context

- Engine: Godot 4.7.2
- Language: GDScript
- Main presentation surface: `scenes/main/main.tscn` + `scenes/main/main.gd`
- Canonical orchestration: `autoload/game_state.gd`
- Research domain: `domain/research/research_service.gd`
- Research content: `resources/research/*.tres`
- Existing persistence: save schema v10
- Validation: `tools/validate_project.py` plus headless Godot regressions

## Constitution Check

- Repository-first verification: PASS — feature derives from current SIGA handoff and merged research-chain state.
- Spec-first delivery: PASS — bounded spec exists before implementation.
- UI/domain separation: REQUIRED — UI may query/render/command only.
- Persistence discipline: PASS — schema v10 remains unless a new canonical state shape is proven necessary.
- Canon/safety boundaries: REQUIRED — uncertainty guardrails remain intact.
- Exact-head evidence: REQUIRED before merge.
- Small coherent wave: PASS — presentation only; no new research content.

## Design

### 1. Query boundary

Keep `GameState.available_research_step_ids()` as the authority for availability.

If the current UI cannot obtain display-safe metadata without reading Resource internals directly, add the smallest read-only GameState query needed to expose presentation data for a known research step. That query MUST NOT own progression logic or mutate state.

### 2. Command boundary

All completion requests flow through:

```text
GameState.complete_research_step(step_id)
```

The UI does not call `ResearchService` directly and does not recreate prerequisite rules.

### 3. Presentation state

The Main scene renders:
- currently available step label(s);
- an action for the selected/available step;
- semantic completion output, including evidence tags/system signals/canon guardrails in a readable form.

Presentation state is ephemeral. Canonical completion remains in `campaign.narrative_flags`.

### 4. Refresh model

After any research completion attempt:
1. render the returned outcome;
2. re-query canonical availability;
3. redraw the research surface.

A rejected/stale action leaves canonical state unchanged and refreshes from GameState.

### 5. Testing

Add a headless UI regression that:
- reaches or seeds the canonical precondition state using repository-supported APIs;
- verifies step 1 appears and step 2 does not;
- triggers step 1 through the UI;
- verifies step 2 becomes actionable;
- triggers step 2 through the UI;
- verifies no remaining action;
- verifies protected uncertainty text/guardrail is represented;
- verifies no additional RNG draw from the research interactions.

Existing domain and save tests continue to own ordered progression and persistence invariants.

## Expected Files

Likely implementation files:
- `scenes/main/main.tscn`
- `scenes/main/main.gd`
- `autoload/game_state.gd` only if a read-only presentation query is needed
- `tests/research_presentation_test.gd`
- `tools/validate_project.py`
- `docs/ARCHITECTURE.md`
- `docs/SIGA-HANDOFF.md`

No new research Resource is planned for this feature.

## Validation Strategy

1. Structural validation.
2. Existing research-chain regression.
3. New research-presentation headless regression.
4. Existing narrative/campaign regressions.
5. Existing save-schema v10 round-trip/migration regression.
6. Exact-head GitHub Actions validation before merge.
