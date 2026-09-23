# SIGA HANDOFF — DA LATA

## Verified repository
- Current repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified base HEAD: `026f8a2a6a208c96e9285707789a50737666f580`
- Active branch: `feat/v0.4-policy-progression`
- PR #14: **OPEN**
- Game/product name: **DA LATA**
- Repository rename desired: `az1nn/da-lata`
- Repository rename is not exposed by the currently connected GitHub actions; after a manual rename, future SIGA runs must discover and adopt the new repository identity from real state.

## Current milestone
**V0.4 — City systems: IN PROGRESS**

Current wave: **Fictional policy proposals and institutional progression**.

Implemented on PR #14:
- Added `PolicyDefinition` with stable fictional proposal IDs and abstract progression gates/effects.
- Added UI-independent `PolicyService` with deterministic proposal availability, enactment and state validation.
- Added three fictional proposals:
  - `policy_participatory_registry`
  - `policy_local_market_charter`
  - `policy_bay_civic_compact`
- Added canonical `institution_level` from 0..3 plus `enacted_policy_ids`.
- Proposal enactment applies only abstract Cash / Influence / Reputation / Heat deltas.
- Policy progression consumes no RNG draws.
- Added save schema v8 with a separate `policy` snapshot.
- Preserved explicit v1-v7 readers/migrations; v7 and older saves migrate to default policy state.
- Added policy progression regression coverage.
- Extended structural validation and GitHub Actions for policy/save v8 gates.
- Marked roadmap item **Policy proposals and institutional progression** complete on the feature branch.
- All institutions/proposals remain fictional; no real politicians, parties, elections or targeted persuasion mechanics are introduced.

## Decision
**WATCH**

The implementation is dispatched in PR #14. Merge is gated on the final PR head passing automated validation.

## Active gates
- PR #14 `Validate project`: **PENDING / RECONCILE NEXT**
- Mergeability must be re-read after the check completes.
- If validation fails, inspect the failing job/step, fix on the same branch and re-run.

## Web delivery
- `export_presets.cfg` is not configured.
- No public provider/URL is recorded in repository state.
- Browser delivery is not an acceptance gate for this policy-progression wave.
- SIGA must continue reconciling Web delivery on subsequent waves.

## Next action
1. Reconcile PR #14 current head and GitHub Actions result.
2. If all required checks are green and the PR is mergeable, merge PR #14 using the validated head.
3. Reconcile `master` after merge and persist the final merged state.
4. Then continue V0.4 with **community / reputation feedback loops**.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts, institutions, proposals and political actors remain fictionalized.
- No real politicians, parties, elections or targeted political persuasion.
