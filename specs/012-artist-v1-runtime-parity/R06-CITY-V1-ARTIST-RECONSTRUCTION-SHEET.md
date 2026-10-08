# R06 City V1 — ARTIST concept-locked reconstruction sheet

**State:** `R06-REJECT-01 / ARTIST_REFERENCE_DECOMPOSITION_COMPLETE / CENA_IMPLEMENTATION_NOT_STARTED`  
**Human gate:** `REJECT_ALL / FULL_VISUAL_REBASE_REQUIRED` on rejected runtime `1f799128d9efe33cfdcb8365119fc2eb2371166e`.  
**Human-approved target:** `20261004T110406Z/city` — **retain**; image checksum SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`.  
**Original manifest:** `docs/art-direction/v1/runs/20261004T110406Z-city/MANIFEST.md`.  
**Engine:** Godot-native 3D with screen-space UI. This is a **production art/build contract**, **not** a new concept image, model output, implemented screenshot or visual acceptance.  
**Owner:** ARTIST for source-concept visual authority; CENA for next implementation; SIGA for task ownership and gates.  
**Decision record:** `R06-CITY-V1-HUMAN-REJECT-20261008.md`.

## 0 — CAVEMAN: before → approved target → implementation correction

**BEFORE (rejected exact-head screenshots):** dominant large terracotta and cyan planar blocks; nearly black center stairs; evenly spaced colored square marks and broad repeated mural bands; disjointed rail/plant assets; no legible human-scale commercial node or street population. The orbit discloses paper-thin planes/black gaps. Page composite has overlapping City state text, stage and action-row layers. The rejected construction does **not** read as the accepted art even though the CI and Cloudflare boot were green.

**APPROVED TARGET (actual human-accepted scene, not a new render):** a high-vantage vertical neighborhood with stacked irregular warm-plaster buildings, painted/graffiti/tile walls, narrow stair and landings, railings, full foreground human scale, a recognizable lived-in commercial landing, many residents, awnings, plants, cable networks and a coherent layered background. Warm masonry/shop accents contrast with airy blue/cool background depth. User accepted the **visual image**, not an algorithmic approximation of object counts.

**MANDATE:** replace *all dominant visible architectural presentation*. Preserve proven hidden hotspot/runtime/state substrate only. Do not rename or reinterpret the rejected candidate as accepted.

## 1 — Actual concept decomposition (portrait image coordinates)

Coordinate convention: `x=0` left, `x=1` right, `y=0` top and `y=1` bottom of the accepted 9:16 image. The following broad zones are **visual guidance from the approved concept, not measured screenshot acceptance thresholds**. UI in the concept is incidental/generated and must be implemented with the game's shared UI, never copied as artwork.

| Concept zone | Dominant accepted read | Godot-native reconstruction |
| --- | --- | --- |
| `y≈0.00–0.23` | Clear **blue/cyan atmospheric sky**, distant hills and background neighborhood, framing by high building silhouettes | Render a non-literal fictional distant city with continuous light/cool depth; do not reproduce recognizable real landmarks or image-baked HUD/logo |
| `y≈0.18–0.48` | Deep stacked small painted houses, parapets, roof tanks, terrace vegetation and dense distant architecture | Volumetric staggered block shells with visibly distinct front/side/roof faces, authored paint/tile/wear and coherent lateral street continuity |
| `y≈0.36–0.70` | Visually **active central plaza/market node**: green/tangerine awnings, kiosks, windows, shop openings, people, wires, railing, shade and local warm lights | A *spatially walkable-looking* landing with two-sided commerce architecture, readable shop shutters/interior value contrast and resident clusters; one major graffiti/mural focal, not a repeated stamp |
| `y≈0.62–1.00` | Big descending stone stair corridor, retaining walls, handrails, potted plants, human scale and a near person on steps | Foreground stair landing with worn chipped step risers and actual 3D rails; preserve strong downward leading line. Remap to available play viewport above approved mobile HUD instead of drawing under controls |
| Left/right edges | Asymmetric irregular walls, cables, foliage and storefront cutaways with coherent perspective | Distinct wall/roof thickness and side returns on both sides; avoid one monolithic left quad and another right quad |
| Across whole frame | Lived-in, non-repeated detail at multiple spatial sizes; bright upper horizon vs textured warm near field | Visual density must follow **structural hierarchy**, not evenly sprayed detail particles |

**Key framing invariant:** the photo-like HUD and named Rio monuments in generated artwork are *not* implementable directives. Keep the accepted architectural composition, warm/cool depth, human scale and sense of place while obeying locked global V1 requirements (fictional Rio-adjacent, graffiti/pixel-cluster vocabulary, Godot 3D, no baked labels).

### Important light/color reconciliation

The **approved City image is visibly blue-sky / daylight-readable**, whereas some earlier CENA revisions forced an almost-black/night-only viewport based on the global base prompt. That contradiction was central to the reported non-similarity. **Do not use the old black void as a default art baseline.** ARTIST must preserve the concept's *perceived color separation* — airy blue/cool far field, peach/rust/painted masonry, lush green and warm living/shop areas — while keeping the global V1 pixel treatment and stylistic accents. A deliberately darker final interpretation, if proposed, requires a target-relative ARTIST decision **before** construction, not a silent shift. This sheet does not modify the global V1 board.

## 2 — Composition and spatial scene graph (concept-led)

```text
CityWorld [native Godot Node3D]
  CameraThreeQuarter [portrait physical isometric-feeling projection]
  FictionalFarHorizon [cool sky/atmosphere + volumetric silhouette]
  UpperUrbanMass [unique rooflines, terraces, side faces, water tanks]
  MidHousingLeft/Right [stacked connected architecture, doors/windows/awnings]
  CommercialLanding [shop fronts + shuttered side streets + residents]
  TraversalStair [step runs + landings + solid concrete rail/retaining walls]
  ForegroundLife [one optional anonymous scaled focal silhouette + plants]
  UtilityNetwork [cables, poles, tank, gutters, patch wiring]
  GraffitiSurfaces [authored decals on *actual* walls/retaining faces]
  Area3DAnchors [reuse existing semantic hotspots/collisions]
CityScreen [shared DA LATA UI V1; separate from 3D pixels]
```

**Do not instantiate this graph as placeholder primitive art.** It is the conceptual breakdown CENA must implement using original volumetric forms and low-resolution authored surface assets.

### Three existing semantic interaction foci

| Existing semantic ID | Concept location | Implementation fence |
| --- | --- | --- |
| `city/district_overlook` | Upper/Mid roof observation point, clear stepped painted parapet or rooftop cluster | Physical selection Area3D + accessible focusable District action; no invented district map |
| `city/route_nodes` | Foreground-to-mid central stair/landing turn | Physical stair/route Area3D + keyboard/touch fallback; navigable path visually continuous |
| `city/community_cluster` | Mid-field commercial/plaza activity node | Physical market/community Area3D + event action; readable shop and resident silhouettes |

### Production asset taxonomy (distinct source art, not copied rectangles)

1. **Building/roof volumes** with independent side/roof/wall surfaces, parapets, repaired corners and interlocking scale; silhouette is designed in three-quarter view **and** survives orbit.
2. **Masonry + graffiti** with tile/mortar, patch repair, paint wear, staggered window shutters, wire shadows and bounded mural fields; coarse authored pixel clusters remain visible on a portrait phone.
3. **Stairs + rails** with riser depth, surface wear, genuine landings and handrail thickness; neither a dark flat black stripe nor a sticker.
4. **Commerce + people** with at least one readable shop-opening focal and resident presence at consistent human scale; 3D silhouettes/small sprites are attached to plausible surfaces, never floating motifs.
5. **Plants + utilitarian clutter** with unique leaf cluster shapes, wall pots, cables/water tanks and roof rhythm; details cluster meaningfully where people use space.
6. **Background** as fictional coherent built depth, not giant flat black voids, a real Rio monument, or a city screenshot pasted into the viewport.

Production files need original-art provenance and nearest-neighbor pixel filtering where appropriate. **Authored texture** is not equivalent to stacking more copies of the same facade card.

## 3 — What must NOT survive as visible authority

Verified source: `scenes/visual/city_diorama.gd` on rejected head.

- `_ready()` presently calls `_build_candidate17_authored_neighborhood()` and `_build_r06_pixel_surface_shell()`. The former still runs merely to be hidden; the latter builds **five full-frame quads**.
- `_build_r06_pixel_surface_shell()` creates `R06PixelSurfaceShell` using `assets/city/v1/rebase-a/{far-city,upper-neighborhood,mid-neighborhood,near-facades,foreground-life}.png` and `R06PixelDetailModules` using repeated rebase-b `{near-detail,mid-activity,upper-detail,foreground-detail}.png`.
- These exact source paths and large-card placements are **rejected player-facing sources**, even if they are original PNG assets. Their retained files may remain as auditable history.
- CENA's implementation must stop constructing both rejected visual branches in the live render, and must prove it. Do **not** remove `Area3D` selection objects, `district_marker`, `route_marker`, `local_event_marker`, or the saved gameplay/state references in order to hide visual elements.
- Native geometry is not itself forbidden: use useful 3D building side/roof/thickness + authentic authored pixel surfaces, but **no visually dominant untextured primitive** and **no thin facade billboard with empty oblique side**.

## 4 — Player-facing mobile composition hard gate

- Target isolated and full-page at **540×960** and **1080×1920**; same concept target and camera family.
- Shared `CitySurface` currently nests `Interactive3D` full-root and `Scroll` from normalized `y=0.63`; `city_diorama.gd` moves `ViewportContainer.anchor_bottom=0.78` and action buttons to `y=0.80…0.87`. **These vertical bands overlap**, irrespective of `Scroll.z_index=21`. This is a confirmed visual failure, not an artistically acceptable layering trick.
- CENA/UX must allocate **non-overlapping actual rectangles** for header, diorama, three accessible action buttons, City state/scroll and approved bottom navigation. No button or text rendered under another interactive band; preserve the shared UI's visual tokens/roles, with content allowed to scroll inside its own zone.
- The approved artwork shows a foreground person low in frame, but a static reference is **not** permission to bury the live UI; keep a strongly recognizable stair axis ending before the action/command band.
- Test both portrait sizes with real text/long localized labels, visible focus outline, pointer/touch access, and City→Market→City round-trip. No on-screen control should inherit a hidden hit target from the rejected structure.

## 5 — CAVEMAN ARTIST quality matrix

All *qualitative* rows require evidence from same-head real runtime and direct visual comparison; CI cannot auto-pass them.

| Criterion | Fail / **REJECT** | Eligible to PASS only when |
| --- | --- | --- |
| Framing | Two giant walls flanking an empty black central staircase; disconnected cut-outs | Near stairs → inhabited middle commerce → stepped upper houses → cool distant horizon visibly compose one neighborhood |
| Architecture | Repeated planar wall cards, paper-thin sides, toy boxes | At least two different recognizable front/side/roof constructions, authored pixel wear and irregular rooflines; oblique angle has real thickness |
| Street life | Missing or random floating human/plant marks | Credible scale across resident(s), awning/storefront, railing and utility props; interaction foci visually discoverable |
| Material | Massive unbroken orange/cyan fills, repeated stamps and flat shaded strips | Distinct masonry/paint/tile/shutter/graffiti areas with intentional authored variation, no dominating plastic/primitive read |
| Depth | Paper-edge reveal/black holes during orbit, near/mid/far only from cards | Solid architectural continuity, occlusion and readable parallax through all orbit sampled viewpoints |
| Color | Black void/background and high-neon blocks ignore concept | Perceived warm populated near/mid vs cooler open far background matches accepted concept within pixel-graffiti style |
| UI + accessibility | City scroll overlays button/viewport; controls hard to read or touch | No physical rectangle intersections/text bleed in full-page 540×960 and 1080×1920 plus focus/touch evidence |
| Technical | Good screenshot but controls freeze or preview shell only | Exact-head Validate, Cloudflare Web WASM, scene interaction, LENTE capture + orbit all PASS |

**Critical gates:** any player-facing dominant card/billboard read, missing middle commerce node, empty stair void, broken viewport layout, or failed real-device responsiveness is an ARTIST **REJECT**, even when the aggregate checks pass. No arbitrary pixel similarity score and no counts-only art acceptance.

## 6 — ARTIST handoff / stop conditions

- **ARTIST task `R06-REJECT-01`: COMPLETE (reference decomposition & visual contract only).** No newly generated image; existing human-approved `20261004T110406Z/city` reused as authority. Rejected before captures remain evidence; do not relabel them as AFTER.
- **CENA `R06-REJECT-02`: NEXT (implementation not started).** Build a clean visible City scene from the accepted image using this plan. The first delivery must show a continuous architectural street-scene, not a 5-card shell; a follow-on density-only pass is not an option.
- **CENA `R06-REJECT-03`: PARALLEL_WITH_SCENE_IF_SAME_OWNER**, resolve layout geometry alongside reconstruction without competing branch writers.
- **SIGA `R06-REJECT-04`: BLOCKED ON NEW IMPLEMENTATION**, exact-head Godot/Cloudflare/input/LENTE evidence after implementation.
- **ARTIST `R06-REJECT-05`: BLOCKED**, next human gate prohibited until fresh exact-head comparison is legitimately target-eligible. R07+ LOCKED, PR #213 DRAFT.

**No visual artifact was generated or approved in this phase.** This document is the production reconstruction blueprint, not the delivered art.
