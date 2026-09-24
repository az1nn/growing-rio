# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**WATCH — RB-03 implementation is complete through T012 in PR #68; exact-head CI/provider closure is pending**

Live reconciliation on 2026-09-24:

- canonical repository: `az1nn/growing-rio`;
- default branch remains `master@fd7a2ba5ae763f9df80c12051a5979ee223d1559`;
- RB-02 PR #66 remains open and mergeable from branch `feat/rb-02-navigation-behavior`;
- PR #66 exact-head `Validate project` run #301 on `b8babeafe96052cbe535ae84fd66a85a36d742cc`: **SUCCESS**;
- Vercel on PR #66 reports explicit build-rate limiting: **SOFT_GATE_RATE_LIMIT**;
- by repository policy, that blocks merge evidence but does not create a development lock;
- RB-03 branch `feat/rb-03-operation-management` was created from exact PR #66 head `b8babeafe96052cbe535ae84fd66a85a36d742cc`;
- active stacked PR: **#68 — `feat(rb-03): extract operation management surface`**, base `feat/rb-02-navigation-behavior`;
- implementation/docs head before this handoff write: `b4963654e0c63df3ab069e8d4433a8c1550967f4`;
- RB-03 T004-T009 and T012 are implemented; T010/T011/T013 remain closure work;
- open CENA work changes `scenes/visual/operation_diorama.tscn` and generated Web artifacts; RB-03 intentionally leaves that asset untouched;
- LORE PR #52 remains docs-only and disjoint;
- finale expansion remains frozen until RB-14 PASS/unfreeze.

PR #68 inherits PR #66's pending provider delivery debt. Validate #68 on its own exact current head; do not merge it independently or retarget it to `master` merely to manufacture CI evidence.

## Active — RB-03 Operation Management Surface
- Spec: `specs/rb-03-operation-management-surface/`.
- New presentation owner: `scenes/operation/operation_surface.tscn` + `operation_surface.gd`.
- The staged `Main` container no longer owns care/day/harvest callbacks; it mounts Operation while keeping later Market/Archive/institutional migration content reachable.
- `CultivationService.action_availability()` owns deterministic care/day/harvest availability and blocked reasons.
- `GameState.cultivation_action_availability()` exposes that read-only domain boundary to presentation.
- Operation submits mutations only through existing `GameState.care_for_room()`, `next_day()` and `harvest()` commands.
- Operation exposes a visible, presentation-only `management_requested` handoff for RB-04; RB-03 does not duplicate room/staff/upgrade controls.
- `tests/operation_surface_test.gd` covers blocked-harvest non-mutation, RB-04 handoff purity and full care/next-day/harvest save-snapshot parity against canonical commands.
- CI runs the Operation regression for stacked PR heads.
- T008/T009/T012 are complete.
- T010/T011/T013 remain the final pre-merge drift reconciliation, exact-head validation and guarded bottom-up merge/post-merge persistence.

## Next engineering action
1. Read exact-current-head CI for PR #68 after this handoff commit; the previous pre-doc run is not reusable evidence.
2. If validation fails, RESUME the exact defect on #68 without touching the CENA diorama stream.
3. If repository validation succeeds while Vercel is still rate-limited, keep #68 open and merge-deferred; do not relabel the throttle as a repository failure.
4. Before any merge, re-read live master, #66, #68 and open CENA/LORE overlaps and complete T010 from current evidence.
5. When provider capacity returns, validate and merge bottom-up: #66 first, reconcile/revalidate #68 against the new base, then merge #68 with an expected-head guard and persist post-merge/Web evidence.
6. Only after RB-03 delivery closure ADVANCE the canonical product route to RB-04; finale expansion remains frozen until RB-14 PASS/unfreeze.

## Active — RB-02 Game Shell / Navigation
- Spec: `specs/rb-02-game-shell-navigation/`.
- Product contract: `docs/PRODUCT-EXPERIENCE-MAP.md`.
- PR #65 established the persistent five-destination shell, project boot path, shell-owned global status and staged Main embedding.
- PR #66 adds one overlay host, deterministic overlay return context, Back semantics, modal navigation suspension and portrait/wide navigation modes.
- `tests/game_shell_navigation_test.gd` compares full canonical save snapshots across navigation, overlay/back and layout changes, including RNG state.
- Exact-head CI now executes the shell-navigation regression.
- T010 and T012 are complete; T011 exact-current-head validation and T013 guarded merge/post-merge persistence remain.
- RB-03 must not begin until RB-02 closes or repository reality explicitly supersedes the sequence.

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
1. Re-run exact-current-head validation for PR #66 after the RB-02 architecture/spec/task closure writes, including the game-shell navigation regression.
2. Require provider success for that same PR head; an explicit rate-limit result is `SOFT_GATE_RATE_LIMIT` and blocks merge evidence, not safe continuation work.
3. Reconcile live `master`, open CENA/LORE stacks and changed-path overlap before merge.
4. If exact-head gates are green and #66 is mergeable, close RB-02 T010–T013 with architecture/handoff evidence and guarded merge.
5. Validate the resulting default-branch merge and Web export; reconcile any generated Web commit separately.
6. Only after RB-02 closure ADVANCE to RB-03 — Operation Management Surface.
7. Keep finale expansion frozen until RB-14 explicitly records PASS/unfreeze.

## Boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic; no real politicians, parties, elections or targeted persuasion.
- No faction, institutional form or ending is treated as morally correct.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state.
