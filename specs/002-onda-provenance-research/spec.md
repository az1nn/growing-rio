# Feature Specification: Onda Provenance Gap Research

**Feature:** 002-onda-provenance-research  
**Status:** Ready for implementation planning  
**Roadmap:** V0.5 research chain  
**Created:** 2026-09-23

## Overview

Extend the existing DA LATA research chain with one additional canonical step that maps the known provenance gaps around Dalva's Onda-marked can after the player has already catalogued the object and compared the disputed symbol-order accounts.

The feature must deepen the research loop without authenticating the can, resolving the historical order of the four marks, or implying a continuous historical/genetic DA LATA lineage.

## User Scenarios

### Scenario 1 — A third research step unlocks in order

**Given** the player completed the Onda evidence catalog and symbol-order comparison  
**When** canonical research availability is queried  
**Then** a provenance-gap mapping step becomes available  
**And** it was not available before the symbol-order comparison completed.

### Scenario 2 — Research records provenance uncertainty

**Given** the provenance-gap step is available  
**When** the player completes it  
**Then** the campaign records that the provenance gaps were mapped  
**And** the result explicitly preserves unresolved provenance rather than authenticating the object.

### Scenario 3 — Presentation updates without new UI rules

**Given** the current research presentation surface is active  
**When** the second research step completes  
**Then** the third step appears through the existing canonical availability/presentation boundaries  
**And** no step-order rule is duplicated in UI code.

### Scenario 4 — Persistence remains stable

**Given** the third research step has been completed  
**When** the campaign is saved and restored  
**Then** completion remains persisted  
**And** the step does not become actionable again.

## Functional Requirements

- **FR-001** Add one Resource-backed research step with stable ID `research_onda_provenance_gap_map`.
- **FR-002** The step MUST require `research_symbol_order_compared`.
- **FR-003** The step MUST preserve `lore_dalva_lucia_symbol_order_disputed` and MUST be forbidden if `lore_dalva_lucia_symbol_order_resolved` is set.
- **FR-004** Completion MUST persist `research_onda_provenance_gaps_mapped`.
- **FR-005** Evidence metadata MUST communicate unresolved provenance and gaps in chain-of-custody/context, not historical authentication.
- **FR-006** Canon guardrails MUST state that Onda provenance remains open and research does not authenticate historical/genetic lineage.
- **FR-007** GameState MUST expose the step only through the existing research catalog/service boundaries.
- **FR-008** The existing research presentation MUST render the step without new prerequisite or ordering logic.
- **FR-009** Completion MUST consume no simulation RNG.
- **FR-010** Save schema MUST remain v10; no new persisted shape is introduced.
- **FR-011** Research-chain and research-presentation regressions MUST cover the three-step order and final completion state.
- **FR-012** Exact-head repository validation MUST pass before merge.

## Success Criteria

- **SC-001** The third step is unavailable before `research_symbol_order_compared` and available immediately after it.
- **SC-002** Completing the third step persists `research_onda_provenance_gaps_mapped`.
- **SC-003** Returned guardrails preserve unresolved Onda provenance and historical/genetic-lineage uncertainty.
- **SC-004** The Main research surface automatically advances from step two to step three and then to no actionable research.
- **SC-005** Save v10 round-trip preserves completion and final availability.
- **SC-006** Full repository validation is green on the exact final PR head.

## Out of Scope

- Authenticating the Onda can or assigning it a definitive origin/date.
- Resolving the historical order or common origin of Onda, Sol, Ferrugem and Estrela.
- Adding real cultivation parameters, genetics instructions or yield optimization.
- Adding operational parallel-market logistics, sourcing, concealment or evasion.
- Introducing real politicians, parties, elections or targeted persuasion.
- Adding new narrative events, ending logic or a new save-schema version.
- Broad UI redesign.
