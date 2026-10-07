# R06 — City V1 CENA decomposition / build sheet

**Parent:** Feature 012 / R06 City V1  
**Source concept:** `20261004T110406Z/city`  
**Concept decision:** `ACCEPT`  
**Renderer:** `GODOT_NATIVE_V1`  
**UI:** reuse DA LATA UI V1; no City-local UI fork  
**Status:** READY_FOR_IMPLEMENTATION

## Composition target

Rebuild the approved vertical neighborhood read as real Godot geometry. Preserve the concept's steep descending stair spine, dense stacked architecture, mural/paint rhythm, warm practical pools, cool atmospheric separation and lively mid-field neighborhood node.

Portrait composition is the authority:

1. **Upper field — district skyline / rooftops**
   - layered fictional roof silhouettes and compact stacked houses;
   - visible cable runs, water tanks/utility silhouettes and painted parapets;
   - no literal postcard monument or real-map landmark.

2. **Middle field — neighborhood activity node**
   - small shopfront/awning cluster, plaza/landing and mural wall;
   - strongest warm practical pool;
   - sufficient open sightline for the local-event interaction anchor.

3. **Lower field — traversal stair spine / UI-safe foreground**
   - broad descending stairs and landing establish route readability;
   - foreground walls/planters frame depth without blocking touch targets;
   - keep lower 20–25% composition calm enough for the shared DA LATA command/navigation band.

## Three semantic 3D anchors

### CITY_DISTRICT_ROOFTOPS
Physical anchor: upper/middle rooftop cluster with one clearly readable painted parapet/crown-like graffiti marker.  
Interaction: existing district-selection semantics only.  
Accessibility fallback: named focusable control in the shared City surface.

### CITY_ROUTE_NODES
Physical anchor: stair/landing junctions and alley connectors along the central traversal spine.  
Interaction: existing route/navigation semantics only; no real-world map instructions.  
Accessibility fallback: keyboard/focus route list synchronized with the same semantic IDs.

### CITY_LOCAL_EVENT
Physical anchor: middle-field plaza/shopfront/mural activity node.  
Interaction: existing local-event semantics only.  
Accessibility fallback: shared focusable event action with non-color-only state.

## Modular geometry kit

- 3–4 reusable stacked-house shells with variant widths/heights;
- roof/parapet modules;
- stair flights, landings and retaining walls;
- balcony/awning modules;
- shutter/shopfront modules;
- cable poles + bounded cable splines;
- water tank / utility silhouettes;
- wall planter and bucket vegetation clusters;
- graffiti/decal planes from V1 stencil vocabulary;
- streetlamp/awning practical-light fixtures;
- low-cost background block cluster for depth only.

## Material / pixel treatment

Use the shared V1 material vocabulary and scene-only pixel-render policy. Avoid glossy PBR toy surfaces. Keep chunky texel scale consistent across concrete, painted masonry, shutters and decals. Warm amber practicals should be local pools, not global orange wash; cool navy/petrol ambient separates depth planes.

## Camera and depth

- portrait-first three-quarter / isometric-feeling authored camera;
- central stair spine must remain legible at 540×960;
- preserve at least three clear depth bands;
- foreground occlusion must not cover semantic anchors;
- avoid distant panoramic postcard framing that turns the scene into a skyline screenshot.

## Shared UI integration

City consumes the accepted DA LATA UI V1 shell from R05. Scene art must leave the persistent lower command/navigation band readable. Do not generate or bake labels into the environment; all authored UI text remains in-engine.

## Runtime acceptance checks

- City scene loads without fallback/placeholder geometry;
- all three semantic anchors route pointer/touch and keyboard/focus correctly;
- minimum touch target and accessible fallback rules remain green;
- 540×960 and 1080×1920 preserve the stair spine, rooftop cluster and local-event node;
- no literal tourist landmark, generated HUD, or flat-image substitution appears;
- board → accepted City concept → runtime comparison remains visually traceable.

## Implementation fence

T051-E may now start. T051-F/G/H/I remain ordered after implementation. R07+ remain LOCKED until R06 receives human runtime `ACCEPT` and persists `PASS`.


## Structural rebase directive — Candidate 2

Candidate 1 runtime evidence on `02ea25ea35544dafa870b378e4f1f3d10eb6a706` is `REVISE / STRUCTURAL_REBASE_REQUIRED`. CI success is retained as engineering evidence only.

CENA must now converge on the accepted concept by replacing the miniature/blockout read with:
- authored facade dressing on the stacked-house shells (doors, parapets, painted/graffiti patches and rooftop utility silhouettes);
- denser lived-in mid/foreground activity using real Godot geometry for people, planters and practical fixtures;
- stronger near/mid/far separation through shadows and a subdued far-city depth band;
- warmer painted masonry with cyan/magenta/amber retained as accents rather than full neon toy surfaces;
- a larger portrait scene field while preserving the shared DA LATA command/navigation band.

Do not change gameplay/state/persistence or semantic IDs `city/district_overlook`, `city/route_nodes`, and `city/community_cluster`. Candidate 2 must return through exact-head Validate → Visual Acceptance → LENTE before human review.

## Candidate 14 bounded night / graffiti / depth alignment — 2026-10-05

Candidate 13 exact-head evidence cleared the dominant flat-card/primitive construction failure. ARTIST therefore forbids another construction rebase unless new exact-head pixels regress. Candidate 14 is limited to the three remaining V1 deltas: inky navy tropical-night grammar with local warm practical pools, stronger graffiti/pixo relief on existing volumetric surfaces, and a denser authored far-city night band.

Implementation constraints:
- preserve Candidate 13 perspective camera, custom extruded facade/stair construction and all semantic/gameplay/state contracts;
- remove the bright daytime-blue Candidate 11 skyline from the visible stack;
- use `c14-night-city-depth.svg` only as authored surface material on custom extruded far-depth geometry, not as a flat substitute for the playable City;
- add mural/pixo as relief geometry on the existing composition rather than returning to façade cards;
- keep warm light local and cool navy ambient dominant;
- exact-head evidence must pass before ARTIST/human review.

R07+ remain LOCKED.

## Candidate 15 bounded focal-graffiti / far-depth detail — 2026-10-05

Candidate 14 exact-head pixels fix the daytime-sky regression and preserve the volumetric Candidate 13 construction. ARTIST review keeps two residual V1 deltas: graffiti/pixo still lacks dominant portrait-scale focal hierarchy, and the far-city reads too shallow/sparse despite correct night color grammar.

Candidate 15 is limited to:
- additional authored extruded far-neighborhood silhouettes between playable architecture and the Candidate 14 night band;
- roof/utility/window rhythm that reads as lived-in depth without flattening into a replacement backdrop;
- stronger relief mural/pixo surfaces in the mid/upper neighborhood, kept outside the semantic stair/hotspot contract;
- local low-energy practicals only; do not alter Candidate 14 global ambient/key/fill values.

Preserve Candidate 13 perspective camera and volumetric facades/stairs, Candidate 14 night grammar, gameplay/state/persistence, semantic IDs and shared DA LATA UI V1. No `_c10_card`, `_c8_box` or new `BoxMesh` construction is allowed in Candidate 15.

R07+ remain LOCKED until explicit human runtime `ACCEPT`.



## Candidate 16 human-reject construction/composition rebase — 2026-10-05

Candidate 15 is explicitly **HUMAN REJECTED**. Its focal-graffiti and far-depth additions remain evidence, not an accepted runtime baseline. The next attempt must change the player-facing composition materially rather than add another bounded detail layer.

Candidate 16 directives:
- restore the locked V1 `orthographic isometric / three-quarter` camera contract for the final runtime presentation;
- demote the Candidate 13 near/mid architecture and stair composition instead of continuing to decorate it;
- rebuild the visible neighborhood as stacked authored custom ArrayMesh houses in near/mid/upper tiers;
- make the central descending stair spine the dominant portrait traversal shape;
- preserve inky-night palette, authored pixel/graffiti materials and Candidate 15 lived-in far-depth evidence where compatible;
- add terrace, roof/utility, cable and local practical-light rhythm through custom extruded geometry only;
- do not use `_c10_card`, `_c8_box` or new `BoxMesh` construction inside Candidate 16;
- preserve gameplay/state/persistence, semantic IDs and DA LATA UI V1.

R07+ remain LOCKED until explicit human runtime `ACCEPT`.

## Runtime recovery fence — GAME_FROZEN

The human reported that the Candidate 15 player-facing game froze. A subsequent Candidate 16 visual commit does not supersede this functional blocker.

Before any further visual acceptance:
- rejected historical Candidate 8–10 builders and superseded Candidate 13 construction MUST NOT execute from `_ready()`;
- rejected Candidate 4–7 static roots must remain disabled at runtime;
- Candidate 13 remains source/history only; Candidate 16 owns live architecture/stair volumes, and current visual construction may stay only if the exported Web build remains responsive;
- Visual Acceptance must prove a City → Market → City input roundtrip on the exact head, in addition to screenshots;
- screenshots, LENTE, and green render checks do not constitute runtime acceptance if the input loop is frozen.

R07+ remain LOCKED.



## Candidate 17 authored-neighborhood production consolidation — 2026-10-07

**Trigger:** ARTIST exact-head review of `6ea714c1402161b5e4158b62ff86b502aa95c4b5` returned
`IMPLEMENTATION_REVISE / LOW_POLY_FORBIDDEN / VISUAL_CONSTRUCTION_REBASE_REQUIRED`.

Candidate 17 changes the production strategy rather than adding another bounded detail layer:

- one live City production stack only; rejected Candidate 11/12/14/15/16 builders are no longer executed from `_ready()`;
- five original authored pixel assets provide distinct warm/cool facade material, shopfront detail, integrated mural/pixo and far-neighborhood depth;
- visible architecture is rebuilt from irregular custom `ArrayMesh` volumes with patch relief, shopfronts, balconies, awnings, pipes, roof patches and mural relief;
- a 22-step custom-mesh stair spine restores the accepted vertical traversal silhouette;
- authored resident silhouettes, vegetation clusters, cable rhythm and bounded local practicals add lived-in scale without returning to primitive-box density;
- portrait occupancy is expanded by moving the City viewport/button band downward while preserving the lower UI-safe area;
- no `_c8_box`, `BoxMesh.new()` or Candidate-10 flat-card helper is allowed inside Candidate 17;
- gameplay/state/persistence, semantic IDs, native Godot interaction and DA LATA UI V1 remain unchanged.

Runtime history is retained in source/specs for auditability, not rebuilt into the live scene tree. This is also the runtime-recovery strategy: rejected visual experiments may not consume player-facing construction cost.

**Gate:** freeze the new exact head, then run Validate → City Visual Acceptance → Visual Acceptance with City→Market→City responsiveness → LENTE → ARTIST. Human runtime acceptance is invalid until all exact-head gates are terminal green. R07+ remain locked.


## R06 Visual Rebase A — raster pixel-surface shell — 2026-10-07

The authoritative human verdict is now **REJECT ALL / LOW_POLY_VETO** for Candidate 17. Any earlier statement that Candidate 17 is an accepted construction baseline is superseded for player-facing art.

This first full-rebase implementation slice follows the ARTIST contract `R06-CITY-V1-ARTIST-REBASE.md`:

- Candidate 17 remains only as auditable source/history and is hidden + process-disabled at runtime;
- the visible City shell is rebuilt as **five low-resolution raster PNG planes** with nearest-neighbor filtering: foreground life, near facades, mid-neighborhood, upper neighborhood and far city;
- the five planes retain real Z separation/parallax inside native Godot 3D rather than collapsing into one wallpaper;
- semantic `Area3D` hotspots, gameplay/state/persistence, DA LATA UI V1, camera contract and Cloudflare/mobile recovery remain fenced;
- the corrective raster-shell builder contains no SVG authority, `BoxMesh` generation or `_c13_extruded_polygon` construction.

This slice is **implementation evidence only**, not ARTIST acceptance and not a human visual pass. Freeze one exact head and return through `Validate → Cloudflare/mobile readiness → City Visual Acceptance → Visual Acceptance → LENTE → ARTIST`. R07+ remain locked.


## R06 Visual Rebase B — density, depth and activity modules — 2026-10-07

ARTIST exact-head review of `d60a91982d89b57939e469a050bed4f19407f273` returned **IMPLEMENTATION_REVISE**. The visible low-poly veto was cleared, but accepted-concept parity was not yet met because the five base raster layers still read as oversized cutout planes with insufficient neighborhood density and activity.

This bounded CENA slice preserves Rebase A and adds:
- **10 smaller transparent raster modules** distributed across foreground, near, mid and upper spatial depths;
- facade/window/awning/graffiti breakup in the near field;
- shop/resident/planter activity in the mid field;
- roof tank/antenna/cable rhythm in the upper field;
- railing/plant/stair-edge clutter in the foreground;
- nearest-neighbor + unshaded raster authority for every new module.

The semantic/gameplay fence is unchanged: no state, persistence, interaction ID, route behavior or DA LATA UI ownership changes. Candidate 17 remains hidden/process-disabled. This is implementation evidence only; ARTIST and human implementation acceptance remain downstream gates.
