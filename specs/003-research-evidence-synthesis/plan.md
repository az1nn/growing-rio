# Implementation Plan: Research Evidence Boundary Synthesis

**Feature:** 003-research-evidence-synthesis  
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
- Persistence discipline: PASS — completion uses existing narrative flags in schema v10.
- Canon/safety boundaries: REQUIRED — provenance, symbol order and historical/genetic lineage remain unresolved.
- Small coherent wave: PASS — one new research Resource plus catalog/test/doc changes.
- Exact-head evidence: REQUIRED before merge.

## Design

### 1. New research Resource

Add `resources/research/evidence_boundary_synthesis.tres`.

Contract:
- stable ID: `research_evidence_boundary_synthesis`;
- required prior flag: `research_onda_provenance_gaps_mapped`;
- preserved dispute flag: `lore_dalva_lucia_symbol_order_disputed`;
- forbidden resolved-order flag: `lore_dalva_lucia_symbol_order_resolved`;
- completion flag: `research_evidence_boundaries_synthesized`;
- evidence and guardrail metadata reuse already-supported presentation semantics.

### 2. Catalog integration

Preload and register the new Resource in `GameState._research_step_catalog()`.

No new command/query API is required. Existing `available_research_step_ids()`, `research_step_presentation()` and `complete_research_step()` remain authoritative.

### 3. Presentation

No new scene logic is planned. The existing dynamic research presentation must discover the fourth step from canonical availability and display its metadata through `research_step_presentation()`.

The feature SHOULD reuse evidence/guardrail IDs that already have readable UI labels, avoiding presentation-only vocabulary expansion.

### 4. Persistence

The new completion flag is automatically part of the known narrative-flag set through the research catalog. Save schema remains v10.

### 5. Testing

Extend:
- `tests/research_chain_test.gd` for four-step ordering, protected uncertainties, RNG stability, duplicate prevention and save round-trip;
- `tests/research_presentation_test.gd` for automatic step-three -> step-four -> complete UI refresh.

Update structural validation to require the new Resource and four-step research contract.

## Expected Files

- `specs/003-research-evidence-synthesis/spec.md`
- `specs/003-research-evidence-synthesis/plan.md`
- `specs/003-research-evidence-synthesis/tasks.md`
- `specs/003-research-evidence-synthesis/checklists/requirements.md`
- `resources/research/evidence_boundary_synthesis.tres`
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
