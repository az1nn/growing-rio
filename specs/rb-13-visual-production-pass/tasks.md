# Tasks: Visual Production Pass

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-13 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Perform visual debt audit/prioritization.
- [x] [T005] Normalize reusable visual system.
- [ ] [T006] Promote high-impact OperationDiorama blockouts.
- [ ] [T007] Polish responsive readability/focus/motion.
- [ ] [T008] Validate provenance and performance.
- [ ] [T009] Record remaining placeholders and evidence.

## Phase 2 — Reconcile, validate, persist

- [ ] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [ ] [T011] Run targeted/full validation on the exact current implementation head.
- [ ] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [ ] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

Only T001-T003 are complete. No runtime implementation is implied by this documentation wave.


## Runtime progress — 2026-09-24

- T004 reconciled live CENA waves 002-011 and RB-12: the OperationDiorama's high-impact primitive families already carry production-candidate treatment; the highest-impact remaining cross-surface gap was shell/UI visual inconsistency.
- T005 adds `resources/ui/dalata_theme.tres` and applies it at the GameShell and standalone Main roots so shared button, panel, label and keyboard/controller focus treatment flows through the current UI tree.
- T006-T013 remain open pending fresh rendered acceptance, responsive/fallback verification and exact-head delivery evidence.
