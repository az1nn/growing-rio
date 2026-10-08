# R06 City V1 — Visual Rebase C (ARTIST → CENA Spec Kit execution)

**Task key:** `012:R06:VISUAL-REBASE-C / AUTHORED_URBAN_PARITY`  
**Decision authority:** ARTIST review of PR #213 @ `9836f8917a3b2dd3c0f70334a9c7892b323ea9c3` — `IMPLEMENTATION_REVISE / TARGET_PARITY_NOT_MET`  
**Approved concept:** `20261004T110406Z/city` — unchanged, human ACCEPT  
**Current item:** R06 CURRENT; R07+ LOCKED; PR #213 stays DRAFT.  
**State:** C1 implementation published for verification; C2–C4 pending; no runtime visual ACCEPT.

## Problem statement

Rebase A replaced dominant low-poly construction with raster pixel shells. Rebase B added ten spatially staggered pixel detail modules. Exact-head automated gates passed, but actual portraits still read as broad flat billboards with insufficient authored masonry/windows/roofline variety, sparse shop and resident activity, weak 3D environmental depth and a City state-panel legibility concern in the 1080×1920 full page. Technical success is not artistic acceptance.

## Scope and authority

- **ART:** approved urban pixel-art × graffiti, dense/damaged/lived-in, non-toy source-image language.
- **CENA:** authored assets, spatial placement, occlusion, portrait composition and safe-area ownership.
- **SIGA:** branch/PR concurrency, evidence freeze, automated gates and next-step sequencing.
- **ARCH/GODOT:** only if an engine subsystem or reusable runtime API must change; none requested in C1.
- **ARTIST:** target-relative visual approval. Human acceptance is downstream and not currently eligible.

## Ordered work

### C1 — Stop City content being painted beneath the scene layer
Preserve accepted DA LATA UI V1. Keep City state-panel `Scroll.anchor_top = 0.63` and place its canvas draw-order **above** the City diorama's z=6 viewport and z=20 hotspot/action buttons. Add a structural Godot regression requiring the City state-panel content start after the viewport and every action button, with a normalized 0.012 safe gap, and a strictly higher paint order. Validate with fresh full-page captures in both portrait targets; structure alone cannot prove glyph contrast or compositing.

### C2 — Authored source art, not another billboard multiplication
Replace the visually dominant flat or reused raster masses with **distinct low-resolution original PNG/WebP pixel-art modules**, carrying irregular sidewalls/rooflines, chipped masonry, tile, shutters/windows, mural layering, practical amber light clusters and repair/wear at the pixel-cluster level. Draw compact, visually scaled residents and shop-life clusters as individually readable sprites; add plant and cable variation. Keep nearest sampling and transparent silhouette cutouts. Avoid repeated near-identical modules and procedural flat rectangles masquerading as final art.

### C3 — Depth, occlusion, and composition
Compose spatially staggered near facades, middle shop/stair life, upper roofs and far neighborhood with non-uniform silhouettes/overlaps and independently legible parallax in the orbit video. Maintain the center stair corridor, rooftop/district, route and community/local-event semantic anchors and touch affordances. Reserve the shared lower City state panel and action band. Do not redesign the approved UI or touch state/economy/persistence/Cloudflare boot.

### C4 — Exact-head evidence and decision
Freeze one final implementation HEAD, then pass Validate project, Cloudflare delivery and mobile readiness, City visual regression, Visual Acceptance and LENTE page+isolated at 540×960 and 1080×1920 plus orbit video. ARTIST compares fresh frame and motion to the **same** accepted City concept and returns **ACCEPT / REVISE / REJECT** with explicit checks for:
- dominant low-poly/toy or oversized billboard language;
- authored facade/roof/masonry/graffiti individuality;
- human-scale residents/vegetation/commerce;
- legible foreground→middle→upper→far spatial depth;
- safe-area text/controls without occlusion;
- exact-head preview `TEST:` and City→Market→City input responsiveness.

If still failing target parity, persist REVISE without requesting a human gate. Only ARTIST clearance + explicit human runtime ACCEPT can complete T051-H/I and unlock R07.

## Non-goals / preservation fence

No new City concept, no Three.js production return, no extra primitive-density pass, no changes to gameplay, persistent schema, semantic hotspots (`city/district_overlook`, `city/route_nodes`, `city/community_cluster`), DA LATA UI tokens/components, Cloudflare Web bootstrap, R07+, or unaccepted visual merge.

## C1 verification boundary

The C1 z-index adjustment and test are a narrow **structural** corrective first step, not a final source-art rebase. CI and captured visual evidence must be gathered on its own new HEAD; the previous green checks for `9836f8917a3b2dd3c0f70334a9c7892b323ea9c3` do not transfer.
