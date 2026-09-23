# Feature Specification: Act V Final Form Eligibility

**Feature:** 007-act-v-final-form-eligibility  
**Status:** Complete  
**Roadmap:** V0.5 campaign / finale path  
**Created:** 2026-09-23

## Overview

Materialize the canonical `event_forma_da_lata` scene and introduce the smallest deterministic gameplay boundary that can report which ending families are currently eligible from accumulated campaign state.

This feature does not select an ending, rank endings, render codas, execute `event_da_lata_handoff`, or complete `arc_da_lata`.

## User Scenarios

### Scenario 1 — The final-form debate opens after DA LATA is named

**Given** `lore_da_lata_name_canonical = true`  
**When** narrative availability is queried  
**Then** `event_forma_da_lata` becomes available  
**And** no ending is selected merely because the event opened.

### Scenario 2 — The debate records a governance posture without choosing a winner

**Given** `event_forma_da_lata` is available  
**When** the player resolves any canonical intervention  
**Then** `lore_final_form_debate_seen = true` is persisted  
**And** exactly one documented `choice_final_form_*` flag is persisted  
**And** the choice does not directly persist an ending ID.

### Scenario 3 — Ending eligibility is derived from accumulated state

**Given** the final-form debate is complete  
**When** ending eligibility is queried  
**Then** the result is derived deterministically from campaign metrics, buyer relationships, community state and narrative evidence  
**And** zero, one or multiple ending families may be eligible  
**And** the result contains no score, rank, winner or moral ordering.

### Scenario 4 — Composite eligibility requires genuinely mixed state

**Given** `O Verão Volta` is evaluated  
**When** either the licensed or parallel-market relationship is absent, or the research/community/reputation/influence floor is not met  
**Then** `ending_o_verao_volta` is not eligible  
**And** satisfying all required dimensions makes it eligible without making it superior to any other ending.

### Scenario 5 — Eligibility remains derived across save/restore

**Given** a valid schema-v10 save after the debate  
**When** state is restored  
**Then** the same ending eligibility set is recomputed from restored canonical state  
**And** no new persistent ending-selection field is required.

## Functional Requirements

- **FR-001** The feature MUST preserve the `NarrativeEventDefinition -> NarrativeEventService -> GameState -> Main` boundary.
- **FR-002** `event_forma_da_lata` MUST be a Resource-backed narrative event registered after `event_nome_da_lata`.
- **FR-003** The event MUST require `lore_da_lata_name_canonical`.
- **FR-004** Every event choice MUST set `lore_final_form_debate_seen` plus exactly one canonical intervention flag.
- **FR-005** No event choice MAY persist an ending ID or complete `arc_da_lata`.
- **FR-006** A dedicated domain service MUST compute ending eligibility without consuming RNG and without depending on UI state.
- **FR-007** Eligibility MUST be gated by `lore_final_form_debate_seen`; before the debate, no ending family is eligible.
- **FR-008** The service MUST return stable ending IDs and MAY return multiple eligible IDs.
- **FR-009** The service MUST NOT return scores, rankings, preferred choices, winners or moral labels.
- **FR-010** `ending_marca_nacional` MUST require licensed-market participation plus minimum cash and Reputation maturity.
- **FR-011** `ending_rede_viva` MUST require minimum average Community support plus minimum Reputation.
- **FR-012** `ending_noite_sem_rotulo` MUST require parallel-market participation plus an accumulated autonomy/distributed-governance signal; no single debate choice alone may make it eligible.
- **FR-013** `ending_arquivo_publico` MUST require completed evidence research plus an explicit uncertainty/provenance-preserving signal.
- **FR-014** `ending_atlantico` MUST require minimum capital/Influence maturity plus a coordination/execution signal.
- **FR-015** `ending_o_verao_volta` MUST require Research, Community, Reputation and Influence maturity while preserving participation in both licensed and parallel markets.
- **FR-016** Numerical eligibility floors MUST live as named service constants so future balancing can change them without altering narrative canon.
- **FR-017** The four canonical debate choices MUST preserve protected uncertainty and ending neutrality.
- **FR-018** `O Verão Volta` MUST remain a composite ending family, never a “true ending”.
- **FR-019** Institutional content MUST remain fictional/systemic; no real politicians, parties, elections or targeted persuasion are introduced.
- **FR-020** Parallel-market references MUST remain abstract and non-operational.
- **FR-021** Narrative and eligibility evaluation MUST remain deterministic and RNG-stable.
- **FR-022** Save schema v10 MUST be reused; eligibility is derived and no persistent shape is added.
- **FR-023** Existing feature-006 regression MUST converge so the naming event now hands off to `event_forma_da_lata`.
- **FR-024** Full repository validation MUST pass on the exact current PR head before merge.
- **FR-025** `event_da_lata_handoff`, ending selection, codas and `arc_da_lata` completion remain out of scope.

## Success Criteria

- **SC-001** Completing the existing Ato V opening naturally unlocks `event_forma_da_lata`.
- **SC-002** All four canonical interventions persist the shared debate flag without persisting an ending choice.
- **SC-003** Eligibility queries are deterministic and can expose multiple simultaneous ending families.
- **SC-004** A regression proves each ending family can be made eligible by its documented maturity vector.
- **SC-005** A regression proves `O Verão Volta` requires both market relationships and all four cross-system maturity dimensions.
- **SC-006** Save-v10 round-trip preserves the state from which the same eligibility set is recomputed.
- **SC-007** Existing campaign/narrative/research/save regressions remain green.
- **SC-008** Exact-head CI and Vercel status are green before guarded merge.

## Out of Scope

- Selecting or persisting a chosen ending.
- Ranking eligible endings.
- `event_da_lata_handoff`.
- Ending-specific codas.
- Completion of `arc_da_lata`.
- New UI for an ending picker.
- New save schema fields.
- New real-world political content.
