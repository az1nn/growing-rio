# Feature 012 / R04 — Operation V1 build sheet

**Task:** T030  
**Roadmap:** R04 — Operation V1 production scene  
**Renderer:** `GODOT_NATIVE_V1`  
**Concept state:** `CONCEPT_ACCEPTED`

## Immutable visual authority

- Global ARTIST V1 board SHA-256: `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`.
- Accepted Operation concept: `assets/art-direction/v1/scenes/operation.webp`.
- Accepted concept SHA-256: `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce`.
- ARTIST run: `20260930T103636Z/operation`.
- Human concept decision: `ACCEPT`, 2026-09-30.
- Written authority: `docs/art-direction/ARTIST-V1-STYLE.md`, `docs/art-direction/v1/README.md`, `docs/art-direction/v1/BASE-PROMPT.md`, `docs/art-direction/v1/SCENES.json`.

The board/written guide outrank incidental generated details. The accepted concept is the per-scene composition target. Runtime acceptance remains separate.

## Production composition

### Camera / silhouette

Target: compact portrait-first three-quarter cutaway workshop.

Current production camera starts from the existing orthographic Operation framing and may be tuned only to satisfy:
- complete workshop silhouette at 540×960 and 1080×1920;
- readable foreground apron without consuming the lower 20–25% UI-safe region;
- three interaction clusters visually separated;
- no flat reference-image substitution.

The shell must read as an invented worn urban workshop: open-roof/cutaway mass, concrete/tile floor, back wall, side wall, rolling-shutter/metal-door mass, exposed utility silhouettes and a foreground threshold.

### Three physical focal anchors

| V1 focus | Runtime physical cluster | Semantic contract | Normalized target zone |
| --- | --- | --- | --- |
| workbench | rough counter/worktop + tools/storage silhouette | management/operation context remains presentation-only unless routed through existing surface logic | left_focus |
| abstract plants | existing planter/canopy cluster, kept deliberately fictional and non-instructional | existing `plant_cluster` pointer/touch + accessible fallback | center_focus |
| inventory shelves | shelves/bins/crates cluster | existing `management_storage` pointer/touch + accessible fallback | right_focus |

No new gameplay state API is introduced by the visual pass.

## Geometry decomposition

### T031 — architectural shell + camera
- floor + foreground apron/threshold;
- back/side walls with layered reveals;
- shutter/door mass;
- exposed pipe/utility silhouettes;
- orthographic portrait composition;
- use shared V1 structural/worn/painted material roles.

### T032 — workbench cluster
- rough timber worktop/counter;
- blocky storage below/behind;
- readable tool/prop silhouettes without operational instructions;
- warm practical-light focal support.

### T033 — abstract plant cluster
- preserve three abstract planters/canopies;
- foliage stays stylized/fictional, not botanically instructional;
- center-zone silhouette remains independently clickable.

### T034 — inventory-shelf cluster
- shelving verticals/horizontals;
- modular bins/crates;
- right/side readable silhouette;
- preserve management hotspot + button fallback.

### T035 — graffiti / pixel / material / lighting
- apply `V1PixelRenderPolicy` to the scene SubViewport only; authored UI stays full resolution;
- use `V1MaterialVocabulary` roles: `structural_dark`, `petrol_shadow`, `worn_concrete`, `repaired_wood`, `painted_metal`, `foliage_muted`;
- accents: controlled `accent_magenta`, `accent_cyan`, `accent_amber`;
- physical crown/tag/stencil surface uses the shared V1 graffiti pipeline;
- no glossy showroom/PBR look, no generic low-poly palette.

## Lighting contract

- dominant dark ink/navy structural read;
- restrained cyan/magenta accents;
- amber practical focal light;
- no shadow configuration that breaks Web/mobile stability without measured evidence;
- preserve legibility of clickable silhouettes at portrait width.

## Interaction preservation

R04 must keep:
- `Viewport.physics_object_picking = true`;
- pointer mouse activation for existing hotspots;
- touch activation for existing hotspots;
- `ObjectActionButton` accessible fallback;
- `ManagementActionButton` accessible fallback;
- emitted semantic IDs `plant_cluster` and `management_storage`.

A third visible visual focus does not authorize inventing a third gameplay action.

## Pixel / UI boundary

The scene is allowed to render at the shared 2× scene-only shrink baseline with nearest filtering. UI labels/buttons remain outside that reduced-resolution presentation boundary at full resolution.

Acceptance must confirm the apparent pixel density reads intentional rather than as a blurred/downscaled generic 3D scene.

## Safe-area contract

- lower 20–25% of portrait frame must remain usable by authored UI;
- 3D focal anchors should remain above the fallback buttons;
- no concept-image text is baked into runtime geometry/textures;
- interaction targets remain sufficiently separated for touch.

## Explicitly excluded

- Three.js production bridge or renderer reversal;
- flat concept image used as runtime wallpaper;
- real location/brand/political imagery;
- operational cultivation instructions;
- Market/R05 or any later scene implementation;
- Finale PR #189 work.

## Verification sequence

1. repository structural validation;
2. Operation scene-load / semantic-hotspot regression;
3. exact-head Web export if touched runtime requires it;
4. LENTE isolated/full-page at 540×960 and 1080×1920;
5. compare board + accepted concept + AFTER;
6. ARTIST/CENA runtime decision `ACCEPT` or `REVISE`;
7. only then mark R04 `PASS`.

## Current implementation delta

The existing Operation scene already contains real 3D shell, camera, workbench-like counter, abstract plants, storage/crates, pointer/touch picking and accessible fallbacks. R04 therefore refines/rebuilds that geometry into the accepted V1 language rather than replacing gameplay ownership.

The first runtime slice after this sheet is T031: bind the existing shell/camera to the R03 V1 pixel/material system while preserving exact semantic interaction contracts.


## Structural rebase checkpoint — after Rev13

Rev13 exact-head evidence was structurally rejected against the accepted Operation concept.

**Execution substate:** `STRUCTURAL_REBASE_REQUIRED`.

The next implementation is not Revision 14 and does not stack another dressing generation on the rejected scaffold. The visible layer is rebuilt from the accepted concept on current `master` guardrails:

- hide the superseded direct visual meshes while retaining canonical Area3D interaction ownership;
- create a new `OperationV1AcceptedRebuild` visual root;
- enforce the accepted silhouette: left/back vertical garden, center workbench, right/back packed supply wall;
- place the amber crown on a dedicated back-wall field that survives portrait HUD occupancy;
- use small repeated masonry, foliage, supply and floor units with nearest-sampled material textures;
- retain Godot 4.7.2 / GL Compatibility, scene-only pixel shrink, semantic IDs, pointer/touch picking and accessible fallbacks.

This checkpoint reopens T031–T039 under the structural rebase; it does not unlock R05.
