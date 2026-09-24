# Feature Specification: Community Feedback

**Feature:** rb-08-community-feedback  
**Re-baseline ID:** RB-08  
**Status:** Specified — implementation not started  
**Target maturity:** PRESENTED  
**Depends on:** RB-07; later consumed by RB-14  
**Created:** 2026-09-23

## Overview

Expose district community support and its relationship to Reputation/campaign state through contextual feedback instead of opaque numbers, without inventing new formulas or causal claims.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player understands support

**Given** community support exists for districts  
**When** the active district is inspected  
**Then** current support is readable with supported context  
**And** it is distinct from global Reputation

### Scenario 2 — Feedback follows a transition

**Given** a supported action changes community support/Reputation  
**When** state updates  
**Then** bounded feedback identifies the game-system consequence  
**And** unsupported causality is not claimed

### Scenario 3 — District alignment holds

**Given** the active district changes  
**When** Community feedback updates  
**Then** the new district context is shown  
**And** old context is not retained as current

### Scenario 4 — Campaign linkage avoids spoilers

**Given** community state contributes to later readiness  
**When** support is inspected  
**Then** progress may be communicated at an accepted coarse level  
**And** ending predicates/rankings are not exposed

## Functional Requirements

- **FR-001** Source support from canonical community state/stable district IDs.
- **FR-002** Distinguish district support from global Reputation.
- **FR-003** Use qualitative context only where existing resources/events support it.
- **FR-004** Do not invent causal explanations absent from domain/canon.
- **FR-005** Stay synchronized with City active-district state.
- **FR-006** Avoid finale spoilers, ending rankings and preferred outcomes.
- **FR-007** Do not duplicate community/Reputation formulas in UI.
- **FR-008** Keep content fictional and non-persuasive.

## Success Criteria

- **SC-001** Active-district support is understandable and distinct from Reputation.
- **SC-002** Relevant transitions produce clear canonical feedback.
- **SC-003** City and Community never disagree on active district.
- **SC-004** Campaign linkage remains neutral and non-spoiling.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- New community formulas
- Real demographic/community modeling
- Policy workflow
- Campaign-gate rewrite before RB-14

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
