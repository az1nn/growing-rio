# Feature 012 — SIGA Strict Sequential V1 Roadmap

**Execution mode:** `STRICT_SEQUENTIAL`  
**Owner:** SIGA  
**Visual authority:** approved ARTIST V1 board + written style guide + per-scene human acceptance  
**Current item:** `R04`  
**Rule:** exactly one roadmap item may be active. A later item is locked until the current item is `PASS`.

## Purpose

This file is the mandatory continuation queue for DA LATA V1 runtime parity.

When the user says **`Siga`**, SIGA MUST reconcile live repository state against this roadmap and work on the earliest non-`PASS` item only. This roadmap overrides normal `WATCH + PARALLEL_ADVANCE` behavior for later V1 roadmap items.

Waiting on CI, review, capture, deployment or another gate does **not** authorize starting the next roadmap item. While waiting, SIGA may only perform safe progress that belongs to the same current item: diagnose its gates, improve its tests/docs/evidence, reconcile drift, prepare its acceptance package, or perform another bounded step that cannot advance a later roadmap item.

## State machine

Allowed states:

- `LOCKED` — predecessor is not `PASS`; no implementation or acceptance work may start.
- `CURRENT` — the single item SIGA is allowed to mutate/advance now.
- `WATCH` — same item is waiting on an external/CI gate; it remains the current item.
- `BLOCKED` — same item cannot progress without a real user/product decision or unavailable dependency.
- `PASS` — all exit gates are verified and persisted; only then may SIGA unlock the next item.

Invariant:

```text
one CURRENT/WATCH/BLOCKED item
        |
        v
execute same item only
        |
        v
verify exact-head + human gates
        |
        v
persist PASS
        |
        v
unlock exactly one successor
```

No wave batching. No scene skipping. No "safe parallel" implementation of a later V1 roadmap item.

## Mandatory SIGA behavior

For every `Siga` invocation while this roadmap is active:

1. Verify repository identity and current `master`/PR heads.
2. Read this file plus Feature 012 `spec.md`, `plan.md`, `tasks.md`, ARTIST ledger and current acceptance evidence.
3. Find the earliest roadmap item that is not `PASS`.
4. Reconcile its actual state from live PR/CI/artifacts; never trust this file blindly when live state disagrees.
5. Execute at least one meaningful atomic step **inside that item**.
6. Verify applicable tests, visual captures, human acceptance and delivery state.
7. Update task/acceptance ledgers and this roadmap state when a gate changes.
8. Mark `PASS` only when every listed exit gate is satisfied.
9. Unlock the next item only after persistence of the predecessor's `PASS`.
10. End with the compact SIGA developer report naming exactly one `Next` item/action.

## Ordered roadmap

| ID | Status | Deliverable | Exit gate |
|---|---|---|---|
| **R01** | **PASS** | Finish bounded renderer evidence spike on PR #193 | exact-head validation + Godot/Three.js captures/metrics sufficient for renderer decision; spike evidence persisted; no claim of production acceptance |
| **R02** | **PASS** | Persist renderer decision and architecture lock in SPEC-012 / PR #191 | `renderer-decision.md` is one of the allowed final states; plan/tasks reconciled; #193 disposition recorded; #191 exact-head required gates green and delivered to `master` |
| **R03** | **PASS** | Build the shared ARTIST V1 runtime visual system | renderer-specific pixel strategy, material/decal/graffiti vocabulary, provenance, composition anchors, validators and measured budget exist and pass structural gates |
| **R04** | **CURRENT** | **Operation V1** production scene | Operation concept/style conformance verified; 3D implementation complete; semantic hotspots preserved; exact-head 540×960 + 1080×1920 LENTE evidence; ARTIST/CENA runtime `ACCEPT` |
| **R05** | LOCKED | **Market V1** | concept accepted just-in-time; runtime implemented; required hotspot tests; two portrait captures; ARTIST/CENA `ACCEPT` |
| **R06** | LOCKED | **City V1** | concept accepted just-in-time; runtime implemented; required hotspot tests; two portrait captures; ARTIST/CENA `ACCEPT` |
| **R07** | LOCKED | **Institutional V1** | concept accepted just-in-time; runtime implemented; required hotspot tests; two portrait captures; ARTIST/CENA `ACCEPT` |
| **R08** | LOCKED | **Archive V1** | concept accepted just-in-time; runtime implemented; required hotspot tests; two portrait captures; ARTIST/CENA `ACCEPT` |
| **R09** | LOCKED | **Campaign V1** | concept accepted just-in-time; runtime implemented; campaign behavior preserved; two portrait captures; ARTIST/CENA `ACCEPT` |
| **R10** | LOCKED | **Narrative V1** | concept accepted just-in-time; runtime implemented; narrative behavior preserved; two portrait captures; ARTIST/CENA `ACCEPT` |
| **R11** | LOCKED | **Finale Selection V1** | isolated concept accepted; distinct selection composition implemented; choice semantics preserved; exact-head LENTE; ARTIST/CENA `ACCEPT` |
| **R12** | LOCKED | **Finale Handoff V1** | isolated concept accepted; distinct handoff composition implemented; transition semantics preserved; exact-head LENTE; ARTIST/CENA `ACCEPT` |
| **R13** | LOCKED | **Finale Coda V1** | isolated concept accepted; distinct coda composition implemented; exact-head LENTE; ARTIST/CENA `ACCEPT` |
| **R14** | LOCKED | **Finale Recap V1** | isolated concept accepted; distinct recap composition implemented; exact-head LENTE; ARTIST/CENA `ACCEPT` |
| **R15** | LOCKED | Final V1 certification | all 11 runtime targets are individually accepted; semantic/accessibility regressions green; performance/payload/provenance verified; certified `master` SHA persisted |
| **R16** | LOCKED | Repository hygiene after V1 certification | obsolete V1 predecessor assets/branches handled by evidence; branch hygiene performed safely; `master` protection/rules documented or enabled where supported; final SIGA/ARTIST/CENA/LENTE handoffs reconciled |

## Scene item gate template

R04–R14 all use the same mandatory gate order:

```text
BOARD + STYLE GUIDE
      |
      v
scene candidate audit
      |
      v
REVISE if needed
      |
      v
human concept ACCEPT
      |
      v
implementation in selected production renderer
      |
      v
structural + gameplay/hotspot regression
      |
      v
LENTE exact-head 540x960 + 1080x1920
      |
      v
ARTIST/CENA runtime ACCEPT
      |
      v
persist PASS -> unlock next scene
```

A generated image, committed asset, green CI run, model review or acceptance of another scene never substitutes for the scene's own human concept/runtime acceptance.

## R01 completion evidence

R01 passed on 2026-09-30. Canonical evidence is persisted in `R01-RENDERER-EVIDENCE.md` and the immutable evidence branch.

- same-head baseline: `ad66752650461676a621bbbf45e57daabe5ac67a`, run `36761814609` — SUCCESS;
- bounded spike: `c6801a0829f72c620c7d9344d8033bcb496f5e91`;
- spike Validate `36760974637` — SUCCESS;
- spike Three.js visual `36760974583` — SUCCESS;
- spike Godot visual `36760974674` — SUCCESS;
- accepted Operation concept remains art-only; no runtime acceptance was inferred.

R02 decision package now locks `GODOT_NATIVE_V1`. PR #193 disposition: evidence-only spike, close unmerged. R02 remains the single current item in `WATCH` until PR #191 exact-head gates pass and the decision package is delivered to `master`; only then may R02 become `PASS` and unlock R03.

## R02 decision package

- final renderer state: `GODOT_NATIVE_V1`;
- canonical decision: `renderer-decision.md`;
- R01 evidence consumed without promoting the spike to production;
- PR #193 disposition: close unmerged, retain exact commit/runs as evidence;
- T015/T016 reconciled;
- #191 exact-head gates: Validate `36762974611` SUCCESS; Three.js visual `36762974605` SUCCESS; Godot visual `36762974588` SUCCESS;
- PR #191 merged to `master` as `8415346397fe756bb26411d55d27b76d1e009480`;
- PR #193 closed unmerged as immutable spike evidence;
- PR #194 closed unmerged as redundant baseline workflow experiment.

Therefore **R02 = PASS** and **R03 is the single current item**.

## R03 completion evidence

R03 passed on 2026-09-30.

- shared pixel render policy: `scenes/visual/v1/v1_pixel_render_policy.gd` — scene-only 2× nearest upscale baseline, full-resolution UI preserved;
- shared material vocabulary/builder: `resources/visual/v1/material-vocabulary.json` + `v1_material_vocabulary.gd`;
- graffiti/stencil pipeline: `graffiti-pipeline.json` + `shaders/v1_graffiti_stencil.gdshader`;
- provenance ledger: `resources/visual/v1/provenance.json`;
- 11-scene composition/focus registry: `resources/visual/v1/composition-anchors.json`;
- structural validator: `tools/validate_v1_visual_system.py`, exercised by canonical `tests/test_artist.py`;
- measured budget: `v1-performance-budget.md`, using only persisted R01 payload/framebuffer measurements;
- implementation head `db55b1691bdf65da6041f945a0a615ad47dabc22`: Validate project run `36768437111` — **SUCCESS**.

R03 does not claim scene runtime acceptance; R04 now owns Operation V1 concept-conformance + production implementation.

## R04 first runtime review — REVISE

R04 remains **CURRENT**. The first implementation pass was structurally healthy but failed the locked visual target.

- reviewed exact head: `f18476c5f417583d5b06e8da6a117297ddb360da`;
- Validate project run `36775607182`: **SUCCESS**;
- Visual acceptance capture run `36775607157`: **SUCCESS**;
- LENTE run `36775607148`, artifact `11127600141`, run key `20260930T205209Z-f18476c5f417-r36775607148-a1`: **EVIDENCE_COMPLETE_REVIEW_PENDING**, zero capture gaps and zero browser-console errors;
- ARTIST/CENA comparison against accepted Operation concept SHA-256 `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce`: **REVISE**.

Bounded revision targets for the same R04 item:
1. replace sparse/blockout read with denser repaired-brick/workshop dressing;
2. move abstract foliage toward the left/back growing-rack composition;
3. move management/supply shelving to the right/back and workbench toward the foreground;
4. restore the concept's amber crown/light identity and add warm pendant pools;
5. add fan/duct, shelf props, floor patchwork and entry steps while preserving fictional/non-instructional vegetation;
6. improve isolated/full-page legibility without touching gameplay, saves, semantic IDs or accessibility.

No later scene is unlocked by this review. The revised head requires fresh exact-head CI/LENTE and a new runtime decision.

## Completion condition

This roadmap is complete only when `R01..R16 = PASS`.

Until then, **`Siga` means: continue the earliest non-PASS roadmap item, one at a time.**
