# R06 City V1 — human-approved five-asset composition V2

**Decision:** `HUMAN_APPROVED_COMPOSITION_V2` — 2026-10-12. User explicitly answered **"Concordo aprovado"** to the ARTIST/SIGA recommendation to redistribute the five primary City assets, giving the protagonist first-class status instead of a separate rooftop water-tank slot.

**Scope:** documentation, scene-asset role distribution and ARTIST/CENA planning. **Not** permission to produce new art, edit approved source files, import into Godot, mount the compositor, run production changes, merge PR #213, or mark City runtime accepted.

**Canonical repo/PR:** `az1nn/growing-rio` / #213 Draft; task `012:R06`. Preserve the human-approved City reference `20261004T110406Z/city` (SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`), locked pixel-art × graffiti V1, `LIGHT-01=A`, G1–G25, R1 D/R2 D/R3 D/R4 D/R5 B and architecture B / native Godot 2D/2.5D with clear apparent near/mid/far depth.

## New visual inventory — one BG + five coherent units

| Current slot | Responsibility | Preserved acceptance / remaining gate |
| --- | --- | --- |
| **BG** (outside five) | One composited bright sky, clouds, fictional hills and far-city backdrop | SKY/01 and revised SKY/FAR/01 concepts approved; production BG not yet imported |
| **01 Coral + tank** | Stronger left Coral house with coherent rooftop tank/terrace **inside the same principal asset** | Original Coral SVG `OBJECT_ART_ACCEPTED`; separately approved UPPER/03 tank PNG concept remains valid reference; joint production/import not approved |
| **02 Ochre shop** | Right staggered house with shop frontage and native architectural silhouette | Original Ochre SVG `OBJECT_ART_ACCEPTED`; Godot import QA pending |
| **03 Commerce plaza** | One inhabited landing/market with integrated shops, awnings, residents and urban wear | Revised commercial **CITY/05 concept** was human-approved 2026-10-10; its historical concept ID does not mean current slot 05. [Approval record](./R06-CITY-COM-05-CONCEPT-REVIEW.md) exists; exact PNG/SVG bytes and hash still unavailable/unchecked |
| **04 Stairway** | Continuous descending staircase, turning landing, bilateral rails, weathered masonry | Second STAIR/01 concept human-approved; production sprite extraction/scale/alpha still pending |
| **05 Protagonist** | **REQUIRED** near-field player character giving scale, focal hierarchy and traversal intent | Visual **role approved now**; standalone protagonist asset not yet approved/produced |
| **06 optional** | Only if an assembled composition proves genuinely necessary | Not part of default build; no automatic extra artwork authorization |

**Supersession:** former `slot 03 = water tank` is incorporated into Coral slot 01; former `slot 05 = commerce` becomes 03; optional foreground figure becomes **required slot 05**. Historical UPPER/03 and CITY/05 names remain valid original *concept identifiers* and earlier acceptance records must not be rewritten as if their production assets had already been mounted.

## Spatial, technical and review constraints

- **Far:** bright luminous blue sky and layered cool fictional neighborhood; no literal landmark wallpaper, generated HUD, flat low-poly cards or night-only override.
- **Upper:** Coral taller on left, Ochre staggered right, tank physically belongs to Coral; preserve original SVG `480×620` natural aspect, don't mirror or squash.
- **Middle:** inhabited commerce **slot 03** provides the visual/social center and meets the upper houses at the stair landing.
- **Near:** stair **04** leads the eye toward the plaza; protagonist **05** must read separately over/in front of near steps without obscuring shared R05 mobile UI and semantic hotspots.
- **Painter order:** BG → Coral+tank/Ochre → commerce → stairs/rails → protagonist → separate native UI.
- **One-artwork rule:** the accepted STAIR/01 and SKY/FAR/01 PNG concept images contain neighboring scenery; don't paste them entire and duplicate houses, commerce or backdrop. Decorative foliage/cables/shutters/graffiti live inside core artwork or shared generic assets, not a separate review queue.
- **Known ARCH compatibility debt (unimplemented):** the existing unmounted `scenes/visual/city_svg25d_layers.gd` accepts only SVG and stretches textures. Future separately authorized work must validate mixed SVG/PNG, aspect-preserving nearest-neighbor rendering, transparency and pixel fidelity at 540×960 and 1080×1920.

## Next gates — no implied release

1. Record **this visual-slot decision as PASS** in Feature 012 documents.
2. Recover the **exact** user-approved revised CITY/05 PNG/SVG attachment and provenance; no invented SHA or replacement concept; prior approval remains intact.
3. Get **separate, explicit authorization** for `R06-B-PLAN-GATE` and `R06-B-01B` Godot import/rasterization QA, then production of compatible BG/house+tank/commerce/stairs/player assets. No runtime or source mutation at this step.
4. Present **one composed preview** when true usable sources exist. Distinguish object concept acceptance, scene composition acceptance and actual Godot runtime acceptance.
5. Verify real Web/Cloudflare exact HEAD, LENTE full/isolated 540×960 and 1080×1920, City→Market→City, keyboard/touch/UI, preserved `city/district_overlook`, `city/route_nodes`, `city/community_cluster`, and VIS-01..VIS-08 before a separate human runtime `ACCEPT`.

**State preserved:** R05 PASS; R06 CURRENT; old City renderer HUMAN REJECT_ALL; R07+ LOCKED; PR #213 Draft / no merge.
