# Archive Godot 3D — CENA reference/provenance

Status: **CENA reference selected / repository-derived / no external runtime assets**

## Decision

The first canonical Archive pass will use an original fictional **evidence desk + shelving wall + document-lighting** composition built entirely from repository-authored Godot primitives and materials.

The scene must read immediately as a research/archive workspace while preserving the existing Archive UI as the only source of research actions, completed records and canon uncertainty.

## Visual source of truth

This pass reuses the accepted DA LATA visual grammar already present in the repository:

- portrait-first UI-over-3D composition;
- fixed orthographic miniature/cutaway framing;
- dark concrete / warm plaster / dark metal / teal / warm wood / terracotta material family;
- cool structural light plus restrained warm practicals;
- chunky low-poly procedural geometry;
- no authored texture dependency;
- Web/mobile-safe shadowless lighting baseline.

The Archive must remain visually distinct from:
- Operação: production-room/grow-room grammar;
- Mercado: storefront/transaction grammar;
- Cidade: terraced urban overlook;
- Institucional: public forum / proposal-pedestal grammar.

## Archive composition

### 1. Evidence desk

A broad foreground desk forms the primary interaction anchor. It may contain abstract document slabs, trays and a small lamp-like practical, but no readable real-world document, seal, logo or institution.

The desk interaction is presentation-only: activating it focuses or reveals the existing research UI. It never completes research or changes narrative state.

### 2. Shelving wall

The rear plane uses repeated shelving/archive modules with varied neutral document-box silhouettes. The rhythm should communicate stored records without implying that any visible prop corresponds to a canonical fact.

### 3. Uncertainty rail

A restrained teal/metal rail or header element separates the archive wall from the evidence desk. It is a visual continuity device only. It must not map color, size, placement or lighting to `CÂNONE`, `RUMOR` or `ABERTO` in a way that promotes one epistemic state over another.

### 4. Warm document practical

One or two warm practical lights may highlight the desk and document silhouettes while the overall structural lighting remains cool. Lighting must support depth/readability, not imply factual certainty.

### 5. Quiet side props

Small plant, crate or neutral storage silhouettes may occupy edges to avoid an empty blockout. They must stay subordinate to the desk/shelving read and must not introduce new lore symbols.

## Primary 3D affordance

Use one pointer/touch-pickable `Area3D` covering the evidence-desk interaction zone, plus one visible keyboard/assistive `Button` fallback.

Both routes emit the same presentation signal, for example:

`archive / evidence_desk`

The Archive surface may respond by scrolling/focusing the existing `ResearchActions` or equivalent UI target only.

## Canon boundary

The 3D scene must not:

- complete research;
- resolve a narrative choice;
- change `CÂNONE / RUMOR / ABERTO`;
- write save data;
- call RNG;
- unlock content;
- visually certify a disputed or unresolved lore fact;
- introduce new narrative canon.

If a future asset requires a specific historical/narrative interpretation, route that question through LORE before visual acceptance.

## Provenance

- external reference images copied into repository: **none**;
- third-party runtime assets: **none**;
- runtime geometry: **repository-authored Godot primitives**;
- textures: **none required for first pass**;
- license/attribution dependency: **none**;
- reference basis: existing DA LATA Godot/Three.js scene language and repository visual-direction documents.

## CENA acceptance criteria for implementation

The runtime pass is eligible for CENA acceptance only when:

1. the Archive has a clearly visible dedicated 3D viewport at 540x960 and 1080x1920;
2. the evidence desk and shelving wall are immediately distinguishable from the generic context blockout;
3. the desk is pointer/touch interactive and has an accessible button fallback;
4. activation changes presentation/focus only;
5. the uncertainty boundary remains intact and no prop visually authenticates disputed lore;
6. exact-head validation, Web export and rendered evidence are current.
