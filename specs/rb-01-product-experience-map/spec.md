# Feature Specification: Product Experience Map

**Feature:** rb-01-product-experience-map  
**Re-baseline ID:** RB-01  
**Status:** Product architecture contract implemented — validation/merge pending  
**Target maturity:** PRESENTED product architecture contract  
**Depends on:** Product re-baseline; no RB dependency  
**Created:** 2026-09-23

## Overview

Define the canonical player-facing surface map before more runtime UI is built. Establish major surfaces, ownership, navigation, global vs contextual information, narrative/campaign interruption, and portrait Web/mobile constraints.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — System ownership is clear

**Given** the campaign exposes cultivation, business, city, institutional, research and narrative systems  
**When** the player needs to act on one of them  
**Then** the product map assigns the action to exactly one primary surface  
**And** cross-surface summaries do not duplicate ownership

### Scenario 2 — Navigation preserves context

**Given** the player is working inside one product surface  
**When** the player visits another surface and returns  
**Then** the map defines the context that is preserved  
**And** navigation alone never resets or advances simulation

### Scenario 3 — Campaign interruptions are predictable

**Given** a narrative/campaign event becomes available during management  
**When** the event is presented  
**Then** the map defines interrupt, overlay or queue behavior  
**And** the player has a defined return path

### Scenario 4 — Portrait remains viable

**Given** the game runs in a narrow portrait viewport  
**When** all major surfaces and global status are represented  
**Then** critical actions and status remain reachable and legible  
**And** the design does not depend on one unbounded vertical Main

## Functional Requirements

- **FR-001** Define canonical top-level surfaces: Operation, Market, City, Institutional, Archive/Research, plus bounded global/campaign overlays.
- **FR-002** Map every re-baseline capability to one primary surface owner or an explicitly global layer.
- **FR-003** Separate persistent shell information from surface-local information and controls.
- **FR-004** Define forward/back/return-to-context semantics without embedding domain rules in navigation.
- **FR-005** Define narrative/campaign interrupt, overlay and queue semantics.
- **FR-006** Define portrait-first Web/mobile and wide-layout constraints.
- **FR-007** Carry the DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED model into every mapped capability.
- **FR-008** Introduce no gameplay, balance, save-schema or canon change.

## Success Criteria

- **SC-001** Every capability in the maturity matrix has one unambiguous player-facing owner.
- **SC-002** The navigation graph has no orphan major surface or duplicate core-action ownership.
- **SC-003** Narrative/research entry and return behavior is explicit for portrait Web/mobile.
- **SC-004** RB-02 through RB-15 can reference the map without redefining top-level architecture.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- Godot scene/navigation implementation
- Domain/balance/campaign-gate changes
- Final visual assets
- Permanent post-008 numbering

## Implementation result

The canonical map is implemented in `docs/PRODUCT-EXPERIENCE-MAP.md`. It defines the five top-level destinations, system ownership matrix, shell/global layers, navigation purity and return semantics, narrative queue/overlay behavior, portrait/wide constraints, current-Main migration and downstream RB constraints.

## Planning-wave boundary

This RB implementation remains documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
