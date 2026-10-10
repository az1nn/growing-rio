> **SUPERSEDED — HUMAN REJECT ALL, 2026-10-08.** The City player-facing visual implementation at `1f799128d9efe33cfdcb8365119fc2eb2371166e` was explicitly rejected: “Reject completo, nada parece com o art concept.” Do not execute incremental polish, extend its billboard/card/raster architecture, or reinterpret its green CI as artistic acceptance. See [R06-CITY-V1-HUMAN-REJECT-20261008.md](./R06-CITY-V1-HUMAN-REJECT-20261008.md) for the current authoritative ARTIST handoff. Keep this file for historical traceability only.

# R06 City V1 — ARTIST Full Visual Rebase Contract

Status: **ARTIST_REJECT / FULL_VISUAL_REBASE / LOW_POLY_FORBIDDEN**  
Human verdict: **REJECT ALL — runtime still reads low-poly**  
Rejected runtime head: `2f2ab87f91fb0cc5aa8d831add87c4ccbbaa3b53`  
Accepted concept authority: `20261004T110406Z/city` — HUMAN ACCEPT  
Roadmap: R06 CURRENT; R07+ LOCKED.

## Why Candidate 17 is no longer a usable visual baseline

The runtime is technically healthy again, but the player-facing City still violates the canonical V1 art gate.

ARTIST inspected the actual current production assets after the human veto. The dominant Candidate 17 facade/shop/far-city sources are still extremely simple vector constructions: broad rectangular color bands, flat window blocks, geometric skyline masses and symbolic resident/vegetation shapes. The implementation may use custom ArrayMesh and authored files, but **authorship alone does not clear the visual veto**. The resulting frame can still read as low-poly/toy-like because the visible silhouette and surface language remain simplified geometric masses.

The human verdict is authoritative. Previous `LOW_POLY_VETO_CLEARED`, `READY_FOR_HUMAN_RUNTIME_GATE` and `RECOMMEND_ACCEPT` classifications are superseded.

## Rebase principle

**Separate the visible art shell from the physical interaction shell.**

The next R06 implementation must stop asking visible runtime geometry to carry the final art direction.

### Visible art shell — pixel authored

Use a raster-first production language for every dominant player-facing category:

- facade / wall modules;
- stair / ground surface;
- shopfronts and awnings;
- graffiti and mural fields;
- residents;
- vegetation;
- street props / cables / clutter;
- far-neighborhood silhouettes.

Preferred source: low-resolution PNG/WebP pixel assets with nearest-neighbor filtering and deliberate pixel clusters. SVG may remain for tooling/source reference, but **must not be the dominant final player-facing City asset language** when it produces smooth geometric blocks.

Every visible module must carry authored edge breakup, patching, wear, tile/masonry/metal rhythm, irregular silhouette and graffiti identity at the source-art level. Do not rely on more polygons or more lights to create that detail.

### Physical interaction shell — hidden 3D

Preserve real Godot 3D interaction and depth, but demote construction geometry from visual authority:

- keep `Area3D`, collision, semantic hotspot IDs and depth anchors;
- keep the accepted camera/stair route and native 3D ownership;
- invisible/simple collision volumes are allowed;
- visible primitive or low-detail geometry is not.

The player should see authored pixel art, while the interaction system may use hidden 3D scaffolding underneath it.

### Diorama depth

Build the City as a layered spatial composition rather than a box-mesh miniature:

1. foreground stair/landing pixel surfaces;
2. left/right near-facade pixel modules;
3. mid-stair residents/shops/vegetation;
4. upper neighborhood and roof silhouettes;
5. far-city pixel silhouette layer.

Use real Z/depth separation and parallax so the result still reads as a physical three-quarter diorama. A single flat wallpaper is forbidden.

## Hard replacement rules

The rebase must replace or visually demote the current dominant low-poly read across the full frame.

Forbidden as final player-facing authority:

- flat-color BoxMesh/primitive architecture;
- custom mesh silhouettes that still read as low-poly blocks;
- vector rectangles/triangles used as final residents or vegetation;
- repeated flat facade panels with minimal authored surface information;
- lighting-only attempts to hide the construction;
- mesh-count/density metrics as art-quality proxies.

Allowed only as hidden support:

- primitive collision;
- invisible layout anchors;
- invisible hotspot volumes;
- non-visible structural scaffolding.

## Preservation fence

Do not change:

- accepted City concept `20261004T110406Z/city`;
- gameplay/state/persistence;
- semantic IDs `city/district_overlook`, `city/route_nodes`, `city/community_cluster`;
- DA LATA UI V1;
- mobile/Web delivery recovery;
- R06 ownership and R07+ lock.

No new City concept is requested. This is an implementation rebase toward the already approved target.

## Internal ARTIST gate before another human review

Do **not** present another R06 human gate until all of the following are true on one exact head:

- fresh 540×960 and 1080×1920 LENTE page captures;
- fresh isolated City captures;
- orbit/video proves real spatial depth;
- runtime mobile load gate passes;
- no dominant facade, ground, resident, vegetation or prop category reads as low-poly;
- pixel clusters/material breakup are visible at portrait scale;
- graffiti/mural language is authored, irregular and non-repetitive;
- foreground → midground → background depth remains legible;
- ARTIST classifies the result `LOW_POLY_VETO_CLEARED` **after** inspecting the new pixel-surface rebase, not by inheritance from Candidate 17.

If any category still materially reads low-poly, ARTIST returns `REJECT / LOW_POLY_FORBIDDEN` without escalating to the human gate.

## Next execution slice

Route to CENA as **R06 VISUAL REBASE A — PIXEL-SURFACE SHELL**.

First implementation objective: replace the complete player-facing City shell with raster pixel-art modules and sprite/surface layers while preserving hidden 3D interaction. Do not add another Candidate-17 polish layer and do not treat existing C17 visible assets as baseline authority.

After implementation freeze one exact head and run:

`Validate → Cloudflare/mobile readiness → City Visual Acceptance → Visual Acceptance → LENTE → ARTIST`

Only ARTIST may decide whether the result is eligible for the next human visual gate.
