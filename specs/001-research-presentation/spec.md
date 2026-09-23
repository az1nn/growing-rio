# Feature Specification: Research Presentation Surface

**Feature:** 001-research-presentation  
**Status:** Ready for implementation planning  
**Roadmap:** V0.5 research chain  
**Created:** 2026-09-23

## Overview

Players need a playable way to discover and complete currently available DA LATA research steps without exposing or duplicating the underlying progression rules in presentation code.

The surface must make the existing ordered research chain understandable while preserving the project's uncertainty guardrails: research records and compares evidence, but does not authenticate provenance, a continuous historical/genetic lineage, or a definitive symbol order.

## User Scenarios

### Scenario 1 — See currently available research

**Given** the campaign state makes one or more research steps available  
**When** the player reaches the research presentation  
**Then** the player can see the available research step(s) with human-readable labels  
**And** unavailable or already-completed steps are not presented as actionable.

### Scenario 2 — Complete an available research step

**Given** a research step is currently available  
**When** the player chooses to complete it  
**Then** the request is resolved through the canonical research command boundary  
**And** the player sees the resulting semantic evidence/system outcome  
**And** the step is no longer actionable after completion.

### Scenario 3 — Ordered progression is preserved

**Given** a later research step depends on completion of an earlier one  
**When** the earlier step has not been completed  
**Then** the later step cannot be completed from the presentation surface.

### Scenario 4 — Protected uncertainty remains visible

**Given** a research result concerns disputed historical/canon evidence  
**When** the result is presented  
**Then** the presentation communicates uncertainty without declaring a protected open question resolved.

### Scenario 5 — Save and restore does not regress research state

**Given** one or more research steps have been completed  
**When** the game state is saved and restored  
**Then** completed research remains completed  
**And** the presentation reflects the restored canonical availability state.

## Functional Requirements

- **FR-001** The presentation MUST derive actionable research steps from canonical game state rather than maintain its own availability list.
- **FR-002** The presentation MUST provide a readable label for each actionable research step.
- **FR-003** Completing a step MUST go through the canonical research completion command boundary.
- **FR-004** Presentation code MUST NOT implement prerequisite, ordering or consequence rules independently.
- **FR-005** After successful completion, the presentation MUST refresh from canonical state.
- **FR-006** The player MUST receive a readable representation of semantic result information returned by research completion.
- **FR-007** Protected canon guardrails returned by research completion MUST remain visible or faithfully represented; the UI MUST NOT convert uncertainty into fact.
- **FR-008** Attempting to act on stale/unavailable research state MUST fail safely without duplicating progression or corrupting campaign state.
- **FR-009** The feature MUST preserve deterministic simulation behavior and MUST NOT consume simulation RNG solely for presentation or research completion.
- **FR-010** The feature MUST preserve save schema v10 unless implementation introduces genuinely new canonical persisted state.
- **FR-011** A headless regression MUST exercise the player interaction path from availability through completion and refresh.
- **FR-012** Existing narrative, research-chain and save-schema regressions MUST remain green.

## Success Criteria

- **SC-001** A valid available research step can be completed through the UI in an automated headless test.
- **SC-002** A later step is never actionable before its canonical prerequisite is complete.
- **SC-003** After completion, the UI refresh shows the next canonical state without maintaining duplicate progression data.
- **SC-004** The interaction produces no additional simulation RNG draw.
- **SC-005** Save v10 round-trip preserves the completed research state and resulting UI availability.
- **SC-006** Exact-head repository validation is green before merge.

## Out of Scope

- Adding new research-chain steps.
- Resolving the disputed symbol order or Onda provenance.
- Authenticating any continuous historical or genetic DA LATA lineage.
- New save-schema fields unless proven necessary.
- Real cultivation parameters or operational cultivation guidance.
- Real trafficking/sourcing/evasion mechanics.
- Real politicians, parties, elections or targeted persuasion.
- Broad Main scene redesign unrelated to research presentation.
