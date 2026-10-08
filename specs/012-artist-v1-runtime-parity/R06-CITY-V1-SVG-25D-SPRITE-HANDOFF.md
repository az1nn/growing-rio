# R06 City V1 — modular SVG / Godot 2.5D sprite production

**State:** PROMPT_HANDOFF_READY / NO_NEW_ART_APPROVED  
**Task:** `012:R06:REJECT-02:SVG-25D` · **Repo:** `az1nn/growing-rio` · **PR:** #213 · **Roadmap:** R06 only; R07+ LOCKED.  
**ARTIST target (unchanged):** accepted City `20261004T110406Z/city`, SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`.  
**Human visual decision:** `REJECT_ALL` on previous A/B/C; five large panels / black stair void may not be reused as player-facing art.

## Architecture

- **Engine/runtime:** Godot Web, already integrated with gameplay, input and persistence.
- **Display:** stack separately produced transparent vector sprites (`TextureRect` under Control, or `Sprite2D`/`Parallax2D` when Camera2D is useful). Z-order, authored isometric front/side/roof illustrations, purposeful overlap, small parallax and perspective scaling create **2.5D**. No heavy volumetric scene build.
- **Controls:** separate native full-resolution DA LATA UI. Preserve existing `city/district_overlook`, `city/route_nodes`, `city/community_cluster` via current hidden Area3D adapter or screen-space overlays with **identical** semantic events and accessible buttons.
- **Art fence:** no single city wallpaper, no five giant flat cards, no additive polish on rejected huge facade quads, no low-poly boxes, no invented UI text or tourist landmark.

```text
CitySurface (native HUD + scene-safe controls)
  City2D (visible)
    SKY        atmospheric cool cyan/blue
    FAR        distant hills + 3–5 independent compact roof silhouettes
    UPPER      unique stacked house front/side/roof clusters
    MID        varied wall/shop/stair/rail cluster
    COMMERCE   inhabited market landing, warm windows, awnings
    NEAR       continuous descending stair, railing, plants, resident
  CityWorld3D (retained interaction-only adapter, visually hidden)
```

## Art production ledger

Each requested item is **one sprite object or coherent single building**, transparent outside its silhouette. Distinct families:

| Family | Original SVG modules | Focal requirement |
| --- | --- | --- |
| `sky-far` | sky/backdrop, three unique far housing/roof silhouettes | bright cool depth; only atmosphere may fill full frame |
| `upper` | house A front+side+roof, house B front+side+roof, water tank/terrace | staggered asymmetric roofline, authored paint |
| `mid` | left painted home, right worn masonry shop, window/shutter details | convincing scale and nonuniform wall wear |
| `commerce` | shop interior/opening, green + amber awnings, stall, two residents | human-scale active central landing |
| `stairs` | upper stair run, turning landing, lower run, two separate railings | continuous strong downhill compositional axis |
| `life` | person foreground, foliage clusters x3, cables x2, single mural field | foreground depth/utility scale and identity |

Use `assets/city/v1/svg25d/source/<family>/<sprite-id>.svg` for editable originals. `assets/city/v1/svg25d/layers.json` is the final placement/depth manifest **only when every referenced file exists**. Each object is unique enough to avoid stamp repetition. Source original art may be agent generated but ARTIST owns acceptance.

## Prompt handoff — one object per invocation

> **CENA/ARTIST SVG ASSET TASK:** Using the HUMAN-APPROVED DA LATA City concept `20261004T110406Z/city` and V1 graffiti/pixel style board as immutable reference, generate **exactly one** original transparent SVG sprite: `{sprite-id}` in `{family}` for `{layer}`. Draw a richly authored, chunky pixel-art/graffiti three-quarter isometric illustration with hard crisp edges, asymmetric silhouette, worn warm painted masonry, cool distant depth, readable roof/side/front drawing where appropriate, plausible human scale, distinct shutters/stairs/railings/plants/awnings, and restrained cyan/magenta/amber. Keep perspective/light/pixel scale consistent with the approved concept. Output vector `path`/`polygon`/`rect` groups with stable names, tight viewBox and TRUE TRANSPARENT BACKGROUND; provide target placement box `[x,y,w,h]` normalized to the diorama, depth coefficient 0..1, alignment/occlusion notes, palette and prompt/provenance. ABSOLUTELY NO scene-wide wallpaper, full-city render, giant empty colored wall, primitive low-poly, five planes, glow/blur, raster screenshot embedding, external images, SVG text, fabricated HUD/logo, real landmark or repeated graffiti stamp. Mark `ORIGINAL_SPRITE_CANDIDATE`, never `ACCEPT`. ARTIST must review one family before batch generation.

## Godot integration

The prepared unmounted `scenes/visual/city_svg25d_layers.gd` reads a final manifest with rows ordered far-to-near. Each row:

```json
{"id":"left-awning","path":"res://assets/city/v1/svg25d/source/commerce/left-awning.svg","rect":[0.10,0.47,0.38,0.16],"depth":0.65}
```

`rect` normalized within **diorama viewport**; `depth` 0 far/static → 1 foreground/fast. Use only genuine original assets. There is no runtime sprite manifest in this first handoff: creating placeholder paths or activating a blank prototype would regress visual delivery.

Godot typically rasterizes SVG at import; validate ThorVG subset, imported scale, nearest texture filtering, transparency and actual exported pixels. If unsupported SVG features force PNG runtime export, retain the editable SVG. Do not bake native HUD into art. The previous full-page/isolated 540x960 + 1080x1920 captures remain mandatory.

## Acceptance & validation

1. **Art:** match approved bright skyline, irregular interlocking upper buildings, warm human-scale commerce and detailed foreground stairs. No dominating cardboard walls or voids.
2. **Depth:** controlled ~4s left/right and small vertical pan shows far moving less than near, intentional occlusion and no detached sprite edges. Since City is 2.5D, backside geometry of a 3D orbit is **not** a valid visual failure.
3. **UX:** physical non-overlap among diorama, action row and scroll panel; test text/focus/touch at both portrait sizes; City→Market→City stays responsive.
4. **Engineering:** exact-head Godot import/export, CI, Cloudflare source SHA, browser logs and semantic IDs. Media-time capture budget unchanged.
5. **Gate:** LENTE captures actual runtime; ARTIST compares approved concept; only then human can accept or reject a new production candidate.

**Next:** CENA produces the first distinct front+side+roof building SVG sprite family for ARTIST review. Do not yet switch the player-facing City renderer.

Official references:
- https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_images.html
- https://docs.godotengine.org/en/stable/tutorials/2d/2d_parallax.html
