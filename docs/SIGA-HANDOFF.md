# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**ADVANCE — feature 008 complete; start RB-02 Game Shell / Navigation**

Verified closure on 2026-09-24:

- canonical repository: `az1nn/growing-rio`;
- feature 008 replacement PR #63 exact head: `9416f65c18d7e4d0b9feeb8cb135e0ebadc4c98a`;
- exact-head `Validate project` run #275 / `36006545508`: **SUCCESS**;
- Vercel on PR #63 exact head: **SUCCESS**;
- PR #63 merged with `expected_head_sha=9416f65c18d7e4d0b9feeb8cb135e0ebadc4c98a`;
- guarded merge result: `0d507770b0ddd39d5622472892a4ef3909babc94`;
- post-merge `Validate project` run #276 / `36006696732`: **SUCCESS**;
- Vercel on the product merge commit: **SUCCESS**;
- post-merge `Export Godot web build` run #35 / `36006694194`: **SUCCESS**;
- generated Web refresh commit: `8317996f51c7d7286205e8df463902f8f51e4e8b`;
- Vercel on generated Web refresh HEAD: **SUCCESS**;
- no Actions run exists on the bot-generated Web commit, consistent with the repository's documented GitHub Actions bot-push behavior;
- stale PR #51 was closed unmerged as superseded by #63;
- feature 008 tasks T001-T015 are complete in this closure record.

Finale expansion is now frozen. Do **not** start feature 009, finale handoff or ending-specific codas before RB-14 explicitly records PASS/unfreeze.

The next product implementation target is **RB-02 — Game Shell / Navigation**. It must consume the accepted RB-01 Product Experience Map and preserve its five top-level destinations: Operação, Mercado, Cidade, Institucional and Arquivo.

## Completed — feature 008
- Spec: `specs/008-act-v-ending-selection-persistence/`.
- Superseded branch/PR: `feat/008-act-v-ending-selection-persistence-r3` / #51 — closed unmerged.
- Delivered branch/PR: `feat/008-act-v-ending-selection-persistence-r4` / #63 — merged.
- `EndingSelectionService` performs deterministic, RNG-free selection from currently eligible ending IDs.
- `GameState.selected_ending_id` becomes immutable after a valid selection.
- Save schema is v11 with stable `campaign.selected_ending_id`.
- v10 migration intentionally produces an empty selected ending rather than inferring a finale choice.
- No ending is ranked, scored or labeled as the correct/winning ending.
- No ending picker, `event_da_lata_handoff`, ending coda or `arc_da_lata` completion was added.
- The current stacked-PR CI contract was preserved during reconciliation instead of copying stale workflow state from PR #51.
- Web delivery is green through the generated refresh commit `8317996f51c7d7286205e8df463902f8f51e4e8b`.

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
1. Start **RB-02 — Game Shell / Navigation** from the latest verified `master`, not from feature-008 branches.
2. Execute RB-02 T004 first: reconcile the five RB-01 route IDs against the live Main scene/control tree and current open PRs.
3. Claim a dedicated RB-02 implementation branch before runtime mutation.
4. Keep destination/navigation/overlay state presentation-only; surface switching must not advance time, consume RNG, reset campaign state or create a second canonical state store.
5. Preserve existing Main functionality during staged migration.
6. Implement the smallest coherent shell slice, then add navigation state-preservation regressions before expanding surface detail.
7. Re-scan the open CENA/LORE stacks before every shared-path write and before merge.
8. Keep finale expansion frozen until RB-14 explicitly records PASS/unfreeze.

## Boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic; no real politicians, parties, elections or targeted persuasion.
- No faction, institutional form or ending is treated as morally correct.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state.
