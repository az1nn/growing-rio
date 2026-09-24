# Feature Specification: Save / Load / Campaign UX

**Feature:** rb-11-save-load-campaign-ux  
**Re-baseline ID:** RB-11  
**Status:** Specified — implementation not started  
**Target maturity:** PRESENTED  
**Depends on:** RB-02; existing versioned SaveService  
**Created:** 2026-09-23

## Overview

Expose the mature versioned save boundary through complete player-facing Continue/Save/Load/New Campaign flows with atomic validation and safe failure.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player continues

**Given** a valid persisted campaign exists  
**When** Continue is chosen  
**Then** the intended campaign loads through existing validation  
**And** the shell opens in a valid context

### Scenario 2 — Player saves/restores

**Given** a campaign is active  
**When** a valid slot is saved and later loaded  
**Then** canonical state round-trips through SaveService  
**And** transient UI state is not silently canonicalized

### Scenario 3 — Invalid save fails safely

**Given** stored data is corrupt/unsupported/invalid  
**When** load is attempted  
**Then** the load is rejected before partial mutation  
**And** clear recovery feedback is shown

### Scenario 4 — New campaign is deliberate

**Given** an existing campaign may be overwritten/abandoned  
**When** New/Reset is chosen  
**Then** destructive consequences require confirmation  
**And** existing data is not silently destroyed

## Functional Requirements

- **FR-001** Expose Continue, Save, Load and New/Reset Campaign entry points appropriate to the storage model.
- **FR-002** Route payload creation/parsing/loading through current SaveService/GameState.
- **FR-003** Never partially apply invalid data before validation succeeds.
- **FR-004** Show readable errors for unsupported schema, corruption and unknown-content validation.
- **FR-005** Require confirmation for destructive reset/overwrite.
- **FR-006** Support at least one durable campaign slot and a slot model extensible without duplicating domain state.
- **FR-007** Isolate Web/mobile storage adapter from canonical payload format.
- **FR-008** Keep UI-only shell/navigation state out of persistence unless explicitly justified/versioned.

## Success Criteria

- **SC-001** Current-schema save/load works through player controls.
- **SC-002** Supported older-schema fixtures migrate through the same path.
- **SC-003** Invalid data leaves active campaign unchanged and explains failure.
- **SC-004** New/reset cannot silently destroy a campaign.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- Cloud account sync
- Save editor/debug injection
- Gameplay changes for UX convenience
- Arbitrary scene-state persistence

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
