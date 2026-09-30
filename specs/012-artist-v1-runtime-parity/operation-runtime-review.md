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
