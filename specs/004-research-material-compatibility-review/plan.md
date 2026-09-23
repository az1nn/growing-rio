# Implementation Plan: Research Material Compatibility Review

**Feature:** 004-research-material-compatibility-review  
**Spec:** [spec.md](./spec.md)

## Technical Context

- Engine: Godot 4.7.2
- Language: GDScript
- Research model: `ResearchStepDefinition`
- Research domain: `domain/research/research_service.gd`
- Canonical orchestration: `autoload/game_state.gd`
- Existing presentation: `scenes/main/main.gd`
- Existing persistence: save schema v10
- Canon source: `docs/lore/ACT-IV-NARRATIVE-EVENT-LIBRARY.md`
- Validation: structural Python validator + headless Godot regressions

## Constitution Check

- Repository-first verification: PASS.
- Spec-first delivery: PASS — this feature is specified before implementation.
- UI/domain separation: REQUIRED — eligibility remains in Resource/service/GameState.
- Determinism: REQUIRED — research completion consumes no RNG.
- Persistence discipline: PASS — evidence and completion reuse narrative flags in schema v10.
- Canon/safety boundaries: REQUIRED — limited material compatibility does not authenticate provenance, order or lineage.
- Small coherent wave: PASS — one research Resource plus catalog/presentation/test/doc convergence.
- Exact-head evidence: REQUIRED before merge.

## Design

### 1. New research Resource

Add `resources/research/material_compatibility_review.tres`.

Contract:
- stable ID: `research_material_compatibility_review`;
- required early-chain flag: `research_evidence_boundaries_synthesized`;
- required Act IV evidence flags:
  - `lore_material_origin_compatibility_established`;
  - `lore_star_mark_revealed`;
  - `lore_original_lineage_still_unproven`;
- required dispute flag: `lore_dalva_lucia_symbol_order_disputed`;
- forbidden flag: `lore_dalva_lucia_symbol_order_resolved`;
- completion flag: `research_material_compatibility_reviewed`.

The Resource intentionally does not use `unlock_after_event_id = event_foto_estrela`, because that event is not yet in the runtime narrative catalog. Canonical persisted evidence flags are the integration seam for future Act IV implementation.

### 2. Catalog integration

Preload and register the new Resource in `GameState._research_step_catalog()`.

No new command/query API is required. Existing `available_research_step_ids()`, `research_step_presentation()` and `complete_research_step()` remain authoritative.

### 3. Presentation semantics

Add a readable UI label for:
- `evidence_material_compatibility_limited`;
- `material_compatibility_does_not_prove_lineage`.

No prerequisite or ordering logic is added to the scene.

### 4. Persistence

All prerequisite and completion flags become known through the research catalog and persist inside existing schema-v10 `campaign.narrative_flags`. No schema bump is required.

### 5. Testing

Extend:
- `tests/research_chain_test.gd` for deferred unlock after step four, incremental Act IV flag gating, fifth-step completion, RNG stability, protected uncertainty, duplicate prevention and save round-trip;
- `tests/research_presentation_test.gd` for no-action after step four, automatic appearance after final evidence flag, fifth-step completion and readable evidence/guardrail text.

Update structural validation to require the new Resource and five-step contract.

### 6. Documentation

Update `docs/ARCHITECTURE.md` to record the fifth research step as a future-Act-IV evidence bridge. Keep the V0.5 research-chain roadmap item open because current runtime narrative gameplay still does not naturally produce the Act IV evidence flags.

## Expected Files

- `specs/004-research-material-compatibility-review/spec.md`
- `specs/004-research-material-compatibility-review/plan.md`
- `specs/004-research-material-compatibility-review/tasks.md`
- `specs/004-research-material-compatibility-review/checklists/requirements.md`
- `resources/research/material_compatibility_review.tres`
- `autoload/game_state.gd`
- `scenes/main/main.gd`
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
