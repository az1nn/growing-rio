# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**WATCH — RB-10 implementation is repository-green on its exact implementation head, but this persistence wave advances the PR head and therefore requires fresh exact-head repository validation. Vercel remains an explicit `SOFT_GATE_RATE_LIMIT`; once the persisted head is repository-green, the development route may ADVANCE to RB-11 while RB-09/RB-10 delivery stays merge-deferred.**

Live reconciliation on 2026-09-24:
- Verified default-branch base before this wave: `master@468401729addaf9faece48cb250a6a773e089a24`.
- PR #79 — RB-09 remains open against `master` at `5e5a30182a085cd128691bf57d1da5a0c7697bdf`; Validate project #378 and Visual acceptance #22 succeeded, while Vercel reports the explicit build-rate limit.
- PR #78 — CENA 008 remains open against `master` at `25ce7440d62b86480ad4bcc5e831da589ec93e9e`; repository/visual validation is green and Vercel reports the same build-rate limit.
- PR #80 — CENA 009 is stacked on #78 at `71d55bf2d3e0c4ae6f8e52d8cbf1a089efce62ca`.
- PR #81 — RB-10 is open against `master`; before this handoff write its head is `85f6a0c42ab6e3c7719d34bbb0cb329e8005a11c`, mergeable and zero commits behind `master`.
- The RB-10 exact implementation head `ec783dfb7be6a8c5ca01987a57950d5e90c45b5c` passed Validate project #382 and Visual acceptance #26.
- Visual/Web export generated `2da54d688e09396c7ef94eedf5ea2b180c44ab1b` (`chore(web): refresh exported build`), synchronizing the exported browser payload with RB-10.
- Workflows on that bot-generated Web commit were `action_required`, so they were not reused as green evidence.
- Subsequent architecture/roadmap/spec persistence deliberately creates a newer human-authored PR head; exact-current-head CI must be read again after this handoff commit.
- Vercel failures observed on the active product/CENA heads point to the provider's build-rate-limit URL and remain `SOFT_GATE_RATE_LIMIT`, not application/build failures.
- Finale expansion remains frozen until RB-14 records PASS/unfreeze.

## Active — RB-10 Archive / Research / Narrative UX
- Spec: `specs/rb-10-archive-research-narrative-ux/`.
- Branch: `feat/rb-10-archive-research-narrative-ux`.
- PR: **#81 — `feat(rb-10): move research and narrative UX into Archive`**.
- Base: `master`.
- `scenes/archive/archive_surface.tscn` is now the shell destination for available research, completed research and permitted resolved narrative review.
- Research continues through existing canonical `GameState.available_research_step_ids()`, `research_step_presentation()` and `complete_research_step()` behavior; no research domain/RNG/save rule was duplicated.
- Available narrative events interrupt through the shell overlay, preserve the exact prior destination, block navigation/back until resolved, and return to that prior destination after resolution.
- RB-02's presentation-only shell invariant is preserved: the shell delegates the canonical narrative mutation through Archive rather than calling `GameState.resolve_narrative_choice()` directly.
- The embedded legacy Main research/narrative panels are hidden; standalone Main remains available for compatibility.
- Resolved narrative material is archived from existing `completed_event_ids`/choice flags.
- Protected uncertainty/canon guardrails remain visible; RB-10 adds no campaign gate, domain service or save-v11 field.
- `tests/research_presentation_test.gd` now validates the Archive research path.
- `tests/game_shell_navigation_test.gd` now validates narrative interruption, resolution, exact return context and resolved archival.
- Spec Kit T004-T009, T011 and T012 are complete. T010 remains open for the final pre-merge drift barrier; T013 remains open for guarded merge/post-merge delivery.

## Concurrency reconciliation performed
RB-10 was branched directly from verified `master@468401729...` because it is disjoint from the unresolved provider-gated work.

Open-PR overlap was checked before implementation and again during the wave:
- RB-09/#79 changes policy/institutional state, including `autoload/game_state.gd`; RB-10 avoided those paths.
- CENA #78/#80 changes CENA docs, the operation diorama and `tools/validate_project.py`; RB-10 avoided those paths.
- RB-10 instead changes Archive, shell/Main presentation, existing regressions, its Spec Kit state and product docs.
- No force update was used.
- The branch remained zero commits behind `master` at the final pre-handoff barrier.
- The generated Web commit was treated as real branch drift and invalidated stale exact-head evidence rather than being ignored.

## Validation history
- Initial RB-10 head failed structural validation because shell directly called `resolve_narrative_choice()`.
- The defect was fixed by delegating the mutation through Archive, restoring the shell's presentation-only contract.
- Exact implementation head `ec783df...`: Validate project #382 **SUCCESS**.
- Exact implementation head `ec783df...`: Visual acceptance #26 **SUCCESS**.
- Generated Web head `2da54d6...`: workflows reported `action_required`; not accepted as completion evidence.
- This handoff persistence creates a newer head. Treat all older green runs as historical evidence only until the new exact head is green.

## Open work observed at this handoff write
- PR #81: `feat/rb-10-archive-research-narrative-ux` -> `master` — RB-10, final persisted-head validation pending.
- PR #79: `feat/rb-09-policy-institutional-surface` -> `master` at `5e5a30182a085cd128691bf57d1da5a0c7697bdf`.
- PR #78: `feat/cena-008-floor-surface-rhythm` -> `master` at `25ce7440d62b86480ad4bcc5e831da589ec93e9e`.
- PR #80: `feat/cena-009-wall-bay-rhythm` -> `feat/cena-008-floor-surface-rhythm` at `71d55bf2d3e0c4ae6f8e52d8cbf1a089efce62ca`.

## Next engineering action
1. Read PR #81's exact head created by this handoff update and require fresh `Validate project` plus applicable visual evidence for that exact head.
2. If repository validation fails, classify **RESUME** and fix only the exact RB-10 defect.
3. If repository validation succeeds while Vercel remains the explicit build-rate/quota limit, retain `SOFT_GATE_RATE_LIMIT`, keep #81 open/merge-deferred and classify development **ADVANCE**.
4. The next bounded product slice is **RB-11 — Save / Load / Campaign UX**. Start it from the newest safe `master` base when disjoint; reuse the existing versioned SaveService/GameState boundary and preserve atomic invalid-load rejection.
5. When Vercel capacity returns, re-read #78/#79/#81 and their dependent stacks, validate exact heads, execute each final concurrency barrier and merge only heads whose full required gates are green using expected-head guards.
6. Finale expansion remains frozen until RB-14 explicitly records PASS/unfreeze.

## Persistent boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic.
- No real politicians, parties, elections or targeted persuasion are modeled.
- No faction, institutional form or ending is treated as morally correct or preferred.
- Real-history inspiration remains distinguishable from fictional canon.
- Chat/model memory is not canonical project state.
