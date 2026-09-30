# Feature 012 — Renderer decision baseline

**Decision state:** PRELIMINARY  
**Current recommendation:** `GODOT_NATIVE_V1`  
**Decision gate owner:** SIGA architecture + CENA/ARTIST visual evidence

## What exists now

### Godot
- canonical runtime;
- owns UI, input, navigation, state, persistence and Web export;
- all canonical destinations already provide real 3D, Camera3D, lighting, pickable Area3D and accessible fallback;
- exact-head visual capture infrastructure already covers the 11 destination/phase views.

### Three.js
- isolated reference packages for six scene families;
- exact `three@0.186.1`;
- deterministic static rendering, resize, disposal and metrics are well-structured;
- packages are not part of the shipped Godot runtime or current Vercel output;
- current visual contract is deliberately primitive/low-poly;
- current packages generally enforce zero authored scene textures and no dynamic shadows;
- no equivalent V1 packages currently exist for Campaign, Narrative or Finale phases.

## V1 fit analysis

### Where current Three.js work helps
- renderer lifecycle discipline;
- camera/framing experiments;
- static visual acceptance harnesses;
- geometry/material performance instrumentation;
- isolated browser prototyping.

### Where it does not remove V1 work
V1 requires a new production art layer regardless of engine:
- pixel-art texture/atlas treatment;
- graffiti/stencil surfaces;
- denser scene-specific geometry;
- richer props;
- scene-specific atmosphere;
- new palette/lighting;
- 11-scene parity.

Reusing the existing Three.js package structure therefore saves some renderer boilerplate but not the dominant V1 content-production effort.

## Production architecture cost

Choosing Three.js for shipped V1 would introduce a second 3D runtime boundary beside Godot and require a supported bridge for:
- canonical state -> Three.js presentation;
- hotspot IDs -> Godot/UI focus;
- pointer/touch event arbitration;
- accessible fallback synchronization;
- lifecycle during scene navigation;
- responsive UI/scene composition;
- build/deploy packaging;
- visual testing across both systems.

That bridge has no demonstrated product value yet because Godot already owns these capabilities.

## Preliminary conclusion

For the stated goal "V1 implemented 1:1 in the playable game", Three.js is **not currently necessary** and the existing Three.js visual implementation is **not aligned with the new V1 target**.

The preferred architecture is:
- Godot = production scene renderer;
- ARTIST V1 = immutable visual target;
- CENA = decomposition/assets/composition authority;
- LENTE = exact-head visual verifier;
- Three.js = frozen reference/prototyping lane unless the Operation renderer spike proves a material advantage.

This is not a deletion decision. It is a production-ownership decision.

## Evidence still required before finalizing

The final decision should be locked only after:
1. current Godot Operation capture;
2. current Three.js Operation/Grow Room capture;
3. one minimal V1 pixel/graffiti material spike;
4. comparable Web/mobile metrics;
5. integration-cost verification.

If those results contradict the preliminary conclusion, amend the plan before runtime implementation.


## User-approved architectural interpretation — 2026-09-30

The user explicitly agrees with the following interpretation and it is now a binding decision criterion for the renderer gate:

1. **Existing Three.js work is not, by itself, a production justification.** Its current value is historical R&D, isolated browser prototyping, visual/performance evidence and comparison support for Feature 012.
2. **Avoid sunk-cost architecture.** The fact that six Three.js scene-family prototypes already exist does not justify building the remaining V1 scenes, maintaining renderer parity or adding a permanent second runtime.
3. **Three.js remains a production candidate only through the bounded Operation evidence spike.** To be selected, it must demonstrate a material product/engineering advantage over Godot that is large enough to pay for the permanent bridge cost: state presentation, hotspot routing, pointer/touch arbitration, accessibility synchronization, lifecycle, combined build/deploy, capture/testing and dual-runtime maintenance.
4. **If #193 does not prove that material advantage, the expected R02 outcome is `GODOT_NATIVE_V1`.** In that outcome, Three.js is frozen as reference/lab evidence; no new V1 scenes are added for parity, it is not packaged into the shipped runtime, and historical work may be archived or cleaned up only in the later bounded repository-hygiene decision.
5. **The prior Three.js investment is not considered wasted if production does not use it.** Its delivered value is the evidence and architectural learning used to make the renderer decision.
6. **Other Web render stacks are not added to the current spike.** PlayCanvas, Babylon.js, React Three Fiber or another browser renderer would incur the same fundamental second-runtime/bridge boundary with less project reuse than the existing Three.js prototype. Introducing one now would widen R01 beyond the constitution's small-coherent-wave rule. Any future Web-first replatform requires its own explicit bounded Spec Kit architecture feature.
7. **Developer experience remains a legitimate requirement, but should first be improved at the authoring/tooling layer.** If Godot satisfies ARTIST V1 visually and operationally, prefer better declarative scene data, asset tooling, generation/import helpers, fast preview and LENTE automation around the single Godot runtime rather than adopting a second production renderer solely for authoring preference.

This section does **not** finalize T015/R02 early. #193 must still produce the exact-head visual, performance and integration evidence required by the active roadmap. It records how that evidence will be interpreted once available.
