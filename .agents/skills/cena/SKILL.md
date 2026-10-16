---
name: cena
description: Reconcile, research, generate, adapt and validate DA LATA visual assets and Godot scenes when the user invokes the standalone magic word `CENA`.
---

# DA LATA CENA — visual scene continuation protocol

## Purpose

`CENA` is the repository-local visual production command for **DA LATA**.

It exists because a playable game can be mechanically correct while remaining visually underdeveloped. A standalone `CENA` invocation must therefore reconstruct the actual visual state of the game, identify the smallest coherent visual gap, research references when needed, create or source appropriate assets, integrate them into Godot scenes, validate the result, and persist the new visual state.

Authority:

```text
REAL REPOSITORY STATE
  > CENA HANDOFF
  > VISUAL DIRECTION + IMPLEMENTED SCENES/ASSETS
  > LORE CANON / GAME SPECS
  > CHAT / MODEL MEMORY
```

Chat memory is never canonical visual state.

---

## Repository identity lock

Canonical repository:

```text
az1nn/growing-rio
```

Before any visual research, asset generation, scene edit, import, branch creation or mutation, verify that the active repository resolves exactly to `az1nn/growing-rio`.

Fail closed:

- exact match -> continue;
- another repository -> `CENA_REPO_MISMATCH`, report and stop with zero mutation;
- identity cannot be verified -> `CENA_REPO_UNRESOLVED`, stop and do not guess.

Do not infer the repository from recency, GitHub activity, similar names, chat history, or another repository containing a CENA/SIGA/LORE skill.

---

## Trigger

Treat `CENA` as the magic visual continuation command when used standalone, ignoring case, whitespace and terminal punctuation.

Examples:

```text
CENA
Cena
cena!
```

Prose that merely contains the word "cena" does not automatically trigger the continuation protocol.

---

# CENA domain

CENA owns work whose primary purpose is **visual presentation and scene materialization**.

Allowed work includes:

- visual direction and reference boards;
- environment and prop research;
- asset inventory and gap analysis;
- original concept/reference image generation when available;
- sourcing compatible external assets with explicit license/provenance;
- 3D scene composition;
- MeshInstance3D / primitive blockout only as transient internal construction scaffolding; never as an acceptance candidate or final visual language;
- imported meshes and textures;
- materials, shaders and surface treatment;
- WorldEnvironment, sky, fog and color treatment;
- Camera3D framing and presentation;
- DirectionalLight3D / OmniLight3D / SpotLight3D setup;
- static environment dressing;
- scene transitions whose primary purpose is presentation;
- 2D/3D hybrid presentation;
- UI-over-3D composition;
- visual feedback, particles and non-mechanical animation;
- import settings, texture sizing and mesh optimization;
- mobile/Web visual performance budgets;
- screenshot or visual-regression evidence when tooling permits;
- asset/source manifests and visual documentation.

## Hard art-direction gate — NO LOW-POLY FINAL READ

The approved DA LATA V1 presentation is **PIXEL ART × GRAFFITI × URBAN ISOMETRIC 3D**. A scene that visibly reads as low-poly is not a stylistic variant, production candidate, or acceptable intermediate for human visual review.

- Blockout primitives may be used privately to establish scale, collision, interaction anchors, camera and composition.
- Before CENA presents a candidate for ARTIST/LENTE/human acceptance, the visible blockout read must be replaced by authored production surfaces, silhouettes and detail consistent with the accepted concept.
- If an exact-head capture still reads as primitive boxes, toy-like faceted geometry, smooth solid-color masses, placeholder materials or generic low-poly architecture, classify `CENA-REJECT_LOW_POLY`.
- Do not attempt to cure `CENA-REJECT_LOW_POLY` by increasing primitive density or adding more boxes. Change the asset/material construction strategy: authored facade forms, pixel-textured/material breakup, patched masonry/tile/metal, graffiti/mural surfaces, props, vegetation, residents and layered depth as required by the accepted scene concept.
- Green tests, working interactions and performance do not override this art-direction rejection.

CENA must not silently become:

- a gameplay/mechanics feature;
- an economy/balance redesign;
- a save-schema change;
- a generic architecture refactor;
- new narrative canon;
- a broad lore-authoring session;
- unrelated CI/infrastructure work.

When visual work exposes one of those dependencies, record it and route it to SIGA or LORE instead of hiding the scope expansion.

---

# Relationship with SIGA and LORE

## SIGA

SIGA remains the general engineering/product continuation router.

CENA may modify Godot scene code or small presentation helpers when inseparable from the visual slice. If the required change becomes a reusable Godot engine/runtime subsystem, route implementation through `GODOT` under SIGA. Gameplay features, persistence changes, architecture migrations or broad delivery work remain SIGA-owned.

```text
CENA defines/preserves visual contract
-> GODOT owns reusable engine/runtime mechanics when needed
-> QA verifies automated contracts
-> LENTE returns rendered evidence
-> CENA accepts/revises
-> SIGA delivers
```

## LORE

LORE remains the narrative/canon authority.

CENA may visualize canonical characters, places, factions, symbols, artifacts and campaign moments, but it must not turn an artistic decision into new canon.

If a scene requires a narrative fact that canon does not define:

```text
CENA-BLOCKED or preserve as non-canonical visual exploration
-> record the question
-> route canon decision through LORE
```

Visual references never override canonical narrative documents.


## 3JS

3JS is the renderer implementation owner when an active bounded specification selects Three.js.

CENA remains authoritative for:
- visual target and composition;
- reference/provenance decisions;
- palette/material/lighting direction;
- rendered visual acceptance;
- explicit `ACCEPT` / `REVISE` decisions.

When a standalone CENA continuation selects a Three.js visual target:

```text
CENA defines + persists the visual contract
-> route player-facing Three.js runtime implementation through 3JS
-> 3JS returns exact-head rendered evidence
-> CENA accepts or revises the visual result
```

Do not let CENA silently hand-author a new Three.js runtime capability without the 3JS Spec Kit / engineering workflow. Likewise, 3JS must not invent a new art direction merely because it owns renderer code.

Godot-native adaptation remains valid for visual slices whose selected renderer/runtime is Godot.


---

# Start protocol

Every standalone `CENA` starts in **VERIFY-FIRST** mode.

## 1. RECONCILE

Reconstruct actual visual state before deciding what to make.

### RepoProbe
- repository identity;
- default branch and exact HEAD;
- open PRs/branches touching scenes/assets;
- exact-head CI/deployment state when relevant.

### GodotSceneProbe
Inspect, as applicable:
- `project.godot`;
- main scene;
- all `.tscn` scene files;
- Node3D/Control composition;
- cameras;
- lights;
- WorldEnvironment;
- materials/shaders;
- animation players;
- particle systems;
- viewport configuration;
- renderer and mobile/Web constraints.

### AssetProbe
Inventory:
- meshes (`.glb`, `.gltf`, `.obj`, etc.);
- textures and images;
- materials and shaders;
- fonts/icons;
- audio only when directly tied to scene presentation;
- generated/imported asset folders;
- provenance/license records.

Classify assets as:

```text
IMPLEMENTED
AVAILABLE_UNUSED
PLACEHOLDER
MISSING
NEEDS_REWORK
LICENSE_UNKNOWN
```

### VisualDirectionProbe
Read:

```text
docs/VISUAL-DIRECTION.md
docs/CENA-HANDOFF.md
```

Then load only the relevant GDD, architecture, specs and lore needed for the scene being considered.

### ConcurrencyProbe
Before mutation:
- capture current `master` HEAD;
- inspect overlapping open PRs;
- capture blob SHAs for files to edit;
- use a dedicated branch;
- re-read live state before logical write batches;
- never overwrite a newer scene/asset edit blindly.

If concurrent work changes the visual evidence, recompute the route.

---

## 2. DECIDE

Choose exactly one:

```text
CENA-RESUME
CENA-WATCH
CENA-ADVANCE
CENA-BLOCKED
```

### CENA-RESUME
Use when an existing visual wave is unfinished and safe work remains.

Examples:
- a scene blockout exists but lacks materials/lighting;
- generated/reference assets still need runtime adaptation;
- an asset PR requires revisions;
- a visual handoff names a partially completed slice.

### CENA-WATCH
Use when the visual work is already dispatched and only an active external gate remains.

Examples:
- CI/export is running;
- a PR is awaiting review;
- deployment is refreshing after merged scene changes.

Do not start a second competing visual wave while the current one is gated.

### CENA-ADVANCE
Use when previous visual work is verifiably complete.

Select the next smallest coherent visual capability in this order:

1. explicit NEXT in `docs/CENA-HANDOFF.md`;
2. visually missing part of the current playable loop;
3. placeholder-heavy scene already visible to the player;
4. presentation gap blocking a canonical campaign moment;
5. reusable visual system required by several already-defined scenes;
6. polish only after structural visual gaps are addressed.

Prefer one player-visible slice over a broad asset dump.

### CENA-BLOCKED
Use when safe continuation requires:
- a human art-direction decision not encoded in the repo;
- an unresolved lore/canon decision;
- a license decision;
- an unavailable source asset whose replacement materially changes direction;
- a technical subsystem that must first be handled by SIGA.

Persist the exact blocker and safe alternatives; do not invent approval.

---


## Build/deploy rate limits — non-blocking visual stacking

A build/deployment provider rate limit is **not a CENA lock**.

When the visual code/scene is internally valid but the external provider reports an explicit rate/quota/scheduling limit:

```text
CENA external state = SOFT_GATE_RATE_LIMIT
development route = may continue
merge of affected PR = deferred until provider validation exists
```

Rules:

- rate limit alone MUST NOT force `CENA-WATCH` if a safe next visual slice exists;
- CENA MAY select `CENA-ADVANCE` and open the next bounded visual PR;
- when the next visual slice depends on the unmerged one, create a **stacked PR** whose base is the unresolved visual branch rather than pretending the dependency is already on `master`;
- when work is disjoint, prefer the newest safe repository base and avoid unnecessary stack depth;
- keep the rate-limited PR open and explicitly record the missing provider validation;
- run all repository/engine/visual validations that are available independently of the throttled provider;
- do not claim public deployment parity while the rate-limited validation is missing;
- after the provider window clears, validate the oldest unresolved visual PR first, merge bottom-up, then reconcile/revalidate every dependent PR against its new base;
- an actual scene import, Godot export, test, configuration or runtime failure is a hard failure and MUST NOT be mislabeled as rate limiting.

`CENA-WATCH` is reserved for cases where waiting is genuinely the only safe continuation. External throttling with stackable visual work is not such a case.

# 3. RESEARCH

Research is **mandatory** when:
- no established visual reference exists for the target scene;
- the target depicts a real place, architecture, period, object family or cultural reference;
- an external asset/source is being considered;
- a visual decision depends on current engine/platform constraints.

Research can use web/image search and other available reference tools.

For each research wave:

1. define the visual question;
2. collect a small, purposeful reference set;
3. distinguish factual reference from artistic interpretation;
4. record source/provenance in the CENA handoff or dedicated visual notes;
5. check asset licenses before importing anything;
6. prefer CC0/public-domain/original assets when practical;
7. never copy a copyrighted game's distinctive assets or recreate a living artist's signature style as a direct imitation.

Research output must result in an implementation decision, not an endless moodboard.

---

# 4. GENERATE / SOURCE

Choose the smallest suitable production path.

## A. Godot-native blockout
Use Godot primitives and simple materials for early 3D composition when the visual problem is spatial rather than asset-detail dependent.

Good for:
- room shells;
- counters/tables/shelves;
- light studies;
- camera framing;
- interaction-space layout;
- mobile/Web performance prototypes.

## B. Original generated visuals
When image-generation capability is available, it may be used for original:
- concept frames;
- texture ideation;
- decals/posters/signage;
- UI-adjacent scene art;
- sky/background studies;
- visual targets for later 3D implementation.

Generated 2D imagery is not a substitute for a runtime 3D mesh. CENA must label concept/reference output separately from production-ready Godot assets.

## C. External assets
When sourcing third-party assets:
- verify license;
- record source and license;
- avoid unknown-license files;
- adapt scale, orientation, materials and import settings;
- keep source attribution if required;
- prefer formats well supported by Godot, especially glTF/GLB for 3D.

---

# 5. ADAPT / INTEGRATE

Every asset must be adapted to the actual game rather than dropped into the repository unreviewed.

Check:
- scene scale and transform;
- pivot/origin;
- texture dimensions and compression;
- material compatibility;
- renderer compatibility;
- transparency;
- collision only if the scene actually needs it;
- lighting response;
- draw-call/material count;
- mobile/Web memory impact;
- import stability;
- deterministic path references;
- visual hierarchy;
- legibility behind the UI;
- portrait/mobile composition where applicable.

For DA LATA specifically, preserve a **presentation-first 2D/3D hybrid** unless a bounded spec deliberately changes the interaction model. Existing gameplay semantics must remain intact while CENA improves what the player sees.

---

# 6. VALIDATE

A CENA wave is not complete because a file exists.

Run all applicable checks:

### Repository/engine
- Godot project parses;
- edited scenes load;
- referenced assets resolve;
- no missing external resources;
- existing tests remain green.

### Visual
- camera shows the intended composition;
- important objects remain legible;
- lighting/materials are coherent;
- no obvious clipping/z-fighting;
- UI remains readable over the scene;
- portrait/mobile framing is acceptable;
- placeholder content is explicitly marked.

### Performance
For Web/mobile targets:
- avoid gratuitous high-poly meshes;
- constrain texture sizes;
- avoid excessive dynamic lights;
- reuse materials where practical;
- prefer baked/static presentation when the scene does not need real-time complexity.

### Delivery
When the playable Web build is part of the current wave:
- export succeeds;
- deployment matches the exact validated head;
- do not claim a public visual result from stale deployment evidence.

---

# 7. PERSIST

Update:

```text
docs/CENA-HANDOFF.md
```

Record:
- verified repository HEAD;
- CENA route;
- visual target;
- research performed;
- assets added/reworked;
- scene files changed;
- provenance/licenses;
- validation evidence;
- known visual debt;
- next visual action;
- dependencies routed to SIGA or LORE.

Do not store CENA state outside the repository.

---

# Visual quality invariants

CENA should prefer:

- strong silhouette and composition before micro-detail;
- a coherent lighting language over many unrelated effects;
- a small reusable material vocabulary;
- environmental storytelling tied to existing canon;
- recognizably Rio-inspired atmosphere without pretending every scene is a literal real-world reproduction;
- readable mobile framing;
- visual hierarchy that supports the management/narrative loop;
- assets that look like they belong to the same game.

Avoid:
- asset-store collage aesthetics;
- random photorealism mixed with flat placeholders;
- decorative 3D that obscures critical UI;
- huge textures or meshes with no visible benefit;
- visual changes that alter mechanics without explicit scope;
- importing assets with unclear rights.

---

# DA LATA initial visual reality

At creation of this skill, the verified repository showed:

- main scene: `scenes/main/main.tscn`;
- root type: `Control`;
- presentation dominated by Labels, Buttons, Panels and containers;
- no Camera3D, WorldEnvironment or 3D light nodes in the main scene;
- no player-facing 3D environment in the verified scene tree;
- renderer: Godot GL Compatibility;
- target layout: portrait 1080x1920 viewport, 540x960 override;
- Web export/deployment already exists and must remain viable.

This snapshot is historical evidence only. Every future CENA invocation must re-check live state.

---

# First visual priority

Unless live repository state supersedes it, the first CENA wave should establish one coherent **player-visible 3D presentation slice** for the existing management loop rather than attempting a full art overhaul.

Suggested bounded target:

```text
3D environment layer for the grow-space / operation scene
+ camera
+ environment/lighting
+ a restrained material palette
+ existing management UI preserved as overlay
```

The goal is to prove the visual language and 2D/3D composition before scaling asset production.

---

# Final invariant

```text
CENA = VERIFY VISUAL STATE
    -> RESEARCH WHAT IS MISSING
    -> GENERATE OR SOURCE RESPONSIBLY
    -> ADAPT TO GODOT
    -> VALIDATE IN THE PLAYABLE GAME
    -> PERSIST REPOSITORY-LOCAL STATE
```
