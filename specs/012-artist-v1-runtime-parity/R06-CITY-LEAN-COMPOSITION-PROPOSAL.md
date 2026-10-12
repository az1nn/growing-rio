# R06 City V1 — lean composition proposal (ARTIST → CENA)

**Status:** `2026-10-12 HUMAN APPROVED V2 COMPOSITION / DOCUMENT ONLY`. Technical execution authorization remains pending.  
**Repository:** `az1nn/growing-rio`, PR #213 Draft, task `012:R06:LEAN-PLAN-01`.  
**Inspected HEAD:** `75b8066af155b082cb127f1c8166b1cb19036eee`.  
**Immutable City art target:** `20261004T110406Z/city`, SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`.

**Authorities:** [lean art budget](./R06-CITY-LEAN-ART-BUDGET.md), [COMP-01 source-aspect/placement review](./R06-CITY-V1-ARTIST-COMPOSITION-01.md), [STAIR/01 accepted concept](./R06-CITY-STAIR-01-CONCEPT-REVIEW.md), [strict roadmap](./SIGA-ROADMAP.md). R05 `PASS`; R06 sole `CURRENT`; R07+ `LOCKED`. Original City runtime `REJECT_ALL` remains binding.

This is **a plan for review**, not a new asset, implemented scene, import/raster QA, browser evidence, human runtime acceptance or permission to deploy/merge.

## 1 — 2026-10-12 HUMAN APPROVED V2: one BG + five units

This replaces the previous planning slot allocation only, and does not imply new asset/runtime acceptance. Full canonical scope, original concept references and human decision: [R06-CITY-V2-HUMAN-APPROVED-COMPOSITION.md](./R06-CITY-V2-HUMAN-APPROVED-COMPOSITION.md).

| Current slot | Coherent responsibility | Source/acceptance |
| --- | --- | --- |
| **BG** (not counted) | One bright sky/cloud/far-hill/fictional-city atmosphere, not full-scene wallpaper | SKY/01 + revised SKY/FAR/01 concepts ACCEPTED; production BG PENDING |
| **01 Coral + tank** | Left Coral house, **rooftop tank/terrace integrated** rather than a separate main asset | Coral SVG art ACCEPTED; `UPPER/03` PNG concept ACCEPTED; combined production/import PENDING |
| **02 Ochre** | Right Ochre shop house, natural authored roof/side/front silhouette | Ochre SVG art ACCEPTED; Godot import QA PENDING |
| **03 Commerce** | One inhabited commercial landing/plaza (store, awning, residents) | Revised historical `CITY/05` concept human ACCEPTED; [review](./R06-CITY-COM-05-CONCEPT-REVIEW.md). Conversation PNG/SVG bytes/hash not verified |
| **04 Stairs** | One large continuous descending stair, landing, two rails and appropriate wear | Second STAIR/01 PNG concept human ACCEPTED; source isolation/import PENDING |
| **05 Player** | **Required** near-field protagonist, for scale and visual focus | Role HUMAN-APPROVED; standalone sprite/object not yet approved/produced |
| **06 optional** | Only if future assembled evidence justifies | NOT REQUIRED |

Existing `UPPER/03` and `CITY/05` are **historical concept IDs**, not current principal slot numbers. Keep original SVGs unchanged, no extra decorative variant queue.

## 2 — Concept-relative stage and layer contract

The reference is **940×1672 portrait**. These bands are approximate **visual review guidance**, not Godot scene coordinates or a license to bake UI into art.

- **Far / y≈0–0.36:** blue luminous sky, cloud shapes, cool fictitious hills and distant fictional neighborhood. No postcard landmarks. Bright daylight (`LIGHT-01=A`), not the superseded night reinterpretation.
- **Upper / y≈0.30–0.70:** Coral stronger/higher on left **with integrated tank/terrace**; Ochre slightly lower on right. Preserve open central skyline/stair sightline rather than giant walls, cardboard facade pairs or an empty black hole.
- **Mid / y≈0.40–0.73:** slot **03** as a visually active, believable commercial landing that joins the upper structures to the stair.
- **Near / y≈0.67–1.00:** slot **04** dominates downward movement with connected rails and worn steps; **required player slot 05** provides visible near-field scale. Crop/reframe to the actual shared R05 mobile scene-safe viewport, never behind the persistent HUD.

**Painter's ordering:** BG → upper houses/roof tank → central commerce → staircase/rail foreground → **required protagonist 05** → independent native Godot UI and semantic hotspots.

Retain [COMP-01](./R06-CITY-V1-ARTIST-COMPOSITION-01.md)'s **native aspect ratio** and Coral-left/Ochre-right boxes: each original SVG has a 480×620 viewBox. Never scale X and Y independently into the rough rectangles or mirror approved original art. The opening between their main masses must lead into commerce and stairs. Full Godot 2D is allowed if scale, occlusion, perspective, contrast and near/mid/far hierarchy make depth convincing; shallow 2.5D/parallax optional. No mandated physical 3D orbit.

**No duplication:** STAIR/01's accepted PNG contains *extra surrounding buildings, BG and commerce*. Its acceptance covers the visual staircase concept, **not** treating the whole picture as a transparent 04 sprite. Similarly the approved revised SKY/FAR/01 panorama includes near architecture; only its atmospheric intent belongs to BG. Later authorized production must isolate/re-author one coherent unit while preserving accepted form and quality, not copy duplicate whole-scene wallpapers.

## 3 — Bounded proposed sequence; all implementation gates still closed

1. **COMP V2 HUMAN GATE: PASS 2026-10-12** — redistribution approved. **R06-B-PLAN-GATE remains separately closed** for engineering execution, import and production.
2. **R06-B-01B import QA** — with specific authorization, Godot-import each already-approved SVG; capture transparent individual render, verify original proportions, nearest-filter, alpha, clipping and pixel parity. Original source bytes unchanged, per-item results.
3. **ARTIST historical CITY/05 (now slot 03) already concept-ACCEPTED** — source-verification handoff only: recover the exact approved conversation PNG/SVG, verify bytes/hash, then compose without replacing its art or generating speculative variants. Do not auto-produce optional 06.
4. **Production ARTIST/CENA** — first acquire the approved original conversation PNGs/SVGs and validate the recorded hashes where known (obtain CITY/05 hash before source use); author one background and coherent 01 Coral+tank, 03 commerce, 04 stairs and **required 05 protagonist** units, avoiding embedded scenery duplication; preserve per-asset provenance and import evidence.
5. **Godot composition** — only after approval, mount one native 2D/2.5D City player-facing visual layer, disable rejected A/B/C/old cards and maintain the shared DA LATA UI plus semantic interaction IDs `city/district_overlook`, `city/route_nodes`, `city/community_cluster`, gameplay and persistence.
6. **Verify and accept** — exact-head Validate; real interactive Godot Web/Cloudflare URL; touch/keyboard/focus, navigation City→Market→City, HUD-safe zones; LENTE page and isolated City at **540×960 and 1080×1920**; pan test **only if pan is implemented**; target-relative VIS-01..VIS-08 by ARTIST; then *explicit human runtime ACCEPT*. CI-green cannot grant R06 PASS.

**Technical debt (future separate authorization):** unmounted `city_svg25d_layers.gd` currently rejects PNG paths and stretches SVG images; adapt for mixed SVG/PNG, natural aspect and nearest-filter transparent assets, proven with real Godot output. **Do not:** generate assets, import Godot scenes, create `layers.json`, mount compositor, mutate scene/runtime/tests, publish a new visual candidate, merge PR #213 or unlock R07 on the authority of this file.

**NEXT:** recover/verify exact approved revised CITY/05 source PNG/SVG, then obtain **separate bounded execution authorization** for R06-B-01B Godot import and later art production. The five-unit **composition** is approved, but the new player asset and combined Coral+tank asset are not individually production-approved. No assembled scene/runtime acceptance.
