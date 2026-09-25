# Feature Specification: Policy / Institutional Surface

**Feature:** rb-09-policy-institutional-surface  
**Re-baseline ID:** RB-09  
**Status:** Implemented in PR #79 — exact-head validation pending  
**Target maturity:** PRESENTED  
**Depends on:** RB-02; context from RB-06/RB-08  
**Created:** 2026-09-23

## Overview

Materialize the fictional institutional/policy domain as a dedicated neutral surface for institution progression, policy availability/enactment and civic participation.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player understands institution state

**Given** institution progression exists  
**When** Institutional opens  
**Then** current fictional state and available participation are readable  
**And** no real political claim is implied

### Scenario 2 — Player evaluates a fictional policy

**Given** policies are available  
**When** one is inspected  
**Then** canonical prerequisites/effects are described neutrally  
**And** no option is labeled correct or preferred

### Scenario 3 — Player enacts a policy

**Given** a fictional policy is enactable  
**When** the player confirms  
**Then** the existing transition runs  
**And** connected canonical state updates

### Scenario 4 — Blocked policy is understandable

**Given** a policy is unavailable  
**When** it is inspected  
**Then** supported fictional prerequisites are shown  
**And** no real institution is modeled

## Functional Requirements

- **FR-001** Make Institutional the primary owner of institution progression, fictional policy availability/enactment and civic participation.
- **FR-002** Keep every policy/entity fictional/systemic and repository-canonical.
- **FR-003** Delegate policy availability/enactment to existing domain/GameState logic.
- **FR-004** Describe consequences neutrally; do not rank, endorse or recommend policies.
- **FR-005** Introduce no real politicians, parties, elections, ballot measures or targeted persuasion.
- **FR-006** Reference compliance/community as context without duplicating their ownership.
- **FR-007** Read Influence/global state canonically.
- **FR-008** Distinguish enacted, available and unavailable states without UI-side formulas.

## Success Criteria

- **SC-001** Current institutional progression and supported policy states are inspectable.
- **SC-002** Available policies can be enacted through canonical commands.
- **SC-003** Prerequisites/effects match domain/resource data.
- **SC-004** No policy is ranked/recommended and no real-world persuasion appears.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- Real political content
- New policy catalog/tuning
- RB-06 compliance mechanics
- Campaign rewrite before RB-14

## Implementation boundary

RB-09 is implemented in PR #79 as presentation/orchestration over the existing canonical fictional policy system. `GameState.institutional_snapshot()` exposes institution level, policy states, civic participation and compliance/community context without adding a second rules engine. The Institucional surface calls only existing canonical commands for participation and enactment.

No policy catalog/tuning, persistence schema or real-world political content is added. Policy availability remains delegated to `PolicyService.resolve_enactment()`; UI text describes prerequisites/effects neutrally and provides no ranking, recommendation or preferred option.
