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
