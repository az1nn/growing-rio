# DA LATA — Visual Direction

Status: **baseline / to be evolved by CENA**

This document is the canonical repository-local visual-direction surface for player-facing assets and scenes. It records durable visual decisions. Temporary execution state belongs in `docs/CENA-HANDOFF.md`.

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

The first implementation should use blockout/procedural primitives when that is faster and safer than importing a large asset pack.

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
