# DA LATA — ARTIST Session 001: visual language exploration

Status: **PROPOSED / awaiting player creative-direction feedback**. This is a concept-art exploration, not a replacement for `docs/VISUAL-DIRECTION.md`, not a merged gameplay feature, and not runtime asset evidence.

## Reference
User-supplied collage dated 2026-09-30 shows individual `archive`, `campaign`, `city`, `finale-coda`, `finale-handoff`, `finale-recap`, `finale-selection`, `institutional`, `market`, `narrative`, `operation` scenes. Current look: dark-background three-quarter low-poly dioramas and abstract geometry. The montage is directional, not exact-head screenshot proof. Before implementation, capture fresh isolated scene screenshots.

## Opening diagnosis
Observed in provided montage: (1) consistent silhouette grammar exists, (2) material treatment is still largely flat/primitive, (3) finale variants appear visually near-identical and may lack differentiated storytelling, (4) large black voids between geometry and screen UI can reduce perceived scene density. These are hypotheses to confirm against fresh isolated full-res captures.

## Creative decision prompts
1. Tonal axis: **A** urban tactile grounded; **B** graphic arcade / playful; **C** cinematic mysterious; **D** blend, with ratios.
2. Stylization: **A** strict minimal low-poly; **B** handcrafted indie low-poly with selective texture; **C** stylized semi-realistic.
3. Camera: retain orthographic fixed 3/4 everywhere, or vary by scene/cinematic beats while preserving clarity?
4. Fictional urban identity: contemporary Rio-adjacent interiors vs retro-futurist alternative Brazil vs another explicit choice?
5. Touch UX: purely external overlay UI vs physical interactive props with selective overlay vs strongly diegetic UI?

## Base prompt v0 — English / portable
Premium handcrafted isometric 3D video-game environment concept for DA LATA, a fictional Brazilian narrative management game. Portrait-first orthographic three-quarter diorama with unmistakable modeled depth, readable modular architectural cutaway, deliberate foreground / midground / background silhouette layering, intentional lighting and cohesive material response. Rio-adjacent compact improvised urban architecture, without tourist postcards. Painted concrete with subtle age and repair, deep teal tile accents, matte dark steel frames, warm used wood, terracotta and restrained living green. Cool atmospheric ambient shading contrasted with one motivated amber practical light. Deep charcoal void isolates the architecture; richly composed scene uses its available viewport space, and leaves controlled UI-safe negative space. Distinct visually legible gameplay objects with strong touch affordances. Artfully stylized low-poly forms with restrained surface detail, warm human stories visible in props and wear. Consistent camera and asset scale across scenes. Target: modular meshes and economical lighting compatible with Godot 4.7/Web/mobile; this image is **concept art only**, not production implementation.

## Negative prompt v0
No photorealistic faces, no generic asset-store mismatched props, no overly toy-like plastic sheen, no tourist landmark collage, no flat faux-3D pasted UI, no clutter obscuring interactive targets, no unreadable invented labels or tiny text, no instructional cultivation annotations, no heavy volumetric rendering requirement, no long-lens blur that destroys touch-target clarity, no gratuitous bloom.

## First isolated scene delta — OPERATION
Compact grow-space / workshop cutaway in a fictional Rio-adjacent building. View from elevated three-quarter angle. Strong original silhouette: exposed concrete wall with repaired glazed tile stripe and framed frosted window; wooden service counter with worn edges and two purposeful tabletop props; black metal shelf with colored storage cases; three fictional abstract plant canopies in terracotta pots, stylized enough to read at phone size, not biologically instructional; distinctive warm amber practical lamp; cool teal ambient light through window; subtle cables and handmade repairs, no readable signage. Distinct **three** foreground interactive focus objects: plant grouping, service bench, inventory shelf. Preserve uncluttered lower screen zone for game management controls. No overlay labels in concept image. Generate exactly one scene, not a collection.

## Next scene order — pending creative decision
`operation` (style anchor) -> `market` -> `city` -> `archive` -> `institutional` -> `campaign` -> `narrative` -> finale variants, one by one, unless player chooses otherwise.

## Approval
`operation`: **PROPOSED**, awaiting first render and player review. No palette, lighting or design from this session is yet approved for production.
