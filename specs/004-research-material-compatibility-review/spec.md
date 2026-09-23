# Feature Specification: Research Material Compatibility Review

**Feature:** 004-research-material-compatibility-review  
**Status:** Ready for implementation  
**Roadmap:** V0.5 research chain  
**Created:** 2026-09-23

## Overview

Extend the deterministic DA LATA research chain with one later-campaign review step that becomes available only after the existing four-step early dossier is complete and the campaign has explicit Act IV evidence that material-origin compatibility was established, the Estrela mark was revealed, and the original historical/genetic lineage remains unproven.

This feature is a chronology bridge, not an Act IV implementation. It deliberately does not add `event_foto_estrela` to the runtime narrative catalog. Instead, it defines the research contract that future Act IV gameplay can unlock by persisting the already-canonical flags from the lore event library.

The review records a limited material-compatibility conclusion while preserving the protected uncertainty around exact Onda provenance, historical order/common origin of the four marks, and continuous historical/genetic DA LATA lineage.

## User Scenarios

### Scenario 1 — Early research remains complete until later campaign evidence exists

**Given** the player completed `research_evidence_boundary_synthesis`  
**And** the Act IV material-compatibility evidence flags are not all present  
**When** canonical research availability is queried  
**Then** no later research step is available  
**And** the early research chain does not invent Act IV evidence.

### Scenario 2 — Explicit Act IV evidence unlocks the review

**Given** the early research synthesis is complete  
**And** the campaign records `lore_material_origin_compatibility_established`  
**And** the campaign records `lore_star_mark_revealed`  
**And** the campaign records `lore_original_lineage_still_unproven`  
**When** canonical research availability is queried  
**Then** `research_material_compatibility_review` becomes available.

### Scenario 3 — Review records a limited conclusion without authenticating lineage

**Given** the review is available  
**When** the player completes it  
**Then** the campaign records `research_material_compatibility_reviewed`  
**And** the result describes material compatibility as limited evidence  
**And** exact Onda provenance, symbol order/common origin, and historical/genetic lineage remain unresolved.

### Scenario 4 — Existing presentation discovers the later step automatically

**Given** the Main research surface is active  
**When** the final required Act IV evidence flag becomes true  
**Then** the fifth research action appears through the existing GameState query/presentation boundary  
**And** UI code does not own the prerequisite rule.

### Scenario 5 — Persistence remains stable

**Given** the fifth research step has been completed  
**When** the campaign is saved and restored  
**Then** completion and all prerequisite evidence flags survive schema v10  
**And** the step does not become actionable again.

## Functional Requirements

- **FR-001** Add one Resource-backed research step with stable ID `research_material_compatibility_review`.
- **FR-002** The step MUST require `research_evidence_boundaries_synthesized`.
- **FR-003** The step MUST require the canonical Act IV flags `lore_material_origin_compatibility_established`, `lore_star_mark_revealed`, and `lore_original_lineage_still_unproven`.
- **FR-004** The step MUST continue to require `lore_dalva_lucia_symbol_order_disputed` and MUST be forbidden when `lore_dalva_lucia_symbol_order_resolved` is true.
- **FR-005** Completion MUST persist `research_material_compatibility_reviewed`.
- **FR-006** The result MUST expose a display-safe evidence semantic for limited material compatibility without representing it as exact historical provenance.
- **FR-007** Canon guardrails MUST state that material compatibility does not prove lineage and MUST keep Onda provenance, symbol order/common origin, and historical/genetic lineage unresolved.
- **FR-008** GameState MUST expose the step only through the existing research catalog/service boundaries.
- **FR-009** The existing research presentation MUST discover the step dynamically and MUST not implement Act IV prerequisite logic.
- **FR-010** Completion MUST consume no simulation RNG.
- **FR-011** Save schema MUST remain v10; prerequisite and completion state MUST reuse `campaign.narrative_flags`.
- **FR-012** This feature MUST NOT add `event_foto_estrela` or any other Act IV event to the runtime narrative catalog.
- **FR-013** Research-chain and research-presentation regressions MUST cover the deferred unlock, fifth-step completion, protected uncertainties, duplicate prevention and save-v10 round trip.
- **FR-014** Exact-head repository validation MUST pass before merge.

## Success Criteria

- **SC-001** Completing the fourth research step alone leaves the fifth unavailable.
- **SC-002** The fifth step becomes available only after all three canonical Act IV evidence flags are present.
- **SC-003** Completing the fifth step persists `research_material_compatibility_reviewed` without consuming RNG.
- **SC-004** Returned evidence visibly distinguishes limited material compatibility from exact provenance authentication.
- **SC-005** The Main research surface transitions from no action to the fifth action when the final evidence flag arrives, with no UI-owned eligibility rule.
- **SC-006** Save v10 round-trip preserves prerequisite evidence plus fifth-step completion.
- **SC-007** Full repository validation is green on the exact final PR head.

## Out of Scope

- Runtime implementation of `event_foto_estrela` or the broader Act IV event chain.
- Making the fifth research step naturally reachable from currently implemented narrative gameplay.
- Claiming a definitive origin/date for Dalva's Onda can.
- Resolving historical order or common origin of Onda, Sol, Ferrugem and Estrela.
- Authenticating a continuous historical/genetic DA LATA lineage.
- Beginning Act V reconstruction or finale logic.
- Changing save schema or adding duplicate campaign state.
- Real cultivation parameters or operational cultivation guidance.
- Operational parallel-market logistics, sourcing, concealment or evasion.
- Real politicians, parties, elections or targeted persuasion.
