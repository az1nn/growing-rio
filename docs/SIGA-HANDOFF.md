# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**WATCH — RB-02 shell-routing slice is implemented in PR #65; exact-head gates pending**

Live reconciliation on 2026-09-24:

- canonical repository: `az1nn/growing-rio`;
- verified pre-RB-02 `master`: `88f06ef2f12e5c80d7872f30b3756b7345293b78`;
- feature 008 closure PR #64 is merged and post-merge `Validate project` #278 plus Vercel succeeded;
- active RB-02 branch: `feat/rb-02-game-shell-navigation`;
- active PR: **#65 — `feat(rb-02): add persistent game shell routing`**;
- implementation head before this handoff write: `2c8e239fd17820205018a26e162696debddca6c2`;
- RB-02 T004–T006 are implemented: live Main/control reconciliation, persistent five-destination shell routing, and shell-owned global status;
- current Main remains embedded under Operação so all existing playable actions stay reachable during staged migration;
- shell validation rejects known gameplay mutation calls, keeping navigation presentation-only;
- open CENA/LORE stacks do not overlap the current RB-02 changed paths;
- finale expansion remains frozen until RB-14 PASS/unfreeze.

Do not treat PR #65 as complete until exact-current-head `Validate project` and required provider status are green, followed by guarded merge and default-branch validation.

## Active — RB-02 Game Shell / Navigation
- Spec: `specs/rb-02-game-shell-navigation/`.
- Product contract: `docs/PRODUCT-EXPERIENCE-MAP.md`.
- Canonical destination IDs: Operação, Mercado, Cidade, Institucional, Arquivo.
- New shell: `scenes/shell/game_shell.tscn` + `game_shell.gd`.
- Project boot now routes through the shell.
- Global status reads Day/Cash/Heat/Reputation/Influence directly from canonical GameState.
- Main exposes only an `embedded_in_shell` presentation compatibility boundary; no domain ownership moved into the shell.
- T007 overlay/back/return behavior remains open.
- T008 responsive portrait/wide navigation adaptation remains open.
- T009 explicit non-mutation regression remains open.
- RB-03..RB-11 surface decomposition remains downstream scope.

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
1. Validate PR #65 on its exact current head after this handoff write.
2. Require Vercel/provider success for the same head.
3. Re-read `master`, PR #65 and open-PR overlaps immediately before merge.
4. If green and mergeable, merge #65 with an expected-head SHA guard.
5. Validate the resulting default-branch HEAD.
6. Then RESUME RB-02 with T007–T009: overlay/back/return semantics, responsive portrait/wide behavior, and explicit navigation non-mutation regression.
7. Do not begin RB-03 until RB-02 T007–T013 close or repository reality explicitly supersedes the sequence.
8. Keep finale expansion frozen until RB-14 explicitly records PASS/unfreeze.

## Boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic; no real politicians, parties, elections or targeted persuasion.
- No faction, institutional form or ending is treated as morally correct.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state.
