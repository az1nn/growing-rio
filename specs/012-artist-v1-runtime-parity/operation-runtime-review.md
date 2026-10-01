# Feature 012 / R04 — Operation runtime review

**Decision:** `REVISE`  
**Reviewed head:** `f18476c5f417583d5b06e8da6a117297ddb360da`  
**Accepted concept:** `assets/art-direction/v1/scenes/operation.webp`  
**Accepted concept SHA-256:** `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce`

## Verified evidence

- Validate project: run `36775607182` — SUCCESS.
- Visual acceptance capture: run `36775607157` — SUCCESS.
- LENTE: run `36775607148`, artifact `11127600141`, run key `20260930T205209Z-f18476c5f417-r36775607148-a1`.
- LENTE exact head matches the reviewed PR head.
- Evidence contract: 22/22 pages, 22/22 isolated scenes, 11/11 videos, 11/11 first-ready posters, 0 gaps.
- `browser-console-errors.txt`: empty.
- Operation page 540×960: luminance 15.9, contrast 17.6, dark share 0.93.
- Operation page 1080×1920: luminance 14.0, contrast 14.4, dark share 0.962.
- Operation isolated 540×960: luminance 20.9, contrast 21.2, dark share 0.874.
- Operation isolated 1080×1920: luminance 21.0, contrast 21.7, dark share 0.874.

Metrics are diagnostic only; the decision comes from comparing the rendered pixels with the locked board/style guide and accepted scene concept.

## Why REVISE

The runtime preserves the required real-3D shell, semantic hotspots, accessible fallbacks and V1 palette wiring, but the rendered scene still reads as a sparse low-poly blockout rather than the accepted Pixel Art × Graffiti × Urban Diorama production target.

Concrete mismatches:
- the accepted scene has a dense repaired urban shell, layered brick/plaster, fan/duct silhouettes, hanging warm practicals and multiple prop layers; the runtime is mostly clean planar walls plus a few clusters;
- the accepted composition places the foliage/growing rack predominantly left/back, the main work surface foreground/right-center and supply shelving on the right; the runtime keeps large abstract plants in the center foreground and storage on the left;
- the accepted crown is a warm amber/yellow wall mark; the runtime first pass used magenta/cyan geometry;
- the accepted floor has irregular patched tile/graffiti rhythm; the runtime floor is mostly uniform;
- full-page Operation presentation remains very dark, so the 3D focal anchors lose hierarchy below the UI.

## Bounded revision 2

Revision 2 stays inside R04:
- densify the existing Godot-native scene with production dressing, not a flat image;
- preserve `plant_cluster`, `management_storage`, pointer/touch behavior and both accessible fallbacks;
- keep abstract fictional vegetation and avoid operational cultivation detail;
- recompose existing interaction clusters toward the accepted layout;
- add repaired brick/plaster accents, fan/duct, warm pendants, wall racks/supplies, workbench props, floor patchwork and entry steps;
- use amber crown/light identity and brighter measured ambient/practical lighting.

After code changes, the old LENTE evidence becomes historical. The new exact head must pass regression + LENTE at both portrait targets before another ARTIST/CENA runtime decision.

## Revision 3 runtime review — REVISE

**Reviewed head:** `902fb2475044f0338f41e3d2c16aa5932c0318bd`  
**Validate:** run `36787370078` / #1009 — SUCCESS.  
**Visual acceptance capture:** run `36787370117` / #507 — SUCCESS.  
**LENTE:** run `36787370155` / #49, artifact `11132565389`, run key `20260930T224650Z-902fb2475044-r36787370155-a1` — 22/22 pages, 22/22 isolated scenes, 11/11 videos, 11/11 posters, zero gaps.

Exact-head visual inspection confirms material progress over the first runtime: composition is denser, brighter, the warm/cool hierarchy is visible, the workshop silhouette is clearer and the wall receives physical color marks. R04 still does **not** pass runtime acceptance because the dominant foreground foliage remains smooth rounded low-poly geometry and the wall mark still reads closer to clean geometric strips than the locked chunky-pixel / handmade-graffiti language. The isolated scene therefore remains materially short of the accepted V1 visual invariant even though structural/interaction gates are green.

## Bounded revision 4

Revision 4 remains presentation-only inside R04:
- use a stronger Operation-specific scene-only nearest-neighbor shrink while keeping UI full-resolution;
- preserve planter collision/semantic contracts but visually replace legacy smooth canopy meshes with physical box-cluster crowns;
- add irregular physical graffiti drips/tag fragments so the wall reads less like vector strips;
- retain current camera, workshop density, lighting, gameplay, saves and accessibility;
- rerun exact-head regression + 540×960 / 1080×1920 LENTE before any runtime ACCEPT.

## Revision 4 runtime review — REVISE

**Reviewed head:** `00f903b366d63119c30d4839bcba7838c080be57`  
**Validate:** run `36797204356` — SUCCESS.  
**Visual acceptance:** run `36797204324` — SUCCESS.  
**LENTE:** run `36797204341`, artifact `11135611633` — SUCCESS; exact-head 540×960 + 1080×1920 evidence inspected.

Revision 4 improves the pixel read and removes the dominant smooth legacy canopy silhouette, but it still does not meet the individually accepted Operation concept closely enough for T040. The remaining gap is now concentrated and measurable: the runtime still reads as macro-block low-poly geometry, the left wall carries too much empty mass, the growing rack lacks layered leaf density, and the repaired masonry / floor / handmade graffiti texture is materially sparser than the accepted target.

## Bounded revision 5

Revision 5 remains inside R04 and remains presentation-only:
- tighten the orthographic framing without changing interaction ownership;
- replace macro wall patches with staggered individual 3D repair bricks;
- replace rounded rack foliage with layered pixel-leaf geometry;
- add side-wall handmade tag fragments, floor micro-patches and extra abstract leaflets;
- add one restrained warm rack practical to recover the accepted warm workshop hierarchy;
- preserve `plant_cluster`, `management_storage`, pointer/touch picking and both accessible fallbacks.

The Revision 4 evidence is historical after the next commit. T040 still requires exact-head regression + LENTE and final ARTIST/CENA `ACCEPT`.


## Revision 5 runtime review — REVISE

**Reviewed head:** `2b8b5ea10e0618ce3de910170d49ed37c958c935`  
**Validate:** run `36849502283` — SUCCESS.  
**Visual acceptance:** run `36849502192` — SUCCESS; artifact `11154899161` inspected at 540×960 and 1080×1920.  
**LENTE:** run `36849502235` was still capturing when the exact-head visual mismatch was already sufficient to reject the revision; its output becomes historical once Revision 6 is pushed.

Direct comparison with the accepted Operation concept still shows a material mismatch. Revision 5 is denser than Revision 4, but the player-facing image remains dominated by oversized foreground plant masses, broad empty floor, simple block masonry and a weak wall signature. The accepted concept is a compact room-scale pixel diorama with the plant rack concentrated left/back, dense small-object shelving right/back, a strong amber crown, warm practical pools and a much finer repaired floor/wall rhythm. Therefore T040 remains open and R05 remains locked.

## Bounded revision 6

Revision 6 is a concept-parity pass inside R04:
- tighten orthographic framing again so the authored room fills more of the portrait scene;
- suppress oversized legacy foreground planters visually while preserving their semantic contract through the left/back rack hotspot;
- make the left/back two-tier rack the primary vegetation silhouette;
- add a prominent amber crown matching the accepted visual signature;
- add smaller repeated masonry, plaster, shelf-object and floor-tile rhythm;
- strengthen the warm practical hierarchy while retaining cool shadow support;
- preserve Godot 4.7.2 / GL Compatibility, gameplay, save ownership, pointer/touch interaction and accessible fallbacks.

Revision 6 requires a fresh exact-head Validate + Visual acceptance + LENTE capture before another runtime decision.


## Revision 7 runtime review — REVISE

**Reviewed head:** `1993d3833eb0b7f69531999e3c35307f02c92fbf`  
**Validate:** run `36852059994` / #1024 — SUCCESS.  
**Visual acceptance:** run `36852059964` / #519 — SUCCESS; artifact `11156088806` inspected at 540×960 and 1080×1920.  
**LENTE:** run `36852060093` / #55 was still capturing when the completed exact-head Visual Acceptance artifact already exposed a decisive composition defect; its output is historical after Revision 8.

Revision 7 materially improved density, rack/supply repetition and room dressing, but the player-facing result still failed the accepted compact cutaway composition. The canonical CENA-016 `Floor` remained an 11-unit visible slab and dominated the lower half of the portrait scene. This visually recreated the long stage/runway problem even though the later apron/service pieces were hidden. The accepted concept instead terminates the room quickly at a short urban threshold and keeps visual emphasis on the left/back rack, right workshop wall, amber crown and warm workbench.

## Bounded revision 8

Revision 8 remains presentation-only inside R04 and explicitly preserves the CENA-016 structural contract:

- keep the canonical `Floor` node, mesh, transform and rear-boundary evidence intact, but hide it from the Operation V1 presentation;
- hide its foreground/spine joint strips together with the already-hidden service runway;
- add a compact authored visible floor inside the cutaway room;
- tighten the orthographic framing from 5.15 to 4.85;
- enlarge/isolate the amber crown wall signature and strengthen warm workbench/crown pools;
- preserve `plant_cluster`, `management_storage`, all pointer/touch picking, accessible fallbacks, saves and gameplay ownership;
- add regression guards proving the canonical long floor stays presentation-hidden while the compact authored floor remains visible.

Revision 8 requires fresh exact-head Validate + Visual Acceptance + LENTE evidence before any final ARTIST/CENA `ACCEPT`.
