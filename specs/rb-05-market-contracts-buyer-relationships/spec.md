# Feature Specification: Market / Contracts / Buyer Relationships

**Feature:** rb-05-market-contracts-buyer-relationships  
**Re-baseline ID:** RB-05  
**Status:** Specified — implementation not started  
**Target maturity:** PRESENTED  
**Depends on:** RB-02; RB-04 for full business loop  
**Created:** 2026-09-23

## Overview

Turn existing selling, contract and buyer-relationship state into a dedicated Market experience with readable risk/reward feedback while keeping the parallel market abstract and non-operational.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player compares channels

**Given** sellable product exists  
**When** Market opens  
**Then** available buyer/channel choices and known game consequences are identifiable  
**And** no real-world operational guidance is provided

### Scenario 2 — Player accepts a contract

**Given** a valid contract is available  
**When** the player accepts it  
**Then** the existing contract transition activates  
**And** requirements/status come from canonical state

### Scenario 3 — Relationship feedback updates

**Given** a sale/contract changes a buyer relationship  
**When** the transition completes  
**Then** updated relationship state is visible  
**And** feedback reflects canonical state

### Scenario 4 — Blocked contract is explainable

**Given** a contract cannot be accepted/resolved  
**When** it is inspected  
**Then** the supported blocked state is communicated  
**And** no second ruleset is invented

## Functional Requirements

- **FR-001** Make Market the primary surface for selling channels, contracts and buyer relationships.
- **FR-002** Keep licensed and abstract parallel channels distinct without operational illicit-market detail.
- **FR-003** Delegate contract availability/acceptance/resolution to existing domain/GameState behavior.
- **FR-004** Read buyer relationships from canonical state.
- **FR-005** Show known immediate consequences only when supported by domain/resource data; do not guarantee hidden RNG outcomes.
- **FR-006** Reference compliance and district demand via canonical read models instead of duplicating logic.
- **FR-007** Remain usable in portrait Web/mobile.
- **FR-008** Introduce no new buyer types, contracts, formulas or real-world evasion tactics.

## Success Criteria

- **SC-001** All supported selling paths are reachable from Market.
- **SC-002** Supported contract lifecycle is player-facing and domain-consistent.
- **SC-003** Relationship changes are visible after relevant transitions.
- **SC-004** Risk/reward feedback is understandable without unsupported guarantees.
- **SC-005** Parallel-market presentation remains abstract/non-operational.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- New buyer/contract content
- RB-06 compliance workflow
- RB-07 district management
- Real-world illicit-market guidance

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
