# T013 — bounded ARTIST V1 renderer-treatment spike

**State:** READY_TO_EXECUTE after same-head T010/T011 captures.  
**Accepted visual target:** `operation-concept-acceptance.md`.  
**Constraint:** do not rebuild the full Operation twice and do not disturb gameplay/state ownership while measuring renderer fit.

## Question this spike must answer

Can the accepted Operation V1 visual language — chunky apparent pixels, crown/graffiti focal surface, dark navy structure with cyan/magenta/amber accents, and readable workbench geometry — be added to the canonical runtime without introducing a second production renderer boundary?

The spike is deliberately smaller than the final Operation slice. It is evidence for T015, not a substitute for T030–T039.

## Shared visual sample

Test exactly these three deltas, preserving current camera and semantic interaction wiring:

1. **Scene-only pixel treatment**
   - Godot UI remains full-resolution.
   - 3D presentation gets a controlled low-resolution / nearest-neighbor treatment at portrait widths.
   - No global page/CSS pixelation and no screenshot-as-wallpaper substitution.

2. **One graffiti/crown focal surface**
   - use authored geometric/procedural crown/tag vocabulary only;
   - no baked gameplay text;
   - no real mural copying;
   - surface must visibly carry hot-pink/cyan/amber on dark structural mass.

3. **One representative workbench cluster**
   - preserve current workbench physical geometry as the representative prop;
   - add only enough material/edge treatment to test V1 readability;
   - do not model the entire accepted room during this spike.

## Godot candidate

Files allowed for the bounded spike:
- `scenes/visual/operation_diorama.tscn`
- a dedicated V1 spike shader/material under `resources/visual/v1/spike/`
- narrowly scoped validation tests for the spike.

Expected implementation shape:
- keep the existing `SubViewport` as the 3D isolation boundary;
- test a lower internal render resolution / nearest filter strategy or a Compatibility-safe scene-only shader;
- add a small crown/tag geometry or material surface to the existing wall plane;
- preserve `Area3D`, `object_activated`, fallback buttons, canonical `GameState`, camera transform and Operation UI.

Hard failure conditions:
- Control UI is pixelated;
- pointer/touch picking is displaced from visible objects;
- visual treatment requires a static accepted-concept image in runtime;
- canonical state or save behavior changes;
- GL Compatibility/Web export fails.

## Three.js comparison lane

Do **not** rebuild the room. Apply the same bounded questions to `threejs/operation-diorama` only:
- lower-resolution / nearest-looking renderer presentation at the same CSS viewport;
- one crown/tag surface;
- workbench material treatment;
- retain deterministic resize/dispose metrics.

Three.js evidence is still a **standalone reference lane**. It must not be wired into the shipped game during T013. A production bridge is only justified if T014 evidence later supports `THREEJS_PRODUCTION_V1`.

## Measurements to persist in T014

For both 540×960 and 1080×1920:
- screenshot artifact linked to exact 40-char commit;
- browser console/page errors;
- build/export result;
- renderer/scene metrics already available from each harness;
- visual observations against the same accepted Operation reference:
  - chunky apparent pixel scale,
  - crown/graffiti legibility,
  - workbench silhouette,
  - UI-safe region,
  - obvious input alignment issue: yes/no;
- implementation delta: changed files and added runtime boundary count.

Do not fabricate FPS, GPU time, memory, or device metrics that are not actually measured.

## Decision rule

T013 passes when both paths have enough bounded evidence for T014, **not** when one path merely looks prettier.

T015 then records one of:
- `GODOT_NATIVE_V1`
- `THREEJS_PRODUCTION_V1`
- `BLOCKED_NEEDS_PRODUCT_DECISION`

The current architecture remains provisionally Godot-native until T014 is complete.
