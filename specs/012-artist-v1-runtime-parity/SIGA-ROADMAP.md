# Feature 012 — SIGA Strict Sequential V1 Roadmap

**Execution mode:** `STRICT_SEQUENTIAL`  
**Owner:** SIGA  
**Visual authority:** approved ARTIST V1 board + written style guide + per-scene human acceptance  
**Current item:** `R06`  
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

## P0 visual convergence policy — 2026-10-02

Until R15 is `PASS`, Feature 012 is the repository's P0 product-delivery stream.

- The earliest non-`PASS` scene/certification item is the only visual product item SIGA advances.
- A green build, green CI, successful deployment, preserved hotspots or successful screenshot capture is not scene completion without target-relative ARTIST/CENA `ACCEPT`.
- Runtime acceptance compares **global board + accepted scene concept + exact-head runtime**. The previous runtime exists only to detect regressions; incremental improvement against it cannot close the item.
- If the target requires visual information that the current primitive/blockout scaffold does not contain, implementation must produce or replace the required meshes, materials/textures/decals, props, dressing, lighting and atmosphere.
- Historical RB-13 `PRODUCTION-CANDIDATE` labels do not satisfy V1 parity.
- Structural mismatch routes to recomposition/rebase. Cosmetic accumulation on a structurally rejected scaffold is not valid progress toward `PASS`.
- Feature 013 and later implementation remain queued; they cannot preempt this stream while R04-R15 contains a non-`PASS` item.

## Hard write fence + architecture fence — 2026-10-01 correction

This roadmap is stricter than generic SIGA waiting behavior.

- While any R04-R15 item is `CURRENT`, `WATCH` or `BLOCKED`, **all later roadmap items may not receive branches, PRs, preflights, task decomposition, concept acceptance or implementation**, even if described as spec-only or safe parallel preparation.
- PR #202 was closed unmerged because it prepared R05 while R04 was still non-PASS.
- Every mutation must belong to the earliest non-PASS item and satisfy the final renderer decision in `renderer-decision.md` plus [architecture-execution-guardrail.md](./architecture-execution-guardrail.md).
- `GODOT_NATIVE_V1` means native reconstruction from the accepted ARTIST target. Frozen Three.js or superseded primitive/blockout composition may be consulted as evidence but cannot silently remain the production scaffold.
- ARTIST structural REVISE must cause structural replacement/recomposition. Two consecutive reviews citing the same structural class of mismatch trigger `STRUCTURAL_REBASE_REQUIRED`.

### R04 completion boundary

R04 is `PASS`. Candidate 9 exact-head `28c3e3c75042a183e1ac091dc1595b2be009397f` passed Validate `36924774052`, Visual Acceptance `36924773928` and bounded LENTE `36924773924`. ARTIST/CENA inspected both 540×960 and 1080×1920 targets against the locked Operation concept and persisted `IMPLEMENTATION_ACCEPTED`: the crown is readable on its dark field, cyan/magenta separation is preserved, pendants no longer cross the focal sightline, and camera/floor/hotspots/gameplay/accessibility remain unchanged. R05 is now the single current item; R06+ remain locked.

### R06 current boundary — 2026-10-04

R06 City V1 is `CURRENT`. Canonical execution plan: [`R06-CITY-V1-PLAN.md`](./R06-CITY-V1-PLAN.md). Human ARTIST concept `ACCEPT` is recorded for run `20261004T110406Z/city`; `SCENE-STATUS.json#city` is now `CONCEPT_ACCEPTED`, provenance is persisted, and the CENA build sheet is complete. **T051-E native Godot implementation is now the current bounded gate.** R07+ remain locked.

### R05 completion boundary — 2026-10-04

R05 is `PASS`. Human runtime `ACCEPT` was recorded for exact-head `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e`; Validate, Visual Acceptance at 540×960 and 1080×1920, auxiliary scene checks and Vercel were green. PR #205 was merged to `master` as `f73190b89bafca1e05310f4f816c2cdc788bd03d`. The accepted Market ARTIST baseline and approved DA LATA UI edge-chrome treatment are now the reusable R06+ baseline. R06 City V1 is the single current item.

## Ordered roadmap

| ID | Status | Deliverable | Exit gate |
|---|---|---|---|
| **R01** | **PASS** | Finish bounded renderer evidence spike on PR #193 | exact-head validation + Godot/Three.js captures/metrics sufficient for renderer decision; spike evidence persisted; no claim of production acceptance |
| **R02** | **PASS** | Persist renderer decision and architecture lock in SPEC-012 / PR #191 | `renderer-decision.md` is one of the allowed final states; plan/tasks reconciled; #193 disposition recorded; #191 exact-head required gates green and delivered to `master` |
| **R03** | **PASS** | Build the shared ARTIST V1 runtime visual system | renderer-specific pixel strategy, material/decal/graffiti vocabulary, provenance, composition anchors, validators and measured budget exist and pass structural gates |
| **R04** | **PASS** | **Operation V1** production scene | Operation concept/style conformance verified; 3D implementation complete; semantic hotspots preserved; exact-head 540×960 + 1080×1920 LENTE evidence; ARTIST/CENA runtime `ACCEPT` |
| **R05** | **PASS** | **Market V1 + DA LATA UI V1 pilot** | concept accepted; 2.5D runtime parity; shared UI tokens/components implemented in Market; required hotspot/UI-state tests; two portrait captures; human ARTIST/CENA `ACCEPT` |
| **R06** | **CURRENT** | **City V1** | concept accepted just-in-time; runtime implemented; required hotspot tests; two portrait captures; ARTIST/CENA `ACCEPT` |
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

## R05 visual baseline recovery override — 2026-10-04

Human `REVISE ALL` supersedes the Market-local shared-shell composition introduced after Candidate 10.

- `2caac959bf5a7a6ea3d8f19b620ad28eafb00726` is the visual recovery baseline because it is the last Market runtime direction explicitly judged close to the accepted ARTIST concept before UI work displaced the scene.
- The accepted ARTIST concept must remain the player-facing substrate. The replacement `market-runtime-backdrop.svg` is rejected.
- Market MUST NOT mount `MarketUIScreen` or `ActionDeck`; the canonical outer GameShell owns header/navigation chrome.
- Functional work from T050-I survives only when composition-neutral: real touch routing, focus/accessibility, minimum touch targets and semantic hotspot fallbacks.
- UI iteration from this point is edge-chrome refinement only. Any candidate that reduces target-relative concept similarity is `REVISE`, regardless of technical green.
- Structural tests must fail if the rejected local shell/deck or substitute backdrop returns.
- R05 is PASS after explicit human runtime ACCEPT on exact-head `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e`; R06 City V1 is now CURRENT. R07+ remain LOCKED.

## R05 UI-system convergence amendment — 2026-10-03

Human review of Market Candidate 10 established that the 2.5D ARTIST rebase is sufficiently close to the accepted concept to move the current R05 convergence focus to player-facing controls. R05 is PASS and R06 is CURRENT. R07+ remain LOCKED.

Before Market can receive runtime `ACCEPT`, R05 now owns the **DA LATA UI V1 pilot**. This is a shared-system task executed inside the current Market item; it does not authorize implementation of later scenes.

Canonical execution plan: [`R05-DA-LATA-UI-V1-PLAN.md`](./R05-DA-LATA-UI-V1-PLAN.md). T050-E through T050-J are delivered; T050-J received explicit human runtime ACCEPT.

Required outputs:

1. **Canonical tokens** — spacing/grid, typography scale, border/shape language, semantic colors, focus treatment and motion timings.
2. **Five button roles** — `PRIMARY_ACTION`, `SECONDARY_ACTION`, `UTILITY`, `DANGER_RISK`, `NAVIGATION_TAB`.
3. **Mandatory states** — `DEFAULT`, `HOVER_FOCUS`, `PRESSED`, `DISABLED`, `ACTIVE_SELECTED`; `LOCKED` where progression requires it.
4. **Shared navigation shell** — top status/title region, scene-local action region and persistent bottom command/navigation band.
5. **Market pilot** — replace ad-hoc Market navigation/action controls with shared components without changing gameplay/economy/persistence semantics.
6. **Accessibility/input** — pointer, keyboard/focus and touch targets remain first-class; state cannot rely on color alone.
7. **Visual authority** — UI inherits the accepted DA LATA pixel/graffiti language: dark charcoal substrate, amber primary action, cyan/teal system/navigation, magenta event/emphasis; no generic glossy/mobile UI and no return to Three.js/low-poly visual grammar.
8. **Reuse fence** — City and later screens may consume this system only after R05 passes; no later-screen implementation occurs during the pilot.

R05 exit gate is therefore extended to require: shared UI spec + implementation, Market application, structural/UI-state regression, exact-head 540×960 + 1080×1920 evidence, and explicit human runtime `ACCEPT`.

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
target decomposition + production asset plan
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
target-delta review: board + accepted concept + runtime
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

## R04 completion evidence

R04 passed on 2026-10-01.

- accepted runtime head: `28c3e3c75042a183e1ac091dc1595b2be009397f`;
- Validate #1074 / `36924774052` — SUCCESS;
- Visual Acceptance #562 / `36924773928` — SUCCESS, artifact `11194250019`;
- bounded LENTE #94 / `36924773924` — SUCCESS, artifact `11193202545`, 2/2 pages, 2/2 isolated scenes, 1/1 video, zero gaps, empty browser-console log;
- ARTIST/CENA: `IMPLEMENTATION_ACCEPTED`;
- semantic hotspots, pointer/touch, accessible fallbacks, gameplay/persistence and `GODOT_NATIVE_V1` remain green;
- R05 is PASS; R06 is the only unlocked/current successor; R07+ remain locked.


## Completion condition

This roadmap is complete only when `R01..R16 = PASS`.

Until then, **`Siga` means: continue the earliest non-PASS roadmap item, one at a time.**
