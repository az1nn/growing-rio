# Feature Specification: Game Shell / Navigation

**Feature:** rb-02-game-shell-navigation  
**Re-baseline ID:** RB-02  
**Status:** Specified — implementation not started  
**Target maturity:** PRESENTED  
**Depends on:** RB-01 accepted  
**Created:** 2026-09-23

## Overview

Replace product-level dependence on monolithic Main with a stable shell that hosts canonical destinations and global status while remaining presentation-only.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player changes destination

**Given** a campaign is running  
**When** the player selects Operation, Market, City, Institutional or Archive/Research  
**Then** that destination becomes active in the shell  
**And** canonical campaign state is preserved

### Scenario 2 — Global status stays coherent

**Given** the player moves between surfaces  
**When** canonical day/cash/Heat/Reputation/Influence changes  
**Then** the shell reflects current values  
**And** no surface owns a second copy

### Scenario 3 — Back is predictable

**Given** an overlay/detail is open  
**When** the player closes or goes back  
**Then** the immediately previous valid context returns  
**And** simulation is not mutated

### Scenario 4 — Responsive access is preserved

**Given** the viewport is portrait or wide  
**When** navigation is used  
**Then** all primary destinations and critical global status remain reachable  
**And** domain behavior is unchanged

## Functional Requirements

- **FR-001** Expose exactly the RB-01 major destinations unless the Product Experience Map is amended.
- **FR-002** Keep navigation state presentation-only; do not duplicate GameState progression.
- **FR-003** Read global status from canonical state.
- **FR-004** Provide deterministic close/back behavior for overlays/details.
- **FR-005** Changing surfaces must not consume RNG, advance day or reset campaign state.
- **FR-006** Remain usable in portrait Web/mobile and wider layouts.
- **FR-007** Keep existing Main functionality reachable during staged migration.
- **FR-008** Do not persist navigation state unless a later explicit canonical-state decision requires it.

## Success Criteria

- **SC-001** All RB-01 destinations are reachable through one shell.
- **SC-002** Surface switching never mutates simulation by itself.
- **SC-003** Global status is consistent across surfaces.
- **SC-004** Back/close behavior is testable in narrow and wide layouts.
- **SC-005** Later RB surfaces can be added without rebuilding a monolithic Main.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- Detailed RB-03..RB-11 workflows
- Domain progression changes
- Final visual polish
- Default persistence of UI route

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
