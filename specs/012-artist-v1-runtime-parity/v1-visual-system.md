# R03 Shared ARTIST V1 Visual System — T020 pixel render policy

**Status:** T020 implemented; R03 remains CURRENT  
**Renderer:** Godot-native / GL Compatibility  
**Authority:** Feature 012 + locked ARTIST V1 board/style guide

## Decision

Pixel treatment is **scene-only**. The existing 3D `SubViewport` is the render boundary; authored UI remains at the normal application resolution.

The reusable policy is `res://scenes/visual/v1/v1_pixel_render_policy.gd`.

For a scene container:

1. keep the scene inside its existing `SubViewportContainer`;
2. enable container stretch;
3. set `stretch_shrink = 2` as the V1 baseline, producing a 2× lower internal 3D raster in each axis;
4. upscale with `CanvasItem.TEXTURE_FILTER_NEAREST`;
5. keep labels, buttons, overlays, navigation and accessibility controls outside that reduced-resolution viewport;
6. allow scene-specific shrink changes only through measured R03/R04+ evidence, bounded to 1–4.

## Why this is the shared baseline

- It satisfies FR-006 without pixelating gameplay UI.
- It keeps the canonical Godot state/input/accessibility architecture intact.
- It works in the existing GL Compatibility/Web path without a global post-process dependency.
- It creates deliberate chunky raster structure before authored low-resolution textures, decals and materials are added in T021–T023.
- It is reusable across current scene layouts: the Operation root can pass itself as the container, while scenes with nested viewport containers can pass that child.

## Interaction contract

This helper changes render resolution/filtering only. It MUST NOT:
- move cameras or hotspot geometry;
- alter domain/gameplay state;
- replace physical 3D anchors with a flat image;
- change full-resolution UI sizing;
- change semantic hotspot IDs or accessible fallback controls.

Pointer/touch and accessible fallback regression are verified when the first production scene becomes current (R04), then per scene.

## Acceptance for T020

T020 is complete when:
- the reusable policy exists;
- nearest-neighbor upscale and bounded scene shrink are encoded;
- the full-resolution UI boundary is documented;
- the structural CI test asserts the policy contract;
- repository validation passes on the exact PR head.

T021–T026 remain open and R03 cannot pass until their exit gates are satisfied.
