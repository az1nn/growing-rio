---
name: 3js
description: Continue DA LATA Three.js scene implementation and refinement from verified repository state while preserving CENA visual direction, LORE canon and SIGA engineering gates.
---

# DA LATA 3JS — Three.js Scene Continuation Skill

## Purpose

`3js` is the repository-local continuation command for **Three.js scene work** in DA LATA.

It combines three existing authorities without replacing them:

- **SIGA** owns repository reality, engineering delivery, Spec Kit, concurrency, CI and merge safety.
- **CENA** owns visual direction, composition, asset provenance and rendered acceptance.
- **LORE** owns narrative canon, including the `CÂNONE / RUMOR / ABERTO` distinction.
- **3JS** owns implementation and refinement of player-visible 3D scenes when the chosen renderer is Three.js.

The command is intentionally narrow. It is not permission to rewrite the game architecture, replace Godot, redesign the visual language or invent new canon.

Canonical trust order:

```text
LIVE REPOSITORY / CI
> RATIFIED CONSTITUTION + ACTIVE SPEC
> 3JS HANDOFF
> CENA VISUAL DIRECTION + CENA HANDOFF
> LORE CANON
> CHAT / MODEL MEMORY
```

## Repository identity lock

Canonical repository:

```text
az1nn/growing-rio
```

Before any read beyond identity or any mutation:

1. verify the repository full name exactly;
2. verify the default branch and exact HEAD;
3. read open PRs/branches that may overlap scene, Web or rendering work;
4. load `.agents/skills/siga/SKILL.md`;
5. load `.agents/skills/siga-concurrency/SKILL.md` before mutation;
6. load `.agents/skills/cena/SKILL.md`;
7. load the smallest relevant LORE sources only when the target scene depicts canonical narrative content.

If the repository identity does not match, stop with:

```text
3JS_REPO_MISMATCH
```

No cross-repository mutation is allowed.

## Trigger

Treat `3js` as the standalone magic continuation command, ignoring case, surrounding whitespace and terminal punctuation.

Examples:

```text
3js
3JS
3js!
```

Prose that merely mentions Three.js does not automatically invoke the continuation protocol.

## Scope owned by 3JS

3JS may own:

- Three.js `Scene` composition;
- `WebGLRenderer` configuration;
- orthographic or perspective camera implementation required by an accepted visual target;
- geometry, instancing and scene graph composition;
- Three.js materials and lighting;
- glTF/GLB loading and adaptation when licensed assets are explicitly approved;
- environment/background treatment;
- non-mechanical presentation animation;
- resize/resolution handling;
- scene lifecycle, disposal and GPU-resource cleanup;
- draw-call, geometry, texture and shader budgets;
- mobile/Web performance tuning;
- deterministic scene builders and presentation adapters;
- visual-regression hooks and screenshot evidence;
- a read-only presentation adapter from canonical game state into Three.js.

3JS must not silently become:

- a gameplay/economy rewrite;
- save-schema ownership;
- a generic app architecture migration;
- a full Godot replacement;
- new narrative canon;
- a real-world cultivation simulator;
- an asset-pack import with unclear provenance;
- a visual redesign that bypasses CENA.

When the work crosses those boundaries, persist the dependency and route it through SIGA, CENA or LORE.

## Current visual baseline — preserve by default

Until a bounded CENA decision explicitly changes direction, Three.js work must preserve the accepted DA LATA presentation grammar:

- **orthographic diorama** as the default operation-space composition;
- **presentation-first 2D/3D hybrid**, with UI remaining legible over the scene;
- portrait-first acceptance at **540x960** and **1080x1920**;
- strong silhouettes and readable spatial layers before micro-detail;
- restrained, reusable materials rather than asset-store collage;
- concrete slab / warm plaster structural language;
- dark-metal trim, joints, frames and reveals;
- teal accents/lower-wall treatment;
- terracotta planters and restrained low-poly foliage;
- cool/warm two-light balance;
- visible but non-dominant architectural rhythm such as floor joints, wall bays and window mullions;
- translucent low-priority feedback surfaces where the diorama should remain visible;
- no gratuitous photorealism;
- no external runtime asset without provenance/license review.

This baseline is a **style lock**, not a permanent technology lock.

3JS may improve fidelity, depth, animation, atmosphere, material response and performance only when the change still reads as the same game and passes CENA acceptance.

## Runtime ownership rule

Godot remains the canonical runtime unless an active, bounded specification explicitly changes runtime ownership.

Therefore:

```text
Three.js prototype/parity work != automatic runtime migration
```

The first Three.js implementation must be additive and reversible. It must not silently replace the stable boot path, gameplay state, save path or accepted Godot scene.

Generated Godot Web export files are outputs, not a safe place to hand-author a Three.js subsystem.

## Start protocol

Every standalone `3js` begins VERIFY-FIRST.

### 1. RECONCILE

Read live state and the smallest sufficient evidence set:

```text
.agents/skills/siga/SKILL.md
.agents/skills/siga-concurrency/SKILL.md
.agents/skills/cena/SKILL.md
docs/3JS-HANDOFF.md
docs/3JS-ARCHITECTURE.md
docs/VISUAL-DIRECTION.md
docs/CENA-HANDOFF.md
.specify/memory/constitution.md
```

Then inspect, when relevant:

- active Three.js spec/plan/tasks;
- current Web/export structure;
- package/dependency manifests;
- scene assets and provenance;
- open CENA/SIGA/3JS PRs;
- exact-head CI;
- relevant lore docs.

Do not assume Three.js is already installed. Verify first.

### 2. CLASSIFY

Choose exactly one:

```text
3JS-RESUME
3JS-WATCH
3JS-ADVANCE
3JS-BLOCKED
```

**3JS-RESUME** — active Three.js work is incomplete and safe work remains.

**3JS-WATCH** — implementation is dispatched and the only remaining action is an active exact-head CI/render/deploy/review gate.

**3JS-ADVANCE** — prior Three.js work is verifiably complete; begin the next bounded scene capability.

**3JS-BLOCKED** — continuation requires an unresolved architecture decision, CENA art-direction decision, LORE canon decision, license decision or unavailable acceptance evidence.

### 3. ALIGN

Before changing visuals, reconcile the target against CENA.

Before depicting narrative facts, reconcile against LORE.

Before changing integration/runtime architecture, reconcile against SIGA + the active spec.

A Three.js implementation detail must not become a new visual or narrative authority merely because it is easier to code.

### 4. SPEC

Any new player-facing Three.js runtime capability must follow the repository constitution:

1. create/select a bounded Spec Kit feature;
2. define user value and acceptance criteria;
3. define technical plan and file-level tasks;
4. mark explicit out-of-scope boundaries;
5. only then implement.

A pure repair restoring an already-specified Three.js behavior may use the smaller repair path.

### 5. IMPLEMENT

Prefer small scene modules with explicit ownership:

- scene construction;
- camera;
- lighting;
- materials;
- assets/loaders;
- resize/resolution;
- state-to-presentation adapter;
- lifecycle/disposal;
- visual test hooks.

Keep domain logic outside the renderer.

If Three.js is introduced as a dependency, pin the exact version in the project manifest/lockfile and record the choice in the active plan. Do not rely on an unpinned CDN as the production dependency path.

### 6. PARITY FIRST

For a scene translated from the accepted Godot presentation, prove visual parity before redesign.

Parity evidence should cover:

- camera/framing;
- major masses and silhouette;
- foreground/background hierarchy;
- palette/material family;
- light direction and warm/cool balance;
- UI-over-3D legibility;
- portrait composition;
- named canonical props/locations when applicable.

Do not chase pixel identity. Preserve the visual language and player-readable hierarchy.

### 7. VALIDATE

A 3JS wave is not complete because it renders locally.

Require applicable evidence for the exact current head:

**Repository**
- project validation succeeds;
- dependency/build checks succeed;
- no unresolved references/imports.

**Renderer**
- scene boots without console/page errors;
- resize is deterministic;
- resources are disposed when scenes are destroyed/replaced;
- no runaway render loops/listeners;
- no obvious shader/material fallback defects.

**Visual**
- CENA style lock is preserved unless the active wave explicitly changes it;
- 540x960 and 1080x1920 captures are reviewed when the scene is player-facing;
- no obvious clipping, z-fighting or UI occlusion;
- important silhouettes and canonical objects remain readable.

**Performance**
- avoid gratuitous geometry/material duplication;
- reuse geometries/materials where practical;
- use instancing for repeated objects when it materially reduces cost;
- constrain texture dimensions;
- limit dynamic lights/shadows to demonstrated need;
- record a Web/mobile performance budget in the active plan for production scenes.

**Delivery**
- CI evidence must match the exact PR head;
- a deployment/provider quota may be a soft gate only when it is explicitly a provider limit and internal validation is green;
- never claim public parity from stale deployment evidence.

### 8. PERSIST

Update:

```text
docs/3JS-HANDOFF.md
```

Record:

- verified repository/base/head;
- route;
- active spec/wave;
- target scene;
- visual baseline used;
- CENA/LORE dependencies;
- files/modules changed;
- Three.js version/dependencies when present;
- asset provenance;
- validation evidence;
- known debt;
- next action.

Do not store canonical 3JS continuation state outside the repository.

## Concurrency rules

3JS inherits SIGA concurrency rules.

Before mutation:

- snapshot default HEAD;
- inspect open PR overlap;
- claim a dedicated branch;
- capture blob SHAs for same-path edits.

Before each write batch:

- re-read relevant live state;
- treat overlapping scene/render contracts as semantic overlap even when filenames differ;
- never overwrite newer CENA/SIGA/LORE handoffs;
- never merge based on stale exact-head validation.

Open CENA scene work is not automatically a blocker. It is a blocker only when the Three.js wave depends on or would reinterpret the same visual contract without reconciliation.

## CENA coordination

CENA is the visual authority.

3JS should ask, in repository terms:

```text
What should this scene look/read like?
-> CENA

How should that accepted target be implemented in Three.js?
-> 3JS
```

If 3JS discovers a better-looking direction, record it as a proposal and route the direction change through CENA before treating it as accepted.

## LORE coordination

LORE is the canon authority.

3JS may render canonical places, symbols, characters, props and campaign moments, but:

- never promote `RUMOR` to `CÂNONE`;
- never close an `ABERTO` question through environmental art;
- never invent political parties, real politicians or targeted political persuasion;
- keep cultivation and parallel-market depiction abstract rather than instructional.

If the scene needs an undefined narrative fact, route that question to LORE.

## First bounded implementation target

Unless live state supersedes it, the first product wave is:

```text
3JS-001 — OperationDiorama parity proof
```

Goal:

- reproduce the accepted OperationDiorama visual grammar in Three.js;
- preserve orthographic framing and portrait-first composition;
- recreate only the minimum room shell, slab, architectural rhythm, planters/foliage, lighting and material families needed to prove parity;
- feed it from a read-only presentation model;
- keep the stable Godot runtime intact;
- capture 540x960 and 1080x1920 evidence;
- measure Web performance before any migration discussion.

Out of scope for 3JS-001:

- replacing the canonical game runtime;
- changing gameplay;
- changing persistence;
- redesigning the visual identity;
- adding broad third-party asset packs;
- changing lore.

## Final invariant

```text
3JS = VERIFY LIVE STATE
    -> ALIGN WITH SIGA + CENA + LORE
    -> SPEC THE BOUNDED CAPABILITY
    -> IMPLEMENT THREE.JS
    -> PROVE VISUAL PARITY
    -> VALIDATE EXACT HEAD
    -> PERSIST
```
