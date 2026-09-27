# Feature Specification — 3JS-004 City Topographic Continuity

## Status
Implementation candidate. Requires exact-head automated/rendered evidence and CENA review.

## User value
Cidade is the next canonical player surface after Mercado. 3JS-004 gives it a distinct topographic urban identity while preserving the accepted DA LATA Three.js grammar and leaving district/community gameplay entirely in the canonical Godot/domain layer.

## Functional requirements
- **FR-001 — one-scene scope:** own only the Three.js City presentation under `threejs/city/`.
- **FR-002 — accepted style inheritance:** inherit the 3JS-002 orthographic miniature, chunky low-poly silhouettes, palette roles, high-roughness structural materials, warm/cool lighting balance, portrait-first composition, zero-authored-texture baseline and disabled dynamic shadows.
- **FR-003 — original city composition:** render an original fictional hillside-city slice with a foreground retaining/overlook edge, three stepped elevation bands, clustered low-rise massing, restrained taller background silhouettes and vegetation breaks.
- **FR-004 — reference boundary:** use `docs/visual-references/3js-city/README.md` as reference only. Do not reproduce a real Rio neighborhood, landmark, map, road network or district geometry.
- **FR-005 — gameplay boundary:** consume presentation-only immutable placements. Do not implement demand, support, reputation, district selection, market multipliers or campaign rules in Three.js.
- **FR-006 — civic/political boundary:** no real political institutions, parties, elections, laws, targeted persuasion, real district advocacy or real-world civic guidance.
- **FR-007 — navigation boundary:** no street routing, addresses, travel paths, logistics routes or geospatial navigation detail.
- **FR-008 — portrait acceptance:** preserve foreground/mid-ground/background readability at 540x960 and 1080x1920 with a deliberate quiet/dark UI reserve.
- **FR-009 — lifecycle:** deterministic resize, on-demand render, explicit geometry/material/renderer disposal and no perpetual animation loop.
- **FR-010 — dependency:** pin exactly `three@0.186.1`; no new runtime dependency.
- **FR-011 — provenance:** repository-authored procedural geometry only; no third-party runtime asset in this wave.
- **FR-012 — budget:** <= 60 draw calls, <= 22,000 triangles, <= 9 material families, 0 authored textures, DPR <= 1.5 and dynamic shadows disabled.
- **FR-013 — CENA gate:** final visual result is exactly `ACCEPT` or `REVISE`; implementation remains CANDIDATE until CENA reviews exact-head rendered evidence.

## Acceptance scenarios
### AS-001 — immediate City read
At 540x960, stepped terrain, clustered buildings, vegetation breaks and skyline silhouettes read as a compact fictional city context without labels or a literal map.

### AS-002 — style continuity
The scene is visibly part of the same DA LATA visual system as Grow Room and Mercado without cloning either interior composition.

### AS-003 — high-resolution portrait
At 1080x1920, the upper ridge and background volumes add depth without exposing empty prototype space or overwhelming the UI reserve.

### AS-004 — non-map abstraction
The scene communicates district contrast through massing/elevation only; it does not provide a usable route, road layout or real geography.

### AS-005 — engineering acceptance
The exact PR head builds deterministically, captures both portrait sizes, reports no browser/page errors, stays inside budget and exposes teardown.

### AS-006 — visual decision
CENA returns `ACCEPT` or `REVISE`. Only ACCEPT authorizes delivery closure.

## Out of scope
- gameplay/domain/persistence changes;
- Godot runtime replacement;
- real district/landmark reproduction;
- map or travel simulation;
- real political/institutional content;
- free-roam camera;
- external asset packs or copied reference imagery;
- changes to the accepted global style lock.
