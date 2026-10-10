# DA LATA — Visual Direction

Status: **baseline / to be evolved by CENA**

This document is the canonical repository-local visual-direction surface for player-facing assets and scenes. It records durable visual decisions. Temporary execution state belongs in `docs/CENA-HANDOFF.md`.

## Approved V1 hard gate — low-poly is rejected

The accepted DA LATA V1 target is **PIXEL ART × GRAFFITI × URBAN ISOMETRIC 3D**. **Low-poly is not an accepted final style.**

Primitive/blockout geometry is allowed only as temporary construction scaffolding for composition, collision and interaction work. It cannot pass CENA, ARTIST, LENTE or human visual acceptance while the rendered scene still reads as low-poly, toy-like faceted geometry, primitive boxes, smooth flat color masses or placeholder surfaces.

For visual acceptance, authored surface language is mandatory: pixel-oriented material/texture breakup, patched masonry/tile/metal, expressive graffiti/mural planes, layered silhouettes and lived-in environmental detail appropriate to the approved scene concept. When a candidate still reads low-poly, the required action is a **visual construction rebase**, not another primitive-density pass.

For R06 City, the human-approved concept `20261004T110406Z/city` is the fixed target. A low-poly miniature interpretation is a hard rejection even when engineering gates are green.

## Product context
DA LATA is a portrait-oriented Brazilian management / narrative simulation built in Godot. The current gameplay loop is functional and UI-led; the visual direction must add place, atmosphere and material identity without destroying the clarity of the management interface.

## Current technical frame
- Godot: 4.7.x project
- renderer: GL Compatibility
- primary viewport: 1080x1920 portrait
- window override: 540x960
- Web/mobile delivery matters
- existing gameplay UI is `Control` based

## Direction principles

### 1. 2D/3D hybrid first
Do not begin with a full free-roaming 3D redesign.

The initial target is a **3D diorama / environment presentation layer** behind or around the existing management interface. The player should feel that systems happen in a physical place while the interface remains fast and readable.

### 2. Rio-inspired, not postcard Rio
Use architecture, humidity, density, improvised layering, concrete, tile, painted metal, vegetation, sodium/warm interior light and Atlantic daylight as research axes where they fit the fictional world.

Avoid turning every frame into a tourist landmark collage.

### 3. Material vocabulary before asset quantity
Prefer a restrained reusable palette:
- painted/plastered masonry;
- concrete;
- aged ceramic/tile;
- painted metal;
- simple wood/laminate;
- glass/plastic;
- vegetation accents.

Exact palette and surface values must be refined by CENA research.

### 4. Lighting carries mood
Favor one dominant readable lighting idea per scene rather than many dynamic lights.

Early grow-space slice should test:
- clear key/fill separation;
- atmospheric warmth/coolness;
- readable silhouettes;
- enough contrast to remain legible behind portrait UI;
- GL Compatibility/Web/mobile cost.

### 5. Environmental storytelling follows canon
Props and dressing should reinforce existing world/lore instead of introducing facts accidentally.

Examples of safe categories:
- wear, repairs and reuse;
- notebooks, generic labels, storage objects;
- fictional packaging/signage already supported by canon;
- plants/containers only at the level needed for visual fiction.

Do not add operational real-world cultivation instruction through labels, diagrams, measurements or equipment setup.

### 6. Coherent stylization beats mismatched realism
The game should not look like a collection of unrelated marketplace assets.

When mixing sources, normalize:
- scale;
- roughness/material response;
- saturation/contrast;
- texel density;
- lighting response;
- silhouette complexity.

## Initial scene target

### Grow-space / operation diorama
Purpose: prove the visual language without changing gameplay semantics.

Minimum scene ingredients:
- a room/environment shell;
- one deliberate Camera3D;
- WorldEnvironment;
- one primary light plus only necessary support lights;
- simple modular surfaces;
- a restrained prop set;
- existing management UI preserved as readable presentation.

Blockout/procedural primitives may be used only during internal construction when that is faster and safer than importing a large asset pack. They must be replaced or visually transformed before any production-candidate or human visual-acceptance gate; visible low-poly/blockout read is rejected.

## Asset quality tiers

### BLOCKOUT
Spatial proof using primitives/basic materials. Acceptable during scene composition.

### PRODUCTION-CANDIDATE
Correct scale, provenance, material/import settings and acceptable performance.

### PRODUCTION
Integrated, validated, visually coherent, documented and accepted by the current CENA wave.

CENA must not call a concept image or moodboard a production 3D asset.

## Provenance requirements
Third-party runtime assets require:
- source;
- author/provider;
- license;
- local path;
- modifications;
- attribution requirement.

Unknown-license assets do not enter production.

## Performance heuristics
Until profiling establishes tighter budgets:
- prefer simple geometry for structural forms;
- reuse materials;
- avoid gratuitous transparency;
- constrain texture resolution to visible need;
- minimize dynamic lights;
- favor static presentation over expensive real-time effects;
- validate in Web/mobile-oriented GL Compatibility.

These are heuristics, not hard numeric budgets. CENA should replace them with measured constraints when real scene profiling exists.

## Open visual decisions
CENA research should resolve, through playable prototypes rather than prose alone:
- exact stylization level;
- dominant camera angle/lens language;
- final color/material palette;
- how much of the UI becomes diegetic vs overlay;
- whether later locations reuse a modular diorama grammar;
- the boundary between realistic Rio reference and fictionalized city identity.

## Ownership
- **CENA** owns visual research, assets, materials, lighting, cameras, scene composition and visual adaptation.
- **LORE** owns canon and narrative meaning.
- **SIGA** owns cross-cutting engineering/product continuation.


## CENA research decision — operation diorama v1

Date: 2026-09-23

### Reference question
How can the first DA LATA environment feel recognizably urban/Rio-adjacent without becoming a postcard, while remaining readable in portrait UI and cheap enough for Godot Compatibility/Web?

### Factual / technical references
- Godot 4.7 Camera3D docs: https://docs.godotengine.org/en/4.7/classes/class_camera3d.html
  - Decision: use orthographic projection with `KEEP_WIDTH` because the project is portrait-oriented and the composition should remain stable across tall aspect ratios.
- Godot renderer overview: https://docs.godotengine.org/en/latest/tutorials/rendering/renderers.html
  - Decision: keep `gl_compatibility`; Web requires Compatibility and the first slice does not need advanced renderer features.
- Godot 3D optimization guide: https://docs.godotengine.org/en/latest/tutorials/performance/optimizing_3d_performance.html
  - Decision: primitive geometry, reused materials, no shadow-casting lights in the first proof.
- Godot internal rendering architecture: https://docs.godotengine.org/en/4.7/engine_details/architecture/internal_rendering_architecture.html
  - Decision: one DirectionalLight3D plus one non-shadowed OmniLight3D; avoid a light-heavy composition.

### Architectural / material references
Reference-only imagery, not imported assets:
- Huma Arquitetura, Apartment IPA, Rio de Janeiro (Architizer): exposed concrete + saturated ceramic tile + warm wood.
  - https://architizer.com/idea/3902201/
- Flamengo apartment renovation (Revista Habitare): concrete structure + green tile + warm timber and daylight.
  - https://www.revistahabitare.com.br/post/reforma-transforma-apartamento-no-flamengo-em-espa%C3%A7o-moderno
- Laranjeiras apartment renovation (YouCanFind): warm timber, painted metal/beam language, compact layered urban interior.
  - https://www.youcanfind.com.br/postagem/arquitetura/interiores/ape-antigo-inspira-com-decor-e-afeto-1706016261

### Implemented visual grammar
- Orthographic three-quarter diorama.
- Dark concrete shell.
- Deep teal ceramic/tile accent.
- Dark painted metal.
- Warm wood.
- Terracotta + restrained green as living accents.
- Cool ambient/key light with one warm practical.
- UI remains a non-diegetic overlay with a translucent atmospheric veil for legibility.
- Runtime geometry is Godot-native and original; no third-party production asset is imported.

### Asset status
- Room shell: `ORIGINAL / BLOCKOUT`
- Counter/worktop: `ORIGINAL / BLOCKOUT`
- Shelf/storage: `ORIGINAL / BLOCKOUT`
- Abstract planters/canopies: `ORIGINAL / BLOCKOUT`
- Materials: `ORIGINAL / BLOCKOUT`
- Lighting/environment/camera: `ORIGINAL / PRODUCTION-CANDIDATE`

This wave intentionally proves composition and material language before any external mesh or texture sourcing.


## CENA production-candidate pass — reusable material vocabulary

Date: 2026-09-23

Wave 002 promotes the operation diorama from an all-inline blockout toward a reusable scene grammar without third-party runtime assets.

### Decisions
- Seven core surfaces become reusable resources under `resources/visual/materials/`.
- Preserve concrete / teal tile / dark metal / warm wood / terracotta / foliage / cool glass.
- Replace cube planter/canopy placeholders with low-segment cylindrical and spherical silhouettes.
- Add restrained window trim and service-pipe dressing using the same material vocabulary.
- Keep shadowless two-light strategy and Compatibility/Web constraints.

### Promotion status
- reusable materials: `ORIGINAL / PRODUCTION-CANDIDATE`
- planter/canopy geometry: `ORIGINAL / PRODUCTION-CANDIDATE`
- architectural trim/service-pipe dressing: `ORIGINAL / PRODUCTION-CANDIDATE`
- room shell/counter/shelves/crates remain `ORIGINAL / BLOCKOUT`

No external license or attribution dependency is introduced.


## CENA production-candidate pass — fixture silhouettes

Date: 2026-09-23

Wave 003 keeps the proven camera/light/material grammar and targets the highest-impact remaining fixture blockouts: the operation counter and storage shelving.

### Reference question
How can the operation diorama gain believable urban/service-room structure without importing a mismatched asset pack or increasing Web/mobile rendering cost materially?

### Reference-only architecture evidence
No referenced image, mesh or texture is copied into the runtime.

- Apartamento Cosme Velho / Venta Arquitetos, Rio de Janeiro — concrete work surface, integrated shelving/cabinetry and exposed metallic electrical conduit:
  https://www.archdaily.com.br/pt/1042780/apartamento-cosme-velho-venta-arquitetos
- Flamengo Apartment / Nop Arquitetura, Rio de Janeiro — demountable metalwork shelving as a lightweight interior fixture:
  https://www.archdaily.com/957602/flamengo-apartment-nop-arquitetura
- FM Apartment / Zanatta Figueiredo — exposed concrete plus custom steel shelving used as a deliberate structural/visual element:
  https://www.archdaily.com/1064144/fm-apartment-zanatta-figueiredo

### Implementation decision
- keep all runtime geometry repository-authored and Godot-native;
- preserve the existing tiled counter mass and warm worktop, adding repeated cabinet-front/handle rhythm for readable scale;
- reinforce the shelving silhouette with crossed dark-metal bracing;
- add small reusable storage-bin volumes using the existing material vocabulary;
- do not add textures, transparency, shadow-casting lights or imported meshes in this wave;
- preserve the portrait orthographic composition and non-diegetic UI overlay.

### Promotion status
- counter fixture detailing: `ORIGINAL / PRODUCTION-CANDIDATE`
- shelving bracing: `ORIGINAL / PRODUCTION-CANDIDATE`
- shelf storage-bin silhouettes: `ORIGINAL / PRODUCTION-CANDIDATE`
- storage crates and structural room shell remain `ORIGINAL / BLOCKOUT`

Third-party runtime assets: **none**.
License/attribution dependency: **none**.

## CENA production-candidate pass — room shell + storage crates

Date: 2026-09-23

Wave 004 continues the established operation-diorama grammar after exact-head validation of wave 003. No new external runtime asset is introduced; this pass deliberately reuses the existing reference set, material vocabulary and low-cost Godot-native geometry.

### Reconciled research decision
- the existing Rio-adjacent architecture references already establish the target language: exposed structural surfaces, dark painted metal, restrained warm timber and compact layered fixtures;
- the remaining high-impact visual debt is not a missing style reference but the flatness of the room shell and the two solid storage-crate blockouts;
- therefore this wave does not broaden the moodboard or import a marketplace pack: it applies the already-approved grammar to those remaining silhouettes.

### Implementation decision
- break the room-shell planes with dark-metal baseboard and doorway framing using existing trim geometry;
- promote both storage crates with contrasting front-frame/slat silhouettes built from the existing handle mesh;
- preserve all established camera, environment, two-light and portrait-overlay contracts;
- add no texture sampling, transparency, imported mesh, shadow-casting light or gameplay-affecting node.

### Promotion status
- room-shell trim / doorway framing: `ORIGINAL / PRODUCTION-CANDIDATE`
- storage-crate silhouette detailing: `ORIGINAL / PRODUCTION-CANDIDATE`
- core wall/floor masses remain `ORIGINAL / BLOCKOUT` pending screenshot/device acceptance

Third-party runtime assets: **none**.
License/attribution dependency: **none**.



## CENA production-candidate pass — shell surface breakup

Date: 2026-09-24

Wave 005 targets the largest remaining blockout surfaces in the operation diorama. The existing Rio-adjacent reference set and material grammar are sufficient, so this pass does not expand the moodboard or introduce external assets.

### Implementation decision
- separate wall finish from the concrete floor with one reusable warm-plaster material;
- add restrained teal lower-wall bands to break broad flat planes without textures;
- add a dark-metal doorway threshold to reinforce the already-established frame language;
- preserve the orthographic portrait camera, WorldEnvironment, two-light setup, UI overlay and GL Compatibility/Web constraints.

### Promotion status
- wall finish / lower-wall breakup: `ORIGINAL / PRODUCTION-CANDIDATE`
- doorway threshold: `ORIGINAL / PRODUCTION-CANDIDATE`
- floor mass: remains `ORIGINAL / BLOCKOUT` pending screenshot/device acceptance

Third-party runtime assets: **none**.
License/attribution dependency: **none**.


## Abstract foliage silhouette grammar

For the operation diorama, player-facing vegetation should read as layered low-poly masses rather than single spherical placeholders. Reuse the established foliage material and inexpensive primitive geometry before introducing texture-heavy or botanically specific assets.

This remains presentation-only:
- no labels, measurements or equipment layout;
- no botanical instruction encoded through scene dressing;
- preserve Web/mobile GL Compatibility constraints;
- prioritize silhouette separation behind the portrait UI.

## CENA production-candidate pass — floor surface rhythm

Date: 2026-09-24

Wave 008 follows the accepted Wave 007 lighting calibration and targets the largest explicitly retained operation-diorama blockout surface: the concrete floor.

### Reconciled decision
- rendered acceptance already established that the current camera, lighting, compositing path and restrained material vocabulary are readable at 540x960 and 1080x1920;
- the floor remained the most prominent surface still recorded as `ORIGINAL / BLOCKOUT`;
- no new moodboard, texture source or external mesh is needed for this bounded promotion.

### Implementation decision
- preserve the existing concrete slab, camera, WorldEnvironment and two-light grammar;
- add four low-profile dark-metal floor joints/inlays using the existing trim mesh and metal material;
- use three transverse joints plus one offset longitudinal spine to break the large uninterrupted plane and reinforce the diorama scale;
- keep the joints slightly above the slab surface to avoid coplanar z-fighting;
- introduce no texture, shader, transparency, imported mesh, extra light or gameplay-affecting node.

### Promotion status
- floor surface rhythm / joint detailing: `ORIGINAL / PRODUCTION-CANDIDATE`
- underlying structural slab: unchanged
- third-party runtime assets: **none**
- license/attribution dependency: **none**

## CENA production-candidate pass — wall bay rhythm

Date: 2026-09-24

Wave 009 follows exact-head acceptance of the floor-surface promotion and targets the remaining explicitly blockout architectural family: the core wall masses.

### Reconciled decision
- CENA-008 exact-head validation passed for `25ce7440d62b86480ad4bcc5e831da589ec93e9e`;
- rendered 540x960 and 1080x1920 captures show the floor rhythm reading beneath the foreground UI without becoming the focal point;
- the perimeter wall planes remain the largest visually uninterrupted structural masses after the accepted shell finish, tile band, doorway frame and baseboard passes;
- the established Rio-adjacent architecture references and existing dark-metal/plaster vocabulary are sufficient, so no new external research or asset source is required.

### Implementation decision
- preserve the BackWall and SideWall structural meshes, warm-plaster finish, teal lower-wall bands, doorway/window framing, camera, environment and two-light grammar;
- add one restrained back-wall bay reveal between the door/window zones, one edge reveal, and two side-wall vertical reveals;
- reuse the existing `Mesh_trim_vertical` geometry and dark-metal material;
- keep all reveals slightly inside the room-facing wall surface to add depth without coplanar overlap;
- introduce no texture, shader, transparency, imported mesh, extra light, gameplay-affecting node or UI-layout change.

### Promotion status
- wall bay / perimeter reveal rhythm: `ORIGINAL / PRODUCTION-CANDIDATE`
- structural wall masses: unchanged
- third-party runtime assets: **none**
- license/attribution dependency: **none**



## CENA production-candidate pass — window pane rhythm

Date: 2026-09-24

Wave 010 follows rendered acceptance of the wall-bay treatment and targets the remaining large uninterrupted glazing plane visible in the operation diorama.

### Reconciled decision
- Wave 009 exact-head validation and visual capture passed on `71d55bf2d3e0c4ae6f8e52d8cbf1a089efce62ca`;
- the 540x960 and 1080x1920 renders preserve the accepted composition with no obvious clipping/z-fighting;
- the blue `WindowPanel` remains a visually broad single plane after perimeter framing and wall-reveal promotion;
- the established architecture/material grammar is sufficient, so no external asset or new visual reference is needed.

### Implementation decision
- preserve the existing glazing panel and perimeter window trim;
- add one centered vertical mullion and one centered horizontal transom;
- reuse the existing dark-metal material and trim meshes;
- place the mullions in front of the glazing plane to maintain clear depth separation;
- introduce no texture, shader, transparency change, imported mesh, extra light or gameplay-affecting node.

### Promotion status
- window pane / mullion rhythm: `ORIGINAL / PRODUCTION-CANDIDATE`;
- underlying window panel: unchanged;
- third-party runtime assets: **none**;
- license/attribution dependency: **none**.


## CENA production-candidate pass — planter rim rhythm

Date: 2026-09-24

Wave 011 follows exact-head rendered acceptance of the window-pane treatment and targets the most visible remaining repeated prop silhouette in the operation diorama: the three terracotta planters.

### Reconciled decision
- Wave 010 exact-head repository validation and visual capture passed on `b902cd730480cdfdac076b47a4294ebf0cc71570`;
- the 540x960 and 1080x1920 captures preserve the accepted room composition, and the window now reads as a restrained four-pane element without obscuring foreground UI;
- the fixture, wall, floor and glazing families now carry production-candidate rhythm, while the planter vessels still read as simple single-mass cylinders beneath the already-layered foliage;
- the established material vocabulary is sufficient, so no external research, texture or asset source is needed.

### Implementation decision
- preserve planter positions, canopy/stem composition, camera, lighting and UI overlay;
- add one shallow lip/rim to each planter using a new low-segment `CylinderMesh`;
- reuse the existing terracotta material so the change improves silhouette/readable scale without adding a new material family;
- introduce no texture, shader, imported mesh, extra light, gameplay-affecting node or botanical instruction.

### Promotion status
- planter vessel rim rhythm: `ORIGINAL / PRODUCTION-CANDIDATE`;
- foliage silhouette grammar: unchanged;
- third-party runtime assets: **none**;
- license/attribution dependency: **none**.


## RB-13 / CENA wave 012 — shared shell visual system

Date: 2026-09-24

### Reconciled visual debt audit
- CENA waves 002-011 already promoted the operation material vocabulary, fixture silhouettes, room-shell details, foliage, lighting, floor rhythm, wall rhythm, glazing and planter silhouettes to production-candidate treatment.
- RB-12 stabilizes contextual 3D hosting/fallback without changing presentation semantics.
- The highest-impact remaining cross-surface inconsistency is the shell/UI layer: default control styling still reads separately from the accepted diorama palette and lacks one reusable focus/panel/button treatment.

### Implementation decision
- introduce one repository-authored Theme resource shared by GameShell and standalone Main;
- carry the established cool charcoal / teal / warm neutral palette into buttons, labels and panels;
- keep visible keyboard/controller focus as a non-color-only outline layer over the base style;
- preserve existing typography hierarchy overrides, layout, navigation labels, destination text, domain behavior and 3D composition;
- add no external font, image, texture, icon or third-party runtime asset.

### Promotion status
- shared shell button/panel/label treatment: `ORIGINAL / PRODUCTION-CANDIDATE`;
- focus treatment: `ORIGINAL / PRODUCTION-CANDIDATE`;
- OperationDiorama asset families: retain previously accepted production-candidate status;
- final portrait/wide/fallback acceptance: pending fresh exact-head capture.

Third-party runtime assets: **none**.
License/attribution dependency: **none**.


### Responsive/readability slice

- portrait navigation uses a three-column wrapped grid so labels remain readable at the 540x960 target instead of compressing five destinations into one row;
- global campaign status uses three columns in portrait and five columns in wide layout;
- navigation targets retain 64px minimum height and the shared Theme focus outline provides a non-color-only keyboard/controller cue;
- no motion/transition delay is introduced for critical navigation input;
- SurfaceHost minimum height is reduced from 640 to 560 so the wrapped portrait navigation and two-row status remain inside the target viewport budget;
- this slice adds no external assets and no new runtime 3D cost.


## CENA Wave 013 — compact portrait HUD calibration

### Evidence
The latest accepted RB-13 visual capture retained one concrete responsive debt at 540x960: the top HUD and compact shell copy were materially denser than the wide presentation. RB-14/RB-15 are now ancestors of live `master`, no open PR owns the shell substrate, and the operation diorama/compositing contract is already accepted.

### Decision
Keep the existing shell information hierarchy and navigation semantics, but introduce one narrow portrait-density mode at viewport widths `<= 600px`:
- reduce outer shell margins from 16/18px to 12px;
- reduce header/layout spacing;
- reduce the DA LATA title and destination-label sizes without hiding either;
- reduce Campaign button minimum footprint while retaining a 44px minimum height;
- compact the five global-status labels to shorter two-line forms and 16px type;
- preserve the 3-column portrait status/navigation structure, focus affordances, destination order and all campaign semantics.

### Boundaries
No gameplay, persistence, campaign progression, navigation destination, diorama geometry, lighting, material, lore/canon or external asset changes.

### Validation target
Require exact-head repository/Godot validation plus rendered acceptance at 540x960 and 1080x1920. The compact mode must reduce top-HUD crowding at 540x960 while the 1080x1920 composition remains unchanged in hierarchy and readability.


### Wave 013 capture correction
The first 540x960 capture proved that logical viewport width is not the same as rendered Web canvas width in this project. Responsive density selection must therefore use the physical window/canvas size for runtime presentation. The accepted visual target remains unchanged: compact only the 540px presentation while preserving the 1080px hierarchy.


## CENA Wave 014 — embedded diorama breathing room

Date: 2026-09-25

### Evidence
Final Wave 013 portrait captures show that the shell-level HUD density is accepted, but the embedded legacy event log still behaves like a full-height content surface. A single short event sentence sits inside a large expanding opaque panel, reducing the visible contribution of the already-accepted OperationDiorama.

### Decision
- keep the event/log message visible;
- in shell-embedded Main only, cap the log panel to a 96px minimum visual band;
- remove its vertical expansion claim so unused SurfaceHost space exposes the diorama instead of an empty panel;
- preserve the existing Theme, veil, camera, lighting, material grammar, operation controls, navigation and standalone Main layout.

### Promotion status
- embedded operation composition / foreground-to-diorama balance: `ORIGINAL / PRODUCTION-CANDIDATE`;
- runtime assets introduced: **none**;
- third-party assets: **none**;
- license/attribution dependency: **none**.


## CENA Wave 015 — lightweight feedback overlays

Date: 2026-09-25

### Evidence
The accepted Wave 014 captures confirm that the embedded event log no longer expands through the SurfaceHost, but two full-width informational surfaces remain visually heavier than their content: the operation FeedbackPanel and the legacy event LogPanel. Both use the global opaque panel treatment over the accepted diorama, so the foreground still masks room detail more than necessary.

### Decision
- preserve both feedback messages, dimensions, interaction semantics and layout ownership;
- introduce one repository-authored translucent overlay StyleBox for low-priority informational bands;
- apply it only to OperationSurface FeedbackPanel and embedded/standalone LogPanel;
- retain readable label shadow, teal border language and the accepted shared Theme;
- make no camera, geometry, lighting, gameplay, persistence, navigation or canon change.

### Promotion status
- low-priority feedback overlay treatment: `ORIGINAL / PRODUCTION-CANDIDATE`;
- runtime visual resource: `resources/ui/dalata_overlay_panel.tres`;
- third-party assets: **none**;
- license/attribution dependency: **none**.

### Validation target
Require exact-head repository validation plus rendered acceptance at 540x960 and 1080x1920. Both feedback bands must remain readable while materially more of the diorama is perceptible through them, with no clipping, contrast regression or input change.


## CENA Wave 016 — foreground floor depth

### Evidence
The accepted CENA-015 render at 540x960 and 1080x1920 keeps the OperationDiorama readable after the translucent feedback pass, but the orthographic room floor terminates well before the portrait navigation. That leaves a large featureless environment-background band beneath the player-visible room, most pronounced at 1080x1920.

### Decision
Use the existing accepted camera, lighting and material grammar. Extend only the presentation floor toward the foreground so portrait height is used by the established room instead of by empty background.

Implementation contract:
- preserve the rear floor edge by increasing the floor depth from 8 to 11 and shifting its center from z=0 to z=1.5;
- continue the accepted dark-metal floor-joint rhythm with one foreground transverse joint;
- recenter and extend the existing longitudinal floor joint across the promoted surface;
- do not change Camera3D transform/projection, walls, props, UI, navigation, gameplay or save state.

Runtime assets introduced: **none**.
Third-party assets: **none**.
License/attribution dependency: **none**.

### Acceptance
Require exact-head Validate project plus rendered acceptance at 540x960 and 1080x1920. The extended floor must materially reduce the dead lower portrait band while keeping the room silhouette, controls and navigation unclipped. Any crop, foreground dominance or readability regression rejects the wave.


## CENA Wave 017 — foreground apron transition

### Evidence
The final exact-head Wave 016 captures at 540x960 and 1080x1920 confirm that the promoted room floor reduces the lower dead band, but a large uninterrupted environment-background band still remains between the visible floor termination and bottom navigation. The gap is most pronounced at 1080x1920.

Wave 016 already proved that simply increasing the main room floor helps, so this slice avoids turning the whole lower viewport into more identical slab. Instead it adds a shallow stepped foreground apron that makes the room termination intentional and carries the accepted surface language farther toward navigation.

### Decision
- preserve the accepted main floor depth, camera transform/projection, lighting, walls, props, shell UI and navigation;
- add one narrower concrete apron immediately beyond the main floor;
- step the apron slightly below the room slab so the boundary reads as a deliberate foreground transition rather than one oversized floor plane;
- reuse the existing dark-metal trim as a terminal edge;
- add no external asset, texture, shader, material family, light, gameplay node or persistence behavior.

### Promotion status
- foreground apron transition: `ORIGINAL / PRODUCTION-CANDIDATE`;
- runtime assets introduced: **none**;
- third-party assets: **none**;
- license/attribution dependency: **none**.

### Acceptance
Require exact-head Validate project plus rendered acceptance at 540x960 and 1080x1920. The residual black band should be materially reduced while the apron remains subordinate to the room, does not collide with portrait navigation, and introduces no clipping or z-fighting.


## CENA Wave 018 — foreground service plinth

Date: 2026-09-25

### Evidence
The exact-head Wave 017 visual artifact `10864491967` passes at 540x960 and 1080x1920 with an empty browser-console artifact. The stepped apron reads cleanly and does not collide with navigation, but a substantial uninterrupted environment-background band still remains below its terminal edge, especially in the 1080x1920 capture.

### Decision
- preserve the accepted camera transform/projection, lighting, room floor, Wave 017 apron, walls, props, shell UI and navigation;
- add one narrower recessed concrete service plinth immediately beyond the apron rather than growing the main slab again;
- reuse the existing dark-metal trim vocabulary as two longitudinal service rails plus a terminal edge;
- keep the plinth subordinate to the room and validate that it approaches, but does not collide with, portrait navigation;
- add no external asset, texture, shader, material family, light, gameplay node or persistence behavior.

### Promotion status
- foreground service plinth: `ORIGINAL / PRODUCTION-CANDIDATE`;
- runtime assets introduced: **none**;
- third-party assets: **none**;
- license/attribution dependency: **none**.

### Acceptance
Require exact-head Validate project plus rendered acceptance at 540x960 and 1080x1920. The remaining black band must be materially reduced while the new plinth remains visually secondary, preserves the accepted room silhouette, and introduces no clipping, z-fighting or navigation collision.


## CENA Wave 019 — foreground service landing

Date: 2026-09-26

### Evidence
CENA Wave 018 is internally accepted on exact PR head `e08b3d9478b1cc769cf54653b489d807113df3eb`:
- Validate project run `36147983862` / #471: **SUCCESS**;
- Visual acceptance capture run `36147983931` / #103: **SUCCESS**;
- rendered artifact: `10870338522`;
- browser console/page-error artifact: **empty**;
- Vercel remains explicit `api-deployments-free-per-day` / `SOFT_GATE_RATE_LIMIT`.

Rendered inspection confirms that the recessed Wave 018 service plinth is readable at 540x960 and 1080x1920 without clipping, z-fighting or navigation collision. A substantial uninterrupted environment-background band still remains beyond its terminal edge, most visibly in the 1080x1920 capture.

### Decision
Finish this foreground progression with one narrower, lower service landing rather than expanding the main room slab again:
- preserve Camera3D transform/projection, lighting, walls, props, shell layout, navigation and all accepted Wave 016-018 geometry;
- add a 4.6 x 3.6 recessed concrete landing immediately beyond the Wave 018 plinth;
- step it lower than the plinth so the foreground remains layered and visually subordinate;
- terminate it with one reused dark-metal edge;
- add no external asset, texture, shader, material family, light, gameplay node, persistence behavior or lore/canon change.

### Promotion status
- terminal foreground service landing: `ORIGINAL / PRODUCTION-CANDIDATE`;
- runtime assets introduced: **none**;
- third-party assets: **none**;
- license/attribution dependency: **none**.

### Acceptance
Require exact-head Validate project plus rendered acceptance at 540x960 and 1080x1920. The remaining lower environment band should be materially reduced without turning the foreground into a dominant slab, clipping the room, colliding with portrait navigation or introducing z-fighting.


## 3JS-002 grow-room reference convergence — candidate style lock

Date: 2026-09-26

The project owner supplied a new visual-reference set specifically to drive the Three.js grow-room pass. The repository copy lives at:

`docs/visual-references/3js-grow-room/`

These images are **reference-only** and are not runtime assets. Their ownership/license is not established by the repository, so no source asset, logo, UI, sprite, branded element, proprietary prop or exact layout may be copied into DA LATA.

### Candidate direction to prove

The grow room should test an original DA LATA synthesis:

- fixed orthographic / near-isometric room-as-diorama composition;
- chunky low-poly geometry with pixel-art discipline in silhouette and surface detail;
- dense but deliberate prop clustering so the room feels authored rather than like an empty blockout;
- miniature depth cues and softened distance, without blurring focal/interactable content;
- darker room envelope with selective warm practical focal light and cooler separation/fill;
- existing DA LATA material identity carried forward through concrete/plaster, dark metal, warm wood, terracotta and restrained vegetation;
- portrait-first readability and clear UI-over-3D contrast.

### Style-lock gate

This is **CANDIDATE** direction.

The grow room is now the style-governing validation scene. No later screen should be visually rebuilt around this direction until the exact-head 3JS-002 grow-room captures pass the explicit ACCEPT/REVISE review.

On **ACCEPT**, the proven camera/material/lighting/scale/detail tokens are persisted here as the definitive reusable baseline.

On **REVISE**, further visual work stays focused on the grow room; the rest of the product does not inherit an unvalidated style.


## 3JS-002 definitive grow-room style lock — ACCEPT

Date: 2026-09-26

### Acceptance evidence
The Revision 1 grow-room render on PR #111 head `d4822fd6b5edc2c6634c22838bbc5ec771422313` was inspected at 540x960 and 1080x1920 after the initial REVISE pass. Artifact `10912912460` had empty browser console/page-error evidence and remained inside the 3JS-002 budget at both portrait sizes: 50 draw calls, 3,236 triangles, 9 material families, 0 authored scene textures, DPR 1 and dynamic shadows disabled.

The reviewed result is **ACCEPT**. It preserves the fixed miniature/cutaway read while adding enough authored workshop/storage density, foreground structure and warm/cool focal separation to stop reading as a clean blockout. The room remains original repository-authored procedural work; the reference pack is still consultation-only.

### Definitive reusable Three.js tokens
- **camera:** fixed orthographic; position `[8.4, 7.2, 10.9]`; target `[0, 1.15, 0.65]`; orthographic width `10.2`; portrait vertical bias `0.72`;
- **palette roles:** near-black blue/green envelope, concrete gray, warm plaster, teal accent, dark metal, warm wood, terracotta, restrained foliage green, cool glass and warm emissive practical;
- **surface response:** flat-shaded low-poly geometry; high-roughness concrete/plaster/terracotta/foliage, lower-roughness dark metal/glass; zero authored textures in the accepted baseline;
- **lighting:** cool ambient `0.86`, cool directional key `1.78`, cool rim `0.72`, primary warm practical intensity/distance `48 / 6.8`, secondary warm practical intensity/distance `18 / 5.4`; ACES filmic tone mapping at exposure `1.08`; no dynamic shadows;
- **scale/readability:** world grid unit `0.5`, minimum silhouette target `0.12`, clustered props separated by deliberate negative space rather than uniform clutter;
- **composition:** room shell + work zone + abstract living zone + storage/service zone must remain readable without labels at 540px portrait width; high-resolution portrait may reserve dark envelope for UI but must not expose unfinished interior massing;
- **rendering:** DPR cap `1.5`, static/on-demand rendering unless a later bounded spec justifies animation, explicit teardown/disposal, instancing for repeated forms when useful;
- **edge/detail policy:** chunky geometry and architectural rhythm supply edge definition; no outline/post-process pass is required by the accepted baseline.

### Propagation rule
This ACCEPT unlocks reuse of the grow-room style grammar in later **bounded** 3JS scene specifications. It does not authorize an engine migration, gameplay/persistence changes, direct copying of the visual-reference sources or an automatic redesign of every screen.


## CENA-020 — Market visual target

Date: 2026-09-26

### Reconciled evidence
- 3JS-002 Grow Room is delivered and its rendered style decision is **ACCEPT**;
- the accepted Grow Room tokens above are now the reusable Three.js baseline;
- `scenes/market/market_surface.tscn` is still a Control-only player surface with no dedicated 3D scene;
- no open PR existed at CENA-020 claim time;
- live base: `master@bd4ef780649ee48fca91e2147872e06b3f1586d1`.

### Decision
Advance the next visual target to **Mercado**, not another Grow Room refinement and not a broad all-screen redesign.

Mercado should inherit the definitive Grow Room grammar while changing the spatial story:
- fictional compact wholesale/deal bay rather than cultivation/workshop room;
- strong aisle/service-lane depth;
- foreground deal counter;
- mid-ground crate/storage cluster;
- background shutter/mesh/loading rhythm;
- one cart/trolley commerce silhouette;
- cool industrial overhead structure plus one restrained warm vendor practical;
- preserved dark envelope, concrete/plaster, dark metal, warm wood and teal palette roles;
- no copied real-world signage, brands, product packaging or literal CADEG/COBAL layout.

Reference research and the full composition/safety contract are recorded in:
`docs/visual-references/3js-market/README.md`.

### Renderer ownership
CENA owns this visual target and the later rendered ACCEPT/REVISE decision. Runtime implementation is routed to the repository-local `3js` workflow because the selected renderer is Three.js.

A future bounded `3JS-003` Spec Kit package must be created before player-facing Market runtime implementation.

### Provenance
Runtime assets introduced: **none**.  
Third-party runtime assets: **none**.  
Reference-only external research: CADEG / Mercado Municipal and COBAL architectural material.  
No external image or asset is copied into the repository in this wave.


## CENA-021 — Cidade visual target

Date: 2026-09-27

### Reconciled evidence
- PR #119 is merged on `master@f402713d2e3b9003aa49bcefb944e1bbc91dd903`;
- the merge commit currently has Vercel **SUCCESS**;
- no pull request was open at the CENA-021 work claim;
- Grow Room remains the accepted Three.js style lock and Mercado is delivered;
- canonical top-level surface order is Operação → Mercado → Cidade → Institucional → Arquivo;
- `scenes/city/city_surface.tscn` remains a Control-only surface with no dedicated Three.js scene.

### Decision
Advance the next visual target to **Cidade**.

Cidade should inherit the accepted orthographic-miniature grammar while changing the spatial story from interior room/deal bay to a fictional topographic urban slice:
- foreground retaining edge / overlook strip;
- mid-ground stepped low-rise district clusters across three elevation bands;
- restrained vegetation breaks that make district boundaries readable without labels;
- a few taller background volumes for skyline depth, never recognizable real landmarks;
- cool ambient/key/rim lighting with one restrained warm neighborhood-practical cluster;
- dark UI reserve preserved in portrait framing;
- concrete/plaster/dark-metal/warm-wood/terracotta/teal family continuity;
- no literal Rio map, real district name, street network, route, address, business, political institution or real-world navigation detail.

### Renderer ownership
CENA owns composition, provenance and the rendered ACCEPT/REVISE decision. Runtime implementation is routed to repository-local **3JS** as bounded **3JS-004**.

### Acceptance direction
The candidate must:
- read immediately as a compact fictional city/hillside district scene at 540x960;
- remain compositionally distinct from Grow Room and Mercado while visibly belonging to the same game;
- preserve portrait UI legibility;
- avoid map-like operational detail;
- stay within the established low-cost Three.js/Web discipline;
- return to CENA for explicit **ACCEPT** or **REVISE** before delivery.

### Research / provenance
Reference-only source notes live at `docs/visual-references/3js-city/README.md`. No external runtime asset is introduced in this target wave.


## CENA-022 — Institucional visual target

Date: 2026-09-28

### Reconciled evidence
- live claim base: `master@a8d1c3efae578e1325cd69783108a4f0aa5747b9`;
- 3JS-004 Cidade is accepted and delivered;
- Grow Room remains the accepted Three.js style lock;
- canonical surface order is Operação → Mercado → Cidade → Institucional → Arquivo/Pesquisa;
- `scenes/institutional/institutional_surface.tscn` remains Control-only;
- PR #148 is the deterministic owner of task key `3JS-005`;
- concurrent Feature 009 PRs are parallel-safe for this visual scope, with `docs/SIGA-HANDOFF.md` explicitly excluded.

### Decision
Advance the next visual target to **Institucional** as an original fictional administrative/civic forum.

The target inherits the accepted orthographic-miniature grammar while avoiding any real political or electoral representation:
- foreground public threshold / low waiting bench;
- generic participation/service desk;
- three **equal** proposal pedestals using identical scale, material and illumination;
- archive/storage rhythm and abstract process rails;
- cool structural ambient/key/rim with balanced warm practicals;
- concrete / plaster / teal / dark-metal / warm-wood family continuity;
- deliberate dark portrait UI reserve;
- no real institution, legislature, government body, party, election, ballot, law, politician, flag, seal, map, campaign symbol, advocacy or policy recommendation.

### Neutrality invariant
No visual hierarchy may imply that one policy or institutional path is better, preferred or more legitimate than another. Proposal placeholders are intentionally equivalent and contain no semantic policy data.

### Renderer ownership
CENA owns composition, provenance and the rendered ACCEPT/REVISE decision. Runtime implementation routes to repository-local **3JS** as bounded **3JS-005**.

### Research / provenance
The target is derived entirely from the accepted repository style lock and existing product surface contract. No external runtime asset or copied reference image is introduced. Full translation notes: `docs/visual-references/3js-institutional/README.md`.


## CENA-023 — Arquivo Three.js visual target

Date: 2026-09-29

### Reconciled evidence
- Feature 010 / CENA-017 is closed and certified on the default branch.
- The five canonical Godot destinations have distinct 3D presentation.
- The Three.js reference set already covers Operation/Grow Room, Market, City and Institutional.
- `threejs/archive/` is the remaining top-level Three.js continuity gap.
- The canonical Godot Archive already defines a strong internal composition: evidence desk/tray, archival shelves/storage, an uncertainty rail, cool structural light and one restrained warm desk practical.

### Decision
Advance **Arquivo** as bounded **CENA-023 / 3JS-006**.

The Three.js candidate must preserve the semantic hierarchy of the canonical Archive without copying nodes mechanically:
- evidence desk/tray as primary focal point;
- archival shelf/storage rhythm;
- abstract document/evidence forms with no real-world readable claims;
- uncertainty/evidence rail as a visual boundary;
- cool envelope with restrained warm desk focus;
- accepted DA LATA orthographic miniature/material grammar.

### Canon boundary
The scene is presentation-only. It must not resolve research, authenticate provenance or lineage, alter evidence, mutate canon, resolve narrative, expose real-world cultivation parameters or call gameplay state.

### Provenance
External visual research is not required for this slice. The target is derived from repository-owned Godot Archive assets plus the accepted 3JS-002 style lock. Runtime geometry for the first candidate must be repository-authored procedural geometry; authored textures and third-party runtime assets remain zero.

### Route
Current visual state: **CANDIDATE / SPECIFIED**.

3JS-006 owns implementation under `threejs/archive/`. CENA must inspect exact-head 540x960 and 1080x1920 rendered evidence and record exactly **ACCEPT** or **REVISE** before delivery.


### CENA-023 / 3JS-006 rendered acceptance — 2026-09-29

Reviewed exact runtime head: `0b2c9b79f0e038a2a87817260c04665095c77619`.

Evidence:
- Validate project #841 / run `36624016711`: **SUCCESS**;
- Three.js Archive visual acceptance #2 / run `36624016700`: **SUCCESS**;
- artifact `11059757870`, digest `sha256:e338a4760d911f50787ccfc574ec5b7b8c1571b7c425d2da3cba860c7fd795ea`;
- 540x960 + 1080x1920 captures inspected;
- browser console/page-error evidence: **empty**;
- both sizes: 21 draw calls, 360 triangles, 7 material families, 0 authored scene textures, DPR 1, dynamic shadows disabled.

Decision: **ACCEPT**.

The evidence desk/tray remains the clear foreground focal point, archival shelves/boxes establish the memory-storage read, the teal uncertainty rail is legible without claiming evidentiary certainty, and the warm desk practical separates the review area from the cool structural envelope. The scene is compositionally distinct from the prior Three.js surfaces while remaining inside the accepted DA LATA miniature grammar. No clipping or portrait hierarchy defect requires revision.

The final delivery head still requires a fresh exact-head rerun after acceptance bookkeeping and temporary-claim removal; acceptance does not waive that gate.


## ARTIST approved V1 — pixel graffiti urban (2026-09-30)

The user approved a new game-wide **concept art direction**: **pixel art + graffiti + fictional Brazilian urban isometric 3D**. Authoritative original visual and SHA256: `assets/art-direction/v1/da-lata-v1-style-board.png`, detailed locked prompt and per-scene briefs: `docs/art-direction/v1/`. Earlier realistic/blockout aesthetic sections above remain historical implementation records, not the target for new per-scene art approvals. The eleven individual scene concepts, asset adaptations and exact-head player renders are **not yet approved or delivered solely by this style decision**. ARTIST owns human per-scene art approvals, CENA/3JS own physical 3D runtime implementation, and LENTE supplies fresh before/after evidence when available. Do not paste the board as a flat background; retain readable touch interactions, mobile portrait composition and real 3D depth.
