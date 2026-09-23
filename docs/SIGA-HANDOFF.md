# SIGA HANDOFF — DA LATA

## Verified repository
- Current repository: `az1nn/growing-rio`
- Default branch: `master`
- Game/product name: **DA LATA**
- Verified `master` HEAD before this wave: `58d61fe2cdf1a68bdbcf3cec0f7f44f364b94505`
- Working branch: `feat/v0.4-district-demand`
- PR #13: **OPEN**
- PR head before this handoff commit: `79279f65347bafde7413d73933273302c68b1cba`
- Repository rename desired: `az1nn/da-lata`
- Repository rename is not exposed by the currently connected GitHub actions; after a manual rename, future SIGA runs must discover and adopt the new repository identity from real state.

## Current milestone
**V0.4 — City systems: IN PROGRESS**

Current wave: **Fictional city districts and demand simulation**.

Implemented on PR #13:
- Added `DistrictDefinition` content model.
- Added deterministic `CityService` with initial demand, daily demand transitions and bounded price multipliers.
- Added all seven canonical fictional districts from `docs/lore/DISTRICTS.md`:
  - `district_morro_cedro`
  - `district_centro_baixo`
  - `district_baia_velha`
  - `district_orla_vigia`
  - `district_arco_norte`
  - `district_restinga_clara`
  - `district_mercado_madrugada`
- Added `active_district_id` and persistent `district_demand` to canonical GameState.
- District selection is independent of UI ownership.
- Existing sale/contract pricing reads a bounded abstract district-demand multiplier.
- City demand transitions are deterministic and do not introduce a new RNG draw.
- Added save schema v7 with a separate `city` snapshot.
- Kept explicit v1-v6 save readers/migrations; pre-v7 saves migrate to canonical default city state.
- Added district regression coverage and extended structural validation/CI.
- Updated architecture to v0.4 and marked the first V0.4 roadmap item complete on the feature branch.

## Decision
**WATCH**

The change is dispatched in PR #13, but its exact final head must pass the repository validation gate before merge.

## Active gates
At PR creation:
- PR #13 was open at head `79279f65347bafde7413d73933273302c68b1cba`.
- The pull-request workflow run was not yet observable immediately after creation.
- This handoff update itself advances the PR head and therefore requires a fresh exact-head gate check.

Required exact-head gate:
- Structural validator.
- Godot 4.7.2 install + SHA-256 verification.
- Godot headless import/editor smoke.
- Deterministic seeded simulation.
- Economy service regression.
- Business service regression.
- Room cultivation state regression.
- Staff/upgrades regression.
- Contracts/relationships regression.
- Compliance progression regression.
- Fictional district demand regression.
- Save schema v7 round-trip + v1/v2/v3/v4/v5/v6 migrations.

## Web delivery
- `export_presets.cfg` is not configured on `master` at the start of this wave.
- No public provider/URL is currently recorded.
- Browser delivery is not an acceptance gate for this district-demand wave.
- SIGA must continue reconciling Web delivery and configure reproducible Web export/deployment once it becomes milestone acceptance or repository capability.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts and institutions are fictionalized.
- No real politicians, parties or targeted political persuasion.

## Next action
1. Reconcile the exact PR #13 head after this handoff commit.
2. Require `Validate project` success at that exact head.
3. If all automated gates are green, merge PR #13 into `master`.
4. Persist final merged state on `master`.
5. Continue V0.4 with fictional policy proposals and institutional progression.
