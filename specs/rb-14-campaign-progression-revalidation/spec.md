# Feature Specification: Campaign Progression Revalidation

**Feature:** rb-14-campaign-progression-revalidation  
**Re-baseline ID:** RB-14  
**Status:** Specified — implementation not started  
**Target maturity:** PLAYABLE/PRESENTED validated end-to-end  
**Depends on:** RB-03..RB-13 materially complete  
**Created:** 2026-09-23

## Overview

Revalidate Ato I through Ato V against the newly surfaced product. Ensure campaign gates correspond to meaningful player actions instead of merely satisfiable internal flags, changing only gates proven misaligned.

This package deliberately uses an `rb-XX` identifier and does **not** consume permanent post-008 feature numbering.

## User Scenarios

### Scenario 1 — Progression uses surfaced systems

**Given** a fresh campaign starts  
**When** the player reaches later acts through normal management systems  
**Then** act progression follows understandable achievements  
**And** developer-only shortcuts are unnecessary

### Scenario 2 — Specs 005-008 remain coherent

**Given** existing campaign features are canonical  
**When** a full campaign is replayed  
**Then** their gates/events/eligibility/persistence remain natural or receive bounded documented amendments  
**And** nothing is silently rewritten

### Scenario 3 — Save/load preserves progression

**Given** the campaign is saved at representative boundaries  
**When** it is restored  
**Then** progression matches uninterrupted play  
**And** no gate is duplicated/skipped

### Scenario 4 — No finale steering is added

**Given** multiple endings may become eligible  
**When** pre-finale readiness is reached  
**Then** revalidation does not rank/prefer outcomes  
**And** neutral eligibility/selection remains

## Functional Requirements

- **FR-001** Audit progression end-to-end from Ato I through pre-finale.
- **FR-002** Map every campaign gate to observable meaningful player achievement or explicitly justified systemic state.
- **FR-003** Revalidate specs 005-008 instead of silently rewriting them.
- **FR-004** Identify flag-only shortcuts that no longer represent player experience.
- **FR-005** Any gate correction must remain deterministic and receive regression coverage.
- **FR-006** Test save/load continuity at representative act boundaries.
- **FR-007** Preserve canon/protected uncertainty unless separate lore work changes it.
- **FR-008** Keep ending eligibility/selection neutral and RB-15 blocked until PASS.

## Success Criteria

- **SC-001** A fresh campaign reaches pre-finale through intended surfaced play.
- **SC-002** Every gate has documented player-facing meaning or justified systemic status.
- **SC-003** Specs 005-008 receive PASS or bounded amendment with evidence.
- **SC-004** Save/restore at representative boundaries preserves progression equivalence.

## Dependencies and sequencing

- Live repository/CI and `docs/SPEC-KIT-PRODUCT-REBASELINE.md` override stale planning assumptions.
- Reconcile this RB immediately before implementation.
- Dependency order is product sequencing, not permission to copy stale implementation state.
- Close implementation with explicit DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED maturity evidence.

## Out of Scope

- New ending families
- Ending codas
- Unrelated visual polish
- Real-world political content

## Planning-wave boundary

This specification package is documentation only. It changes no runtime, scene, domain, persistence, resource, test, CI or deployment behavior.
