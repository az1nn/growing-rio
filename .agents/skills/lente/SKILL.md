---
name: lente
description: Capture exact-head DA LATA pages and isolated scenes, use image/video models to critique and brainstorm scene/object improvements, and route accepted visual hypotheses through CENA/3JS/SIGA/LORE.
---

# DA LATA LENTE — multimodal visual feedback loop

## Purpose

`LENTE` is the repository-local visual observation and ideation skill for **DA LATA**.

Its job is to look at what the game actually renders now, not what source code claims it should render.

A standalone LENTE run must:

1. reconcile the live repository and exact head;
2. resolve the smallest active scene scope unless the user explicitly requests `LENTE full`;
3. obtain fresh page + isolated screenshots for that scope;
4. obtain one short deterministic scene video for that scope when supported;
5. inventory renderable/interactable scene objects;
6. use available image/video understanding or generation models to produce bounded visual hypotheses;
7. distinguish observation from aesthetic proposal;
8. route selected improvements to CENA/3JS/SIGA/LORE without bypassing their authority;
9. allocate a unique, versioned folder for every explicit capture;
10. generate and save a general, evidence-linked CAVEMAN analysis alongside its media;
11. archive immutable evidence separately from master and persist a compact handoff.

LENTE is a **critic/orchestrator**, not the visual authority.

Authority order:

```text
REAL REPOSITORY + EXACT-HEAD RENDERED EVIDENCE
> ACTIVE SPEC / ACCEPTANCE CONTRACT
> CENA VISUAL DIRECTION
> 3JS IMPLEMENTATION CONTRACTS
> LORE CANON
> LENTE MODEL HYPOTHESES
> CHAT / MEMORY
```

A model suggestion never becomes art direction merely because it looks plausible.

---

## Repository identity lock

Canonical repository:

```text
az1nn/growing-rio
```

Before capture, artifact download, workflow dispatch, report persistence or implementation routing:

- verify the repository full name exactly;
- verify default branch and exact target head;
- inspect overlapping open PRs that touch visual/runtime/capture paths;
- fail closed on repository mismatch.

States:

```text
LENTE_REPO_MISMATCH
LENTE_REPO_UNRESOLVED
```

No cross-repository mutation is allowed.

---

## Trigger

Treat `LENTE` as the standalone magic command, ignoring case, whitespace and terminal punctuation.

Examples:

```text
LENTE
Lente
lente!
```

Useful scoped forms are also valid:

```text
LENTE operation
LENTE market objects
LENTE finale video
LENTE full
LENTE APPLY SCENE-operation-02
```

A prose mention of “lente” does not automatically trigger the protocol.

---

# Ownership boundaries

## LENTE owns

- exact-head visual evidence gathering;
- page/scene/object capture orchestration;
- screenshot and scene-video evidence selection;
- scene/object inventory generation;
- multimodal critique;
- reference ideation;
- before/after comparison planning;
- hypothesis IDs and prioritization;
- creation of bounded visual-improvement candidates;
- routing to the specialist that owns implementation.

## CENA owns

- visual direction;
- palette/material/lighting/composition acceptance;
- whether a model-generated reference is useful;
- rendered visual ACCEPT / REVISE decisions.

## 3JS owns

- Three.js renderer implementation;
- Three.js camera/material/light/geometry changes;
- renderer performance and lifecycle.

## SIGA owns

- generic engineering architecture;
- CI/delivery;
- reusable tooling outside the bounded visual slice;
- gameplay/domain/save changes.

## LORE owns

- narrative canon;
- meaning of places, symbols, characters, institutions and story objects.

LENTE must never convert a generative-model idea into canon, gameplay, or production art without the owning specialist.

---

# Evidence system

Canonical capture contract:

```text
tools/visual_lab/manifest.json
```

Inventory validator:

```text
tools/visual_lab/build_inventory.py
```

Isolated-scene runner:

```text
tools/visual_lab/visual_lab_runner.tscn
```

Capture harness:

```text
tools/visual_lab/capture.cjs
```

Workflow:

```text
.github/workflows/visual-lab.yml
```

Review prompts:

```text
tools/visual_lab/prompts/scene-review.md
tools/visual_lab/prompts/object-review.md
tools/visual_lab/prompts/video-review.md
```

The isolated runner is a CI/export fixture only. The workflow temporarily switches the exported main scene in the Actions worktree. It does **not** change the production boot scene in the repository.

---

# What “recent” means

For LENTE, freshness is commit-relative, not clock-relative.

Preferred evidence:

```text
artifact exact head SHA == target head SHA
```

An old screenshot from yesterday is stale if source changed. A screenshot from minutes ago is also stale if it belongs to another head.

Use evidence states:

```text
EXACT_HEAD
MASTER_BASELINE
STALE
MISSING
```

Rules:

- `EXACT_HEAD` is valid for acceptance and before/after reasoning.
- `MASTER_BASELINE` is valid only for comparison when reviewing a PR.
- `STALE` may help orient the model but must not support an ACCEPT claim.
- `MISSING` requires capture when visual judgment is necessary.

---

## Latency budget authority

LENTE capture timing is governed by `docs/VALIDATION-LATENCY-BUDGETS.md` and `tools/validation_latency_budgets.json`.

Media-time rules are hard invariants for new or modified capture code:

- once the exact-head runtime reports READY, a still image must be persisted within **1000 ms**; the capture harness reads the rendered canvas directly instead of using full Playwright page screenshots;
- the active video acquisition window targets **no longer than the requested media duration**; the machine contract permits only a small scheduler tolerance and measures post-processing separately;
- GitHub queue delay, tool/bootstrap installation, runtime readiness and artifact upload are separate timings and must never be reported as video/image capture time;
- where a readiness signal/condition exists, do not add a fixed sleep to approximate readiness.

This contract does **not** change the current progressive-check cadence by itself. Polling optimization is a separate approved task.

# Canonical capture set

The manifest currently requires:

## Full player-facing page states

- Operation
- Market
- City
- Institutional
- Archive
- Campaign
- Narrative
- Finale selection
- Finale handoff
- Finale coda
- Finale recap

At:

- 540x960
- 1080x1920

## Isolated visual scenes

The matching Operation/Market/City/Institutional/Archive/Campaign/Narrative dioramas and the four Finale presentation phases.

Each isolated scene receives:

- 540x960 PNG;
- 1080x1920 PNG;
- deterministic 4-second diagnostic WebM orbit.

The orbit is evidence only. It does not propose orbiting gameplay cameras.

## Object frames

Object capture is intentionally opt-in.

When needed, LENTE dispatches the workflow with:

- `capture_objects=true`;
- optional `object_scene`;
- optional exact `object_name`.

The isolated runner hides unrelated `MeshInstance3D` nodes and reframes the scene camera around the requested mesh. This creates a model-friendly object study without committing generated renders to the repo.

---

# Start protocol

Every standalone LENTE run begins VERIFY-FIRST.

## 1. RECONCILE

Read:

```text
.agents/skills/lente/SKILL.md
.agents/skills/cena/SKILL.md
.agents/skills/3js/SKILL.md
.agents/skills/siga/SKILL.md
docs/LENTE-HANDOFF.md
docs/VISUAL-DIRECTION.md
docs/CENA-HANDOFF.md
docs/3JS-HANDOFF.md
tools/visual_lab/manifest.json
```

Then inspect:

- exact target head;
- relevant open PRs;
- latest LENTE workflow run for that exact head;
- latest standard visual-acceptance run for that exact head;
- canonical scene inventory;
- only the active spec/lore needed for the target scene.

Do not load broad lore or gameplay history when the visual question does not require it.

## 2. CLASSIFY

Choose exactly one:

```text
LENTE-CAPTURE
LENTE-REVIEW
LENTE-APPLY
LENTE-WATCH
LENTE-BLOCKED
```

### LENTE-CAPTURE

Every explicit capture allocates a NEW versioned run even if evidence for the
same SHA already exists.

Routing is intentionally bounded:

- `LENTE <scene>` captures exactly that canonical scene/page/video packet;
- bare `LENTE` resolves the active bounded scene from live SIGA/roadmap/PR state and captures that scene only;
- `LENTE full` is the only user command that requests the complete canonical all-scenes packet;
- object capture inherits its parent scene scope.

Only reuse prior captures for comparison, never as a substitute for an explicitly
requested fresh execution. Use CAPTURE whenever fresh exact-head evidence is missing
or incomplete.

### LENTE-REVIEW

Use **only** for an explicit `LENTE REVIEW <run-id>` or a targeted
review requested without a fresh capture. It may read an immutable prior
folder but must not overwrite that folder or imply a new capture occurred.

### LENTE-APPLY

Use only when a specific hypothesis ID has been selected for implementation.

LENTE does not directly bypass specialist ownership. It converts the hypothesis into the smallest bounded CENA/3JS/SIGA/LORE work item and follows that specialist's rules.

### LENTE-WATCH

Use only when capture/review is already dispatched and no safe review or specification work remains.

### LENTE-BLOCKED

Use when a required human art-direction, license, canon or architecture decision is genuinely unresolved.

---

# 3. CAPTURE

## Immutable version on every execution

**Each explicit LENTE capture creates a NEW version**, even on the same head.
`LENTE REVIEW <run-id>` may inspect an older run without a new capture,
but must never overwrite its evidence.

The GitHub workflow allocates:

```text
visual-lab/runs/YYYYMMDDTHHMMSSZ-<sha12>-r<run_id>-a<attempt>/
  pages/  scenes/  videos/  objects/
  inventory.json  capture-metadata.json  browser-console-errors.txt
  metrics.json  CAVEMAN.md  MODEL_REVIEW_PROMPT.md
```

The artifact name includes source SHA + run ID + attempt. The short-lived Actions
artifact is the transport. After completion, `.github/workflows/lente-history.yml`
runs a privileged **master-only** archiver and appends this folder to the dedicated,
never-to-be-merged `lente-history` branch. The permanent entry point is
`lente-history/INDEX.md`; never commit these PNG/WebM dumps to master.
An explicit history-workflow dispatch can backfill a versioned run.

Incomplete runs retain a diagnostic `INCOMPLETE` CAVEMAN where an artifact
exists. Cancelled redundant PR checks with no artifact cannot be archived;
explicit LENTE dispatches do not cancel one another.

## Dispatch

When capture is required, dispatch `.github/workflows/visual-lab.yml`.

Dispatch contract:

- scoped capture: `scene_scope=<canonical-scene-id>`;
- full capture: `full_capture=true` and no `scene_scope`;
- object capture: keep the parent `scene_scope` and opt into `capture_objects=true`.

An explicit workflow dispatch without a scene or `full_capture=true` is invalid.
PR validation without a product-scene task key uses one `operation` smoke scene
to validate the harness rather than paying for the complete repository capture.

Use object capture only for targeted object study.

## Progressive checks

A running capture inherits SIGA's bounded progressive check policy:

```text
initial -> +15s -> +30s -> +60s -> +120s
```

Do not tight-poll. Do not keep a session open indefinitely only for Actions.

Between windows, safe progress includes:

- reading visual direction;
- preparing review dimensions;
- comparing the previous accepted master baseline;
- creating the next bounded review template;
- reconciling scene inventory.

If final same-invocation check is still running, persist the exact pending run/head and return. Never claim background monitoring.

---

# 4. VERIFY EVIDENCE

A valid LENTE artifact must contain:

```text
inventory.json
capture-metadata.json
browser-console-errors.txt
pages/*.png
scenes/*.png
videos/*.webm
```

And must satisfy:

- no missing manifest page frame;
- no missing isolated scene frame;
- no missing scene video or corresponding first-ready-frame QA poster;
- video playback contains no Godot splash/loading frames in its post-ready diagnostic window;
- active MediaRecorder acquisition matches the requested recording window (normally four seconds) within the canonical scheduler tolerance;
- video finalization is measured separately and remains within the canonical post-processing budget;
- every still records ready-to-file timing and remains within the canonical 1000 ms budget;
- capture metadata and artifact name identify the checkout's exact head SHA, not the PR synthetic merge SHA;
- no browser/page errors;
- inventory manifest covers the canonical 3D audit rows;
- every discovered `scenes/visual/*_diorama.tscn` is represented in the manifest;
- artifact SHA matches target head;
- the run key combines UTC time, source SHA, Actions run ID and attempt;
- `CAVEMAN.md`, `metrics.json` and `MODEL_REVIEW_PROMPT.md` live beside THIS run's media;
- a completed run is appended to `lente-history` or an archive failure is reported.

A successful workflow is evidence that files were produced, not proof that the scene is good.

---

# 5. CAVEMAN GENERATED FROM EVIDENCE

Each capture automatically generates `CAVEMAN.md` with **O QUE TEMOS,
ONDE DÓI, CENA POR CENA, FAZER AGORA**, linking to the matching screenshots
and WebMs inside the same version folder. It also emits machine-readable
`metrics.json` and a ready-to-use `MODEL_REVIEW_PROMPT.md`.

Automated luminance, contrast, occupancy and motion comparisons produce
**review candidates only**. They cannot identify composition errors or prove
real 3D, usability or art acceptance by themselves. The LENTE agent inspects
the actual images/videos and, when a capable model is available, adds a
`CAVEMAN-MODEL.md` multimodal synthesis as an append-only review companion
(or inside the new folder before its archive). Separate OBSERVED, HYPOTHESIS
and owner-approved direction; never fabricate a model review.

# 6. MULTIMODAL REVIEW

For each target scene, provide the model with the smallest coherent evidence packet:

```text
full-page screenshot
+ isolated-scene screenshot
+ orbit video
+ matching inventory entry
+ visual direction excerpt
+ active acceptance criteria
```

Do not throw the entire repository at an image/video model.

## Image understanding lane

Use the scene-review prompt to identify:

- hierarchy;
- silhouette;
- camera;
- lighting;
- material coherence;
- depth;
- interaction affordance;
- UI legibility;
- visual identity consistency.

## Video understanding lane

Use the video-review prompt to find issues that appear over angle/time:

- occlusion;
- weak back sides;
- depth collapse;
- unstable silhouettes;
- material/lighting inconsistency;
- unfinished geometry exposed by movement.

## Object lane

When a scene finding names a specific prop/mesh:

1. use `inventory.json` to resolve exact mesh names;
2. request an object capture for the smallest useful subset;
3. run the object-review prompt;
4. keep parent scene evidence in context so the object is not optimized in isolation from composition.

## Image generation lane

When available, image generation may create **reference-only**:

- overpaint concepts;
- alternate material treatments;
- lighting studies;
- prop silhouette variants;
- composition sketches.

Generated images must be labeled `REFERENCE_NOT_RUNTIME_ASSET`.

Never silently replace production assets with generated pixels.

## Video generation lane

When available, video generation may create **reference-only** studies for:

- atmosphere;
- light motion;
- transition timing;
- camera-language comparison;
- prop animation concepts.

Generated video is a hypothesis, not gameplay behavior and not acceptance evidence.

---

# 6. SYNTHESIZE HYPOTHESES

Every suggestion gets a stable ID.

Examples:

```text
SCENE-operation-01
OBJECT-market-ContractTray-01
MOTION-city-02
```

Each candidate must include:

- observed evidence;
- proposed change;
- affected scene/object;
- expected player-facing benefit;
- implementation owner;
- performance/canon/architecture risk;
- deterministic before/after evidence needed.

Prefer 3–7 high-value hypotheses. Do not generate an unbounded aesthetic wishlist.

Separate:

```text
OBSERVED
HYPOTHESIS
GENERATED_REFERENCE
ACCEPTED_DIRECTION
IMPLEMENTED
VERIFIED
```

Those states are not interchangeable.

---

# 7. PRIORITIZE

Default ordering:

1. hidden/broken/empty scene;
2. unreadable focal object or interaction;
3. major camera/composition failure;
4. lighting/material inconsistency;
5. missing depth/environmental structure;
6. repeated primitive/object quality;
7. micro-detail/polish.

A visually impressive idea is not automatically more important than a legibility failure.

---

# 8. APPLY

`LENTE APPLY <hypothesis-id>` performs orchestration.

Route by dominant change:

```text
visual direction / Godot scene art -> CENA
Three.js implementation -> 3JS
generic engineering/tooling -> SIGA
canon/meaning -> LORE
```

LENTE must pass the specialist:

- hypothesis ID;
- exact source head;
- before evidence paths/artifact id;
- affected scene/object names;
- generated reference if any;
- acceptance test;
- explicit out-of-scope boundaries.

Implementation must be bounded. One hypothesis may become more than one task only when dependencies require it.

---

# 9. VERIFY IMPROVEMENT

After implementation:

1. capture the new exact head;
2. compare with the exact pre-change evidence;
3. use the same scene/object prompt dimensions;
4. check visual direction and performance constraints;
5. record one of:

```text
IMPROVED
NEUTRAL
REGRESSED
INCONCLUSIVE
```

A generated concept looking better than the game is not proof of implementation improvement.

Only exact-head runtime evidence can verify runtime improvement.

---

# 10. PERSIST

Update:

```text
docs/LENTE-HANDOFF.md
```

Persist only compact state:

- target head;
- capture run/artifact;
- reviewed scenes;
- accepted/rejected/open hypothesis IDs;
- specialist routing;
- next visual review/action.

Do **not** commit bulk PNG/WebM evidence to master. Archive every completed version on the separate `lente-history` branch; Actions artifacts are temporary transport only.

If a generated reference becomes important to an accepted CENA decision, persist it only through the repository's normal asset/provenance rules.

---

# Artifact economy

LENTE must not create runaway storage.

Rules:

- default capture = one active/scoped page + isolated scene + short video;
- full all-scenes capture is explicit via `LENTE full`;
- object frames are opt-in and scoped when practical;
- explicit runs always get a unique folder even for an identical head;
- default Actions artifact retention = 14 days; permanent snapshots live on the isolated history branch;
- persist conclusions, not every temporary model output;
- never add binary capture dumps to normal PRs unless a bounded spec explicitly requires it.

---

# Safety / content boundary

DA LATA cultivation, market and political/institutional content remains an abstract fictional strategy-game presentation.

LENTE must not turn visual review into:

- real-world cultivation instruction;
- operational illegal-market guidance;
- real-person political persuasion;
- new narrative canon without LORE.

---

# Final output

A standalone LENTE run should end compactly:

```text
LENTE <CAPTURE|REVIEW|APPLY|WATCH|BLOCKED> — <scope>
Head: <short sha> | Evidence: <exact-head/stale/missing>
Reviewed: <pages/scenes/objects>
Findings: <accepted/open/rejected counts>
Routed: <hypothesis -> owner>
Blocker: <none or one actionable blocker>
Next: <one next action>
```

# Final invariant

```text
LENTE = VERIFY WHAT RENDERS
      -> CAPTURE EXACT HEAD
      -> ISOLATE SCENES / TARGET OBJECTS
      -> ASK IMAGE + VIDEO MODELS
      -> LABEL OBSERVATION VS HYPOTHESIS
      -> ROUTE THROUGH CENA / 3JS / SIGA / LORE
      -> RECAPTURE
      -> VERIFY VISUAL IMPROVEMENT
```
