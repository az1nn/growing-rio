# Feature Specification: Archive / Research / Narrative UX

**Feature:** rb-10-archive-research-narrative-ux  
**Re-baseline ID:** RB-10  
**Status:** Specified — implementation not started  
**Target maturity:** PRESENTED  
**Depends on:** RB-01/RB-02; preserves specs 001-004  
**Created:** 2026-09-23

## Overview

Move existing research/narrative presentation out of monolithic Main into Archive/Research while preserving deterministic research behavior and CÂNONE/RUMOR/ABERTO boundaries.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player reviews research

**Given** research steps are available  
**When** Archive/Research opens  
**Then** available research is shown from existing state  
**And** completion uses the current deterministic command

### Scenario 2 — Player reviews completed material

**Given** research/events were completed  
**When** archive is browsed  
**Then** completed and available items are distinguishable  
**And** canonical content/provenance remains intact

### Scenario 3 — Narrative event returns correctly

**Given** an event becomes available during management  
**When** it is resolved through shell interruption behavior  
**Then** the player returns to prior context  
**And** permitted resolved material is archived

### Scenario 4 — Protected uncertainty survives UI

**Given** lore contains CÂNONE/RUMOR/ABERTO distinctions  
**When** material is presented  
**Then** those distinctions remain visible/semantically intact  
**And** uncertainty is not silently collapsed

## Functional Requirements

- **FR-001** Make Archive/Research the primary destination for research work and permitted historical review.
- **FR-002** Preserve specs 001-004 and their deterministic domain ownership.
- **FR-003** Use existing research availability/completion behavior.
- **FR-004** Use existing narrative availability/resolution behavior.
- **FR-005** Preserve CÂNONE/RUMOR/ABERTO distinctions.
- **FR-006** Follow RB-01/RB-02 interruption/return semantics.
- **FR-007** Do not rewrite canon/research text merely for layout.
- **FR-008** Introduce no new campaign gates, flags or save fields from presentation alone.

## Success Criteria

- **SC-001** Research remains fully playable after migration.
- **SC-002** Available/completed research/narrative items are clearly distinct.
- **SC-003** Narrative resolution returns to the correct prior context.
- **SC-004** Canon uncertainty semantics remain intact.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- New research content
- New narrative canon
- Campaign-gate changes
- Finale codas

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
