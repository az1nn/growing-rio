# Feature Specification — 3JS-005 Institutional Continuity

## Status
Specified and visually bounded. Runtime candidate pending implementation and exact-head rendered CENA review.

## User value
Institucional is the next canonical top-level surface after Cidade. 3JS-005 gives the existing fictional policy/institutional gameplay a distinct spatial identity while keeping all policy availability, enactment, compliance and civic-participation rules in the canonical Godot/domain layer.

## Functional requirements
- **FR-001 — one-scene scope:** own only the Three.js Institutional presentation under `threejs/institutional/`.
- **FR-002 — accepted style inheritance:** inherit the 3JS-002 Grow Room style lock: fixed orthographic miniature, chunky procedural silhouettes, restrained material families, cool/warm lighting, portrait-first composition, zero authored textures and disabled dynamic shadows.
- **FR-003 — original institutional composition:** render an original fictional administrative/civic forum with a public threshold, equal proposal pedestals, a neutral participation desk, archive/storage rhythm and a calm institutional backdrop.
- **FR-004 — neutrality by construction:** proposal pedestals MUST have equal scale, material and lighting treatment. No proposal, policy or institutional path may be visually ranked, endorsed, preferred or presented as the correct choice.
- **FR-005 — real-world boundary:** no real institution, government body, legislature, party, election, ballot, law, politician, flag, seal, map, campaign symbol or advocacy message.
- **FR-006 — gameplay boundary:** consume presentation-only immutable placements. Do not implement institution progression, policy prerequisites/effects, enactment, compliance, influence, community support or civic-participation formulas in Three.js.
- **FR-007 — canon boundary:** do not create policy names, factions, institutions or political lore. The scene is generic fictional presentation only.
- **FR-008 — portrait acceptance:** preserve foreground/mid-ground/background readability at 540x960 and 1080x1920 with a deliberate quiet/dark UI reserve.
- **FR-009 — lifecycle:** deterministic resize, on-demand render, explicit geometry/material/renderer disposal and no perpetual animation loop.
- **FR-010 — dependency:** pin exactly `three@0.186.1`; no new runtime dependency.
- **FR-011 — provenance:** repository-authored procedural geometry only; no third-party runtime asset in this wave.
- **FR-012 — budget:** <= 60 draw calls, <= 20,000 triangles, <= 9 material families, 0 authored textures, DPR <= 1.5 and dynamic shadows disabled.
- **FR-013 — CENA gate:** final rendered result is exactly `ACCEPT` or `REVISE`; implementation remains CANDIDATE until CENA reviews exact-head evidence.

## Acceptance scenarios
### AS-001 — immediate Institutional read
At 540x960, the public threshold, neutral participation desk, equal proposal pedestals and archive/backdrop rhythm read as a fictional institutional/administrative space without labels or real-world symbols.

### AS-002 — visual neutrality
All proposal pedestals are equivalent in size, material and illumination. No focal treatment implies a preferred policy or outcome.

### AS-003 — style continuity
The scene visibly belongs to the accepted DA LATA Three.js family while remaining compositionally distinct from Grow Room, Mercado and Cidade.

### AS-004 — high-resolution portrait
At 1080x1920, added architectural depth does not expose unfinished space, obscure the UI reserve or create a dominant ceremonial focal point.

### AS-005 — engineering acceptance
The exact PR head builds deterministically, captures both portrait sizes, reports no browser/page errors, stays inside budget and exposes teardown.

### AS-006 — visual decision
CENA returns exactly `ACCEPT` or `REVISE`. Only ACCEPT authorizes delivery closure.

## Out of scope
- gameplay/domain/persistence changes;
- Godot runtime replacement;
- real political or electoral content;
- policy ranking, recommendation or persuasion;
- real civic guidance or institutional procedure;
- external asset packs or copied reference imagery;
- free-roam camera;
- changes to the accepted global style lock.
