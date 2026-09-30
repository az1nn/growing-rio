# ARTIST V1 — STRICT style-conformance contract

**Product decision:** 2026-09-30, confirmed by user with the original 11-panel DA LATA board attached again.
**Status:** BINDING style gate for Feature 012; **not** proof of individual scene approval or completed implementation.

## Visual source hierarchy

1. **LOCKED GLOBAL VISUAL AUTHORITY:** `assets/art-direction/v1/da-lata-v1-style-board.png` — original approved 1672×941 PNG, SHA-256 `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`.
2. **LOCKED WRITTEN STYLE:** `docs/art-direction/v1/README.md`, `docs/art-direction/ARTIST-V1-STYLE.md`, `docs/art-direction/v1/BASE-PROMPT.md`, and approved scene brief `docs/art-direction/v1/SCENES.json`.
3. **PER-SCENE ACCEPTED TARGET:** isolated V1 concept candidate only **after** explicit human concept `ACCEPT`, with SHA and review log recorded. The 11 WebPs from PR #190 are generated candidates with immutable provenance; they are not implicitly accepted visual overrides.
4. **RUNTIME EVIDENCE:** exact-head LENTE full-page/isolated screenshots/video after scene implementation; implementation must match 1–3 and preserve actual 3D interaction.
5. **PROTOTYPE/OLD LOOK:** previous low-poly Godot/Three.js palette/geometry is reusable engineering work but no longer dictates V1 art.

If a lower-level source disagrees with a higher-level approved visual rule, mark `REVISE`, record the divergence and obtain ARTIST/CENA approval before implementation. No autonomous aesthetic substitution.

## Interpretation of literal visual elements

"Yes, strictly follow the style guide" means preserve authored, guide-compliant visual elements as literally as 3D adaptation permits: approved DA LATA graffiti/crown identity, relative scene framing, staged cutaway geometry, color accents, focal physical objects, roughness and texture rhythm. **Do not sanitize away the approved graffiti/symbol vocabulary or repaint the world into generic low-poly.**

Literal incidental model hallucinations are not automatically canon. The written guide explicitly rules out tourist postcard skylines, exact real buildings, real political branding, real-person likenesses, unsupported narrative, operational instructions and tiny fake text. If a generated candidate contains one, preserve the useful visual role (e.g. height/depth/horizon) with original fictional-world art only after documenting and reviewing the change; do not turn it into an unapproved art-style reinterpretation.

The 11-panel board is a **shared visual grammar**, not a literal runtime menu screenshot or license to reuse the collage as a giant background. Each scene needs its own portrait framing and physical 3D hotspot geometry.

## Global non-negotiables

- **Pixel art:** hard-edged, deliberate pixel clusters and consistent **apparent texel scale** across props/architecture/camera. No smoothed AI-painting or merely applying a global blur/pixelation filter to generic geometry.
- **Graffiti:** expressive handcrafted crown/tag/stencil vocabulary; coherent placement, sprayed/pasted texture rhythm and controlled hotspots; avoid unrelated cyberpunk signage.
- **Physicality:** real three-quarter isometric/orthographic 3D cutaway depth, foreground/midground/background, actionable 3D props. Flat generated reference image as runtime background cannot fulfill this contract.
- **Palette:** dominant dark ink/navy structure; vivid but controlled hot-pink, cyan, amber and secondary foliage accents. README starting swatches are directional, **not locked numeric tolerances**.
- **Architecture:** compact, layered, invented Brazilian urban spaces, worn concrete/brick/tile, shutters, repaired metal/wood, rooftop density where scene-relevant. Avoid photoreal surfaces, pristine glossy showroom, generic toy low-poly or tourist collages.
- **Composition:** each scene has a distinct first-read silhouette and 2–3 sufficiently separated physical interaction foci. Portrait-first 540×960/1080×1920; leave UI-safe area as directed by the approved isolated brief.
- **Identity & text:** preserve the DA LATA crown/graffiti identity. All readable gameplay wording is authored by actual UI/fonts; ignore hallucinated text baked into generated scene concepts.
- **Canon & interaction:** preserve fictional, non-instructional presentation, LORE boundaries, semantic hotspots, touch targets and accessible fallback.

## Required per-scene conformance sheet

Complete *before* geometry implementation:

| Field | Evidence required |
| --- | --- |
| Global version | Original board SHA, style-guide version/date |
| Scene candidate | Generated candidate SHA, review round, status |
| Camera/silhouette | Board panel → isolated concept mapping; camera/volume deviations |
| Graffiti/pixel | Intentional crowns/tags, pixel density and texture-treatment deviations |
| Palette/lighting | Dark structural mass and selected magenta/cyan/amber accents |
| 3D focal anchors | Scene's three `SCENES.json` foci with physical silhouettes |
| Safe area | Portrait UI overlap/empty lower region |
| Unapproved details | Every incidental postcard landmark, invented label/brand or canon conflict to revise |
| ARTIST review | Human scene `ACCEPT` or `REVISE`, date and accepted SHA |
| Runtime comparison | Exact-head 540×960 and 1080×1920 before/after + LENTE CAVEMAN |
| CENA gate | Visual `ACCEPT` or `REVISE` on actual gameplay runtime |

## Gate sequence

`BOARD_APPROVED` → `SCENE_CANDIDATE` → `BOARD_CONFORMANCE_AUDITED` → `SCENE_CONCEPT_ACCEPTED` → `3D_IMPLEMENTED` → `EXACT_HEAD_LENTE_CAPTURED` → `RUNTIME_ACCEPTED`.

Do not skip from generated candidate to runtime implementation. Do not confuse merge of PR #190 (provenance) with approval of its 11 candidates. Existing unrelated CI success is not proof of V1 style conformance.

## Preliminary review warning

The independently generated portrait candidates may introduce details, scale or horizons not present in the original compact board miniatures. No blanket accept is granted. First detailed audit is **Operation**; after it is individually approved and the renderer spike is resolved, proceed one scene at a time. Where the board and a candidate differ, the board/written guide wins until an explicit user-approved change is recorded.
