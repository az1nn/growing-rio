# R06 City V1 — lean composition proposal (ARTIST → CENA)

**Status:** `DOCUMENT_ONLY / HUMAN_EXECUTION_GATE_PENDING` (2026-10-10).  
**Repository:** `az1nn/growing-rio`, PR #213 Draft, task `012:R06:LEAN-PLAN-01`.  
**Inspected HEAD:** `75b8066af155b082cb127f1c8166b1cb19036eee`.  
**Immutable City art target:** `20261004T110406Z/city`, SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`.

**Authorities:** [lean art budget](./R06-CITY-LEAN-ART-BUDGET.md), [COMP-01 source-aspect/placement review](./R06-CITY-V1-ARTIST-COMPOSITION-01.md), [STAIR/01 accepted concept](./R06-CITY-STAIR-01-CONCEPT-REVIEW.md), [strict roadmap](./SIGA-ROADMAP.md). R05 `PASS`; R06 sole `CURRENT`; R07+ `LOCKED`. Original City runtime `REJECT_ALL` remains binding.

This is **a plan for review**, not a new asset, implemented scene, import/raster QA, browser evidence, human runtime acceptance or permission to deploy/merge.

## 1 — Minimal inventory: one BG and five main visual units

| Unit | Single coherent responsibility | Provenance/status |
| --- | --- | --- |
| **BG (not counted)** | **One** bright-blue atmospheric background with clouds, fictional vegetated hills and distant roof silhouettes, no baked interactive street/HUD | Human-approved `SKY/01` and *revised second* `SKY/FAR/01` PNG **concepts** only. Composite asset missing. |
| **01 Coral House** | Upper-left warm Coral Terrace House, preserving native front/side/roof silhouette | Original `assets/city/v1/svg25d/source/upper/coral-terrace-house.svg`; human `OBJECT_ART_ACCEPTED`, import QA pending. |
| **02 Ochre Shop** | Staggered upper-right Ochre Shop Terrace with distinct storefront silhouette | Original `assets/city/v1/svg25d/source/upper/ochre-shop-terrace.svg`; human `OBJECT_ART_ACCEPTED`, import QA pending. |
| **03 Water Tank** | One rooftop terrace/tank coherent unit, spatially attached to the upper buildings | `UPPER/03` isolated PNG `CONCEPT_OBJECT_ACCEPTED`, no committed production sprite. |
| **04 Stair Corridor** | **One** continuous large descending stair with turn/landing, bilateral railings, chipped concrete, integrated appropriate dressing | Human accepted the **second** STAIR/01 PNG concept; SHA-256 `9b49257b41ad7f0c9add6cea8b99e60521036a3561cf9e92c41fdf0a776760df`. Production cutout/import missing. |
| **05 Commerce Landing** | **One** inhabited central shop/stall with awnings/residents integrated into a human-scale landing | Concept referenced by approved City art, but no independently approved/produced object. **NEXT ARTIST CONCEPT GATE**. |
| **06 optional** | One extra near-foreground resident/focal only if composition review proves it necessary | Not a required task and not authorized. |

Grass, cables, weathering, graffiti, shutters, plant pots and small rails belong inside the five primary illustrations or reusable generic background dressing. Do not split them into separate asset variants or human approvals by default.

## 2 — Concept-relative stage and layer contract

The reference is **940×1672 portrait**. These bands are approximate **visual review guidance**, not Godot scene coordinates or a license to bake UI into art.

- **Far / y≈0–0.36:** blue luminous sky, cloud shapes, cool fictitious hills and distant fictional neighborhood. No postcard landmarks. Bright daylight (`LIGHT-01=A`), not the superseded night reinterpretation.
- **Upper / y≈0.30–0.70:** Coral stronger/higher on left; Ochre slightly lower on right; Water Tank belongs to a terrace. Preserve open central skyline/stair sightline rather than giant walls, cardboard facade pairs or an empty black hole.
- **Mid / y≈0.40–0.73:** slot 05 as a visually active, believable commercial landing that joins the upper structures to the stair.
- **Near / y≈0.67–1.00:** slot 04 dominates downward movement, with connected rails and worn steps. Crop/reframe to the actual shared R05 mobile scene-safe viewport, never behind the persistent HUD.

**Painter's ordering:** BG → upper houses/roof tank → central commerce → staircase/rail foreground → optional near person → independent native Godot UI and semantic hotspots.

Retain [COMP-01](./R06-CITY-V1-ARTIST-COMPOSITION-01.md)'s **native aspect ratio** and Coral-left/Ochre-right boxes: each original SVG has a 480×620 viewBox. Never scale X and Y independently into the rough rectangles or mirror approved original art. The opening between their main masses must lead into commerce and stairs. Full Godot 2D is allowed if scale, occlusion, perspective, contrast and near/mid/far hierarchy make depth convincing; shallow 2.5D/parallax optional. No mandated physical 3D orbit.

**No duplication:** STAIR/01's accepted PNG contains *extra surrounding buildings, BG and commerce*. Its acceptance covers the visual staircase concept, **not** treating the whole picture as a transparent 04 sprite. Similarly the approved revised SKY/FAR/01 panorama includes near architecture; only its atmospheric intent belongs to BG. Later authorized production must isolate/re-author one coherent unit while preserving accepted form and quality, not copy duplicate whole-scene wallpapers.

## 3 — Bounded proposed sequence; all implementation gates still closed

1. **HUMAN PLAN GATE** — review/approve this five-unit composition and order. This documentary proposal does not clear `R06-B-PLAN-GATE`.
2. **R06-B-01B import QA** — with specific authorization, Godot-import each already-approved SVG; capture transparent individual render, verify original proportions, nearest-filter, alpha, clipping and pixel parity. Original source bytes unchanged, per-item results.
3. **ARTIST slot 05** — present exactly one new commerce-landing concept as a real inline image. Obtain explicit independent human `ACCEPT/REVISE/REJECT`. Do not auto-produce optional 06.
4. **Production ARTIST/CENA** — first acquire the approved original conversation PNGs and validate their recorded hashes; author a single background and exactly slots 03/04/05 production units, avoiding embedded scenery duplication; preserve per-asset provenance and import evidence.
5. **Godot composition** — only after approval, mount one native 2D/2.5D City player-facing visual layer, disable rejected A/B/C/old cards and maintain the shared DA LATA UI plus semantic interaction IDs `city/district_overlook`, `city/route_nodes`, `city/community_cluster`, gameplay and persistence.
6. **Verify and accept** — exact-head Validate; real interactive Godot Web/Cloudflare URL; touch/keyboard/focus, navigation City→Market→City, HUD-safe zones; LENTE page and isolated City at **540×960 and 1080×1920**; pan test **only if pan is implemented**; target-relative VIS-01..VIS-08 by ARTIST; then *explicit human runtime ACCEPT*. CI-green cannot grant R06 PASS.

**Do not:** generate assets, import Godot scenes, create `layers.json`, mount compositor, mutate scene/runtime/tests, publish a new visual candidate, merge PR #213 or unlock R07 on the authority of this file.

**NEXT:** one human decision — `APPROVE / REVISE` this bounded composition/implementation plan. Production authorizations remain granular.
