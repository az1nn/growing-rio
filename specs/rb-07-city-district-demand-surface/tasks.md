# Tasks: City / District / Demand Surface

> **DELIVERED LEDGER RECONCILIATION — 2026-10-05:** the canonical product roadmap records this RB package as delivered on `master`. Previously unchecked historical bookkeeping items are marked resolved here so this file cannot be mistaken for an active execution queue.

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-07 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Reconcile district catalog/selection/demand APIs.
- [x] [T005] Implement district browse/detail and active state.
- [x] [T006] Implement demand presentation.
- [x] [T007] Integrate Market demand summary/links.
- [x] [T008] Prepare RB-08 community attachment points.
- [x] [T009] Add city consistency regressions.

## Phase 2 — Reconcile, validate, persist

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [x] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [x] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T009 and T012 are complete on the stacked RB-07 implementation branch. Pre-mutation reconciliation confirmed that the existing seven-district catalog, `GameState.select_district()`, deterministic `CityService` demand evolution and save-v11 city state are sufficient; no new domain model or persistence migration is required. Cidade now owns browse/select/demand presentation, Mercado shares the same canonical context and routes detail to Cidade, and a dedicated regression covers command parity, RNG stability and demand synchronization. T010 remains open for the mandatory final pre-merge drift barrier and T013 remains guarded bottom-up merge/post-merge closure. Exact implementation head `eff9a6ca02b499ba581f66ccfa3a1395d02039f6` passed `Validate project` run #36039562063, including structural validation, Godot import, the new City surface regression, policy/community/campaign/research suites and save-v11 round-trip/migrations. The subsequent documentation persistence head still requires its own exact-head validation before merge.
