# Feature Specification: Operation Management Surface

**Feature:** rb-03-operation-management-surface  
**Re-baseline ID:** RB-03  
**Status:** Specified — implementation not started  
**Target maturity:** PRESENTED  
**Depends on:** RB-01 and RB-02  
**Created:** 2026-09-23

## Overview

Give the existing cultivation loop a coherent Operation surface. Reorganize valid gameplay into a dedicated workspace while preserving deterministic domain ownership and contextual diorama presentation.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player reads operation state

**Given** an active room exists  
**When** Operation opens  
**Then** active room, cycle state and relevant local feedback are readable  
**And** global status stays visually distinct

### Scenario 2 — Player uses the core loop

**Given** a cultivation action is valid  
**When** care, advance-day or harvest is triggered  
**Then** the existing canonical command executes  
**And** the surface refreshes from canonical state

### Scenario 3 — Blocked action is understandable

**Given** a cultivation action is unavailable  
**When** the player inspects it  
**Then** the UI communicates unavailable state  
**And** it does not recreate the predicate

### Scenario 4 — Deeper management is routed

**Given** rooms/staff/upgrades are relevant  
**When** the player requests deeper management  
**Then** Operation routes to RB-04  
**And** RB-04 controls are not duplicated inline

## Functional Requirements

- **FR-001** Operation is the primary owner of existing care/day-advance/harvest interaction.
- **FR-002** All action availability comes from existing GameState/domain behavior.
- **FR-003** Active room and cultivation state are clearly identifiable.
- **FR-004** Operation-local feedback is separate from global shell status.
- **FR-005** OperationDiorama may present context but never own gameplay state.
- **FR-006** Provide an explicit RB-04 entry path without absorbing its scope.
- **FR-007** Preserve deterministic simulation and RNG semantics.
- **FR-008** Keep cultivation abstract/non-operational and avoid new realism or balance.

## Success Criteria

- **SC-001** The currently playable cultivation loop works from one Operation surface.
- **SC-002** Enabled/disabled action state matches domain behavior.
- **SC-003** Active-room context is understandable in portrait layout.
- **SC-004** No cultivation/simulation rule is duplicated in scene code.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- Rooms/staff/upgrades workflows
- Market selling/contracts
- New cultivation mechanics
- Production-art replacement

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
