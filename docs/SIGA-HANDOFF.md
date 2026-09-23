# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Research-foundation PR: **#27 — MERGED**
- Final PR head: `9d1d9ab7aa9863e6fce4c5d27d7f703e4e39f062`
- Exact final PR gate: **Validate project run #125 — SUCCESS**
- Merge commit: `1d0eb762b9300812524cb38836d84cd91ab9734e`
- Post-merge gate: **Validate project run #126 — SUCCESS**
- Active technical PR: **none**
- Web delivery: no verified `export_presets.cfg`; not an acceptance gate for this slice
- Live repository/PR/CI state always overrides the references recorded here

## Decision
**ADVANCE**

The first V0.5 DA LATA research-chain foundation is merged and validated on live `master`. The next coherent technical milestone is to extend the research chain beyond its initial Onda evidence step while keeping the roadmap item open until the feature is meaningfully multi-step and playable.

## Completed slice — research foundation
- Added Resource-backed `ResearchStepDefinition`.
- Added deterministic, RNG-free `ResearchService`.
- Materialized `research_onda_evidence_catalog`.
- The first research step unlocks only after `event_dalva_lucia_primeiro_depoimento` and the unresolved Onda evidence state.
- Completion records:
  - `research_da_lata_chain_started`;
  - `research_onda_evidence_catalogued`.
- Added `GameState.research_step_count()`, `available_research_step_ids()` and `complete_research_step()`.
- Reused existing save-v10 `campaign.narrative_flags` for research completion; no schema bump.
- Added `tests/research_chain_test.gd` and wired it into structural validation and GitHub Actions.
- Updated architecture documentation for the new Resource/service/GameState boundary.

## Validation
Final PR head `9d1d9ab...` passed **run #125**, including:
- structural validation;
- Godot 4.7.2 headless import;
- deterministic simulation;
- economy/business/rooms/staff/contracts/compliance regressions;
- fictional district/policy/community regressions;
- narrative-event and campaign-state regressions;
- natural campaign unlock regression;
- **Research chain regression**;
- narrative presentation regression;
- save schema v10 round-trip and v1-v9 migration regression.

Merge commit `1d0eb762...` then passed the same project gate on **run #126**.

## Canon and architecture boundary
- Research records and classifies uncertainty; it does not authenticate provenance, original symbol order, historical continuity or genetic lineage.
- The research service remains UI-independent and RNG-free.
- Research content is Resource-backed; GameState owns orchestration and persistent campaign flags.
- No real cultivation parameters are modeled.
- Existing CÂNONE / RUMOR / ABERTO distinctions remain intact.
- No economic or institutional route is morally privileged.

## Roadmap state
- V0.4 remains complete.
- V0.5 narrative-events/history item remains complete.
- V0.5 **Research chain around the fictional DA LATA cultivar remains in progress**.
- V0.5 finale remains future work.

## Active gate
- **None for the completed research-foundation slice.**
- PR #27 is merged.
- Exact-head and post-merge CI are green.
- Subsequent SIGA runs must reconcile live `master`, open PRs and CI before advancing.

## Next action
Implement the next smallest coherent **research-chain extension**.

1. Add at least one second Resource-backed research step so the feature behaves as a chain rather than a singleton.
2. Gate it through the persisted result of `research_onda_evidence_catalog` plus canonical narrative evidence, not scene state.
3. Preserve evidence-state distinctions and unresolved provenance; no step may turn research progress into proof of a continuous historical/genetic lineage.
4. Keep transitions deterministic and save-persistent through the existing v10 campaign contract unless a genuinely new state shape requires a schema change.
5. Add regression coverage for ordered research progression, duplicate prevention and save round-trip.
6. Only after the chain has multiple connected steps should SIGA consider a research presentation surface and eventual roadmap completion.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts, institutions and political actors remain fictionalized; no real politicians, parties, elections or targeted persuasion.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state; repository state and this repo-local handoff govern continuation.
