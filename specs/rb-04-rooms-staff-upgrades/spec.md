# Feature Specification: Rooms / Staff / Upgrades

**Feature:** rb-04-rooms-staff-upgrades  
**Re-baseline ID:** RB-04  
**Status:** Implemented — exact-head delivery validation pending  
**Target maturity:** PRESENTED  
**Depends on:** RB-02 and RB-03  
**Created:** 2026-09-23

## Overview

Materialize existing multiple-room, room-switching, staff and upgrade capabilities as intentional player decisions without redesigning the simulation.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player switches rooms

**Given** multiple valid rooms exist  
**When** another room is selected  
**Then** the canonical active room changes  
**And** Operation reflects the new context

### Scenario 2 — Player evaluates staff

**Given** staff options exist  
**When** an option is inspected  
**Then** cost, eligibility and known effects are readable  
**And** hiring uses the canonical command

### Scenario 3 — Player evaluates upgrades

**Given** upgrade options exist  
**When** an upgrade is inspected  
**Then** cost, prerequisites and known effects are readable  
**And** acquisition uses the canonical command

### Scenario 4 — Cost feedback follows changes

**Given** management state affects operating cost  
**When** rooms/staff/upgrades change  
**Then** the resulting canonical cost state is surfaced  
**And** UI does not recreate the formula

## Functional Requirements

- **FR-001** Expose all currently supported room instances and active-room switching.
- **FR-002** Use stable room instance/definition IDs owned by the domain.
- **FR-003** Source staff availability/hiring/ownership from existing rules.
- **FR-004** Source upgrade availability/acquisition/ownership from existing rules.
- **FR-005** Display costs/effects from canonical/resource-backed data; never recalculate independently.
- **FR-006** Distinguish unavailable, available and owned states.
- **FR-007** Propagate changes through canonical GameState updates.
- **FR-008** Introduce no new room/staff/upgrade definitions, formulas or tuning.

## Success Criteria

- **SC-001** All valid rooms are inspectable and switchable.
- **SC-002** Available staff and upgrades can be intentionally acquired.
- **SC-003** Displayed affordability/availability matches domain results.
- **SC-004** Operating-cost consequences are visible after transitions.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- New business content
- Cost/effect retuning
- Market/contracts
- Final art

## Implementation status

The original specification package was documentation-only. Runtime implementation now exists on the RB-04 implementation branch and preserves the specification boundary:

- no new room, staff or upgrade definitions;
- no tuning/formula changes;
- no save-schema change;
- presentation reads canonical metadata through `GameState.management_snapshot()`;
- mutations remain `switch_active_room()`, `hire_staff()` and `purchase_upgrade()`;
- exact-head repository validation and provider delivery evidence remain required before merge.
