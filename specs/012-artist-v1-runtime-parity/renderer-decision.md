# Feature 012 — Renderer decision

**Decision state:** FINAL  
**Decision:** `GODOT_NATIVE_V1`  
**Locked by:** SIGA architecture gate R02  
**Evidence package:** `R01-RENDERER-EVIDENCE.md`  
**Decision date:** 2026-09-30

## Decision

DA LATA V1 uses **Godot 4.7.2 / GL Compatibility as the single production 3D renderer**.

Three.js remains a bounded reference/prototyping lane. It is not part of the shipped V1 runtime, does not receive new production-scene ownership, and does not require a Godot↔Three.js state/input bridge for V1.

This is a production-ownership lock, not a deletion decision. Existing Three.js evidence/packages remain available until the final repository-hygiene item decides their long-term archival disposition.

## Evidence used

R01 compared the two renderer candidates from exact repository heads at 540×960 and 1080×1920.

### Same-head baseline

Exact head: `ad66752650461676a621bbbf45e57daabe5ac67a`  
Workflow run: `36761814609` — SUCCESS.

Godot:
- existing canonical game runtime;
- full viewport canvas at both target sizes;
- browser/page error list empty;
- Web export measured at `index.pck=8,308,868`, `index.wasm=39,514,754`, `index.js=279,815` bytes.

Three.js:
- `three@0.186.1`;
- 49 draw calls;
- 1,932 triangles;
- 4 geometries;
- 8 materials;
- 0 authored scene textures;
- DPR 1;
- shadows disabled.

Both baseline renders were materially below the accepted ARTIST V1 target. Baseline visual fidelity therefore did not justify selecting either renderer by appearance alone.

### Bounded V1 treatment spike

PR #193 exact evidence head: `c6801a0829f72c620c7d9344d8033bcb496f5e91`.

Green exact-head evidence:
- Validate project `36760974637` — SUCCESS;
- Three.js visual acceptance `36760974583` — SUCCESS;
- Godot visual acceptance `36760974674` — SUCCESS.

Both paths demonstrated the bounded treatment: lower-resolution/chunky sampling, V1 accent color, physical crown/graffiti motif and preserved camera/massing. The Three.js spike remained lightweight (54 draw calls, 1,992 triangles, 4 geometries, 8 materials), but did not demonstrate a visual or measured advantage that offsets a second production runtime boundary.

## Architecture rationale

### Godot already owns the required product contracts

- canonical `GameState` and persistence;
- navigation and scene lifecycle;
- authored full-resolution UI;
- pointer/touch 3D picking;
- semantic hotspot routing;
- accessible fallback controls;
- current Web export and Vercel packaging;
- current exact-head visual/LENTE capture path.

R01 showed that V1 presentation treatment can be applied inside this existing boundary without moving gameplay state or UI ownership.

### Three.js production would add contracts without removing the dominant work

Production Three.js would still require new supported bridges for:
- canonical Godot state → Three.js presentation;
- Three.js hotspot events → Godot/UI behavior;
- pointer/touch ownership arbitration;
- accessibility/focus synchronization;
- route mount/unmount lifecycle;
- combined build and deployment packaging;
- cross-runtime visual/interaction regression.

The dominant V1 work—authored geometry, materials, low-resolution texture language, graffiti/decal vocabulary, scene composition and eleven-scene acceptance—exists regardless of renderer. R01 produced no compensating benefit that justifies introducing those additional runtime boundaries.

## Locked production architecture

```text
ARTIST V1 accepted scene target
          |
          v
CENA decomposition + authored assets
          |
          v
GODOT 4.7.2 / GL Compatibility
  scene-only V1 render layer
          |
          +--> existing Area3D semantic hotspots
          |
          +--> existing full-resolution Control UI
          |
          v
canonical GameState / persistence
          |
          v
Web export / deployment
          |
          v
LENTE exact-head comparison
          |
          v
ARTIST/CENA runtime acceptance
```

No generated concept image may be substituted for physical interactive 3D geometry.

## Three.js disposition

PR #193 is an **evidence spike**, not production code. Its exact commit and green runs remain the R01 evidence source. The PR is to be closed **unmerged** after this R02 decision is recorded.

For V1:
- do not expand Three.js into Campaign, Narrative or Finale production scenes;
- do not add a Godot↔Three.js runtime bridge;
- retain existing packages only as historical/reference prototypes;
- postpone deletion/archive cleanup to the final repository-hygiene roadmap item.

## User-approved interpretation: reuse is not justification

The user explicitly approved the following architectural interpretation after reviewing the renderer alternatives and the ARTIST V1 target:

- Existing Three.js prototypes are **evidence and R&D assets, not a production entitlement**. Their existence does not create a requirement to preserve renderer parity or expand Three.js to the remaining V1 scenes.
- DA LATA must avoid **sunk-cost architecture**. Prior Three.js work is considered successful even when it is not shipped, because it supplied browser-rendering experiments, comparison evidence, lifecycle/performance knowledge and the bounded R01 decision input.
- Three.js would only have been selected if #193 had demonstrated a **material advantage large enough to pay for the permanent second-runtime cost**. Small visual gains, similar performance, developer familiarity or reuse of prototype boilerplate are not sufficient.
- Because R01 showed comparable ability to apply the required V1 treatment without a compensating Three.js advantage, the correct production outcome is the lower-duplication architecture: **Godot remains the sole production renderer for V1**.
- Other browser render stacks such as PlayCanvas, Babylon.js or React Three Fiber are not substitutes that need another V1 spike. They inherit the same fundamental second-runtime/state-input-accessibility/build bridge problem while having less existing project reuse than Three.js. Introducing one now would violate the constitution's small-coherent-wave principle. A future Web-first replatform requires a separate bounded Spec Kit architecture feature.
- Developer experience remains a valid engineering concern, but for V1 it should be improved **around the Godot authoring pipeline** rather than by adding another production renderer: declarative scene/composition data, low-resolution atlas/material tooling, import/generation helpers, rapid preview and LENTE automation are preferred directions.
- Historical Three.js packages may remain until R16 repository hygiene decides archival/removal. They must not silently regain production ownership through later scene work.

This interpretation strengthens the existing `GODOT_NATIVE_V1` lock; it does not create a new architecture decision or reopen R02.

## Consequences for the next roadmap item

R03 builds the shared ARTIST V1 runtime visual system **in Godot**:
- scene-only pixel strategy with full-resolution UI;
- reusable V1 material/texture/decal vocabulary;
- graffiti/stencil pipeline;
- asset provenance;
- normalized composition/hotspot anchors;
- structural/visual validators;
- measured Web/mobile budget.

Operation production work remains locked until R03 passes.

## Decision integrity

This decision does **not** claim:
- Operation already matches the accepted concept 1:1;
- PR #193 is production-ready;
- any later scene is concept/runtime accepted;
- Vercel quota failures are code failures.

The next architecture change from `GODOT_NATIVE_V1` requires a new explicit SPEC/ADR-level decision with evidence; it must not occur implicitly inside a scene implementation.
