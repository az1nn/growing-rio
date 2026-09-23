# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch before this wave: `master`
- Verified base HEAD: `d6af307da7f41c1729ed4ff357c308ccf44e8a51`
- Base gate: Validate project run #123 — SUCCESS
- Technical branch: `feat/v0.5-research-chain-foundation`
- Active technical PR: pending creation at the time of this snapshot
- Web delivery: no verified `export_presets.cfg`; not an acceptance gate for this slice
- Live repository/PR/CI state always overrides this handoff

## Decision
**WATCH**

The first V0.5 DA LATA research-chain foundation has been implemented on a dedicated branch. It must not merge until the exact final PR head passes `Validate project`.

## Implemented slice — research foundation
- Added Resource-backed `ResearchStepDefinition`.
- Added deterministic, RNG-free `ResearchService`.
- Materialized the first research step: `research_onda_evidence_catalog`.
- The step unlocks only after the first canonical Dalva/Lúcia event and its unresolved Onda evidence state.
- Completion records `research_da_lata_chain_started` and `research_onda_evidence_catalogued`.
- Research completion reuses the existing save-v10 campaign flag contract; no schema bump.
- Added `GameState.research_step_count()`, `available_research_step_ids()` and `complete_research_step()`.
- Added `tests/research_chain_test.gd` and CI coverage.
- Updated architecture/structural validation for the new research boundary.

## Canon boundary
- Research records uncertainty; it does not authenticate provenance, original symbol order or historical/genetic lineage.
- No real cultivation parameters are introduced.
- No route is morally privileged.
- Existing CÂNONE / RUMOR / ABERTO distinctions remain intact.

## Active gate
- Open the technical PR from `feat/v0.5-research-chain-foundation` to `master`.
- Require `Validate project` on the exact final PR head.
- If the gate fails: **RESUME** and fix the failing regression.
- If it is active: remain **WATCH**.
- If exact-head CI is green: merge, verify post-merge `master`, persist the merge state, then **ADVANCE**.

## Next action after green merge
Extend the fictional DA LATA research chain with the next coherent evidence step and/or a presentation surface, preserving the same Resource/service boundary and save-persistent campaign flags. Keep the roadmap research-chain item open until multiple steps form an actual chain.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Institutions and political actors remain fictionalized; no real politicians, parties, elections or targeted persuasion.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state; repository state and this repo-local handoff govern continuation.
