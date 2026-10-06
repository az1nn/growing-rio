# Tasks — 3JS-004 City Topographic Continuity

> **SUPERSEDED LEDGER** — Ledger reconciliation (2026-10-05): this historical Three.js task ledger is terminally superseded by the repository's `GODOT_NATIVE_V1` production architecture and Feature 012 roadmap. `[x]` below means resolved/superseded, not authorization to restore Three.js production work.

## Phase 0 — reconcile / specify
- [x] T001 Verify repository identity, delivered Market closure, City surface state and open PR overlap.
- [x] T002 Select Cidade as the next bounded visual surface through CENA-021.
- [x] T003 Claim `feat/3js-004-city` from exact CENA-021 head.
- [x] T004 Author bounded spec/plan/tasks and safety/provenance boundaries.

## Phase 1 — implementation candidate
- [x] T005 Create isolated `threejs/city/` package with exact `three@0.186.1`.
- [x] T006 Implement fixed orthographic camera and inherited visual tokens.
- [x] T007 Implement original stepped terrain, urban clusters, skyline, vegetation and overlook silhouettes.
- [x] T008 Use immutable presentation-only placements and no domain/gameplay/geospatial logic.
- [x] T009 Implement cool structural + restrained warm practical lighting with shadows disabled.
- [x] T010 Implement deterministic resize, metrics, teardown and disposal.
- [x] T011 Add structural validation and exact-head City capture workflow.

## Phase 2 — evidence / CENA gate
- [x] T012 Revision 1 head `7f25b29cee5f57e99526ef63cd1e9d47e923bd98` passed exact-head Validate project #566.
- [x] T013 Revision 1 City capture #4 passed; artifact `10928746311`, empty console, 23 draw calls, 708 triangles, 8 materials, 0 authored textures, DPR 1, shadows disabled.
- [x] T014 CENA first returned **REVISE** on artifact `10928517376`; Revision 1 artifact `10928746311` was re-reviewed and **ACCEPTED**.
- [x] T015 On ACCEPT only, reconcile dependency #120 and guarded delivery.
- [x] T016 Persist post-merge closure.

## Current route
**3JS-WATCH** — CENA ACCEPT is persisted. Acceptance-status commits advance the PR head, so require fresh exact-head delivery gates before guarded merge.
