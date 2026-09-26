# CENA-020 — Market visual target

Date: 2026-09-26  
Repository: `az1nn/growing-rio`  
Renderer implementation owner: `3js`  
Visual authority: `CENA`

## Status

`CENA-ADVANCE -> CENA-WATCH`

This wave defines the next bounded visual target after the accepted 3JS-002 Grow Room style lock. It does **not** implement a new Three.js runtime scene. Runtime implementation must begin through a bounded Spec Kit package owned by the repository-local `3js` workflow.

## Why Market is next

The current shell exposes these primary player surfaces in order:

1. Operação
2. Mercado
3. Cidade
4. Institucional
5. Arquivo

Operação now has the accepted Grow Room visual baseline. `scenes/market/market_surface.tscn` remains a Control-only information/action surface with no dedicated 3D scene. Mercado is also the next direct step in the existing management loop after operation output is available, so it is the smallest player-visible visual gap rather than a broad multi-screen redesign.

## Visual question

How should Mercado inherit the accepted DA LATA Grow Room grammar while reading immediately as a fictional wholesale/deal space, preserving the existing UI-over-3D composition and keeping all market channels abstract/non-operational?

## Reference research

Reference-only. No source image, logo, signage, branded product, layout, mesh or texture is imported.

### CADEG / Mercado Municipal do Rio de Janeiro
- Official market overview: https://cadeg.com.br/mercado-municipal-rj/
- Official background/history: https://cadeg.com.br/2015/08/11/por-dentro-do-mercado/
- Interior photo/article reference: https://odia.ig.com.br/rio-de-janeiro/2024/08/6897830-cariocas-vao-as-compras-no-cadeg-em-preparativos-para-o-almoco-do-dia-dos-pais.html

Useful visual facts:
- long covered commercial aisle;
- industrial roof and repeated structural rhythm;
- mixed cool overhead light with warmer stall-local light;
- stacked boxes/crates and handcart silhouettes;
- narrow circulation lane with strong depth cue;
- service/loading character without requiring a photorealistic warehouse.

### COBAL Humaitá / Leblon
- Rio heritage decree: https://www.rio.rj.gov.br/dlstatic/10112/4722991/4122101/267DECRETO34796CobaldoLebloneCobaldoHumaita.pdf

Useful visual facts:
- market architecture values roof volume, ventilation and natural-light character;
- individual boxes/stalls may modernize while the larger structural language remains legible.

## DA LATA interpretation

This is **not** a literal CADEG or COBAL recreation.

The Market scene should be an original fictional compact wholesale/deal bay with:

- fixed orthographic / near-isometric miniature composition;
- a strong longitudinal aisle or service-lane depth cue;
- one foreground contract/deal counter;
- one mid-ground vendor/storage bay with restrained stacked crate silhouettes;
- one background loading/service zone with shutter, mesh or frame rhythm;
- one cart/trolley silhouette as a readable commerce cue;
- cool industrial overhead light plus one restrained warm vendor practical;
- accepted dark envelope, concrete/plaster, dark metal, warm wood and teal accent families;
- authored clutter, but deliberate negative space around the decision UI;
- no copied signs, brands, vendor identity or real-world product packaging.

The scene should feel commercial and lived-in, but remain a stylized management backdrop rather than a logistics simulator.

## Safety / content boundary

Mercado must preserve the existing product abstraction:

- no real-world trafficking, evasion or distribution procedure;
- no route maps, concealment methods, quantities, timing, contacts or operational market logistics;
- parallel-market content remains represented only through the existing abstract risk/reward systems;
- no real institution, business or district is depicted as participating in the game's fictional trade.

## Style inheritance

Inherit the accepted 3JS-002 Grow Room tokens unless the later bounded Market spec proves a need to vary them:

- fixed orthographic miniature/cutaway read;
- flat-shaded chunky low-poly geometry;
- near-black blue/green envelope;
- concrete gray, warm plaster, dark metal, warm wood and teal accents;
- high-roughness structural surfaces;
- cool ambient/key separation with selective warm practical focus;
- no dynamic shadows by default;
- portrait-first readability;
- deliberate clustered props rather than uniform clutter;
- zero authored textures as the baseline, unless a later spec explicitly justifies otherwise.

## Composition contract

At 540x960 and 1080x1920, the 3D scene must remain understandable without labels:

- **foreground:** deal/contract counter and one strong commerce prop;
- **mid-ground:** vendor/storage bay with crates/shelving;
- **background:** aisle/loading/service rhythm that gives depth without stealing focus;
- **UI reserve:** darkest/quietest negative-space region remains available behind high-priority controls.

## Acceptance target for the future 3JS implementation

A future `3JS-003` Market spec should require:

1. exact-head repository validation;
2. dedicated 540x960 and 1080x1920 rendered captures;
3. empty browser console/page-error evidence;
4. UI legibility over the scene;
5. the scene reads as Mercado without relying on copied real-world signage;
6. Grow Room style continuity is evident without cloning its room layout;
7. no operational market/logistics detail is introduced;
8. renderer performance/lifecycle budgets are defined by the 3JS spec before implementation;
9. explicit CENA rendered review result: `ACCEPT` or `REVISE`.

## Provenance

Runtime assets introduced by CENA-020: **none**.  
Third-party runtime assets: **none**.  
Reference images copied into the repository: **none**.  
License/attribution dependency: **none** for runtime.

The external sources above are research references only.
