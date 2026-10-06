# Tasks: Visual Production Pass

> **DELIVERED LEDGER RECONCILIATION — 2026-10-05:** the canonical product roadmap records this RB package as delivered on `master`. Previously unchecked historical bookkeeping items are marked resolved here so this file cannot be mistaken for an active execution queue.

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-13 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Perform visual debt audit/prioritization.
- [x] [T005] Normalize reusable visual system.
- [x] [T006] Promote high-impact OperationDiorama blockouts.
- [x] [T007] Polish responsive readability/focus/motion.
- [x] [T008] Validate provenance and performance.
- [x] [T009] Record remaining placeholders and evidence.

## Phase 2 — Reconcile, validate, persist

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [x] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [x] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

Only T001-T003 are complete. No runtime implementation is implied by this documentation wave.


## Runtime progress — 2026-09-24

- T004 reconciled live CENA waves 002-011 and RB-12: the OperationDiorama's high-impact primitive families already carry production-candidate treatment; the highest-impact remaining cross-surface gap was shell/UI visual inconsistency.
- T005 adds `resources/ui/dalata_theme.tres` and applies it at the GameShell and standalone Main roots so shared button, panel, label and keyboard/controller focus treatment flows through the current UI tree.
- T007 converts portrait navigation to a three-column wrap, makes global status responsive (3 columns portrait / 5 wide), preserves 64px action targets and relies on the shared focus style without adding motion that can delay input.
- T006 closes by accepting the already-promoted CENA 002-011 OperationDiorama families on the RB-13 rendered head rather than adding redundant geometry; Visual acceptance #56 succeeded on `c8d1315426ba806995455fe3be707bf8bea1b4e9`.
- T008 is complete: the shared UI system and responsive slice add no third-party runtime asset and no new 3D draw cost; the exact-head visual workflow exported the isolated Web candidate successfully, while RB-12's low-resource `stretch_shrink = 2` fallback remains unchanged.
- T009 records intentional debt in `docs/VISUAL-DIRECTION.md`: no external prop/texture production set is introduced, and further OperationDiorama replacement is evidence-driven rather than mandatory churn.
- T012 is complete through Architecture/Roadmap/SIGA handoff reconciliation from the same verified evidence.
- T010, T011 and T013 remain open for the final pre-merge drift barrier, post-documentation exact-head evidence, and guarded delivery.
