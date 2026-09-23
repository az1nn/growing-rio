# Implementation Plan: Onda Provenance Gap Research

**Feature:** 002-onda-provenance-research  
**Spec:** [spec.md](./spec.md)

## Technical Context

- Engine: Godot 4.7.2
- Language: GDScript
- Research model: `ResearchStepDefinition`
- Research domain: `domain/research/research_service.gd`
- Canonical orchestration: `autoload/game_state.gd`
- Existing presentation: `scenes/main/main.gd`
- Existing persistence: save schema v10
- Validation: structural Python validator + headless Godot regressions

## Constitution Check

- Repository-first verification: PASS.
- Spec-first delivery: PASS — this feature is specified before implementation.
- UI/domain separation: REQUIRED — UI remains query/render/command only.
- Determinism: REQUIRED — research completion consumes no RNG.
- Persistence discipline: PASS — new completion uses existing narrative flags in schema v10.
- Canon/safety boundaries: REQUIRED — provenance and lineage remain unresolved.
- Small coherent wave: PASS — one new research Resource plus catalog/test/doc changes.
- Exact-head evidence: REQUIRED before merge.

## Design

### 1. New research Resource

Add `resources/research/onda_provenance_gap_map.tres`.

Contract:
- stable ID: `research_onda_provenance_gap_map`;
- required prior flag: `research_symbol_order_compared`;
- preserved dispute flag: `lore_dalva_lucia_symbol_order_disputed`;
- forbidden resolved-order flag: `lore_dalva_lucia_symbol_order_resolved`;
- completion flag: `research_onda_provenance_gaps_mapped`;
- semantic evidence/guardrails only.

### 2. Catalog integration

Preload and register the new Resource in `GameState._research_step_catalog()`.

No new command/query API is required. Existing `available_research_step_ids()`, `research_step_presentation()` and `complete_research_step()` remain authoritative.

### 3. Presentation

No new scene logic is planned. The existing dynamic research presentation must discover the third step from canonical availability and display metadata through `research_step_presentation()`.

### 4. Persistence

The new completion flag is automatically part of the known narrative-flag set through the research catalog. Save schema remains v10.

### 5. Testing

Extend:
- `tests/research_chain_test.gd` for three-step ordering, RNG stability, duplicate prevention and save round-trip;
- `tests/research_presentation_test.gd` for automatic step-two -> step-three -> complete UI refresh.

Update structural validation to require the new Resource and Spec Kit artifacts.

## Expected Files

- `specs/002-onda-provenance-research/spec.md`
- `specs/002-onda-provenance-research/plan.md`
- `specs/002-onda-provenance-research/tasks.md`
- `specs/002-onda-provenance-research/checklists/requirements.md`
- `resources/research/onda_provenance_gap_map.tres`
- `autoload/game_state.gd`
- `tests/research_chain_test.gd`
- `tests/research_presentation_test.gd`
- `tools/validate_project.py`
- `docs/ARCHITECTURE.md`
- `docs/SIGA-HANDOFF.md`

## Validation Strategy

1. Structural validation.
2. Research-chain regression.
3. Research-presentation regression.
4. Existing narrative/campaign regressions.
5. Existing save-schema v10 round-trip/migration regression.
6. Full GitHub Actions validation on the exact final PR head.
