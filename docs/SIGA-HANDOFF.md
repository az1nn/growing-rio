# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**RESUME — reconcile and close already-dispatched feature 008, then ADVANCE to RB-02**

RB-01 is complete. Live facts on 2026-09-24:

- canonical repository: `az1nn/growing-rio`;
- live product merge HEAD: `edf2f233b98c8eb35d1358265fb18ceb07278c26`;
- PR #58 stacked-PR CI fix: merged as `a7da6be3982a6c8a11168a91a942b84cf2372362`; PR validation #264 and post-merge #266 succeeded; Vercel succeeded;
- PR #53 product re-baseline/spec bundle: merged as `8591f237776aa3b82a861d30b5a7e65ef59c3c43`; PR validation #267 and post-merge #268 succeeded; Vercel succeeded;
- PR #60 RB-01 Product Experience Map: exact head `81a6aaed9f608325dbb31bdb8a3a30600869a21d` passed validation #270 and Vercel, merged with expected-head guard as `edf2f233b98c8eb35d1358265fb18ceb07278c26`, and post-merge validation #271 plus Vercel succeeded;
- RB-01 canonical output: `docs/PRODUCT-EXPERIENCE-MAP.md`;
- RB-01 tasks T001-T013 are complete.

The re-baseline explicitly allows feature 008 only to finish its already-dispatched delivery cycle and then freezes finale expansion. PR #51 therefore remains unfinished engineering work and takes precedence over starting RB-02. Its branch predates the merged stacked-CI contract and current handoff, so it must be reconciled semantically against live `master`; stale CI/provider evidence must not be reused.

After feature 008 is normally closed and frozen, the next product implementation target is **RB-02 — Game Shell / Navigation** using the five-destination RB-01 contract.

## Completed — feature 007
- Spec: `specs/007-act-v-final-form-eligibility/`.
- Feature branch: `feat/007-act-v-final-form-eligibility`.
- PR #46: **MERGED** — `feat(007): add Act V final-form eligibility`.
- Final PR head: `f1822d06173d2b64adcfe96d1bc248dc37d7adb4`.
- Exact-head PR validation: `Validate project` run #229 / `35927637412` — **SUCCESS**.
- Vercel status on final PR head: **SUCCESS**.
- PR #46 was merged with `expected_head_sha=f1822d06173d2b64adcfe96d1bc248dc37d7adb4`.
- Guarded merge result: `fb581466c01b9a5c7411770205127afe341b1cb1` — **SUCCESS**.
- Post-merge default-branch validation: `Validate project` run #230 / `35927715038` on `fb581466c01b9a5c7411770205127afe341b1cb1` — **SUCCESS**.
- Post-merge Web export: `Export Godot web build` run #17 / `35927715241` — **SUCCESS**.
- Generated Web refresh commit: `1d129e1973cb7f54cf1cdc79220e8849122c1459`.
- Vercel status on generated Web refresh HEAD: **SUCCESS**.
- Feature-007 tasks T001–T014 are complete with this persisted closure.
- The V0.5 finale roadmap item remains open because ending selection, finale handoff and ending codas are not implemented yet.

## Product result
- `event_forma_da_lata` now unlocks naturally after `lore_da_lata_name_canonical`.
- The event records one of four canonical intervention postures while always setting `lore_final_form_debate_seen`.
- No final-form choice stores an ending ID or completes `arc_da_lata`.
- `EndingEligibilityService` derives zero, one or multiple eligible ending-family IDs from accumulated campaign state without RNG, scoring or ranking.
- `GameState.eligible_ending_ids()` exposes that derived domain boundary without adding UI state.
- The six documented families remain available as neutral possibilities:
  - Marca Nacional;
  - Rede Viva;
  - Noite Sem Rótulo;
  - Arquivo Público;
  - Atlântico;
  - O Verão Volta.
- `O Verão Volta` remains a composite family, not a “true ending”, and requires mixed system maturity plus participation in both market relationships.
- Save schema remains v10 because eligibility is recomputed from canonical persisted state.
- Existing Ato V opening now hands off to the final-form debate after save/restore as well.

## Validation added
- Added `tests/act_v_final_form_eligibility_test.gd`.
- Added the regression to `.github/workflows/validate.yml`.
- Extended `tools/validate_project.py` with final-form Resource and eligibility-service contracts.
- Updated `tests/act_v_reconstruction_opening_test.gd` to expect the feature-007 handoff.
- Updated `tests/campaign_state_test.gd` from 12 to 13 canonical narrative events.
- Exact-head CI proved the new regression, existing campaign/research/presentation suites and save-v10 migrations green together.

## Concurrency reconciliation
- Feature 007 started from validated `master@b615eb367fdd12d8341644fee9b37b5df99b1afb`.
- No open PRs overlapped the feature at the implementation write barriers.
- Immediately before guarded merge, PR #46 was the only open PR; its base remained `b615eb367fdd12d8341644fee9b37b5df99b1afb`, its validated head remained `f1822d06173d2b64adcfe96d1bc248dc37d7adb4`, and GitHub reported it mergeable.
- The Web export workflow is mutative and advanced `master` from the product merge to `1d129e1973cb7f54cf1cdc79220e8849122c1459`.
- This handoff branch starts from that generated commit and therefore incorporates, rather than overwrites, the generated Web artifact.
- At the post-export reconciliation there were no open PRs.

## Final gate note
- GitHub Actions bot pushes do not independently trigger the normal `push` validation workflow for the generated Web commit.
- The product merge commit itself is fully validated; the generated commit has successful export and Vercel evidence.
- The handoff closure creates the next user-authored HEAD. Its own PR exact-head validation and the merged `master` validation are the final closure gates.
- Never reuse run evidence after the handoff head changes; read CI against the actual SHA.

## Next engineering action
1. Reconcile PR #51 (feature 008 ending-selection persistence) against live `master`.
2. Preserve the merged stacked-PR CI contract in `.github/workflows/validate.yml`; do not reintroduce the old `pull_request.branches: [master]` filter or synthetic-merge-ref validation.
3. Rebuild any conflicting `docs/SIGA-HANDOFF.md` content from live facts rather than preferring the stale feature branch copy.
4. Re-run exact-head repository validation and Vercel for the reconciled PR #51 head.
5. If green and mergeable, merge #51 with an expected-head guard and validate the resulting default-branch HEAD.
6. Freeze finale expansion after feature 008; do not start 009/finale codas.
7. Then **ADVANCE to RB-02 — Game Shell / Navigation**, consuming `docs/PRODUCT-EXPERIENCE-MAP.md` without redefining its top-level ownership model.
8. LORE/CENA open stacks remain separate workstreams and should be continued through their own repository-local skills unless they create a collision with the active SIGA engineering wave.

## Boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic; no real politicians, parties, elections or targeted persuasion.
- No faction, institutional form or ending is treated as morally correct.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state.
