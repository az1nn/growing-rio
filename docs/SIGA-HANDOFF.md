# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified base HEAD for this wave: `0aa6a0781f8cf6ec86f6546922400c090bb8c9a6`
- Technical branch: `feat/v0.5-research-chain-step-2`
- Active technical PR: **#28 — OPEN**
- Implementation head before handoff persistence: `7608d11430dc820faefd02286db64c6d4aeb87dd`
- Validate project run #128 was **QUEUED** for that implementation head when this handoff was written
- Web delivery: no verified `export_presets.cfg`; not an acceptance gate for this slice
- Live repository/PR/CI state always overrides the references recorded here

## Decision
**WATCH**

The V0.5 research chain now has two ordered, Resource-backed steps. The PR must remain open until `Validate project` passes on the exact final PR head after this handoff persistence commit.

## Implemented slice — ordered research chain
- Kept `research_onda_evidence_catalog` as the first step.
- Added `research_symbol_order_comparison` as the second step.
- The second step requires:
  - completed `event_dalva_lucia_primeiro_depoimento`;
  - persisted `research_onda_evidence_catalogued`;
  - canonical `lore_dalva_lucia_symbol_order_disputed`.
- Completion records `research_symbol_order_compared`.
- `GameState` now registers both research Resources.
- Research remains deterministic, RNG-free and UI-independent.
- Save schema remains v10; research completion persists through existing `campaign.narrative_flags`.
- Regression coverage now checks:
  - no research before the narrative gate;
  - only step 1 after the narrative event;
  - step 2 cannot bypass step 1;
  - step 2 unlocks after persisted step-1 completion;
  - duplicate completion is rejected;
  - both completion states survive save round-trip.
- Structural validation requires both research Resources and their canon guardrails.
- Architecture documentation now describes the ordered multi-step chain.

## Canon and architecture boundary
- Research compares evidence; it does not choose a historical winner.
- Symbol order remains open.
- Onda provenance remains unresolved.
- No continuous historical or genetic lineage is authenticated.
- No real cultivation parameters are modeled.
- Existing CÂNONE / RUMOR / ABERTO distinctions remain intact.
- No economic or institutional route is morally privileged.

## Roadmap state
- V0.4 remains complete.
- V0.5 narrative-events/history remains complete.
- V0.5 **Research chain around the fictional DA LATA cultivar remains in progress**.
- The chain is now genuinely multi-step, so a future SIGA wave may consider a research presentation surface after this PR is merged and post-merge validation is green.
- V0.5 finale remains future work.

## Active gate
- PR #28 is open from `feat/v0.5-research-chain-step-2` to `master`.
- Require `Validate project` on the exact final PR head.
- If the exact-head gate fails: **RESUME** and fix the failing regression.
- If it is queued/in progress: remain **WATCH**.
- If exact-head CI is green: merge PR #28, verify post-merge `master`, persist the merged state, then **ADVANCE**.

## Next action after green merge
Add the smallest playable research presentation surface that renders available research steps and submits completion only through `GameState.complete_research_step()`. Keep availability/consequence rules in the research domain and preserve all canon guardrails.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts, institutions and political actors remain fictionalized; no real politicians, parties, elections or targeted persuasion.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state; repository state and this repo-local handoff govern continuation.
