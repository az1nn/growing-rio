# ARTIST V1 — approved concept-level visual language

**Creative approval:** 2026-09-30, from the user's ARTIST art session. **Production adoption:** awaiting CENA implementation and actual LENTE review. **Original V1 image:** `NOT_ARCHIVED`; exact bytes/hash/storage reference not available to this repository write.

## Accepted direction
**PIXEL ART × GRAFFITI × FICTITIOUS BRAZILIAN URBAN GAME WORLD.** More expressive, hand-made and game-like; explicitly **less realistic** than the previous proposed diorama. Preserve spatially legible **3D** across every required scene and make physical objects discoverable/clickable, including touch and accessible fallback where gameplay requires it. Pixel art refers to the graphic surface vocabulary, not removal of depth.

Reference grammar: strong chunky pixels with consistent apparent texel size; expressive urban graffiti murals and painted/pasted textures; layered urban architecture, repair, reuse, concrete and painted shutters; graffiti color accents against an atmospheric limited palette; confident silhouettes with selective high-contrast highlights; 3/4 orthographic or perspective-adjusted authored 3D camera; mobile-portrait-first; reserve UI-safe space. Use only fictional signage, no invented canon.

Palette **candidates**, not user-locked hex values: deep ink/charcoal structural dark, petrol blue/teal shadow, warm brick/coral and electric yellow/magenta graffiti accents, muted off-white readable highlights. CENA chooses final swatches and profiles them against existing UI.

## Portable BASE_V1 image prompt (English)
Art-directed video-game **concept illustration** for DA LATA, a fictional Brazilian urban narrative-management game. Vivid authentic-looking **handcrafted pixel art combined with bold street graffiti illustration**, intentional chunky pixels and consistent texel scale, spraypaint-like forms rendered through disciplined pixel clusters, layered invented Brazilian urban architecture, patched concrete, brick, shutter doors and paint-worn walls. Bold readable silhouettes and saturated but controlled murals. Give the environment unmistakable **three-dimensional staged depth**: real 3D architectural cutaway and props suitable for later Godot modeling, foreground / midground / background parallax, authored three-quarter camera, crisp visual focus on 2–3 foreground clickable game objects. Compact atmospheric light pools and a restrained shared palette, no fake game HUD, portrait 9:16 scene-safe composition, readable at phone size. Every scene must feel part of the same world and have its own recognizable function and silhouette. **REFERENCE CONCEPT ONLY — NOT A SCREENSHOT, MODEL OR IMPLEMENTED ASSET.**

## NEGATIVE_V1
Photorealism; realistic cinematic PBR showroom; stock low-poly toy render; smoothed AI painting masquerading as pixels; flat wallpaper in place of 3D geometry; generic cyberpunk signage; tiny fake unreadable lettering; compositional clutter hiding targets; inconsistent pixel density; exact real buildings or tourist postcard collage; real-person likeness or political campaigning; real-world cultivation diagrams or how-to labels; unsupported lore; tiny tap targets.

## Prompt assembly
`BASE_V1 + ONE SCENE DELTA + (ONE OBJECT DELTA, if scoped) + NEGATIVE_V1 + RUNTIME NOTES`. Store the **exact strings** in each versioned round's `PROMPTS.md`, not only a summary. For revisions supply a `parent_round` identifier; changing more than one scene per approval round requires explicit user request.

### Seed scene deltas (hypotheses, NOT per-scene approvals)

| ID | Distinctive visual intent / focal objects |
|---|---|
| operation | Dense invented rooftop workshop/room; layered brick/concrete graffiti walls; stylized abstract plant group, service bench and inventory shelf form separate 3D touch targets. No instructional detail. |
| market | Fictional neighborhood exchange booth and expressive sign wall; stylized card/contract tray, offer board and counters. No real illicit logistics. |
| city | Vertical dense block of fictional urban buildings and painted walls; neighborhood selector, transit-like graphic motif and roof silhouettes. |
| institutional | Invented civic hall with abstract community banners, document kiosk and plinth, without real parties/campaign imagery. |
| archive | Narrow vertical archive/workroom; mural indexing motifs, readable filing shelf and physical document station. |
| campaign | Street-scale community organizing mural-board *inside the fictional game's world*, calendar/goal props and stage-like depth, avoiding real-person politics. |
| narrative | Cinematic yet chunky pixel comic-panel staging in a real 3D environment, one clear story prop and depth-separated backdrop. |
| finale-selection | Strong central theatrical stage, clearly separated physically interactive ending-choice indicators. |
| finale-handoff | Unique gateway/passage structure and one unambiguous transition landmark. |
| finale-coda | Quiet environmental aftermath with unique mural/architecture variation distinguishable from selection/handoff. |
| finale-recap | Retrospective gallery/hall of abstract visual motifs; distinct recap framing, not the selection scene with recoloring. |

**Order:** operation → market → city → institutional → archive → campaign → narrative → finale-selection → finale-handoff → finale-coda → finale-recap. Review scene components one-by-one; optional object rounds refine specific props in their approved scene.

## Art-to-runtime acceptance
LENTE exact-head evidence: full page + isolated scene (540×960 and 1080×1920) + 4s post-ready WebM. CENA/3JS implement as actual 3D meshes/geometry with pixel-art texture/pixelated material intent and game-accessible interactions. Regenerate exact-head media after each bounded implementation and compare before/after on composition, graffiti cohesion, pixel density, readability, 3D visibility and interaction. A good concept alone never passes runtime acceptance.

## Original V1 preservation task
Obtain original full composition binary from the initial user-approved ARTIST session, confirm permission for repo retention, compute SHA256, save to an authorized durable reference location without embedding unbounded media in PR branches, and add exact reference/size/hash here. Until available: `STYLE_ACCEPTED`, `REFERENCE_NOT_ARCHIVED`; do **not** assert original art has been saved to the repository.
