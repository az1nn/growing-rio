# Feature Specification: Visual Production Pass

**Feature:** rb-13-visual-production-pass  
**Re-baseline ID:** RB-13  
**Status:** Specified — implementation not started  
**Target maturity:** POLISHED  
**Depends on:** RB-02/RB-03/RB-12 stable  
**Created:** 2026-09-23

## Overview

Promote the highest-impact blockout presentation to production-candidate quality only after shell/scene architecture is stable, without reopening information architecture or gameplay.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Core surfaces feel coherent

**Given** major surfaces are implemented  
**When** the player moves among them  
**Then** typography, spacing, controls and contextual visuals form one product language  
**And** they do not read as disconnected prototypes

### Scenario 2 — Operation reaches production candidate

**Given** operation scene architecture is stable  
**When** visual production is applied  
**Then** validated assets/materials/lighting replace priority blockouts  
**And** performance budget remains satisfied

### Scenario 3 — Portrait readability survives

**Given** a narrow viewport is used  
**When** final treatment is active  
**Then** labels, controls, focus and feedback remain legible/actionable  
**And** polish does not hide function

### Scenario 4 — Fallback stays coherent

**Given** reduced 3D fallback is active  
**When** the same product surfaces are used  
**Then** visual coherence/function remain  
**And** gameplay does not change

## Functional Requirements

- **FR-001** Polish only stable RB-02/RB-12 architecture, not temporary monolithic Main.
- **FR-002** Preserve interaction hierarchy, readability/accessibility and domain behavior.
- **FR-003** Validate provenance/licensing of production assets.
- **FR-004** Respect RB-12 Web/mobile performance budgets.
- **FR-005** Define coherent reusable treatment for typography, spacing, panels, controls and status feedback.
- **FR-006** Do not rely on color alone for important state.
- **FR-007** Do not let motion obscure/delay critical input.
- **FR-008** Document remaining intentional placeholders/debt.

## Success Criteria

- **SC-001** Operation and shell meet a documented production-candidate bar.
- **SC-002** Portrait/wide layouts remain readable.
- **SC-003** 3D remains within performance/fallback contract.
- **SC-004** Committed third-party assets have clear provenance/licensing.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- Information-architecture rewrite
- New gameplay systems
- Campaign-gate rework
- Unbounded low-impact asset replacement

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
