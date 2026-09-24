# Feature Specification: Act V Ending Selection Persistence

**Feature:** 008-act-v-ending-selection-persistence  
**Status:** COMPLETE — merged, validated and Web-exported  
**Roadmap:** V0.5 campaign / finale path  
**Created:** 2026-09-23

## Overview

Add the smallest deterministic boundary that lets the campaign select exactly one currently eligible ending family and persist that choice as canonical campaign state.

This feature does not rank endings, render an ending picker, execute `event_da_lata_handoff`, render ending-specific codas, or complete `arc_da_lata`.

Because the selected ending becomes canonical persisted state rather than a derived value, this feature introduces save schema v11 and preserves migration from v10 and all earlier supported schemas.

## User Scenarios

### Scenario 1 — An eligible ending can be selected

**Given** the final-form debate is complete  
**And** one or more ending families are currently eligible  
**When** the player selects one of those eligible ending IDs  
**Then** that exact ending ID becomes the selected ending  
**And** no score, ranking or moral preference is created.

### Scenario 2 — An ineligible ending is rejected

**Given** an ending family is not present in the current eligible set  
**When** selection is requested for that ending ID  
**Then** campaign state is unchanged  
**And** no ending is persisted.

### Scenario 3 — Selection is immutable within the campaign

**Given** one ending family has already been selected  
**When** another ending selection is requested  
**Then** the original selected ending remains unchanged  
**And** the second request is rejected.

### Scenario 4 — Selected ending survives save/restore

**Given** an eligible ending has been selected  
**When** schema-v11 save data is created and restored  
**Then** the selected ending ID is restored exactly  
**And** deterministic simulation state remains unchanged.

### Scenario 5 — Schema v10 migrates without inventing a selection

**Given** a valid schema-v10 save  
**When** it is loaded by schema-v11 code  
**Then** all prior campaign state is preserved  
**And** the selected ending is empty  
**And** no ending is inferred from eligibility.

## Functional Requirements

- **FR-001** Ending selection MUST remain behind a domain service and GameState orchestration, independent of UI.
- **FR-002** A selection request MUST succeed only when the requested stable ending ID is present in the current `eligible_ending_ids()` result.
- **FR-003** Before any ending is selected, canonical `selected_ending_id` MUST be the empty string.
- **FR-004** A successful selection MUST persist exactly one stable ending-family ID.
- **FR-005** Once non-empty, `selected_ending_id` MUST be immutable for the remainder of that campaign state.
- **FR-006** Selection MUST NOT score, rank, prefer, recommend or morally label any ending family.
- **FR-007** Selection MUST be deterministic and MUST NOT consume RNG.
- **FR-008** Selection MUST NOT complete `arc_da_lata` or execute `event_da_lata_handoff`.
- **FR-009** Save schema MUST advance from v10 to v11 because selected ending is new canonical persisted state.
- **FR-010** Schema v11 MUST persist `selected_ending_id` inside campaign state using a stable string ID.
- **FR-011** Loading a valid v10 save MUST migrate to `selected_ending_id = ""` without inferring a choice.
- **FR-012** Existing v1-v9 migration behavior MUST remain supported.
- **FR-013** A schema-v11 save containing an unknown non-empty ending ID MUST be rejected by GameState validation.
- **FR-014** GameState MUST expose a single selection command and the current selected ending state.
- **FR-015** Eligibility remains derived by the existing `EndingEligibilityService`; this feature MUST NOT duplicate its predicates.
- **FR-016** Existing ending neutrality and protected narrative uncertainty MUST remain unchanged.
- **FR-017** Institutional content MUST remain fictional/systemic; no real politicians, parties, elections or targeted persuasion are introduced.
- **FR-018** Parallel-market references MUST remain abstract and non-operational.
- **FR-019** New behavior MUST have a headless regression covering eligible selection, ineligible rejection, immutability, RNG stability, v11 round-trip and v10 migration.
- **FR-020** Full repository validation MUST pass on the exact current PR head before merge.
- **FR-021** Vercel must be green for the exact current PR head before merge when the repository delivery gate is available.
- **FR-022** UI ending picker, `event_da_lata_handoff`, ending-specific codas and `arc_da_lata` completion remain out of scope.

## Success Criteria

- **SC-001** A currently eligible ending ID can be selected exactly once.
- **SC-002** Ineligible and unknown ending IDs leave selection empty.
- **SC-003** A second selection attempt cannot replace the first.
- **SC-004** Selection consumes no RNG and introduces no ranking output.
- **SC-005** Schema-v11 save/load round-trip preserves the selected ending ID.
- **SC-006** A schema-v10 fixture loads with an empty selected ending and all prior campaign state intact.
- **SC-007** A schema-v11 payload with an unknown selected ending ID is rejected.
- **SC-008** Existing campaign, eligibility, research, presentation and save migrations remain green.
- **SC-009** Exact-head CI is green before guarded merge; a stale or externally blocked deployment gate leaves the feature in WATCH rather than forcing merge.

## Out of Scope

- Ending selection UI or picker presentation.
- Ranking, scoring or recommending endings.
- `event_da_lata_handoff`.
- Ending-specific coda content.
- Completion of `arc_da_lata`.
- Changing ending eligibility predicates or balance floors.
- New narrative canon.
- New real-world political content.
