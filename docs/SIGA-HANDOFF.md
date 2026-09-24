# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**WATCH — feature 008 reconciled in PR #63; exact-head gates pending**

Live reconciliation on 2026-09-24:

- canonical repository: `az1nn/growing-rio`;
- live `master`: `787a611cd2232c72e8cdd611f509c7466feb907c`;
- RB-01 is complete and its Product Experience Map is canonical;
- stale PR #51 was 26 commits behind `master` and collided with the newer stacked-PR CI contract plus this handoff;
- feature 008 was rebuilt from live `master` on `feat/008-act-v-ending-selection-persistence-r4`;
- replacement PR: **#63 — `feat(008): reconcile immutable ending selection`**;
- implementation head before this handoff write: `5754a4d7162c5d03f118b187fb33dd7a0886f04a`;
- current `.github/workflows/validate.yml` keeps unfiltered `pull_request`, `workflow_dispatch`, and checkout of `github.event.pull_request.head.sha`;
- feature 008 restores deterministic immutable ending selection and save schema v11 while preserving migrations through v10;
- finale expansion remains frozen after feature 008; do not start feature 009/codas;
- after feature 008 closes, the product route is **RB-02 — Game Shell / Navigation**.

PR #51 is superseded by #63 and must not be used as merge or CI evidence. Exact-head validation must be read again after this handoff commit because the head will change.

## Active — feature 008
- Spec: `specs/008-act-v-ending-selection-persistence/`.
- Replacement branch: `feat/008-act-v-ending-selection-persistence-r4`.
- PR #63 targets `master` directly.
- `EndingSelectionService` accepts exactly one currently eligible ending family, remains deterministic and RNG-free, and never ranks or scores endings.
- `GameState.selected_ending_id` is immutable once selected.
- Save schema is v11 with stable `campaign.selected_ending_id`.
- v10 migration intentionally produces no inferred ending selection.
- The current stacked-PR CI contract was semantically merged instead of copying the stale PR #51 workflow.
- Required closure: exact-current-head `Validate project` + required provider success, guarded merge, then post-merge default-branch validation.

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
1. Re-read PR #63 exact head after this handoff commit.
2. Require `Validate project` success for that exact SHA.
3. Require Vercel/provider success for the same delivery head; an explicit provider rate limit is `SOFT_GATE_RATE_LIMIT`, not a development lock.
4. Re-scan open PR overlap before merge.
5. If #63 is green and mergeable, merge with an expected-head SHA guard.
6. Validate resulting `master` and persist feature-008 closure.
7. Close/supersede stale PR #51.
8. Freeze finale expansion and **ADVANCE to RB-02 — Game Shell / Navigation**.

## Boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic; no real politicians, parties, elections or targeted persuasion.
- No faction, institutional form or ending is treated as morally correct.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state.
