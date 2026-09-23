# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Reconciled master: `e306bcfa2f454d48f3854a4d32d057da907734ea`
- Master includes PR #32 merge plus the post-merge lore handoff.
- Active feature: `specs/002-onda-provenance-research/`
- Active branch: `feat/002-onda-provenance-research`
- Active PR: **#33 — OPEN**
- PR base at creation: `e306bcfa2f454d48f3854a4d32d057da907734ea`
- Branch was reconciled with the concurrent lore handoff before PR creation.
- Live repository/PR/CI state always overrides this handoff.

## Decision
**WATCH**

The previous engineering feature `001-research-presentation` is complete. SIGA advanced through Spec Kit into one bounded V0.5 research capability and dispatched it as PR #33. The remaining gate is exact-final-head repository validation and merge.

## Feature — 002 Onda provenance research
- Added Resource-backed step `research_onda_provenance_gap_map`.
- Ordered availability requires `research_symbol_order_compared`, the Onda object evidence and the unresolved symbol-order state.
- Completion records `research_onda_provenance_gaps_mapped`.
- Onda provenance remains explicitly unresolved.
- Historical/genetic lineage remains explicitly unauthenticated.
- GameState reuses the existing research catalog/service/query/command boundaries.
- The existing Main research surface discovers the third step dynamically; no UI-owned prerequisite rule was introduced.
- Added display-safe labels for provenance evidence and canon guardrails.
- Extended research-chain regression through three ordered steps, duplicate prevention, RNG stability and save-v10 round-trip.
- Extended research-presentation regression through step two -> step three -> no actionable research.
- Save schema remains v10.
- Updated structural validation and architecture documentation.

## Spec Kit status
- `spec.md`: present.
- `plan.md`: present.
- `tasks.md`: implementation/documentation tasks complete; exact-head validation and final persisted gate evidence remain open.
- `checklists/requirements.md`: complete.
- Research-chain roadmap item remains open; this feature extends it but does not implicitly close it.

## Active gate
- PR #33 is open.
- Re-read the exact PR head after this handoff commit.
- Run/inspect `Validate project` for that exact head.
- If validation fails, repair only the bounded feature and refresh exact-head evidence.
- If validation passes and GitHub reports the PR mergeable, merge PR #33.
- Then reconcile resulting `master` and post-merge validation before declaring the wave complete.

## Next V0.5 action after merge
No subsequent capability is authorized by this handoff before PR #33 is verifiably complete.

On the next ADVANCE after merge:
1. Reconcile live master, roadmap, architecture, canon, Spec Kit artifacts and open PRs.
2. Decide the next smallest research-chain capability through a new bounded Spec Kit feature.
3. Do not start finale implementation until the research-chain roadmap item is explicitly completed by repository evidence.
4. Keep Web delivery non-blocking until an export/deployment capability is actually configured or required by a milestone.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts, institutions and political actors remain fictionalized; no real politicians, parties, elections or targeted persuasion.
- Real-history inspiration remains distinct from fictional canon.
- Onda can provenance, symbol order and continuous historical/genetic lineage remain unresolved.
- Chat/model memory is not canonical project state.
