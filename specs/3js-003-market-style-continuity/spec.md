# Feature Specification — 3JS-003 Market Style Continuity

## Status
Rendered CENA acceptance: **ACCEPT** on implementation head `eb19bae48edbd5698ac09872e718dea9932cf810` / artifact `10914735544`. Delivery persistence now requires fresh exact-head validation.

## User value
Mercado is the next major player surface after Operação. 3JS-003 gives that surface a distinct, readable wholesale/deal-space identity while preserving the accepted Grow Room visual language and the existing abstract market mechanics.

## Functional requirements
- **FR-001 — one-scene scope:** own only the Three.js Market presentation under `threejs/market/`.
- **FR-002 — accepted style inheritance:** inherit the 3JS-002 orthographic miniature, chunky low-poly silhouettes, palette families, high-roughness structural materials, warm/cool lighting balance, portrait-first composition, zero-authored-texture baseline and no dynamic shadows.
- **FR-003 — original market composition:** render an original fictional compact wholesale/deal bay with a foreground deal counter, mid-ground vendor/storage bay, background loading/service rhythm, a strong aisle depth cue and one cart/trolley silhouette.
- **FR-004 — reference boundary:** use `docs/visual-references/3js-market/README.md` as research/visual direction only. Do not reproduce real CADEG/COBAL layouts, brands, signs, businesses or packaging.
- **FR-005 — gameplay boundary:** consume presentation-only immutable data. Do not implement pricing, buyer, contract, risk, routing, inventory, delivery, concealment or distribution rules in Three.js.
- **FR-006 — safety boundary:** no real-world trafficking, evasion, distribution procedure, route map, timing, quantity or contact information.
- **FR-007 — portrait acceptance:** preserve clear foreground/mid-ground/background reading at 540x960 and 1080x1920 with a quiet/dark UI reserve.
- **FR-008 — lifecycle:** deterministic resize, on-demand render, explicit geometry/material/renderer disposal and no perpetual animation loop.
- **FR-009 — dependency:** pin exactly `three@0.186.1`; no new runtime dependency.
- **FR-010 — provenance:** repository-authored procedural geometry only; no third-party runtime asset in this wave.
- **FR-011 — budget:** <= 60 draw calls, <= 22,000 triangles, <= 9 material families, 0 authored textures, DPR <= 1.5 and dynamic shadows disabled.
- **FR-012 — CENA gate:** final visual result is exactly `ACCEPT` or `REVISE`; implementation remains CANDIDATE until CENA reviews exact-head rendered evidence.

## Acceptance scenarios
### AS-001 — immediate Market read
At 540x960 the composition reads as a compact commercial/deal bay through counter, crate/storage, aisle, loading rhythm and trolley silhouettes without labels or copied signage.

### AS-002 — style continuity
A reviewer can identify the accepted Grow Room camera/material/lighting grammar while the Market is not a clone of the Grow Room layout.

### AS-003 — high-resolution portrait
At 1080x1920 the background aisle/service structure adds depth without turning into empty prototype space or visual noise.

### AS-004 — UI reserve
The composition preserves a deliberately quiet dark region behind high-priority interface controls.

### AS-005 — engineering acceptance
The exact PR head builds deterministically, captures both target sizes, reports no browser/page errors, stays inside budget and exposes a teardown hook.

### AS-006 — visual decision
CENA returns `ACCEPT` or `REVISE`. Only ACCEPT authorizes delivery closure.

## Out of scope
- gameplay/economy/persistence changes;
- Godot runtime replacement;
- real business or district depiction;
- operational market/logistics simulation;
- free-roam camera;
- external asset packs or copied reference imagery;
- changes to the accepted global style lock.
