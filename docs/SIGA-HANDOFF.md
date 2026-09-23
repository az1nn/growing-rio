# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Research-chain extension PR: **#28 — MERGED**
- Final PR head: `e0d1ce4d142922fe47cae1d4151f2cceaa6f7050`
- Exact-head gate: **Validate project run #130 / validate job — SUCCESS**
- Merge commit: `77bc7b7f0d98701a00373e5b5adefb146cac3540`
- Concurrent lore merge after the technical branch base: `64f08378c681a24577e2bd2a9db5539e8bdfbca4`
- Latest verified master before this handoff persistence: `d3381d80c70db211b5323ae37ca07d7806846bff`
- The concurrent commits touch only `docs/lore/*`; the second research Resource, GameState registration and regression remain present on live `master`
- Active PRs at reconciliation: **none**
- Web delivery: no verified `export_presets.cfg`; not an acceptance gate for this slice
- Live repository/PR/CI state always overrides the references recorded here

## Decision
**ADVANCE**

The V0.5 DA LATA research feature is now a real ordered two-step chain and PR #28 is merged. The next smallest coherent milestone is a playable research presentation surface that consumes the existing GameState API without moving research rules into UI.

## Completed slice — ordered research chain
- `research_onda_evidence_catalog` remains the first canonical research step.
- Added `research_symbol_order_comparison`.
- Step 2 requires:
  - completed `event_dalva_lucia_primeiro_depoimento`;
  - persisted `research_onda_evidence_catalogued`;
  - canonical `lore_dalva_lucia_symbol_order_disputed`.
- Step 2 records `research_symbol_order_compared`.
- `GameState` now registers both Resource-backed research steps.
- Research remains deterministic, RNG-free and UI-independent.
- Save schema remains v10; completion state persists through `campaign.narrative_flags`.
- Regression coverage verifies ordered progression, premature-step rejection, duplicate prevention, RNG stability and save round-trip.
- Structural validation requires both research Resources and protected canon guardrails.
- Architecture documentation now describes the multi-step chain.

## Validation
Exact final PR head `e0d1ce4d...` ran **Validate project #130**.

Verified from the completed `validate` job/log:
- `VALIDATION PASSED`;
- `RESEARCH CHAIN TEST PASSED`;
- Godot 4.7.2 test workflow completed without `##[error]`;
- save schema v10 regression passed;
- no `FAILED` marker was present in the job log.

PR #28 then merged successfully with expected-head protection.

After merge, concurrent lore work advanced `master`; both concurrent commits were reconciled and are documentation-only under `docs/lore/*`. The technical research-chain artifacts remain present on live `master`.

## Canon and architecture boundary
- Research compares evidence; it does not choose a historical winner.
- Symbol order remains open.
- Onda provenance remains unresolved.
- Research never authenticates continuous historical or genetic lineage.
- No real cultivation parameters are modeled.
- Existing CÂNONE / RUMOR / ABERTO distinctions remain intact.
- No economic or institutional route is morally privileged.

## Roadmap state
- V0.4 remains complete.
- V0.5 narrative-events/history remains complete.
- V0.5 **Research chain around the fictional DA LATA cultivar remains in progress**.
- The research feature is now genuinely multi-step.
- V0.5 finale remains future work.

## Active gate
- **None for the completed ordered-chain slice.**
- PR #28 is merged.
- Exact-head validation is green.
- No technical PR remains open.
- Subsequent SIGA runs must reconcile live `master`, open PRs, CI and concurrent LORE changes before advancing.

## Next action
Implement the smallest playable **research presentation surface**.

1. Render available research step(s) from `GameState.available_research_step_ids()`.
2. Submit completion only through `GameState.complete_research_step()`.
3. Keep availability, ordering and consequences inside `ResearchService` / GameState rather than UI code.
4. Present evidence tags / semantic results without implying authenticated provenance or resolved symbol order.
5. Add a headless UI regression for the research interaction.
6. Keep save schema v10 unless the presentation genuinely introduces new canonical state.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts, institutions and political actors remain fictionalized; no real politicians, parties, elections or targeted persuasion.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state; repository state and this repo-local handoff govern continuation.
