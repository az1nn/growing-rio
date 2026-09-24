# Product Re-baseline Spec Index

**Status:** Planning baseline  
**Source:** `docs/SPEC-KIT-PRODUCT-REBASELINE.md`  
**Permanent feature numbering:** intentionally not assigned

All RB-01 through RB-15 items have Spec Kit planning packages containing `spec.md`, `plan.md`, `tasks.md`, and `checklists/requirements.md`.

| RB | Feature | Target maturity | Dependency |
|---|---|---|---|
| RB-01 | [Product Experience Map](./rb-01-product-experience-map/spec.md) | PRESENTED product architecture contract | Product re-baseline; no RB dependency |
| RB-02 | [Game Shell / Navigation](./rb-02-game-shell-navigation/spec.md) | PRESENTED | RB-01 accepted |
| RB-03 | [Operation Management Surface](./rb-03-operation-management-surface/spec.md) | PRESENTED | RB-01 and RB-02 |
| RB-04 | [Rooms / Staff / Upgrades](./rb-04-rooms-staff-upgrades/spec.md) | PRESENTED | RB-02 and RB-03 |
| RB-05 | [Market / Contracts / Buyer Relationships](./rb-05-market-contracts-buyer-relationships/spec.md) | PRESENTED | RB-02; RB-04 for full business loop |
| RB-06 | [Compliance Experience](./rb-06-compliance-experience/spec.md) | PRESENTED | RB-05; shared context with RB-09 |
| RB-07 | [City / District / Demand Surface](./rb-07-city-district-demand-surface/spec.md) | PRESENTED | RB-02 and RB-05 |
| RB-08 | [Community Feedback](./rb-08-community-feedback/spec.md) | PRESENTED | RB-07; later consumed by RB-14 |
| RB-09 | [Policy / Institutional Surface](./rb-09-policy-institutional-surface/spec.md) | PRESENTED | RB-02; context from RB-06/RB-08 |
| RB-10 | [Archive / Research / Narrative UX](./rb-10-archive-research-narrative-ux/spec.md) | PRESENTED | RB-01/RB-02; preserves specs 001-004 |
| RB-11 | [Save / Load / Campaign UX](./rb-11-save-load-campaign-ux/spec.md) | PRESENTED | RB-02; existing versioned SaveService |
| RB-12 | [Diorama Scene System](./rb-12-diorama-scene-system/spec.md) | PRESENTED scene architecture | RB-01..RB-03; before RB-13 |
| RB-13 | [Visual Production Pass](./rb-13-visual-production-pass/spec.md) | POLISHED | RB-02/RB-03/RB-12 stable |
| RB-14 | [Campaign Progression Revalidation](./rb-14-campaign-progression-revalidation/spec.md) | PLAYABLE/PRESENTED validated end-to-end | RB-03..RB-13 materially complete |
| RB-15 | [Resume Finale](./rb-15-resume-finale/spec.md) | PRESENTED finale completion path | RB-14 PASS/unfreeze |

## Product sequence

```text
RB-01 -> RB-02 -> RB-03 -> RB-04 -> RB-05 -> RB-06 -> RB-07 -> RB-08 -> RB-09 -> RB-10 -> RB-11 -> RB-12 -> RB-13 -> RB-14 -> RB-15
```

RB identifiers are planning/decomposition IDs. Before implementation, reconcile live repository state. A broad RB may later split into smaller permanent numbered features; this index does not allocate 009+.

## Current MR boundary

Documentation only: no gameplay, scenes, GDScript, resources, persistence, tests, CI or deployment behavior changes.
