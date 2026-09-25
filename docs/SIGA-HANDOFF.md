# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**ADVANCE — RB-09 implementation is repository/visual-green and merge-deferred only by the explicit Vercel `SOFT_GATE_RATE_LIMIT`; bounded disjoint development may continue while provider delivery debt remains open.**

Live reconciliation on 2026-09-24:
- `master@468401729addaf9faece48cb250a6a773e089a24` is the verified default-branch base for this wave.
- RB-08 was delivered through PR #77 and the default-branch Web export refreshed immediately afterward.
- Open CENA PR #78 targets `master` at `25ce7440d62b86480ad4bcc5e831da589ec93e9e`; exact-head `Validate project` #370 and `Visual acceptance capture` #14 both succeeded.
- Vercel on #78 still reports the explicit free-tier build-rate limit, so #78 remains merge-deferred under `SOFT_GATE_RATE_LIMIT`.
- RB-09 branch: `feat/rb-09-policy-institutional-surface`.
- RB-09 PR: **#79 — `feat(rb-09): present policy institutional surface`**.
- PR #79 was created from exact `master@468401729addaf9faece48cb250a6a773e089a24`.
- RB-09 implementation head `3082cee5cc570bafc00ac6de3834de39159b0095` passed exact-head `Validate project` #377 and `Visual acceptance capture` #21 after fixing one structural token regression and one neutral-boundary test false positive.
- Vercel on the RB-09 head still reports the explicit free-tier build-rate limit; this is `SOFT_GATE_RATE_LIMIT`, not a source/build/runtime failure.
- This tasks/handoff persistence advances PR #79 beyond `3082cee5...`; exact-current-head repository/visual checks must be read again before any merge claim.
- PR #78 and RB-09 are path-disjoint for runtime work: #78 changes CENA docs, operation diorama and `tools/validate_project.py`; RB-09 intentionally avoids the validator path and changes GameState, Institucional, policy regression and RB-09/product docs.
- Finale expansion remains frozen until RB-14 records PASS/unfreeze.

## Active — RB-09 Policy / Institutional Surface
- Spec: `specs/rb-09-policy-institutional-surface/`.
- `GameState.institutional_snapshot()` is the UI read boundary for institution level, Influence, compliance/community context, civic participation and all canonical policy definitions/states.
- Policy availability and blocking reasons are derived through the existing `PolicyService.resolve_enactment()`; scene code does not reproduce policy gate formulas.
- Institucional distinguishes enacted, available and unavailable proposals and renders Resource-backed prerequisites/effects neutrally.
- Mutations remain exclusively `GameState.enact_policy()`, `GameState.civic_engagement()` and the pre-existing compliance command.
- No policy catalog/tuning, save-schema change, real politician, real party, election, ballot measure, targeted persuasion, ranking or recommended proposal was added.
- `tests/policy_progression_test.gd` now covers blocked/available/enacted presentation, policy and civic surface-command parity, RNG stability and neutral-content boundaries.
- Spec Kit T001-T009, T011 and T012 are complete from exact implementation-head evidence. T010 remains open for final pre-merge drift reconciliation; T013 remains guarded merge/post-merge closure.

## Concurrency state
- #78 remains an independent CENA delivery debt on the same `master` base and does not block bounded RB-09 development.
- Before any RB-09 merge, re-read `master`, #78 and #79; if #78 or another actor changes a shared path/contract, classify and reconcile before merge.
- No stale CI result may be reused after this handoff/docs commit changes #79's head.
- Expected-head guarding is required for merge.

## Next engineering action
1. Read the exact current PR #79 head created by this persistence and require fresh `Validate project` plus visual acceptance evidence for that SHA; do not reuse #377/#21 for the newer docs head.
2. If repository/visual validation remains green while Vercel is explicitly rate-limited, keep #79 open/merge-deferred under `SOFT_GATE_RATE_LIMIT` and permit a bounded **ADVANCE** to **RB-10 — Archive / Research / Narrative UX**.
3. Re-run the open-PR overlap/drift barrier immediately before any later merge.
4. When every required merge gate, including provider delivery if still required, is green, merge #79 with an expected-head SHA guard and validate the resulting default-branch state before closing T010/T013.
5. Finale expansion remains frozen until RB-14 explicitly records PASS/unfreeze.

## Persistent boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic.
- No real politicians, parties, elections or targeted persuasion are modeled.
- No faction, institutional form, policy or ending is treated as morally correct or preferred.
- Real-history inspiration remains distinguishable from fictional canon.
- Chat/model memory is not canonical project state.
