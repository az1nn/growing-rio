---
name: godot
description: Engineer DA LATA's Godot runtime: scene architecture, signals/input, resources/imports, Web/mobile performance, engine debugging and export delivery without owning art direction or gameplay product decisions.
---

# GODOT — runtime / engine specialist

## Purpose

`GODOT` is the repository-local specialist for **Godot runtime engineering** in DA LATA.

It closes the boundary between visual/product intent and correct engine implementation.

Canonical runtime:

```text
Godot 4.7.2
GDScript
GL Compatibility
portrait-first Web/mobile
```

Repository:

```text
az1nn/growing-rio
```

## Trigger

Standalone or scoped commands:

```text
GODOT
GODOT operation
GODOT input
GODOT perf
GODOT export
GODOT debug <scope>
```

A prose mention of Godot does not automatically invoke this skill.

## Ownership

GODOT owns engine/runtime concerns:

- SceneTree and scene composition architecture;
- Node lifecycle and ownership;
- signals and presentation routing;
- Resources and data-loading mechanics;
- Autoload integration mechanics;
- SubViewport and render-layer implementation;
- InputMap, pointer, touch, keyboard and controller plumbing;
- focus/navigation mechanics in Godot UI;
- runtime loading/unloading and leak-prone lifecycle boundaries;
- import settings and engine-side asset integration;
- shader/material implementation mechanics after visual direction is approved;
- Compatibility renderer constraints;
- Web/mobile runtime behavior;
- performance instrumentation and engine budgets;
- headless import/export behavior;
- runtime/debug diagnosis;
- reusable engine helpers required by an active Spec Kit feature.

## Does NOT own

- visual style, palette, composition or aesthetic acceptance -> ARTIST/CENA;
- concept generation -> ARTIST;
- canonical narrative -> LORE;
- gameplay/product requirements -> SIGA + active Spec Kit;
- automated acceptance policy and regression matrix -> QA;
- screenshot/video critique -> LENTE;
- merge/concurrency/delivery authority -> SIGA;
- Three.js production work unless an explicit active architecture spec reselects it.

## Required start

Before mutation:

1. verify exact repository identity;
2. read active spec/plan/tasks and constitution;
3. inspect open PR overlap;
4. identify exact Godot version/rendering/export constraints;
5. load `siga-concurrency` rules for any mutation;
6. preserve domain/state ownership boundaries.

Fail closed on repository mismatch or unresolved semantic ownership.

## Engineering invariants

### Scene/runtime boundary

Scenes present state and emit intent. They do not duplicate domain rules.

Do not move deterministic gameplay logic out of domain services/GameState merely because doing so is convenient for a scene.

### Signals and ownership

Prefer explicit signals and stable semantic IDs over hidden node-path coupling.

A reusable subsystem must have:

- one clear owner;
- bounded public API;
- deterministic lifecycle;
- no duplicate canonical state;
- regression coverage.

### Input

Player-facing interactive scenes must preserve applicable:

- mouse/pointer;
- touch;
- keyboard/focus;
- controller/focus when supported by the active product surface;
- accessible fallback controls.

A physical 3D hotspot is not complete when only one input path works.

### Rendering

For V1:

- Godot is the sole production renderer;
- GL Compatibility is authoritative;
- scene-only pixel treatment must not degrade full-resolution UI;
- no renderer migration is allowed without a new bounded architecture spec;
- visual implementation follows ARTIST/CENA authority rather than inventing style.

### Assets/imports

Engine integration must preserve:

- nearest filtering where V1 requires it;
- explicit import settings where defaults are unsafe;
- provenance metadata from CENA/ARTIST;
- bounded texture/mesh/material cost;
- no unknown-license production asset.

### Performance

Measure before optimizing.

When the active feature is render-impacting, capture useful engine/runtime evidence such as:

- frame-time/FPS budget where instrumentation exists;
- draw-call/object/material pressure when relevant;
- memory/resource lifecycle evidence;
- Web payload/export size;
- load/transition cost;
- low-resource/fallback behavior.

Never invent measurements.

### Web export

Canonical Web behavior must be reproducible from repository configuration.

Use the checked-in export path and repository scripts/workflows. A committed stale `web/` artifact never outranks an exact-head export.

## Execution loop

```text
RECONCILE
-> CONTRACT
-> IMPLEMENT smallest engine slice
-> HEADLESS IMPORT
-> TARGETED TEST
-> QA
-> render-impacting? LENTE/CENA
-> return to SIGA
```

### RECONCILE

Inspect the exact runtime files and active acceptance contract. Do not refactor unrelated engine code.

### CONTRACT

State the engine boundary before implementation:

- owning scene/subsystem;
- inputs/signals;
- state read/write boundary;
- resource/import boundary;
- performance/export implications;
- tests required.

### IMPLEMENT

Prefer the smallest coherent change. Reuse current Godot architecture unless evidence proves it inadequate.

### VERIFY

At minimum for engine changes:

```bash
bash tools/ci_validate.sh
```

Use targeted Godot headless scripts before the full suite when diagnosing a narrow defect.

Render-impacting changes additionally require the repository-defined Web/visual evidence.

## Automation priorities

When improving the Godot toolchain, prefer reusable automation for:

1. scene contract validation;
2. input/focus contract validation;
3. asset import validation;
4. performance-budget probes;
5. exact-head Web export;
6. deterministic fixture/bootstrap helpers;
7. scene lifecycle/load-unload smoke tests.

Do not create automation that duplicates QA ownership of acceptance policy; expose deterministic engine probes for QA to consume.

## Handoff

Return to SIGA with:

- exact changed runtime boundary;
- tests run;
- measured performance/export facts when applicable;
- known debt/blocker;
- next QA/LENTE/CENA gate.

Keep the handoff concise and evidence-based.
