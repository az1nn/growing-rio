# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Truth order: live repository / CI > constitution > active spec/plan/tasks > this handoff > chat/model memory.

## Current route
**WATCH — RB-11 is implemented and repository-green on its last exact implementation head, but this handoff persistence advances the PR head and therefore requires fresh exact-head Validate project + Visual acceptance evidence. Vercel remains an explicit `SOFT_GATE_RATE_LIMIT`: merge/public-delivery is deferred, development is not globally locked.**

Reconciled 2026-09-24:
- `master@468401729addaf9faece48cb250a6a773e089a24`.
- RB-10 PR #81 remains open against master at `c7ce8caf8b53afe7184715a5584a6149aca61ca0`; Validate project #387 and Visual acceptance #31 succeeded.
- RB-11 PR #83 is stacked on #81 via branch `feat/rb-11-save-load-campaign-ux`.
- Last exact RB-11 implementation head before docs persistence: `24a39c844ae75dea4d6c392de17bbd8459735536`.
- Validate project #393 on `24a39c8...`: **SUCCESS**, including the new Campaign persistence and atomic-load regression.
- Visual acceptance #37 was still running when docs persistence began and is historical once this handoff advances the head.
- Vercel on active product/CENA heads reports the explicit provider build-rate-limit URL. Keep classification `SOFT_GATE_RATE_LIMIT`; do not call it an application failure and do not merge while provider proof is required.
- Finale expansion remains frozen until RB-14 records PASS/unfreeze.

## Active — RB-11 Save / Load / Campaign UX
- Spec: `specs/rb-11-save-load-campaign-ux/`.
- Branch: `feat/rb-11-save-load-campaign-ux`.
- PR: **#83 — `feat(rb-11): add save load campaign UX`**.
- Stack base: RB-10 PR #81 / `feat/rb-10-archive-research-narrative-ux@c7ce8caf...`.
- Canonical save schema remains **v11**; RB-11 adds no canonical field and no migration version.
- `persistence/campaign_slot_store.gd` owns durable `user://` JSON slot storage and storage-envelope metadata only.
- `scenes/campaign/campaign_flow_controller.gd` owns Save/Load/New campaign orchestration and delegates canonical payload/state work to GameState.
- `scenes/shell/game_shell.gd` remains presentation-only: campaign menu, confirmation and feedback; it does not directly call gameplay reset.
- Startup exposes Continue/New when a durable slot exists.
- In-session campaign menu exposes Save/Load/New.
- Existing-slot overwrite requires confirmation.
- New Campaign requires confirmation and deliberately preserves the durable slot until a later confirmed overwrite.
- Invalid/corrupt/unsupported data surfaces readable failure and does not partially mutate the active campaign.
- Shell destination/overlay state remains transient and is not canonicalized.

## Validation history
1. First RB-11 head failed structural validation because `game_shell.gd` directly called `reset()`; RB-02 requires the shell to remain presentation-only.
2. Added `campaign_flow_controller.gd` and moved campaign mutations behind that boundary without touching `autoload/game_state.gd`; this avoided overlap with RB-09 PR #79.
3. Structural validation then passed.
4. First campaign regression failed because the test compared raw pre-JSON and post-JSON Variant types. The adapter was valid; JSON numeric normalization made the assertion representation-sensitive.
5. The regression was corrected to validate through the canonical `SaveService.parse()` / GameState semantic boundary.
6. Exact implementation head `24a39c8...`: Validate project #393 **SUCCESS**.
7. That run passed all existing regressions plus:
   - current schema durable round-trip;
   - v10 migration through the same durable slot path;
   - corrupt JSON rejection/readable error;
   - unknown-content rejection with unchanged active canonical state;
   - New Campaign preserving the old durable slot.
8. This handoff commit creates a newer head. All earlier green runs become historical evidence for completion until the new exact head is green.

## Concurrency reconciliation
Open PRs at the last drift scan:
- #83 RB-11 -> RB-10 branch.
- #82 CENA 010 -> CENA 009; touches CENA docs, visual operation diorama and `tools/validate_project.py`.
- #81 RB-10 -> master.
- #80 CENA 009 -> CENA 008.
- #79 RB-09 -> master; touches `autoload/game_state.gd`.
- #78 CENA 008 -> master.

RB-11 deliberately:
- stacks on #81 because both edit the canonical shell;
- does **not** modify `autoload/game_state.gd`, avoiding #79's state-file overlap;
- does **not** modify `tools/validate_project.py` or the operation diorama, avoiding CENA #78/#80/#82 overlap;
- uses no force update.

## Spec Kit task state
- T001-T009: complete.
- T010: open; repeat final drift/overlap barrier immediately before guarded merge.
- T011: open until the final persisted PR head receives fresh exact-head validation.
- T012: complete; architecture/roadmap/handoff persisted from verified facts.
- T013: open; guarded merge/post-merge delivery not allowed while required provider proof is rate-limited.

## Next engineering action
1. Read PR #83's exact head produced by this handoff write.
2. Require `Validate project` and `Visual acceptance capture` success for that exact head.
3. If either repository gate fails, classify **RESUME** and fix only the concrete RB-11 defect.
4. If both repository gates pass while Vercel remains explicit build-rate limiting, keep #83 open/merge-deferred but classify safe development **ADVANCE**.
5. The next bounded product slice is **RB-12 — Diorama Scene System**. Before starting it, reconcile overlap with the active CENA stack because both may touch visual/diorama contracts.
6. When Vercel capacity returns, re-read each base/head bottom-up, rerun any invalidated gates and merge only exact heads whose full required gate set is green using expected-head guards.
7. Finale expansion remains frozen until RB-14 explicitly records PASS/unfreeze.

## Persistent boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic.
- No real politicians, parties, elections or targeted persuasion are modeled.
- No faction, institutional form or ending is treated as morally correct or preferred.
- Real-history inspiration remains distinguishable from fictional canon.
- Chat/model memory is not canonical project state.
