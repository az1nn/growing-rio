# Feature Specification: City / District / Demand Surface

**Feature:** rb-07-city-district-demand-surface  
**Re-baseline ID:** RB-07  
**Status:** Implemented — exact-head delivery validation pending  
**Target maturity:** PRESENTED  
**Depends on:** RB-02 and RB-05  
**Created:** 2026-09-23

## Overview

Materialize district selection and district demand into a dedicated City surface so city state becomes an understandable player decision rather than hidden domain data.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Player selects a district

**Given** multiple valid districts exist  
**When** a district is chosen  
**Then** the canonical active district changes  
**And** Market/Community contexts update

### Scenario 2 — Player reads demand

**Given** district demand state exists  
**When** City is viewed  
**Then** demand is readable per district  
**And** UI does not recompute it

### Scenario 3 — Market follows city state

**Given** demand changes over simulation  
**When** Market is revisited  
**Then** relevant feedback reflects canonical demand  
**And** no stale duplicate is shown

### Scenario 4 — Portrait comparison works

**Given** several districts exist  
**When** they are browsed on portrait  
**Then** each remains selectable with bounded detail  
**And** a large spatial map is not required

## Functional Requirements

- **FR-001** Make City the primary owner of district selection and demand inspection.
- **FR-002** Use stable district IDs/resource data.
- **FR-003** Delegate active-district changes to existing orchestration.
- **FR-004** Read demand from canonical city/economy state only.
- **FR-005** Make the active district visually unambiguous.
- **FR-006** Allow Market summaries but route detailed city management to City.
- **FR-007** Keep districts fictional; do not imply a real-world geographic simulation.
- **FR-008** Introduce no district catalog, demand formula or balance change.

## Success Criteria

- **SC-001** All valid districts are inspectable and selectable.
- **SC-002** Displayed demand matches canonical state.
- **SC-003** Market/Community share the same active district.
- **SC-004** Portrait interaction remains viable without mandatory map UI.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- New districts/formulas
- RB-08 community mechanics
- RB-09 policy mechanics
- Mandatory 3D city map

## Implementation boundary

RB-07 is implemented as a presentation/orchestration slice over the existing canonical district catalog, district selection and deterministic demand simulation. Cidade becomes the detailed owner of district browse/select/demand inspection; Mercado shows only the shared active-district summary and emits a navigation handoff back to Cidade.

No district definitions, demand formulas, tuning, persistence shape, real geography, RB-08 community mechanics, RB-09 policy mechanics or mandatory map UI are introduced.
