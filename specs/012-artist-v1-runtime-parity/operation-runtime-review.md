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


## Revision 8 runtime review — REVISE

**Reviewed head:** `418c7988fd92380e22e467a91faf78d08da311b4`  
**Validate:** run `36853416537` / #1027 — SUCCESS.  
**Visual acceptance:** run `36853416535` / #522 — SUCCESS; artifact `11156549527` inspected at 540×960 and 1080×1920.  
**LENTE:** run `36853416550` / #58 was still capturing when the completed exact-head visual evidence already exposed a decisive style mismatch; its output is historical after Revision 9.

Revision 8 fixed the long visible floor/runway defect and materially improved the compact cutaway composition. It still failed the individually accepted Operation target because the player-facing image remained dominated by macro-block low-poly surfaces, broad olive foliage masses, sparse repaired-wall/floor rhythm, a weakly legible amber crown and insufficient warm/cool practical hierarchy around the existing UI.

## Bounded revision 9

Revision 9 remains presentation-only inside R04:

- preserve the Revision 8 compact authored floor, camera and all semantic/accessibility/gameplay contracts;
- add smaller repeated repaired masonry/plaster/painted-metal surface chips instead of broad flat color fields;
- hide remaining macro foliage blocks and reinforce the left/back rack with smaller repeated pixel-leaf silhouettes across three tiers;
- give the amber crown a dedicated unobscured dark wall field, thicker handmade silhouette and drip/slash fragments;
- add small repeated supply/workbench props for authored workshop density;
- strengthen warm rack/crown/workbench pools while keeping cyan/magenta as controlled edge accents;
- raise the structural regression floor and require key Revision 9 nodes.

Revision 9 requires a fresh exact-head Validate + Visual Acceptance + LENTE capture, followed by ARTIST/CENA runtime `ACCEPT` or another bounded `REVISE`. R05 remains locked.


## Revision 9 runtime review — REVISE

**Reviewed head:** `212103c2929a4da6aad52aed4be95d76716aa640`  
**Validate:** run `36856124715` / #1030 — SUCCESS.  
**Visual acceptance:** run `36856124761` / #525 — workflow FAILURE during screenshot capture, but artifact `11157669589` preserved the full 540×960 set before the timeout.  
**Operation 540×960:** inspected against the accepted concept SHA-256 `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce`.

The partial exact-head evidence is sufficient for a visual decision. Revision 9 improves micro-density and preserves the compact floor, but the player-facing scene still reads materially below the accepted V1 concept: rack foliage remains too blocky/muted, the amber crown is not a dominant signature, the right workshop wall is too sparse, warm practical hierarchy remains weak, and the embedded legacy operation control stack masks too much of the upper diorama.

The #525 failure is capture infrastructure, not a gameplay regression: Playwright timed out after 30 seconds in `page.screenshot`; all 11 540×960 portraits had already been written and uploaded.

## Bounded revision 10

Revision 10 remains presentation-only inside R04/T040:
- zoom the compact room slightly closer without changing hotspot ownership;
- densify the left/back rack with smaller repeated pixel leaves and visible warm grow-light bars;
- strengthen right/back supply shelving and workbench microprops;
- make the amber crown brighter and more legible around portrait controls;
- raise ambient/warm practical readability while retaining controlled cyan/magenta edges;
- compact only the embedded Operation control presentation while preserving every canonical action and domain command;
- harden Visual Acceptance screenshot timeout to 120 seconds so slow SwiftShader frames do not invalidate completed evidence.

Fresh exact-head Validate + Visual Acceptance + LENTE are required. R05 remains locked.


## Revision 10 runtime review — REVISE

**Reviewed head:** \`05d48c7f7893d60eed2ca75cbadfe72c87cbc0eb\`  
**Validate:** run \`36857872449\` / #1031 — SUCCESS.  
**Visual acceptance:** run \`36857872523\` / #526 — SUCCESS; artifact \`11160516552\` inspected at 540×960 and 1080×1920.  
**LENTE:** run \`36857872374\` / #62 was still capturing when completed exact-head Visual Acceptance pixels were already decisive; its Rev10 output becomes historical after Revision 11 is pushed.

Revision 10 improved raw authored detail and fixed the screenshot-timeout infrastructure failure, but the exact-head pixels exposed a deeper implementation problem: successive visual revisions were additive. R5/R6/R7/R9/R10 rack generations, multiple crown generations and multiple floor treatments remained simultaneously visible. Under the scene-only pixel shrink these layers merge into oversized olive foliage masses, broad accent floor blocks and a weakly separated wall signature. The right supply/workbench field is also overlaid by several generations instead of reading as one authored workshop system. Structural, semantic and deployment gates are green; the failure is visual composition/style parity.

The accepted concept remains a compact repaired urban room with one clearly articulated left/back rack, one dominant amber crown, one dense but readable right supply wall, one foreground workbench and fine floor/wall pixel rhythm. Therefore T040 remains open and R05 remains locked.

## Bounded revision 11

Revision 11 is a **consolidation pass**, not another accumulation pass:
- preserve all historical geometry in the scene tree for rollback/evidence, but explicitly hide superseded rack, crown, supply, floor and macro repair generations;
- render one clean three-tier left/back rack with separated small leaves, restrained blooms and warm bars;
- render one compact amber crown generation on a dark breathing field;
- render one right-side supply generation with small repeated objects;
- replace large floor accent tiles with sparse small mosaic fragments on the existing compact R8 floor;
- replace broad wall repair slabs with smaller repeated masonry/plaster rhythm;
- keep the existing workbench anchor but collapse revision-specific clutter into one small-prop generation;
- preserve \`plant_cluster\`, \`management_storage\`, pointer/touch picking, accessible fallbacks, gameplay, saves and Godot-native production ownership.

Revision 11 requires a fresh exact-head Validate + Visual Acceptance + LENTE capture before another ARTIST/CENA decision.


## Revision 13 runtime review — STRUCTURAL_REBASE_REQUIRED

**Reviewed head:** `dd56f04e3099676f6d9bac51c72d7f30b52152b4`  
**Validate:** #1040 / `36872214957` — SUCCESS.  
**Visual Acceptance:** #534 / `36872214900` — SUCCESS; artifact `11167378183` inspected at 540×960 and 1080×1920.  
**Accepted target:** `assets/art-direction/v1/scenes/operation.webp`.

Rev13 added authored nearest-neighbour surface textures and a physical pixel crown decal, but the exact-head runtime remains structurally divergent from the accepted target. It still reads as a broad low-poly staged room rather than a dense vertical pixel/graffiti workshop; the left garden / center bench / right supply silhouette is weak, the crown is not an immediate player-facing signature, and UI/empty-volume bands suppress the authored room.

Per the merged Feature 012 architecture-execution guardrail, this is not eligible for another additive bounded revision.

**Decision:** `IMPLEMENTATION_REVISE → STRUCTURAL_REBASE_REQUIRED`.

Next implementation step: rebuild the rejected visible layer Godot-native from the accepted Operation concept while preserving gameplay, saves, semantic hotspots, pointer/touch interaction and accessible fallbacks. R05+ remain locked.


## Structural rebase candidate 1 runtime review — REVISE

**Reviewed head:** `109d29f187f248c97bff58df9bf8f3201c0a38fa`  
**Validate:** #1046 / `36877863321` — SUCCESS.  
**Visual Acceptance:** #539 / `36877863420` — SUCCESS.  
**LENTE:** #71 / `36877863393` — SUCCESS; artifact `11175160997`, run key `20261001T143817Z-109d29f187f2-r36877863393-a1`; 22/22 pages, 22/22 isolated scenes, 11/11 videos, zero gaps.  
**Vercel:** SUCCESS.

The structural rebase is a clear architecture improvement over Rev13: the rejected additive dressing is gone and the visible scene now derives from one `OperationV1AcceptedRebuild` root. Runtime acceptance still remains **REVISE** against the locked Operation concept.

Exact-head visual inspection found three bounded defects:
- the accepted right/back supply-wall silhouette is effectively absent from both isolated portrait captures, so the intended left garden / center bench / right supply composition is incomplete;
- the amber crown is partially clipped toward the portrait edge instead of reading as a complete central/back signature;
- source inspection exposed a semantic drift: `_configure_v1_pixel_foliage()` ran after the structural rebuild and overwrote the rebuild's `plant_cluster` hotspot position with the legacy R11 coordinate.

### Structural rebase candidate 2 — executed delta

This is a continuation of the Godot-native structural rebase, not additive Rev14 work.

- preserve `OperationV1AcceptedRebuild` as the single visible production root;
- fence the legacy foliage cleanup path so it cannot overwrite rebuild hotspot ownership;
- pin exact plant/storage/workbench hotspot positions in regression coverage;
- move the right/back supply wall inward/forward so it survives portrait framing;
- recenter the crown field leftward so the complete amber signature survives portrait framing;
- keep gameplay, saves, semantic IDs, pointer/touch behavior, accessibility and renderer ownership unchanged.

The 109d evidence is now historical. Candidate 2 requires fresh exact-head Validate + Visual Acceptance + LENTE before another ARTIST/CENA decision. R05 remains locked.


## Structural rebase candidate 2 runtime review — REVISE

**Reviewed head:** `e0e306ee3d97f576f297c1c869faa8476021b5f8`  
**Validate:** #1050 / `36888468046` — SUCCESS.  
**Visual Acceptance:** #543 / `36888468032` — exact-head artifact `11175278571` inspected at 540×960 and 1080×1920.  
**Accepted target:** `assets/art-direction/v1/scenes/operation.webp`.

Candidate 2 fixed the semantic hotspot overwrite and moved the right supply generation inward, but the player-facing composition still fails the accepted Operation target.

Exact-head defects visible at both portrait targets:
- the left/back garden is pushed into the HUD/top band instead of reading as a strong left vertical anchor;
- the amber crown is clipped/obscured near the top and does not read as the accepted central wall signature;
- the right/back supply wall remains peripheral and only partially legible;
- the workbench is oversized relative to the room and dominates the center;
- the visible floor occupies too much of the portrait, recreating an empty-stage read instead of the compact dense cutaway target.

**Decision:** `IMPLEMENTATION_REVISE`.

### Structural rebase candidate 3 — framing correction

Candidate 3 remains within the same accepted-concept rebuild; it must not add a new dressing generation.

Required delta:
- reframe the orthographic camera around the accepted room silhouette rather than the legacy stage;
- reduce foreground floor/apron depth so the room terminates quickly;
- scale/reposition the workbench to a foreground anchor rather than the dominant mass;
- place garden, crown and supply wall inside a deliberate portrait-safe composition band below the Operation HUD;
- preserve the single `OperationV1AcceptedRebuild` root, semantic IDs, exact hotspot ownership, gameplay, saves, pointer/touch behavior, accessibility and Godot-native renderer lock.

Candidate 2 evidence is historical after candidate 3 changes. R05 remains locked.


## Structural rebase candidate 3 runtime review — REVISE

**Reviewed head:** `327d45712dd24cd01639143c9d9d60ba4deb52f8`  
**Validate:** #1054 / `36889894548` — SUCCESS.  
**Visual Acceptance:** #547 / `36889894530` — SUCCESS; artifact `11176852091` inspected at 540×960 and 1080×1920; browser console error log empty.  
**LENTE:** #79 / `36889894718` — SUCCESS; artifact `11180403527`.  
**Accepted target:** `assets/art-direction/v1/scenes/operation.webp`.

Candidate 3 preserved the shortened floor, widened camera window and improved right supply-wall presence/workbench balance, but ARTIST/CENA still returns `IMPLEMENTATION_REVISE`.

Bounded exact-head defects:
- the authored room terminates too high in portrait, leaving a large lower black/empty-volume band before bottom navigation;
- garden and crown remain too close to the HUD/top interaction band;
- the central wall still reads as repaired rectangular patches instead of the accepted magenta/cyan shutter/graffiti signature around the amber crown;
- warm practical pools do not yet dominate against the cool navy night hierarchy;
- supply-wall presence and reduced workbench dominance are gains and must not regress.

### Structural rebase candidate 4 — bounded correction executed

Candidate 4 stays inside the existing `OperationV1AcceptedRebuild` and does not reopen the additive Rev1–13 path.

Executed delta:
- preserve orthographic size `5.10`, compact accepted floor depth `3.55` and exact three semantic hotspot positions;
- raise camera world-Y only, shifting the authored room down into the usable portrait region without changing world hotspot ownership;
- add one deliberate central shutter field plus cyan/magenta graffiti strokes behind the existing amber crown;
- reduce global ambient flattening and strengthen garden/workbench/supply/crown/pendant warm practical pools;
- add regression coverage for the vertical safe-area frame, shutter/graffiti nodes and warm-light hierarchy.

Fresh Candidate 4 exact-head Validate + Visual Acceptance + LENTE are required before the next ARTIST/CENA disposition. R04 remains CURRENT; R05+ remain locked.
