# ARTIST COMP-01 — City V1 source-sprite composition direction (review contract, NOT scene approval)

**Date:** 2026-10-09 · **Repository:** `az1nn/growing-rio` · **PR:** #213 Draft · **Owner:** ARTIST / Feature 012 R06.  
**Result:** `COMPOSITION_DIRECTION_RESOLVED / RENDERED_COMPOSITION_PENDING`. **No production asset, engine composition or human scene acceptance exists.**  
**Source review head:** `34f517db9ec020eeb5aadbaae0ce75cbe7e32698`; this is a **document-only** ARTIST resolution.  
**Human lighting choice:** `LIGHT-01=A`: the approved ORIGINAL bright-blue-sky City scene, not a navy nighttime reinterpretation.  
**Original concept:** `20261004T110406Z/city`, verified source PNG **940×1672**, SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`; archival metadata: `docs/art-direction/v1/runs/20261004T110406Z-city/MANIFEST.md`.  
**Human object decisions:** `coral-terrace-house.svg` (`77df5e5f8b05fd06fa15fa10a51326c3d76ebf75`) and `ochre-shop-terrace.svg` (`2bf03cabcafd9b476cec51aef96b38f735e747a4`) = **`OBJECT_ART_ACCEPTED` separately**, without assembled-family acceptance. Source ledger: `assets/city/v1/svg25d/source/upper/candidate-family.json` / [individual source image previews](../../assets/city/v1/svg25d/source/upper/REVIEW.md).

## 1. What the original reference actually locks

- **0.00–0.36 of portrait height:** airy blue sky, distant hills/cityscape and an open central visual relief. The accepted reference has visible *daylight*, not a navy-night ambient fill.
- **~0.34–0.73:** irregular architectural volumes around a vivid inhabited middle field: painted homes, activity/commerce, localized warm materials, vegetation, cables and graffiti. The **middle focal area must read as lived-in** rather than as two unrelated tall facade cards.
- **~0.67–1.00:** the descending continuous staircase with rails and pedestrians leads the eye from foreground through the middle to background. The staircase is the **primary compositional spine**, not empty black-space infill.
- The image contains example HUD/logo and famous landmark-like details. These are **not implementation assets or literal canon requirements**; preserve the visual hierarchy, spatial rhythm and colors without copying them into runtime art.

Coordinates below are **normalizations of the accepted 940×1672 concept image for design review** (`x,y,w,h`), NOT player-facing positions, Godot pixel coordinates or permission to activate `layers.json`.

## 2. Approved source properties and aspect-ratio issue

Both editable sources are **480×620 viewBox**, source aspect ratio `480/620 = 0.77419`. Both have independently authored facade, side return, roof/parapet and architectural detail groups. **Both side returns occur on the right of their own canvases**, even though local roof/side angles vary. Never mirror either original source to manufacture a symmetric corridor: this would silently change previously accepted sprite art.

Prior `rect_hint` values in the candidate manifest are **only unreviewed suggestions**, not fixed scale/placement: coral `[0.03,0.17,0.39,0.57]`, ochre `[0.60,0.27,0.36,0.54]`. Applied by direct width/height stretching to the **940×1672 reference**, these would create width:height ratios `~0.385` and `~0.375`, approximately **half the native aspect ratio** — an unacceptable distortion. Any eventual renderer must use natural aspect-ratio `contain` / equivalent with transparent margins intact, not warp both dimensions independently.

## 3. COMP-01 composition target — two existing objects, NO new art

| Source sprite | Design review box `[x,y,w,h]` | Native aspect preserved | Relative role |
|---|---|---|---|
| **Coral Terrace House** | **`[-0.045, 0.320, 0.540, 0.392]`** | on the reference: `508×655 px`, ratio `0.775` | left upper/mid architectural mass; warmer coral anchor, higher and slightly larger |
| **Ochre Shop Terrace** | **`[0.550, 0.370, 0.500, 0.363]`** | on the reference: `470×607 px`, ratio `0.774` | right upper/mid commercial mass; lower, smaller, distinct color and shop vocabulary |

**Important:** these are **boxes containing SVG transparent space**, not solid building rectangles. They may extend slightly beyond the LEFT/RIGHT concept edges to keep their authored pixel content on screen. Using the *main polygon footprint only*, estimated illustrated mass is **coral** `x≈0.028..0.395, y≈0.387..0.689` and **ochre** `x≈0.633..0.967, y≈0.440..0.704`. Cables/secondary decorative SVG parts may extend beyond those estimates; **these bounds are calculations from source shapes, not measured rendered alpha**. Correct/reject the boxes once real non-distorted previews are inspected. Do not claim these pixel positions were implemented.

**Protected read in the concept:**
- Maintain an **approximately 0.24-portrait-width architectural opening** between the main upper-building masses around `y=0.45..0.68` (estimated from the two polygon footprints). The central opening must lead into the **stair/market node**, not a black void.
- Retain a **broad bright-blue skyline**, particularly the center around `x≈0.35..0.70` above `y≈0.36`. Do **not** replace the horizon with a billboard or opaque wall.
- The staircase gains dominance from the market landing down through `y≈0.67..1.00`; its rails, landings, people and edge vegetation must overlap the **lower edge** of architecture naturally. No stair/cable clipping and no free-floating house foundations.
- Preserve **asymmetry**: original two sprites are not mirrors, Coral remains visually stronger on the left and Ochre is a staggered right-side mass. Nearby/farther architecture and commerce are contextual requirements to evaluate later, **not authorizations to generate them**.

## 4. Layer ordering / geometry discipline (review only)

`BRIGHT SKY + FAR HILLS` (back) → `FAR ROOFS` → `UPPER: CORAL/OCHRE independent SVGs` → `MID COMMERCE + STAIR LANDING` → `NEAR STAIR/RAILS/RESIDENTS` (front) → `NATIVE UI/HOTSPOTS` (separate).

- The upper two SVGs must not flatten into one paper card, create mutually contradictory depth cues, hide touch-safe space, swallow the market landing or break the descending walkway.
- Actual near/mid/far occlusion and bounded pan/parallax remain **UNVERIFIED** until a future exact-head render. The two source manifest depth hints `0.48` and `0.46` are **unapproved suggestions**, not measured parallax.
- Cool luminosity comes from the **approved blue daylight sky**; painted homes and activity nodes retain vibrant **warm coral/ochre/amber** and authored patina; avoid replacing the reference with a dark navy nighttime overall filter.
- Source SVG acceptance only establishes individual artwork; source previews are **not** evidence of integrated City screenshot, pixel filtering or working gameplay.

## 5. Objective review criteria before any future assembled candidate

| Area | Reviewable condition | Current evidence status |
|---|---|---|
| **Native scale** | SVG canvas/viewBox maintained at 480:620; no squash/stretch | `ARTIST_DIRECTION_DEFINED`; engine/render QA PENDING |
| **Silhouette** | Coral higher/larger left, Ochre staggered right; no mirroring or duplicate cards | `ARTIST_DIRECTION_DEFINED`; combined image PENDING |
| **Central rhythm** | ~24% mid-upper gap leads to active commerce and continuous staircase, not void | `ARTIST_DIRECTION_DEFINED`; combined image PENDING |
| **2.5D depth** | Near/mid/far distinct; bases occluded coherently; bounded two-axis pan credible | `NOT_RENDERED` |
| **Lighting** | `LIGHT-01=A`: original bright blue daylight, warm facades | `APPROVED_DIRECTION`; combined image PENDING |
| **Mobile/UI** | Stage legible at 540×960 and 1080×1920; full native UI remains separate | `NOT_RENDERED` |

**No row above is an actual `VIS-01..VIS-08 PASS`**. Those gates require player-facing Godot/LENTE evidence and independent human runtime approval.

## 6. Strict scope boundary and handoff

**Completed by ARTIST:** resolved the previously open *art-direction* composition choices (proposed non-distorted bounds, left/right stagger, preserved skyline, central stair axis, layer order, LIGHT-01=A). This document is a specification, **not** a fabricated preview or new art asset.

**Not performed:** SVG source modification; new assets or compositions; render/build/import QA; `layers.json`; compositor activation; City runtime edits; deploy; CI claim; merge; scene/runtime acceptance. Existing `R06-B-01B` Godot import/raster QA and all `R06-B-02+` remain separately gated.

Preserve **G1–G25**, **R1 D/R2 D/R3 D/R4 D/R5 B**, architecture **B SVG 2.5D**, original City concept and global style, the two accepted source objects, **R05 PASS**, **R06 current / old City runtime REJECT ALL**, **PR #213 Draft**, **R07+ LOCKED**.

**Next ARTIST-only check when evidence exists:** inspect an *actual* faithful non-distorted per-object and combined composition rendering, compare with these targets and amend only if explicit evidence warrants. If unavailable, record `COMPOSITION_RENDER_NOT_DELIVERED`; do not invent PASS or force a new human gate.
