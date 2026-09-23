# Feature Specification: Research Evidence Boundary Synthesis

**Feature:** 003-research-evidence-synthesis  
**Status:** Ready for implementation  
**Roadmap:** V0.5 research chain  
**Created:** 2026-09-23

## Overview

Extend the deterministic DA LATA research chain with one additional step that consolidates the limits of the evidence already gathered around the Onda-marked can.

The step is deliberately epistemic rather than revelatory: it records that the current dossier contains useful evidence while keeping three protected questions unresolved — the exact provenance of Dalva's can, the historical order/common origin of the four marks, and any claim of continuous historical/genetic DA LATA lineage.

This bounded capability bridges the existing provenance-gap work toward later Act IV/V research without importing future material-compatibility or finale conclusions too early.

## User Scenarios

### Scenario 1 — Boundary synthesis unlocks only after provenance mapping

**Given** the player completed the Onda evidence catalog, symbol-order comparison and provenance-gap map  
**When** canonical research availability is queried  
**Then** an evidence-boundary synthesis step becomes available  
**And** it was not available before the provenance-gap map completed.

### Scenario 2 — Completion records the limits of current evidence

**Given** the synthesis step is available  
**When** the player completes it  
**Then** the campaign records that the current research boundaries were synthesized  
**And** the result preserves unresolved Onda provenance, disputed symbol order and unproven historical/genetic lineage.

### Scenario 3 — Existing presentation discovers the step automatically

**Given** the current research presentation surface is active  
**When** the third research step completes  
**Then** the fourth step appears through the existing canonical availability/presentation boundaries  
**And** no prerequisite or ordering rule is added to UI code.

### Scenario 4 — Persistence remains stable

**Given** the synthesis step has been completed  
**When** the campaign is saved and restored  
**Then** completion remains persisted  
**And** the step does not become actionable again.

## Functional Requirements

- **FR-001** Add one Resource-backed research step with stable ID `research_evidence_boundary_synthesis`.
- **FR-002** The step MUST require `research_onda_provenance_gaps_mapped`.
- **FR-003** The step MUST preserve `lore_dalva_lucia_symbol_order_disputed` and MUST be forbidden if `lore_dalva_lucia_symbol_order_resolved` is set.
- **FR-004** Completion MUST persist `research_evidence_boundaries_synthesized`.
- **FR-005** Evidence metadata MUST reuse the existing unresolved-provenance, disputed-order and material-context semantics; it MUST NOT add a new claim of historical authenticity.
- **FR-006** Canon guardrails MUST keep Onda provenance open, symbol order open and historical/genetic lineage unauthenticated.
- **FR-007** GameState MUST expose the step only through the existing research catalog/service boundaries.
- **FR-008** The existing research presentation MUST render the step without new prerequisite or ordering logic.
- **FR-009** Completion MUST consume no simulation RNG.
- **FR-010** Save schema MUST remain v10; no new persisted shape is introduced.
- **FR-011** Research-chain and research-presentation regressions MUST cover the four-step order and final completion state.
- **FR-012** Exact-head repository validation MUST pass before merge.

## Success Criteria

- **SC-001** The fourth step is unavailable before `research_onda_provenance_gaps_mapped` and available immediately after it.
- **SC-002** Completing the fourth step persists `research_evidence_boundaries_synthesized`.
- **SC-003** Returned evidence/guardrails preserve all three protected uncertainties.
- **SC-004** The Main research surface automatically advances from step three to step four and then to no actionable research.
- **SC-005** Save v10 round-trip preserves completion and final availability.
- **SC-006** Full repository validation is green on the exact final PR head.

## Out of Scope

- Claiming that documents, tape and object are already materially compatible.
- Implementing Act IV events, `event_foto_estrela`, Act V reconstruction or finale logic.
- Authenticating the Onda can or assigning it a definitive origin/date.
- Resolving historical order/common origin of Onda, Sol, Ferrugem and Estrela.
- Authenticating a continuous historical/genetic DA LATA lineage.
- New save-schema fields.
- Real cultivation parameters or operational cultivation guidance.
- Operational parallel-market logistics, sourcing, concealment or evasion.
- Real politicians, parties, elections or targeted persuasion.
- Broad UI redesign.
