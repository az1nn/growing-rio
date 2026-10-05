# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Active strict roadmap: `specs/012-artist-v1-runtime-parity/SIGA-ROADMAP.md`

## Current route
**RESUME — Feature 012 / R05 Market V1.**

R04 is canonically PASS. PR #199 was promoted from Draft and merged to `master` as `5ac663a271e92f77a0d94e7b8eeeb10f61b48534` after exact-head Validate, Visual Acceptance, LENTE and Vercel were green. R05 is the only mutable roadmap item; R06+ remain LOCKED.

## Active session
- Task key: `012:R05:T050`
- Branch: `feat/012-r05-market-v1`
- Draft PR: #205
- Base: `5ac663a271e92f77a0d94e7b8eeeb10f61b48534`
- Temporary claim: `.siga/session-claim-r05-market.md` (remove before merge)

## R05 ARTIST state
The original PR #190 Market candidate SHA-256 `c7d9390f9cba7db434997ca5102841df09a30e95333811b3c297217c2c998075` remains historical `REVISE_REQUIRED`.

The active append-only Market run is:

`artifacts/artist/runs/20261002T091800Z/market`

State: **`CONCEPT_ACCEPTED`**. A revised isolated Market concept was generated, recorded through the canonical ARTIST workflow, and explicitly approved by the user (“Aprovado”). Repository concept evidence is `images/concept/concept-v001.webp`, SHA-256 `438393129ed224a6d63795aa8ad905b9d9e5d0243e6844e86836d7a10d8ee933`; source generation id `9d5a7ed0-4485-4fd3-9d41-75db84d4543b`.

The R05 human concept gate is therefore satisfied. CENA/Godot runtime implementation is now unlocked. The concept is visual direction only and does not imply runtime acceptance.

## R05 QA pre-gate progress
SIGA used the allowed same-item QA lane while the human concept gate remains pending.

Commit `7965bd17af2129ce9cddcf0af4769805b3bb5661` strengthens `tests/market_3d_diorama_test.gd` so R05 now mechanically preserves the three required physical focal anchors:
- vendor counter -> `DealCounter/Body`;
- fictional inventory crates -> `Crates/CrateA`;
- market channel sign -> `LoadingBay/Header`.

The test requires all three anchors to remain visible and pairwise spatially distinct, in addition to the existing `market/deal_counter` and `market/contract_tray` semantic hotspot checks. This is a regression fence only; it does not authorize visual implementation before concept ACCEPT.

Commit `896f66d6a178c3265dc9720fb3d387b6afff25a0` closes the remaining mechanical readability gap: each focal anchor must now retain at least one authored physical axis of 1.0 world unit or larger. This prevents a future Market implementation from technically keeping all three nodes while shrinking a focal into portrait-illegible geometry. The check is structural QA only and does not substitute for ARTIST/CENA visual acceptance.

Commit `b0aaeb10a38de5e23437304c0b9e7d108e502d70` adds a fail-closed R05 concept gate to `tools/validate_feature012_guardrails.py`: if Market runtime paths change while the ARTIST scene ledger lacks `CONCEPT_ACCEPTED` plus an `approved_concept_run`, canonical validation fails. This turns the just-in-time human concept gate into an executable repository invariant before CENA/Godot runtime work can start.

## P0 visual parity invariant
Feature 012 visual convergence is now the explicit P0 product-delivery stream until R15 final V1 certification is `PASS`.

- SIGA must resume the earliest non-`PASS` Feature 012 item before queued Feature 013 implementation or unrelated polish.
- Runtime review is board + accepted scene concept + exact-head runtime; the prior runtime is regression context only.
- Green technical gates never substitute for ARTIST/CENA target-relative `ACCEPT`.
- If primitives/blockouts cannot carry the accepted target, CENA/GODOT must produce or replace the required meshes, materials/textures/decals, props, dressing, lighting and atmosphere instead of accumulating cosmetic patches.
- Structural mismatch routes to recomposition/rebase, not indefinite additive polish.

## Runtime contracts to preserve after concept ACCEPT
- production renderer remains `GODOT_NATIVE_V1`;
- domain/economy/persistence behavior is unchanged;
- existing semantic ownership `market/deal_counter` and `market/contract_tray` remains compatible;
- ARTIST target still requires three physically readable focal silhouettes: vendor counter, fictional inventory crates and market channel sign;
- exact-head 540×960 + 1080×1920 evidence and ARTIST/CENA runtime ACCEPT are required before R05 PASS.

## 2026-10-02 reconciliation
- `master` advanced to `c7e2f59c8575527a5ed0431a5965e4414387ecee`, adding the mandatory SIGA terminal visual-report contract and its protocol tests.
- PR #205 was reconciled again by normal two-parent merge commit `cbc41df0154955f83fd80bf8f87a9216c103b126`; no force update was used and the R05 Market history was preserved.
- The upstream delta was limited to SIGA/RELATORIO protocol files plus `tests/test_siga_protocol.py`; no Market runtime path was changed and the concept gate remains authoritative.
- Every finalized SIGA run now requires exactly one validated DA LATA / `az1nn/growing-rio` visual status report from the same frozen fact packet as the compact text report.
- The R05 concept gate is now satisfied: run `20261002T091800Z/market` is `CONCEPT_ACCEPTED`; CENA/Godot implementation may proceed, but runtime acceptance still requires exact-head visual/interaction evidence.

## Exact-head gate state
The concept-acceptance persistence changes PR #205 after the prior exact-head checks. Fresh applicable checks are required on the new head. The conceptual gate is open, but R05 remains non-PASS until Godot-native implementation, portrait captures, interaction/regression gates and ARTIST/CENA runtime acceptance all pass.

## Next engineering action
Implement Market V1 in CENA/Godot from the accepted run `20261002T091800Z/market`: preserve `market/deal_counter` and `market/contract_tray`, keep the three physical focal silhouettes readable, then capture exact-head 540×960 + 1080×1920 evidence and submit the AFTER state to ARTIST/CENA for target-relative `ACCEPT / REVISE`.

## Persistent boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward.
- Institutional/political gameplay remains fictional and systemic.
- No real politicians, parties, elections or targeted persuasion are modeled.
- Provider limits never become fake green evidence.


## 2026-10-02 R05 implementation start

SIGA persisted the human concept ACCEPT and began the first structural Market V1 recomposition on PR #205.

Implemented in the active branch:
- native Godot Market viewport expanded to full 540×960 portrait composition;
- vendor counter, fictional inventory crates and market channel sign kept as the three required focal silhouettes;
- compact fictional urban massing added without postcard landmarks;
- chunky graffiti/crown language plus magenta/cyan/amber accents added;
- warm-stall versus cool-night lighting strengthened;
- Market management UI moved into the lower portrait safe band;
- economy, persistence and canonical `market/deal_counter` + `market/contract_tray` semantics preserved.

The first exact-head Validate run was green before this handoff persistence. Because this handoff update changes the branch head, all delivery gates must be read again from the new final head before any promotion.


## 2026-10-03 R05 Candidate 1 target-relative review

Exact-head `164746808577bb0ea3a080ddc283da557bf4b471` passed Validate `37072634586`, bounded Visual Acceptance `37072634711` and Vercel, with zero captured browser-console errors. ARTIST/CENA inspection of both portrait renders classified the runtime **IMPLEMENTATION_REVISE / STRUCTURAL** despite technical green.

Primary deltas against accepted run `20261002T091800Z/market`: sparse/wide composition, no vendor silhouette, weak merchandise density, channel sign not reading as a dominant physical board, graffiti/crown occlusion and missing shared V1 pixel filtering.

Candidate 2 therefore performs same-item structural correction only: tighter portrait framing, shared 2× nearest-neighbor pixel policy, authored vendor silhouette, shelf inventory density, larger physical channel board and reduced awning occlusion. R06+ remain locked.


## 2026-10-03 R05 Candidate 2 review — STRUCTURAL_REBASE_REQUIRED

Candidate 2 exact head `1362316e567f6b67581aa5c52e67980af62256c3` passed Validate `37121398087`, bounded Visual Acceptance `37121398014` and Vercel with zero browser-console errors.

ARTIST/CENA still returns **IMPLEMENTATION_REVISE / STRUCTURAL**. Pixel treatment, vendor and shelf density improved, but the same structural mismatch class remains: overhead slab occlusion, channel board cropped to the right, viewpoint too top-down/blockout-like, weak back-wall identity and a large lower void.

Because Candidate 1 and Candidate 2 are consecutive structural revisions, Feature 012's rebase rule is now active: **`STRUCTURAL_REBASE_REQUIRED`**. Candidate 3 replaces the rejected overhead/composition layer, introduces an explicit accepted-target rebuild layer and recenters the wall/sign/vendor composition. No R06 work is allowed.


## 2026-10-03 R05 Candidate 3 review

Structural-rebase head `31bed312e04a17800250cb76abe48c0f8d7c3db2` passed Validate `37121837958`, bounded Visual Acceptance `37121838020` and Vercel with zero browser-console errors.

ARTIST/CENA classifies Candidate 3 **IMPLEMENTATION_REVISE (bounded)**. The structural rebase worked: storefront wall, vendor, shelves and physical channel board now read as one scene. Remaining defects are limited to wordmark occlusion, right-edge board crop and the oversized black lower band caused by foreground floor/framing.

Candidate 4 is restricted to those composition/legibility corrections. R06+ remain locked.


## 2026-10-03 R05 Candidate 4 review

Exact head `a51da684452ccc74211147f46e730f025aa22331` passed Validate `37122154920`, bounded Visual Acceptance `37122154930` and Vercel with zero browser-console errors.

ARTIST/CENA returns **IMPLEMENTATION_REVISE (bounded final legibility pass)**. Candidate 4 fixed the right-edge channel board and foreground safe band. The remaining defect is localized to DA LATA / MARKET identity occlusion by superseded roof posts.

Candidate 5 clears only that sightline, stabilizes crown/wordmark placement and adds one restrained warm pendant cue. After exact-head capture, the flow must stop at the explicit human runtime gate rather than self-accepting R05.


## 2026-10-03 R05 production-asset convergence — READY_FOR_HUMAN_RUNTIME_GATE

SIGA rejected Candidate 5 technical green as insufficient target parity and continued the same strict-sequential R05 item through a bounded production-asset convergence pass.

Final reviewed runtime head before acceptance bookkeeping: `afb733167ec26bd16dc24710e23f33084993bb0e`.

Exact-head evidence:
- Validate project `37123975673`: **SUCCESS**;
- Visual acceptance capture `37123975676`: **SUCCESS**;
- artifact `11274223719`: 540×960 + 1080×1920, browser console errors **0**;
- Vercel: **SUCCESS**.

Material progress in this convergence pass:
- original Market SVG texture assets for mural, poster, rug and crate label;
- tighter target-relative storefront framing and warmer/cooler depth;
- denser product/plant dressing;
- visible vendor silhouette;
- green neon leaf signature and warm string-light cue;
- existing `market/deal_counter` + `market/contract_tray`, economy, persistence and accessibility contracts preserved.

Decision: **READY_FOR_HUMAN_RUNTIME_GATE**, not runtime ACCEPT. PR #205 remains Draft, Market remains `CONCEPT_ACCEPTED`, and R06+ remain LOCKED until explicit human `ACCEPT` or `REVISE`.

Next action: human inspects the exact-head Market runtime and returns exactly `ACCEPT` or `REVISE`.

## 2026-10-03 R05 DA LATA UI V1 — controls/state slice

SIGA resumed the current strict-sequential item `012:R05:T050` and executed the first implementation slice from `R05-DA-LATA-UI-V1-PLAN.md`.

Persisted in PR #205:
- reusable `DalataButton` roles for PRIMARY, SECONDARY, UTILITY, DANGER_RISK and NAVIGATION_TAB;
- reusable `DalataNavTab` with selected state independent from disabled state;
- canonical hard-border/focus/pressed/disabled/selected/progression-locked visual states;
- `resources/ui/v1` tokens/theme foundation;
- existing portrait/wide destination navigation migrated to shared nav tabs;
- Market city-detail, sale, contract and semantic-hotspot fallback actions migrated to shared controls without changing economy, persistence or `market/deal_counter` / `market/contract_tray` callbacks;
- dedicated `tests/dalata_ui_v1_test.gd` added to canonical CI for touch target, explicit lock reason, non-color selected state, max-five portrait navigation and shared Market-action coverage.

Spec Kit state:
- T050-E: **DONE**;
- T050-F: **DONE**;
- T050-G onward: **OPEN**;
- R06+ remain **LOCKED**.

Next canonical action: T050-G — implement the shared three-region DA LATA screen shell (top status/title, scene action region, persistent bottom command/navigation band) inside the current Market pilot before completing T050-H/I/J.

## 2026-10-03 R05 DA LATA UI V1 — shared shell slice

SIGA completed T050-G inside PR #205 without crossing the R05 fence.

Persisted:
- reusable `DalataScreenShell` scene/script under `scenes/ui/v1/`;
- explicit top status/title region, expandable scene action region and persistent bottom command band;
- portrait shell tokens for 16 px safe margin, 64 px top region, 76 px bottom band and five-command maximum;
- shell API for scene identity, action-content mounting and bounded command insertion;
- canonical `dalata_ui_v1_test.gd` structural coverage for the three regions, action mounting and max-five command contract.

T050-G is DONE. T050-H is now the single next task: mount/apply the shared UI system to Market while preserving accepted 2.5D substrate, gameplay, economy, persistence and `market/deal_counter` / `market/contract_tray` semantics. R06+ remain LOCKED.


## 2026-10-03 R05 DA LATA UI V1 — Market integration slice

SIGA completed T050-H inside the strict R05 fence.

Persisted:
- Market mounts the reusable `DalataScreenShell` as the canonical player-facing UI shell;
- accepted Market 2.5D visual substrate remains authoritative behind the UI;
- the owner-local Market action Scroll is geometrically constrained to the shared action region, preserving `%UniqueName` ownership while keeping transactional controls off the focal scene;
- the shared bottom command band exposes exactly five navigation route hooks and explicit Market selected state;
- the legacy outer header and legacy portrait/wide navigation are hidden only for the Market pilot, preventing duplicate chrome without changing later scenes;
- pointer/touch access to Campaign is preserved through a shared UTILITY action while Market owns the shell;
- existing sale, contract, city-detail, economy, persistence and `market/deal_counter` / `market/contract_tray` semantics remain unchanged;
- `tests/dalata_ui_v1_test.gd` now covers shell mounting, command-band ownership, canonical route handoff, owner-boundary preservation, bottom-band non-overlap and Campaign utility preservation.

T050-H is DONE. T050-I is the next task: keyboard/focus, pointer/touch, non-color state-legibility and portrait-safe-area regression. R06+ remain LOCKED.


## 2026-10-03 R05 DA LATA UI V1 — accessibility/state slice

SIGA completed T050-I after T050-H integration passed the canonical suite.

Exact implementation head before bookkeeping: `2d875d55be8c277f9d52e62cb16faeedb9a21b8f`.
Validate project #1189 / run `37137886181`: **SUCCESS**.

Persisted:
- shared controls preserve keyboard focus plus pointer/touch input;
- focus is represented by an external shape/ring rather than color alone;
- disabled controls gain a heavier lower rail so disabled state changes silhouette;
- progression lock remains explicit through `[BLOQ]` plus reason;
- the five-command band owns explicit horizontal/Tab focus neighbors;
- shared command and Market transactional controls remain >=48 px;
- compact portrait shell uses >=16 px vertical and horizontal safe margins;
- Market owner-local actions are structurally asserted not to overlap the persistent bottom command band.

T050-I is DONE. T050-J is next: exact-head Market 540×960 + 1080×1920 visual evidence followed by explicit human ARTIST/CENA runtime ACCEPT/REVISE. R06+ remain LOCKED.


## 2026-10-04 — R06 Candidate 7 dispatched

**CLASSIFY:** `RESUME → EXECUTE → WATCH`

R06 remains the sole CURRENT Feature 012 item. Candidate 6 exact-head engineering gates were all green, but target-relative visual review remained `REVISE`: the scene still read as a dark low-poly miniature rather than the accepted stair-led, authored, lived-in City concept.

Candidate 7 has been executed in PR #213 on the same branch. Scope is limited to City presentation + regression + handoff documentation. It reorients the camera toward the stair corridor, lifts cool-night readability and adds authored facade/mural/shopfront/laundry/resident/vegetation density while preserving gameplay/state/persistence, semantic hotspot IDs, DA LATA UI V1 and native Godot 3D.

**NEXT:** consume only exact-head Candidate 7 Validate + Visual Acceptance + LENTE, compare 540×960 and 1080×1920 pixels to `20261004T110406Z/city`, then persist ARTIST/CENA `ACCEPT` or bounded `REVISE`. R07+ stay locked.


## 2026-10-05 — R06 Candidate 9 dispatched after hard low-poly rejection

**CLASSIFY:** `RESUME → REJECT / LOW_POLY_FORBIDDEN → EXECUTE → WATCH`.

Candidate 8 exact head `df5a05ee4f7fe2ee549311f4f7ee8b393680b6c4` was technically green (Validate `37305099781`, Visual Acceptance `37305099787`, LENTE `37305099792`; artifacts `11343298226` / `11343537336`; console errors 0) but failed the locked visual construction gate: actual 540×960 and 1080×1920 pixels still read as smooth primitive/color-block low-poly architecture.

Candidate 9 therefore changes construction strategy rather than primitive count: authored pixel-surface assets + nearest filtering, textured facade/shopfront/mural cards, irregular ArrayMesh roof silhouettes and layered textured depth. The forbidden `more boxes → more density → lighting tweak` loop is structurally guarded in `city_3d_diorama_test.gd`.

Preserved: accepted City concept `20261004T110406Z/city`, camera corridor, native Godot 3D, gameplay/state/persistence, semantic IDs and DA LATA UI V1. R07+ stay LOCKED.

**NEXT:** exact-head Validate → Visual Acceptance → LENTE → ARTIST target-relative review. No runtime `ACCEPT` is claimed.


## 2026-10-05 — R06 Candidate 10 dispatched

**CLASSIFY:** `RESUME → REJECT / LOW_POLY_FORBIDDEN → EXECUTE → WATCH`.

Candidate 9 `56bfd8426b2dea1393c1338c94b93736bf2eac42` was technically green but still failed the immutable City visual target: its authored textures sat on architecture that remained visibly blocky/low-poly. Visual Acceptance artifact `11344518689` was inspected at both required portrait sizes; LENTE was superseded after the hard rejection.

Candidate 10 changes the player-visible construction grammar: primitive architecture groups and Candidate4–9 visual layers are demoted, while authored transparent pixel-art building/street/far-city cards occupy multiple real 3D depth planes around the physical stair corridor. Interaction/state/UI contracts remain unchanged.

**NEXT:** consume Candidate 10 exact-head Validate + Visual Acceptance + LENTE and inspect actual pixels. No runtime ACCEPT is claimed. R07+ remain LOCKED.


## 2026-10-05 — R06 Candidate 11 review

**CLASSIFY:** `RESUME / AUTHORED_ASSET_PIPELINE_REQUIRED`.

Exact head `e9e5b9aed409f8c790d93141de8a980bf80a3e11`: Validate `37311118312` SUCCESS, Visual Acceptance `37311118411` SUCCESS, artifact `11345487303`, Vercel SUCCESS. Actual 540×960 and 1080×1920 pixels no longer materially read low-poly, so the hard low-poly rejection is cleared.

ARTIST target-relative result remains `IMPLEMENTATION_REVISE`: the runtime is too flat/coarse versus accepted City concept `20261004T110406Z/city`, especially facade authorship, resident/vegetation detail, commerce clutter and layered environmental depth.

**NEXT:** ARTIST/CENA append-only production-asset session; generate/source authored City assets with provenance and integrate them into the existing real-3D interaction scaffold. No Candidate 12 primitive/procedural-box pass. R07+ remain LOCKED.


## 2026-10-05 — R06 Candidate 13 dispatched after human hard reject

**CLASSIFY:** `RESUME → VISUAL_CONSTRUCTION_REBASE_REQUIRED → EXECUTE → WATCH`.

Candidate 12 was authoritatively rejected by the human as `LOW_POLY_FORBIDDEN`. Follow-up head `0a5ee01c0cb39bb70078ebc68e3dc4253989aa1c` completed exact-head Validate, Visual Acceptance, Vercel and LENTE `37332944888`; the freeze was consumed without changing the human verdict.

Candidate 13 replaces dominant flat-card facade construction and the visible box-step presentation with lit textured extruded custom meshes, irregular authored silhouettes and perspective depth while preserving gameplay/state/persistence, all three semantic IDs, shared DA LATA UI V1 and the accepted City concept.

**NEXT:** consume Candidate 13 exact-head Validate + Visual Acceptance + LENTE, inspect real 540×960 / 1080×1920 pixels through ARTIST, and keep R07+ locked unless the human explicitly `ACCEPT`s R06.

## 2026-10-05 — R06 Candidate 14 bounded visual alignment dispatched

**CLASSIFY:** `ADVANCE → EXECUTE → VERIFY`.

Candidate 13 exact head `860120774e3922eee0d5ba75417b431fcf6028f6` completed all exact-head gates successfully. ARTIST consumed the real runtime pixels and classified `REVISE / V1_NIGHT_GRAFFITI_DEPTH_ALIGNMENT`: the volumetric authored-facade rebase is a material improvement and is now preserved; the remaining deltas are limited to night grammar, graffiti/pixo focal strength and far-depth authorship.

Candidate 14 changes only those three areas. It removes the bright Candidate 11 skyline from the player-facing stack, adds an authored inky-night city depth asset on custom extruded ArrayMesh geometry, adds volumetric/relief mural surfaces to the existing City composition, and introduces bounded warm practical OmniLight pools. Candidate 13 perspective camera, facades, stairs, gameplay/state/persistence, semantic IDs and DA LATA UI V1 remain unchanged.

**NEXT:** freeze the Candidate 14 exact head for Validate → City Visual Acceptance → Visual Acceptance → LENTE → ARTIST review. R07+ remain LOCKED until explicit human runtime `ACCEPT`.

## 2026-10-05 — R06 Candidate 14 consumed; Candidate 15 dispatched

**CLASSIFY:** `REVISE → ADVANCE → EXECUTE → VERIFY`.

Candidate 14 exact head `e81661175ca9a1c85b8d65b142ccff4521879daf` is fully terminal green: Validate `37344152541`, City Visual Acceptance `37344152516`, Visual Acceptance `37344152652`, LENTE `37344152729` / artifact `11359743073`, and Vercel SUCCESS. Actual 540×960 + 1080×1920 pixels were inspected.

The night grammar correction is accepted as the preserved baseline and Candidate 13 volumetric construction remains intact. ARTIST classified `REVISE / GRAFFITI_FOCAL_AND_FAR_DEPTH_DETAIL`: pixo/mural hierarchy is still too secondary at portrait scale and distant urban depth remains visually sparse.

Candidate 15 therefore changes only those two residual deltas: more volumetric focal mural/pixo relief and extra authored far-neighborhood/window/roof rhythm with local practical light. Camera, stair corridor, gameplay/state/persistence, semantic IDs, DA LATA UI V1 and Candidate 14 global night lighting are frozen.

**NEXT:** exact-head Validate → City Visual Acceptance → Visual Acceptance → LENTE → ARTIST. R07+ remain LOCKED.



## 2026-10-05 — Candidate 15 human REJECT; Candidate 16 dispatched

**CLASSIFY:** `RESUME → HUMAN_REJECTED → VISUAL_CONSTRUCTION_REBASE_REQUIRED → EXECUTE → VERIFY`.

Candidate 15 exact head `4b419c7ab01f69029bb5a31916d1da942a32d1b4` was technically terminal green (Validate, City Visual Acceptance, Visual Acceptance, LENTE and Vercel) but the human explicitly returned `REJECT` at the runtime gate. That verdict supersedes agent-side accept recommendations. A parallel-session comment that attached the latest rejection to Candidate 14 was corrected; the current verdict is bound to Candidate 15.

Candidate 16 begins a larger composition/construction rebase rather than another polish pass. The final runtime camera returns to the locked V1 orthographic three-quarter contract; Candidate 13 dominant architecture/stairs are demoted; a new tiered authored ArrayMesh neighborhood is built around a 19-step vertical stair spine with terraces, roof/utility/cable rhythm and bounded warm practicals. Gameplay/state/persistence, semantic hotspot IDs, DA LATA UI V1 and the accepted City concept remain fixed.

**NEXT:** freeze Candidate 16 exact head for Validate → City Visual Acceptance → Visual Acceptance → LENTE → ARTIST review. R07+ remain LOCKED.
