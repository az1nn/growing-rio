# SIGA HANDOFF — DA LATA

## Verified repository
- Current repository: `az1nn/growing-rio`
- Default branch: `master`
- Game/product name: **DA LATA**
- Verified base `master` HEAD: `9180b124f77f87e7313d4088d76f3a80974eb55f`
- Base GitHub Actions `Validate project` run #59 (`35850004742`): **SUCCESS**
- Active branch: `feat/v0.4-community-feedback`
- Functional branch HEAD before this handoff commit: `cd7824ec8ed31291d17c3c6cc66ce333035844df`
- Open pull requests before this wave: **NONE**
- Concurrent reconciliation: `master` advanced to `555200d23b0ffbdd0b5d5ccc0610e0adcfbde889` through merged lore PR #15 after this branch was cut.
- The concurrent delta touches only `docs/lore/CHARACTER-RELATIONSHIPS.md`, `docs/lore/LORE-HANDOFF.md` and `docs/lore/README.md`; it does not overlap this engineering wave.
- PR validation must therefore run against the latest `master` merge context before merge.
- Repository rename desired: `az1nn/da-lata`
- Repository rename is not exposed by the currently connected GitHub actions; after a manual rename, future SIGA runs must discover and adopt the new repository identity from real state.

## Current milestone
**V0.4 — City systems: FINAL WAVE IN VALIDATION**

Current wave: **Community / reputation feedback loops**.

Implemented on the active branch:
- Added UI-independent `CommunityService`.
- Added canonical aggregate `community_support{district_id -> 0..100}` for all seven fictional districts.
- Community support starts neutral at 50.0 per district.
- Daily support movement is deterministic and bounded to at most 2 points.
- Inputs are existing abstract state only: Reputation, fictional institutional level and fictional district demand.
- Active-district support feeds a small bounded delta back into Reputation, capped at +/-0.25 per transition.
- Community feedback consumes no RNG draws.
- No identifiable demographic, real politician, party, election or targeted persuasion model is introduced.
- Added save schema v9 with a separate `community.support` snapshot.
- V8 and older saves explicitly migrate community support to canonical neutral defaults.
- Added community feedback regression coverage.
- Extended save-schema regression to cover v9 round-trip plus v1-v8 migration.
- Extended structural validation and GitHub Actions.
- Marked both remaining V0.4 roadmap items complete on the branch.

## Decision
**WATCH**

The V0.4 implementation is complete on the feature branch, but it is not authoritative until the exact branch head passes repository validation and merges into `master`.

## Active gates
1. Open a pull request from `feat/v0.4-community-feedback` to `master`.
2. Verify `Validate project` on the exact PR head.
3. If the required checks are green and the PR remains mergeable, merge using the validated head.
4. Reconcile post-merge `master` and verify its push workflow.
5. Persist the final merged state before advancing to V0.5.

## Web delivery
- `export_presets.cfg` is still not configured.
- Repository root has no configured public browser deployment provider/URL.
- Browser delivery is not an acceptance gate for this V0.4 final wave.
- SIGA must keep reconciling Web delivery on subsequent waves.

## Next action after green merge
Begin **V0.5 — Campaign** with the first coherent narrative-events slice:
1. Reconcile the repo-local lore canon and campaign docs before implementation.
2. Add narrative event data behind a UI-independent event/campaign service.
3. Keep historical/cultural references clearly separated from fictional characters and gameplay claims.
4. Preserve abstract cultivation and parallel-market boundaries.
5. Add deterministic regression coverage and persistence only for new canonical campaign state.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts, institutions, proposals, community state and political actors remain fictionalized.
- No real politicians, parties, elections or targeted political persuasion.
- Chat/model memory is not canonical project state; repository state and this repo-local handoff govern continuation.
