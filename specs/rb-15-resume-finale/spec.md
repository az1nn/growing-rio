# Feature Specification: Resume Finale

**Feature:** rb-15-resume-finale  
**Re-baseline ID:** RB-15  
**Status:** Specified — implementation not started  
**Target maturity:** PRESENTED finale completion path  
**Depends on:** RB-14 PASS/unfreeze  
**Created:** 2026-09-23

## Overview

Resume the frozen finale only after the re-baselined loop is coherent. Turn existing ending eligibility and immutable selection into a complete neutral finale: player-facing selection, DA LATA handoff, ending coda presentation, explicit arc completion and defined post-ending state.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Eligible endings are neutral

**Given** RB-14 passed and multiple ending families are eligible  
**When** finale selection opens  
**Then** all eligible families are presented without ranking/recommendation/winner labels  
**And** no moral preference is implied

### Scenario 2 — Exactly one ending is selected

**Given** no ending is selected  
**When** an eligible family is confirmed  
**Then** existing immutable selection records it  
**And** a second different selection cannot replace it

### Scenario 3 — Finale completes once

**Given** an ending is selected  
**When** handoff/coda completes  
**Then** arc_da_lata completion semantics apply exactly once  
**And** post-ending state is explicit/save-safe

### Scenario 4 — Save/restore is safe

**Given** the campaign is saved around finale boundaries  
**When** it is restored  
**Then** selection/completion/post-ending behavior remain consistent  
**And** irreversible effects are not replayed incorrectly

## Functional Requirements

- **FR-001** Do not implement RB-15 until RB-14 records PASS/unfreeze.
- **FR-002** Use existing ending eligibility and immutable selection boundaries.
- **FR-003** Present eligible endings neutrally; never rank, score, recommend or mark a winner/preferred outcome.
- **FR-004** Keep ineligible endings non-selectable through normal UX.
- **FR-005** Preserve canonical handoff/coda content and protected uncertainty.
- **FR-006** Make arc_da_lata completion deterministic, explicit and idempotent.
- **FR-007** Define post-ending inspect/play/Continue/Load behavior.
- **FR-008** Version persistence only if new canonical state is truly required.
- **FR-009** Prevent save/restore from duplicating irreversible finale effects.
- **FR-010** Keep institutional/policy content fictional/systemic and non-persuasive.

## Success Criteria

- **SC-001** Every eligible family can be selected neutrally and only one becomes canonical.
- **SC-002** Handoff/coda completes once and arc_da_lata is explicitly completed.
- **SC-003** Save/restore preserves immutable selection and idempotent completion.
- **SC-004** Post-ending Continue/Load behavior is defined and test-covered.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- New ending families without separate canon/spec work
- Eligibility-predicate rewrite
- Ending ranking/recommendation
- Real-world political persuasion

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
