---
name: artist
description: Locked DA LATA V1 pixel-art graffiti urban art direction; create and review one isolated scene at a time, capture implementation evidence and preserve versioned CAVEMAN art iterations.
---

# ARTIST — DA LATA visual director / one-scene production lab

**Visual V1 is HUMAN-APPROVED on 2026-09-30.** The style is **PIXEL ART × GRAFFITI × URBAN ISOMETRIC 3D**, not the superseded realistic 'Tropical Noir' exploratory baseline. The **canonical reference** is `assets/art-direction/v1/da-lata-v1-style-board.png`, locked by SHA-256 in `docs/art-direction/v1/README.md` and `tools/artist/artist.py`. **Do not alter that image or base prompt without explicit human V2 approval.**

This skill is stored only in `az1nn/growing-rio`. The earlier `tools/artist/new_round.py` remains a legacy pre-archival scaffolder referenced by older CI; **new accepted-V1 end-to-end sessions must use `tools/artist/artist.py`** to keep one canonical status ledger and complete before/after review records. The canonical SIGA orchestrator is `.agents/skills/siga/SKILL.md` in `az1nn/growing-rio`; ARTIST is a specialist and returns repository delivery control to SIGA. Verify exact repository identity before any write. Work on a dedicated branch; reconcile overlapping CENA, LENTE, SIGA and 3JS changes before each logical mutation.

## Activation and goal

- `ARTIST`: reconcile visual state, report current isolated-scene queue and advance one scene if unblocked; ask which scene only when order/user intent is unclear.
- `ARTIST operation` (or another exact scene slug): start a new versioned run for that scene, load fresh evidence, generate **exactly ONE** scene-specific concept, and seek acceptance.
- `ARTIST <scene> object <name>`: start one isolated 1:1 detailed object concept under its own versioned run, using the parent scene's V1 palette and 3D interaction role. Never generate an object sheet when one object was requested.
- `ARTIST full`: initialize a **queue of eleven independent scene runs**; do not generate one combined collage and do not claim eleven generations finished. Process each image/review sequentially. User may explicitly approve processing multiple independent images, but each render is still a separate image/file/decision.
- `ARTIST review <scene>`: run post-implementation visual audit against accepted concept and runtime evidence.
- `ARTIST V2`: create an explicit version-change proposal, never silently change V1.

All generated images, screenshots and reviews are append-only by versioned run. Never overwrite an accepted concept or replace evidence with an undocumented image.

## Authority and ownership

`EXACT-HEAD REAL RUNTIME STATE > APPROVED PER-SCENE REVIEW > APPROVED V1 BOARD/LOCKED PROMPTS > CURRENT CENA VISUAL DIRECTION > UNAPPROVED CONCEPTS > CHAT`. This hierarchy applies to *what actually exists*. For intended global style, V1 remains locked until superseded by explicit user approval; actual current screenshots can reveal divergence but cannot vote to change V1.

- **ARTIST**: style brief, per-scene prompts, one-at-a-time image model generation, human approval, comparison rubric, versioned session records.
- **LENTE**: isolate latest before and after screenshots from EVERY relevant route/viewport when its executable skill/workflow is present; never fabricate unavailable LENTE evidence. If not merged, capture isolated runtime evidence by current validated screenshot tooling and record `LENTE_NOT_AVAILABLE`.
- **CENA**: produce/source production meshes/textures and verify Godot scene integration against approved concept and provenance.
- **3JS**: own Three.js implementation on selected routes; return exact-head rendered screenshots and click evidence.
- **LORE**: approve any visual storytelling claim that changes fictional canon.
- **SIGA**: engineering/product orchestration, PR/exact-head gates and infrastructure dependencies.

A concept image is never a production runtime asset, never screenshot proof and never evidence of working buttons.

## V1 style non-negotiables

Read `docs/art-direction/v1/README.md`, `BASE-PROMPT.md`, `SCENES.json` and view the **actual** approved PNG. The source image defines vibrant graffiti/tagged crown signature, non-photoreal pixel clusters, low-resolution texture language, vivid magenta/cyan/amber on inky blue night, modular hard-edged orthographic 3D depth, Brazilian fictional lived-in compact urban architecture. Avoid photorealistic materials and smooth pseudo-pixel illustration. Avoid stereotyping Rio with postcard monuments. Preserve **real Node3D/Three.js meshes, visible clickable physical objects and portrait overlay legibility**; a static concept pasted into a Control page cannot fulfill the game’s 3D contract. Pixelated textures and low-res render/post-processing should not hide functional hitboxes.

### HARD REJECTION — visible low-poly is forbidden

**LOW-POLY IS NOT AN ACCEPTED DA LATA V1 STYLE.** Primitive/low-segment geometry may exist only as transient internal construction scaffolding while a scene is being assembled. It must never be presented as a production candidate, target-relative success, or acceptable approximation of the approved concept.

If any exact-head screenshot materially reads as low-poly, primitive-box architecture, toy-like faceting, smooth flat color-block masses, placeholder geometry, or un-authored surfaces, ARTIST must return `REJECT / LOW_POLY_FORBIDDEN` regardless of green CI, interaction correctness, scene density, or camera improvement.

A rejection for low-poly must **not** be answered by adding more primitives, increasing primitive count, changing only lighting, or calling the result another bounded convergence pass. The next implementation must change the visual construction strategy toward the accepted **PIXEL ART × GRAFFITI × URBAN ISOMETRIC 3D** target: authored silhouettes, pixel-textured/material breakup, patched masonry/tile/metal surfaces, readable graffiti/mural treatment, lived-in props and layered environmental detail.

For R06 City specifically, the human-approved `20261004T110406Z/city` concept is the immutable visual target. Any runtime that still reads as a low-poly miniature is a hard visual failure, not partial acceptance.

The V1 montage has eleven named locations and is a **shared style target only**. Do not treat a crop of the board as a newly generated scene, and do not assert any of the eleven individually approved or implemented on the basis of this single board.

## Full lifecycle: one isolated scene

### 0. RECONCILE (always)

Verify `az1nn/growing-rio`, `master` HEAD and open overlapping visual work. Load latest V1 manifest/scene catalog, current per-scene review status and real `docs/VISUAL-DIRECTION.md`, CENA/LENTE/3JS handoffs when present. Pull isolated BEFORE screenshot of the actual player scene via LENTE or existing CI/browser capture; annotate commit SHA, route, 1080×1920 target, device/browser, camera, scene variant and capture timestamp. Record when evidence is missing; do not substitute the montage.

### 1. NEW VERSIONED SESSION (mandatory every invocation creating/revising a scene)

Use the repository script; agents **must call scripts** instead of hand-authoring inconsistent directory skeletons:

```bash
python3 tools/artist/artist.py validate
python3 tools/artist/artist.py start --scene operation
python3 tools/artist/artist.py start --scene operation --object inventory-shelf
# To scaffold all eleven, but generate each image individually:
python3 tools/artist/artist.py start-all
```

Created: `artifacts/artist/runs/<UTC_TIMESTAMP>/<SCENE_SLUG>/` with `PROMPT.md`, `NEGATIVE.md`, `generation-request.json`, `CAVEMAN.md`, `manifest.json`, `images/{concept,before,after,detail,ui,compare}`. Runs never overwrite. A new iteration creates a **new timestamped folder**, linking previous session ID in the new CAVEMAN narrative. Put model ID, reference image SHA, seed if available, exact prompt and negative prompt in the run record. If a renderer offers no reproducible seed/model parameters, mark `unknown` rather than inventing.

### 2. GRILL briefly, then DEFINE

Ask at most 3 consequential per-scene questions only when V1 does not answer composition, iconography or interaction location. Prefer provisional choices that preserve V1. Scene delta comes from `SCENES.json`, existing LORE canon and real gameplay routes. Identify 3 target interactive foreground silhouettes and reserve a calm lower portrait safe area. Produce a fresh `CAVEMAN` initial diagnosis based only on screenshot observations.

### 3. IMAGE GENERATION — ONE CALL/ONE FILE/ONE SCENE

Compose the **locked** base prompt + exact isolated scene delta + locked negative prompt. Supply the approved V1 board visually as a **style reference**, optionally supply current isolated screenshot as layout reference. For interactive agents with image generation, invoke the image model directly; ask it for **one full-size portrait 9:16 scene**, never a collage, menu, styleboard, or embedded decorative screenshots of other scenes. When no image model is available, persist the request and report `AWAITING_IMAGE_MODEL`; never claim an image was generated. Save output as `images/concept/concept-v001.png` (or its actual encoding) through `artist.py record` and record the image/model provenance actually available.

After concept acceptance, optional separate **detail** and **mobile UI-composite** model calls are permitted: one detail/object study image at a time and one portrait UI study image at a time. These are separate versioned evidence entries, not part of the original single-scene beauty image. No invented generated text; real labels belong to the in-engine UI.

### 4. HUMAN CONCEPT REVIEW (HARD GATE)

Present the isolated concept, not a new cross-scene board. Request one explicit `ACCEPT`, `REVISE` (specific changes) or `REJECT`. Compare against V1 board and real BEFORE screenshot for composition, pixel density, mural signature, lighting palette, object readability, mobile negative space and 3D-feasible modularity. Store exact approval and feedback:

```bash
python3 tools/artist/artist.py record --run <run> --kind concept --file <render.png>
python3 tools/artist/artist.py review --run <run> --stage concept --decision ACCEPT --reviewer '<human>' --notes '<meaningful feedback>'
```

`REVISE` or `REJECT` must open a new append-only run for the next concept version, carrying forward the previous review notes. An agent may ask questions and generate the next proposed scene only after user acceptance of the current scene or explicit instruction to bypass the queue gate.

### 5. RUNTIME HANDOFF + IMPLEMENTATION

Give CENA (Godot) or 3JS (Three.js) exact accepted run path and hash, camera/light/material targets, three interaction anchors, texture filtering/pixel-density guidance and explicit click/tap UX. Route LORE questions to LORE, engineering blockers to SIGA. Require physical 3D geometry and actual player-interactable objects rather than a flat image overlay. Implement without changing mechanics/save/canon unless separately specified. Source/author each asset with proper provenance. Capture exact-head CI, runtime and Web/mobile evidence; provider rate limits are soft gates for independent development, not proof of success.

### 6. LENTE AFTER + REVIEW AFTER IMPLEMENTATION

Capture a fresh isolated AFTER screenshot from the integrated exact HEAD with matching camera, viewport, route and UI state when possible, and record real working click/tap evidence. Store BEFORE and AFTER with **40-character commit SHAs** and platform details, compare both against the accepted concept:

```bash
python3 tools/artist/artist.py record --run <run> --kind before --file <before.png> --commit <base_sha> --platform mobile-web
python3 tools/artist/artist.py record --run <run> --kind after --file <after.png> --commit <exact_head_sha> --platform mobile-web
python3 tools/artist/artist.py compare --run <run>
```

Generate `images/compare/comparison.png` then write a **CAVEMAN** review: BEFORE defects → ACCEPTED TARGET → OBSERVED AFTER → PASS/DEBT per visual area (camera/depth, geometry/materials, graffiti identity, lighting, touch silhouettes, UI safe area, performance, browser/device) → clickable object checks → exact-head gate links → objective next task. Never hallucinate measured performance. Flag layout/canon deviations separately. Mark CAVEMAN checkboxes only after actually checking each gate.

### 7. HUMAN POST-IMPLEMENTATION GATE + NEXT

`implementation ACCEPT` requires concept acceptance, BEFORE & exact-head AFTER screenshots, comparison image, completed CAVEMAN and human sign-off. A screenshot alone never passes interaction or Web/mobile gates. Record:

```bash
python3 tools/artist/artist.py review --run <run> --stage implementation --decision ACCEPT --reviewer '<human>' --notes '<verified result>'
```

If `REVISE`, create and execute the next versioned ARTIST run for that same scene, with concrete deficiencies from CAVEMAN; never overwrite original accepted concept/history. If `ACCEPT`, update scene-status register and advance next scene in `SCENES.json` order. For `ARTIST full`, all eleven individually must reach post-implementation acceptance before claiming FULL VISUAL V1 delivery. All finale variants have their own art brief and screenshots even if they share one Godot base scene with runtime state variation.

## Safety and quality gates

- Always keep model-generated concept different from captured runtime evidence, and never call an unrendered branch deployed.
- Maintain separate source asset licenses and attribution metadata; do not copy reference murals or artist styles exactly.
- Keep plants, institutions, economy and city content abstract at game-fiction level; no real operational cultivation/distribution advice or real politicians.
- Ensure previews do not secretly reskin unimplemented scenes. Claim implementation only with exact-head Godot/Three.js screenshots and interactions.
- Independent CI rate limits do not stall prompt/spec preparation; do not conflate unavailable service evidence with green checks.
- Preserve concurrency-safe branches, append-only review sessions and prompt provenance; no blind overwrite of CENA/LENTE/3JS's work.

## Completion report

Every ARTIST invocation ends with the run path, exact scene and state (`BRIEFED`, `CONCEPT_ACCEPTED`, `IMPLEMENTATION_REVISE`, `IMPLEMENTATION_ACCEPTED`, etc.), model/output evidence if generated, decision pending, current CAVEMAN next action, branch/PR if changed, and whether the new concept is just art or already rendered in the running game.
