# R03 V1 Web/mobile performance budget — T026

**Source evidence:** Feature 012 R01 exact-head renderer evidence.  
**Purpose:** establish measured guardrails for the shared visual system; do not invent frame-time data that R01 did not capture.

## Measured baseline

From `R01-RENDERER-EVIDENCE.md` at exact head `ad66752650461676a621bbbf45e57daabe5ac67a`:

- Godot Web `index.pck`: **8,308,868 bytes**
- Godot Web `index.wasm`: **39,514,754 bytes**
- Godot Web `index.js`: **279,815 bytes**
- browser/page errors: **0**
- validated portrait captures: **540×960** and **1080×1920**

The bounded 2× pixel-treatment spike demonstrated the intended internal raster relationship:

- 540×960 presentation → **270×480** internal 3D raster
- 1080×1920 presentation → **540×960** internal 3D raster

R01 did **not** persist trustworthy Godot FPS, frame-time, draw-call or triangle counters. T026 therefore does not fabricate them.

## R03 guardrails

| Metric | R03 budget | Rationale |
|---|---:|---|
| Default scene shrink | **2×** | directly demonstrated by R01 treatment |
| Max shared shrink | **4×** | bounded by `V1PixelRenderPolicy`; anything higher requires new evidence |
| UI raster | **full resolution** | UI is outside scene SubViewport |
| `index.wasm` growth | **≤1%** vs 39,514,754 B unless engine/modules change | shared art system should not materially change engine binary |
| `index.js` growth | **≤5%** vs 279,815 B | allows export-wrapper variation while flagging unexpected growth |
| R03 shared-system `index.pck` growth | **≤500,000 B** vs 8,308,868 B | R03 contains reusable code/metadata, not scene production textures |
| Browser/page errors | **0** | preserved R01 baseline |

## R04 instrumentation debt

Operation V1 (R04) must add/persist renderer runtime measurements for the selected Godot path before production-scene acceptance: representative frame time/FPS plus scene geometry/resource counters appropriate to Godot GL Compatibility. Those values become the scene-production budget for R05–R14.

This debt does not invalidate T026 because the current budget contains only metrics R01 actually measured and explicitly scopes the missing instrumentation.
