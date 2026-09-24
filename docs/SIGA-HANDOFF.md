# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**WATCH — RB-04 is implemented and repository-green on its implementation head; delivery is stacked behind provider-gated RB-03**

Live reconciliation on 2026-09-24:

- canonical repository: `az1nn/growing-rio`;
- default branch: `master@3a3cff67b2f361ca043f86d81f7ce9ccd79c0882`;
- RB-02 PR #66: **merged**;
- RB-03 PR #68: open, mergeable, base `master`, head `95ef5c09fafa84c20cf3e0550ea9ab5dfe895983`;
- PR #68 `Validate project` run #315: **SUCCESS** on its exact head;
- PR #68 Vercel: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`; merge remains deferred, development is not locked;
- RB-04 PR #70: open, mergeable, intentionally stacked on PR #68 via base `feat/rb-03-operation-management`;
- RB-04 implementation head `91dfbbeaa3fe6e21e1f10bd0b4868eea83a445fb` passed `Validate project` run #318, including the new management regression and full save-v11 suite;
- the subsequent task/handoff persistence commits invalidate reuse of run #318 as final-head evidence; require fresh exact-head validation before any merge;
- CENA reconciliation PR #69 is concurrently open at head `30a1354294fa295b9390e9a41bf3297c72ab7839`; its visual stream is disjoint from RB-04 runtime, but both streams extend `tools/validate_project.py`, so that additive validator overlap must be reconciled rather than overwritten;
- the RB-04 branch contains generated `web/**` commit `72829d330bc894b3f7f901a8880016084cf094b9`, created by successful Export Godot web build run #69 from RB-04 runtime commit `0ebe37f82abd94fabd6252be75015374a6266446`; it was not copied from stale CENA output;
- Vercel on the current RB-04 stream remains explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`;
- finale expansion remains frozen until RB-14 PASS/unfreeze.

## Active — RB-04 Rooms / Staff / Upgrades
- Spec: `specs/rb-04-rooms-staff-upgrades/`.
- Branch: `feat/rb-04-rooms-staff-upgrades`.
- PR: **#70 — `feat(rb-04): present rooms staff and upgrades`**.
- Dependency: exact validated RB-03 head / PR #68.
- `GameState.management_snapshot()` is the presentation read boundary for existing room instances/definitions, staff, upgrades, canonical availability/ownership, operating cost and stability modifier.
- Operation owns the management panel; it creates no sixth shell destination.
- Mutations remain exclusively `switch_active_room()`, `hire_staff()` and `purchase_upgrade()`.
- No new room/staff/upgrade content, formula/tuning change or save-schema bump was introduced.
- `tests/management_surface_test.gd` proves UI-command parity, ownership/availability presentation, operating-cost feedback and save-v11 round-trip.
- Structural validation and exact-head CI include the RB-04 management contract.
- T001-T009, T011 and T012 are complete from implementation evidence. T010 still requires the final pre-merge drift barrier; T013 remains guarded merge/post-merge closure.

## Active — RB-03 Operation Management Surface
- Spec: `specs/rb-03-operation-management-surface/`.
- PR #68 is correctly retargeted to `master` after PR #66 merged.
- Exact head `95ef5c09fafa84c20cf3e0550ea9ab5dfe895983` passed `Validate project` run #315.
- The Operation surface owns care/day/harvest presentation and delegates availability to `CultivationService.action_availability()` through `GameState.cultivation_action_availability()`.
- Provider rate limiting is the remaining delivery gate; do not merge #68 while Vercel is `SOFT_GATE_RATE_LIMIT`.
- When provider capacity returns, re-read master, #68, #69 and #70, reconcile concurrent validator/visual drift, revalidate exact heads and merge bottom-up.

## Next engineering action
1. Validate the exact current PR #70 closure head after this handoff write; do not reuse run #318 for the new SHA.
2. If repository validation fails, **RESUME** the exact defect on #70.
3. If validation succeeds while Vercel remains rate-limited, keep #68/#70 open and merge-deferred; the provider throttle is not a development lock.
4. On the next bounded **ADVANCE**, begin RB-05 only from the verified RB-04 head and preserve the intentional stack.
5. Before any merge, execute T010 against live `master`, #68, #69 and #70; preserve CENA visual changes and combine additive validator contracts.
6. When provider capacity is green, merge bottom-up with fresh expected-head evidence, then verify default-branch validation, Web export and provider deployment.
7. Finale expansion remains frozen until RB-14 records PASS/unfreeze.

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
