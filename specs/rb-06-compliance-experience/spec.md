# Feature Specification: Compliance Experience

**Feature:** rb-06-compliance-experience  
**Re-baseline ID:** RB-06  
**Status:** Specified — implementation not started  
**Target maturity:** PRESENTED  
**Depends on:** RB-05; shared context with RB-09  
**Created:** 2026-09-23

## Overview

Make fictional compliance progression legible and playable without turning it into legal advice, real regulation simulation or hidden gating.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player sees current compliance

**Given** canonical compliance state exists  
**When** the relevant context opens  
**Then** current fictional state and known effects are readable  
**And** it is not presented as real legal advice

### Scenario 2 — Blocked progression is understandable

**Given** the next transition is unavailable  
**When** it is inspected  
**Then** supported fictional prerequisites are shown  
**And** no real-world requirement is invented

### Scenario 3 — Connected surfaces stay synced

**Given** a valid transition changes compliance  
**When** state updates  
**Then** dependent surfaces reflect the new canonical state  
**And** no local copy diverges

### Scenario 4 — Current vs prior feedback is clear

**Given** compliance progressed over time  
**When** status is viewed  
**Then** current state is distinguishable from historical feedback  
**And** hidden-number interpretation is not required

## Functional Requirements

- **FR-001** Present compliance as fictional/systemic game state only.
- **FR-002** Expose current compliance where it materially gates Market/Institutional gameplay.
- **FR-003** Source prerequisites/effects from existing domain/resource behavior.
- **FR-004** Do not add real laws, regulators, permits, evasion methods or jurisdiction procedures.
- **FR-005** Distinguish current, available-next and blocked states where supported.
- **FR-006** Choose one detailed owner consistent with RB-01; other surfaces show only summaries.
- **FR-007** Never replace compliance predicates with UI-side logic.
- **FR-008** Keep existing persistence unless an explicit canonical-state gap is proven.

## Success Criteria

- **SC-001** Current compliance and known game consequences are understandable.
- **SC-002** Blocked/available state matches domain predicates.
- **SC-003** Market/Institutional contexts reflect one canonical state.
- **SC-004** No real-world legal/evasion guidance is introduced.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- Real legal/regulatory modeling
- New compliance levels/tuning
- New contracts
- New policy mechanics

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
