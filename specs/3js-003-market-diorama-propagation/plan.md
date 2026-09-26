# Implementation Plan — 3JS-003 Market Diorama Style Propagation

## Verified baseline

- repository: `az1nn/growing-rio`;
- specification base: `master@bd4ef780649ee48fca91e2147872e06b3f1586d1`;
- 3JS-002 Grow Room is delivered with **ACCEPT** style status;
- accepted Grow Room implementation remains under `threejs/grow-room/`;
- canonical runtime remains Godot;
- exact Three.js version to reuse initially: `three@0.186.1`;
- no open PR existed when this specification wave was claimed;
- canonical Mercado ownership is defined by RB-01/RB-05: selling channels, contracts and buyer relationships, with district/compliance only as summaries.

## Delivery strategy

Implement 3JS-003 later as a separate bounded scene under:

`threejs/market-diorama/`

Do not modify gameplay/domain behavior, do not hand-edit generated `web/` output, and do not make Three.js a prerequisite for Mercado usability.

The first implementation pass should reuse the definitive 3JS-002 grammar before inventing any new visual token.

## Visual architecture

Suggested module boundaries:

- `src/main.js` — renderer lifecycle, resize and acceptance signals;
- `src/marketDiorama.js` — scene graph composition;
- `src/camera.js` — accepted fixed orthographic framing;
- `src/styleTokens.js` — imported/extracted definitive style values, with scene-local additions clearly separated;
- `src/materials.js` — reusable accepted material families;
- `src/props.js` — repository-authored abstract market/workspace prop families;
- `src/lighting.js` — accepted cool ambient/key/rim plus restrained warm practical hierarchy;
- `src/presentationModel.js` — immutable/read-only Mercado presentation data;
- explicit disposal for renderer, geometries, materials, textures and listeners.

Do not prematurely create a broad engine/runtime abstraction. A small shared 3JS style-token module may be extracted only if it preserves the accepted Grow Room behavior and makes the two scenes measurably easier to keep consistent.

## Definitive token baseline

The implementation must begin from the accepted values in `docs/VISUAL-DIRECTION.md`:

- fixed orthographic camera grammar;
- camera position `[8.4, 7.2, 10.9]`, target `[0, 1.15, 0.65]`, orthographic width `10.2`, portrait vertical bias `0.72` as the default starting frame;
- near-black blue/green envelope plus concrete/plaster, teal, dark metal, warm wood, terracotta, foliage, cool glass and warm-emissive palette roles;
- flat-shaded low-poly geometry and zero authored textures as the accepted default;
- ambient `0.86`, directional key `1.78`, rim `0.72`, warm practicals `48 / 6.8` and `18 / 5.4`, ACES exposure `1.08`, no dynamic shadows;
- world grid unit `0.5`, minimum silhouette target `0.12`;
- deliberate clustered props separated by negative space;
- DPR cap `1.5`, static/on-demand rendering by default, explicit teardown/disposal.

Scene-local composition may adjust object placement and focal emphasis. Any global-token deviation must be treated as a reviewable CENA decision, not an implementation convenience.

## Mercado composition hypothesis

Use a generic fictional business/workspace read rather than a literal shop or logistics simulation:

1. a clear architectural shell and front/work threshold;
2. one primary contract/review work zone;
3. one secondary relationship/context zone;
4. restrained storage/office silhouettes that communicate lived-in business use without operational detail;
5. warm practical focal points against the accepted cool/dark envelope;
6. enough negative space for portrait UI legibility.

Avoid route maps, real-world location labels, concealment/storage instructions, shipment workflows, packaging instructions or other operational illicit-market cues.

## Performance budget

- draw calls: <= 65;
- triangles: <= 35,000;
- material families: <= 10;
- authored runtime textures: 0 by default;
- DPR: <= 1.5;
- dynamic shadows: disabled;
- static/on-demand rendering unless a bounded visual need justifies animation;
- use instancing for repeated forms when materially useful.

## Validation

1. structural validation for the new package and exact Three.js pin;
2. regression validation for `threejs/grow-room/` so propagation cannot silently break the accepted baseline;
3. `npm ci` + deterministic build;
4. Chromium/SwiftShader render at 540x960 and 1080x1920;
5. empty console/page-error artifact;
6. renderer metrics inside budget;
7. lifecycle/disposal validation;
8. rendered comparison against the accepted Grow Room grammar and canonical Mercado UI;
9. explicit check that disabling/omitting the scene leaves Mercado complete;
10. exact-head evidence only.

## Concurrency

Before implementation and merge:

- re-read master and open PRs;
- treat changes to shared 3JS style tokens, visual-direction contracts, Mercado presentation contracts or shared acceptance workflows as semantic overlap;
- preserve current SIGA/CENA/LORE handoffs;
- never merge from stale CI or stale rendered evidence;
- use guarded merge with the exact current PR head when available.
