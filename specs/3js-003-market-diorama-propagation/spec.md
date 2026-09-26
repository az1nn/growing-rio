# Feature Specification — 3JS-003 Market Diorama Style Propagation

## Status
Specified for implementation. Reuses the definitive 3JS-002 grow-room style baseline with **ACCEPT** status.

## User value
After the Grow Room established the definitive Three.js visual language, the next canonical player surface is Mercado: the place where production becomes business outcomes through selling channels, contracts and buyer relationships.

3JS-003 proves that the accepted visual grammar can travel to a second high-value surface without turning every screen into the same room, without moving gameplay ownership into Three.js and without introducing real-world operational market guidance.

## Functional requirements

- **FR-001 — one-scene scope:** 3JS-003 owns only a Mercado contextual diorama/presentation scene. Cidade, Institucional, Arquivo and additional Operação rooms remain out of scope.
- **FR-002 — definitive-token inheritance:** inherit the accepted 3JS-002 camera/material/lighting/scale/detail grammar from `docs/VISUAL-DIRECTION.md`. Do not silently redefine global style tokens.
- **FR-003 — distinct Market identity:** create an original Mercado composition using the accepted grammar while visually separating it from the Grow Room through layout, prop grouping and focal hierarchy rather than a new global art direction.
- **FR-004 — supplemental presentation:** the Mercado UI remains complete and usable without the 3D scene. Three.js is presentation-only and must not become the owner of contracts, channels, prices, relationships, district demand, compliance or navigation.
- **FR-005 — read-only state:** any market state consumed by Three.js is immutable/read-only presentation data derived from canonical domain/GameState state.
- **FR-006 — abstract commerce:** buyer/channel/contract context must remain fictional and abstract. Do not add real-world trafficking, sourcing, concealment, evasion, route or illicit-market operating guidance.
- **FR-007 — fixed camera:** use a fixed orthographic or near-isometric camera consistent with the accepted Grow Room grammar. Free-roaming camera movement is out of scope.
- **FR-008 — portrait-first acceptance:** the scene must remain coherent at 540x960 and 1080x1920 and reserve sufficient contrast/readability for the canonical Mercado UI.
- **FR-009 — scene semantics without copied UI:** environmental props may suggest a generic exchange/workspace, contract-review zone and relationship/context cues, but must not recreate or duplicate the actual interactive contract/buyer UI inside the diorama.
- **FR-010 — token deviation gate:** any proposed change to global palette roles, camera grammar, material response, lighting model, scale convention or edge/detail policy requires explicit CENA-style review before it can become reusable.
- **FR-011 — provenance:** begin with repository-authored procedural/primitive geometry and authored materials. Any third-party runtime asset requires source/license/provenance review.
- **FR-012 — Web/mobile budget:** target <= 65 draw calls, <= 35,000 triangles, <= 10 material families, 0 authored textures by default, DPR <= 1.5 and no dynamic shadows unless a later bounded acceptance decision explicitly changes that constraint.
- **FR-013 — lifecycle:** deterministic resize/render behavior and explicit renderer/resource/listener disposal are mandatory.
- **FR-014 — no runtime migration:** Godot remains the canonical game runtime. 3JS-003 is not an engine-migration step.

## Acceptance scenarios

### AS-001 — Market identity
At 540x960, the scene reads as a distinct Mercado context rather than a recolored Grow Room while still clearly belonging to the same DA LATA visual family.

### AS-002 — surface support
The Market scene improves place/atmosphere behind or around the existing Mercado controls without obscuring selling, contract or relationship information.

### AS-003 — style propagation
A visual review can identify the definitive Grow Room camera/material/lighting/detail grammar in the new scene without requiring a new global style system.

### AS-004 — abstract market boundary
No prop, label, layout or animation communicates real-world sourcing, trafficking, concealment, evasion or route instructions.

### AS-005 — high-resolution portrait
At 1080x1920, the composition remains intentionally authored and does not expose empty prototype massing, excessive dead bands or detail noise.

### AS-006 — engineering acceptance
The exact final implementation head builds, captures both portrait sizes, emits no browser console/page errors, remains inside renderer budget and tears down resources/listeners cleanly.

### AS-007 — optional 3D contract
Disabling or omitting the diorama leaves the Mercado gameplay surface complete and usable, proving 3D remains contextual presentation rather than product ownership.

## Success criteria

- one original Mercado Three.js scene exists as the second bounded use of the accepted visual grammar;
- Grow Room definitive tokens remain stable unless an explicit reviewed deviation is justified;
- both portrait captures pass rendered review;
- renderer/lifecycle budgets pass on the exact implementation head;
- no gameplay, persistence, economy, canon or navigation semantics change;
- market presentation stays fictional, abstract and non-operational;
- the result provides evidence for whether later Cidade/Institucional/Arquivo scenes should reuse the same 3D grammar.

## Out of scope

- Cidade, Institucional, Arquivo or additional Operação scene work;
- new buyers, contracts, channels, formulas or balance;
- real-world illicit-market operations;
- Godot runtime replacement;
- free-roam camera;
- new canon;
- copied reference-game assets, UI or branding;
- automatic redesign of every remaining surface.
