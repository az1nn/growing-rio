# Tasks: Product Experience Map

## Phase 0 — Specification package

- [x] [T001] Author bounded RB-01 specification.
- [x] [T002] Author implementation plan with constitution/persistence/validation constraints.
- [x] [T003] Complete requirements-quality checklist.

## Phase 1 — Future implementation

- [x] [T004] Reconcile current runtime surfaces and domain-backed capabilities.
- [x] [T005] Produce surface inventory and ownership matrix.
- [x] [T006] Define navigation graph and return-to-context rules.
- [x] [T007] Define narrative/campaign interruption behavior.
- [x] [T008] Document viewport constraints.
- [x] [T009] Review RB-02..RB-15 against the accepted map.

## Phase 2 — Reconcile, validate, persist

- [x] [T010] Reconcile live master/open-PR drift before runtime mutation and before merge.
- [x] [T011] Run targeted/full validation on the exact current implementation head.
- [x] [T012] Update architecture/roadmap/handoff docs from verified facts.
- [x] [T013] Merge under the repository's current guarded-merge contract and persist final state.

## Current wave status

T001-T013 are complete. PR #60 passed exact-head validation #270, merged with an expected-head guard as `edf2f233b98c8eb35d1358265fb18ceb07278c26`, and passed post-merge validation #271 plus Vercel. No runtime implementation was part of RB-01.
