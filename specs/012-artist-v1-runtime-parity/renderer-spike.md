# T013 — Operation V1 renderer treatment spike

**Branch:** `spike/012-operation-v1-renderer`  
**Parent baseline:** `3ebaeba5d36e07e6a6d6054203143b92882204ad`  
**Scope:** deliberately bounded renderer experiment; not production acceptance.

## Hypothesis

The V1 concept can move materially closer to the approved pixel-graffiti language without replacing the gameplay/UI stack or rebuilding the whole scene twice. Test the same minimal treatment in both existing renderer candidates:

1. render only the 3D layer at a 2× lower internal resolution and upscale with nearest/pixelated sampling;
2. shift one existing accent slot to V1 hot pink and the workbench wood toward amber;
3. add one simple physical crown/graffiti wall motif from mesh geometry;
4. preserve the same camera, architecture, workbench, plant/storage silhouettes and hotspot semantics.

## Godot spike

- `OperationDiorama` keeps the existing `SubViewportContainer`; `stretch_shrink = 2` and nearest texture filtering apply only to that 3D presentation layer.
- Authored Controls/buttons remain outside the low-resolution framebuffer and retain full UI resolution.
- Existing terracotta slot becomes the hot-pink V1 accent; no new texture asset or PBR dependency is introduced.
- Five thin mesh strokes + a base create a physical crown mark on the wall. No baked wording or flat concept wallpaper.

## Three.js spike

- The WebGL framebuffer is half CSS width/height while camera math stays at actual viewport dimensions; CSS upscales with `image-rendering: pixelated`.
- Existing material count remains eight: terracotta is repurposed as hot pink, wood becomes warmer amber.
- The same simple crown geometry is added at matching scene coordinates.
- Metrics expose `pixelScale`, `framebufferWidth` and `framebufferHeight` for T014.

## Pass/fail questions

- Does the scene read more like deliberate chunky pixel art at 540×960 and 1080×1920 without pixelating UI?
- Is the crown/graffiti motif readable but subordinate to the three primary foci?
- Do pointer/touch hit regions and accessible fallbacks remain unchanged?
- Does either path require materially more integration work to obtain the same treatment?
- Do exact-head validators, Web builds and visual capture remain green?

A passing spike is evidence for T015; it is not permission to clone the treatment to all 11 scenes until Operation runtime review.


## Production-selection burden — user-approved criterion

Three.js does not receive production preference because its prototypes already exist. Existing implementation is reusable evidence, not architectural entitlement.

For this spike to support `THREEJS_PRODUCTION_V1`, the measured result must show a **material advantage** over the Godot path that is sufficient to justify the permanent cost of a second renderer/runtime bridge. Small visual differences, similar performance, renderer familiarity, or saved prototype boilerplate are insufficient.

If both paths can reach the ARTIST V1 target with comparable quality and performance, the lower-duplication result wins: the existing Godot runtime remains production renderer and Three.js stops at reference/lab scope.

The spike remains intentionally limited to Godot vs the already-existing Three.js candidate. Adding PlayCanvas, Babylon.js, React Three Fiber or another renderer would be a separate architecture/replatform specification, not R01 work.
