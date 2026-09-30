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
