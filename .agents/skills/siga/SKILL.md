# SIGA — repository continuation protocol

This is the canonical continuation and delivery orchestrator for exactly one repository: `az1nn/growing-rio`.

**Project-local authority:** all SIGA behavior for DA LATA / growing-rio is defined by this file plus repository-local helpers, specs, handoffs and live GitHub/CI state inside `az1nn/growing-rio`. SIGA has no operational authority, state, fallback or routing target outside this repository.

## REPOSITORY IDENTITY LOCK — mandatory first gate

Canonical repository for this SIGA skill:

```text
az1nn/growing-rio
```

Repository identity MUST be resolved and verified **before** task discovery, PR/branch/CI inspection, handoff routing, specialist routing or any mutation.

The first SIGA operation MUST be a direct identity probe against `az1nn/growing-rio` using the current project/application binding and/or direct Git/GitHub repository identity. Only after the exact full name matches may SIGA read operational state and continue with RECONCILE.

### Repository scope law

Every SIGA read, route, claim, mutation, verification and merge belongs to `az1nn/growing-rio`.

SIGA MUST:

- use only branches, PRs, Actions/checks, specs, docs, handoffs, assets and skills from `az1nn/growing-rio`;
- load active specialist skills only from `.agents/skills/**/SKILL.md` in `az1nn/growing-rio`;
- treat `docs/templates/**` as examples/templates only, never as active skill authority;
- record a dependency as an external blocker when the active repository explicitly depends on something unavailable inside `az1nn/growing-rio`, rather than leaving this repository to inspect or mutate it;
- stop with zero mutation if the exact canonical repository cannot be verified.

SIGA MUST NOT discover, inspect, route through, synchronize with, mutate, or use operational state from any repository other than `az1nn/growing-rio`.

Identity outcomes are fail-closed:

- exact `az1nn/growing-rio` match → continue;
- resolved identity differs from `az1nn/growing-rio` → `REPO_MISMATCH`; report the mismatch and stop with zero mutation;
- canonical identity cannot be directly verified → `REPO_UNRESOLVED`; stop with zero mutation and do not guess.

When the user says `Siga`, the orchestrator executes this complete loop:

1. **RECONCILE** — inspect live `az1nn/growing-rio` state: default branch, exact HEADs, open PRs, Actions/checks, active spec/roadmap, architecture decisions, repository-local handoffs and relevant specialist state.
2. **CLASSIFY** — choose exactly one top-level continuation:
   - `RESUME`: unfinished work exists.
   - `WATCH`: the current work item remains active but one or more gates/dependencies are pending.
   - `ADVANCE`: previous work is verifiably complete; start the next documented milestone.
3. **ROUTE** — identify the smallest active repository-local specialist skill(s) that own the bounded concern. SIGA keeps orchestration, repository identity, concurrency, verification and delivery authority.
4. **CLAIM** — before mutation, load `.agents/skills/siga-concurrency/SKILL.md`, create/select the dedicated branch/session claim when required, and pass the post-claim overlap barrier.
5. **EXECUTE** — perform a meaningful bounded step through the owning specialist(s), preserving the active spec, roadmap sequencing, architecture and canon boundaries.
6. **VERIFY** — require all applicable targeted tests, canonical validation, rendered acceptance, CI/provider evidence and exact-head proof for the work performed.
7. **MERGE** — when merge preconditions are satisfied, reconcile drift, resolve safe conflicts, merge with an expected-head guard when available, and verify the resulting default-branch state.
8. **PERSIST** — update only the applicable repository-local handoff/spec/task/acceptance records from fresh live facts.
9. **CONTINUE** — prove this invocation produced real repository progress and identify the single next action. Then execute the mandatory terminal report gate: fresh live read -> frozen fact packet -> compact text report -> exactly one validated visual report. A status-only/watch-only result is not a successful SIGA completion unless a declared strict roadmap has a genuine no-safe-progress blocker.

## VALIDATION LATENCY CONTRACT — canonical timing authority

All SIGA-routed validation/capture work is governed by:

```text
docs/VALIDATION-LATENCY-BUDGETS.md
tools/validation_latency_budgets.json
```

SIGA MUST keep queue delay, toolchain/bootstrap cost, runtime-readiness wait and actual validation/capture execution as separate clocks. A timeout is a safety ceiling, never the expected duration.

Rules:

- when an observable readiness condition exists, fixed sleeps are not an acceptable substitute;
- a still image capture begins only after the runtime is ready and has a hard ready-to-file budget of **1000 ms**;
- video acquisition targets real media time: the active capture window MUST target no more than the requested duration, with only the small scheduler tolerance declared in the machine-readable contract;
- p50/p90 workflow budgets are optimization targets until dedicated telemetry enforcement is implemented; exceeding them is `LATENCY_BUDGET_BREACH` evidence, not permission to weaken functional/visual gates;
- hard media invariants apply to any new or modified validation implementation immediately;
- validation latency regressions must be reported to QA/SIGA with the stage responsible rather than hidden inside a generic workflow duration.

The canonical contract is structural repository policy. `tools/validate_validation_latency_budgets.py` protects its schema and non-negotiable media limits. Workflow optimizations, polling changes and historical cleanup are separate bounded tasks.

## COMPACT DEVELOPER SESSION REPORT — mandatory final output

Every `Siga` invocation that passes repository identity resolution MUST end with one compact report for the developer running the session. This is the user-facing continuation report; it is not a historical changelog and it MUST NOT dump raw GitHub payloads, full diffs, full logs or long task histories.

Build it from fresh live reads after the last mutation/check. Prefer one screen of text. Default budget: **8 concise lines/bullets maximum** unless a real failure needs one or two extra lines.

Required fields:

```text
SIGA <RESUME|WATCH|ADVANCE> — <task key or milestone>
Repo: <branch/head-short-sha> | PR: <#n/state or none>
Done: <only material progress produced in this invocation>
Gates: <required exact-head gates only; green/running/failing/soft-rate-limit>
Wait: <next progressive-check window or none>
Blocker: <actionable blocker or none>
Next: <single next developer action/task>
```

Rules:
- include only facts useful to the next developer/session;
- collapse multiple green checks into one summary when they share the same result;
- show a failing check by name, then fetch/detail only the failed job needed to diagnose it;
- mention provider/deployment state only when it affects delivery or is `SOFT_GATE_RATE_LIMIT`;
- omit completed historical waves, long file lists, metrics already persisted elsewhere, prose explanations of protocol and duplicated repository metadata;
- do not reproduce the full persistent `docs/SIGA-HANDOFF.md` in chat;
- if the invocation ends on repository mismatch/unresolved identity or another fail-closed state, still emit the shortest possible report with the reason and next action.

The compact text report is observability, not authority. Repository/CI state remains canonical. It is paired with the mandatory terminal visual report; text alone is not a finalized SIGA output.

## GENERATED VISUAL REPORT IDENTITY FENCE — mandatory

A visual handoff is repository-state output and follows the repository identity lock.

Before rendering, SIGA freezes one fresh **report fact packet** from live `az1nn/growing-rio` evidence containing repository identity `az1nn/growing-rio`, product label `DA LATA`, task id/name, branch/head, active PR, work executed in this invocation, exact-head gates, blocker/wait state, one next action, timestamp, exact preview URLs when available, and current visual evidence.

Rules:

1. Load `.agents/skills/relatorio/SKILL.md` and enforce `REPORT_V1_REFERENCE_LOCK`.
2. Run `REPORT_REFERENCE_PREFLIGHT`: resolve the approved reference `/DA-LATA/REPORTS/REPORT_V1_APPROVED_REFERENCE.png`, library id `libfile_a626ef1fc98081919c4871587ccafa2a`, SHA-256 `a334c2ac9dc4497a24e46d162f0529b26f191e9b74b7cf4ccee2d9494de8431e`.
3. The approved image is presentation identity only; all status facts come from live repository/CI reads.
4. Render factual content only with `tools/render_relatorio_v1.py`. **Generative image tools MUST NOT render repository facts, labels, task ids, hashes, PRs, gate states or URLs.**
5. The terminal REPORT_V1 is a deterministic 1440×1920 portrait SVG with large typography. A raster derivative may be emitted only from that SVG and must be at least 2160×2880.
6. Run `REPORT_TEXT_LEGIBILITY_CHECK`: no factual font below 32 px; body copy targets 42 px; no required fact may be clipped.
7. If a live preview exists, preserve the exact HTTPS URL in the fact packet. The SVG must hyperlink it and the companion `.links.md` must expose it as a normal clickable link. Missing this is `PREVIEW_LINK_REQUIRED`.
8. Evidence thumbnails must come from the same exact-head LENTE/acceptance packet when available; never fabricate gameplay evidence.
9. Foreign project identity such as `Maricá` or `marica-game` is `REPORT_CONTEXT_MISMATCH`.
10. Never invent percentages, task completion, CI results, branches, PRs, URLs or milestones.
11. After rendering run `REPORT_RENDER_IDENTITY_CHECK`, `REPORT_REFERENCE_MATCH_CHECK`, `REPORT_TEXT_LEGIBILITY_CHECK` and `REPORT_PREVIEW_LINK_CHECK`.
12. Any factual mismatch, unreadable typography or meaningful identity drift is `REPORT_RENDER_MISMATCH`; discard and rerender deterministically from the same frozen packet.
13. The approved banner and numbered semantic identity remain; the former dense visual-evidence panel is represented by the larger preview/access + evidence area.
14. The visual is observability only; repository/CI state remains canonical.

## SINGLE FINAL VISUAL REPORT — mandatory terminal output contract

Every `Siga` invocation that passes repository identity resolution MUST end with **exactly one validated REPORT_V1 reference-locked visual report image**. For this contract, the image is the deterministic SVG rendered by the repository tool, never a generative re-typeset.

Mandatory terminal order:

```text
RECONCILE -> CLASSIFY -> ROUTE -> CLAIM -> EXECUTE -> VERIFY -> MERGE -> PERSIST
-> CONTINUE_DECISION -> FINAL_LIVE_READ -> FREEZE_REPORT_PACKET
-> REPORT_REFERENCE_PREFLIGHT -> RENDER_REPORT_V1_DETERMINISTIC
-> REPORT_TEXT_LEGIBILITY_CHECK -> REPORT_PREVIEW_LINK_CHECK
-> REPORT_RENDER_IDENTITY_CHECK -> REPORT_REFERENCE_MATCH_CHECK
-> EMIT_ONCE -> RETURN
```

Rules:

1. No final report visual is emitted before repository work, verification, persistence and the continuation decision are complete.
2. Compact text, SVG and link projection are projections of the same frozen packet.
3. The approved REPORT_V1 reference is mandatory for visual identity; the human-approved 2026-10-07 readability refinement controls factual layout and typography.
4. The final factual report MUST NOT be passed through image generation. There is no generative retry loop for text.
5. Exactly one accepted image is visible.
6. If the approved reference is unavailable, the deterministic renderer fails, text is unreadable, or preview linking cannot be preserved, classify `REPORT_OUTPUT_FAILURE` and keep the SIGA invocation non-finalized.
7. Any repository/PR/head/gate mutation after packet freeze invalidates the packet and visual.
8. When `preview_url` exists, the compact chat report MUST also include the exact clickable preview link; this is accessibility/navigation output, not a second visual report.
9. The accepted REPORT_V1 image is emitted last.

**A SIGA run without one validated final REPORT_V1 reference-locked visual report is not finalized.**

## NON-STOP PROGRESS — every SIGA run must execute a task

Inside the verified active repository, a successful `Siga` invocation MUST NOT terminate after only observing, reporting or waiting.

The invariant is:

```text
RECONCILE -> CLASSIFY -> ROUTE -> CLAIM -> EXECUTE -> VERIFY -> PERSIST -> CONTINUE
```

Every invocation must leave at least one concrete **progress unit**. Examples include:

- implementing or repairing code justified by the active spec;
- creating or advancing a bounded Spec Kit `spec.md`, `plan.md` or `tasks.md`;
- completing a repository-local lore/canon task through LORE;
- improving a repository-local specialist skill when that is the next bounded task;
- adding or repairing tests/acceptance automation;
- reconciling a safe conflict or branch drift;
- merging a verified PR;
- creating a repository-visible next task and executing its first meaningful atomic step in the same invocation.

Merely checking CI, saying that a PR is still running, restating a handoff, or reporting `WATCH` does **not** satisfy this invariant.

### WATCH is non-terminal

`WATCH` remains a valid classification for the **primary thread**, but it is never a reason for the whole SIGA invocation to become idle.

When the primary thread is waiting on CI, review, deployment, provider capacity, another PR or another external dependency, SIGA MUST:

1. preserve the blocked thread and its exact-head evidence;
2. perform a fresh overlap/concurrency scan;
3. select the next safe, bounded task that does not invalidate the blocked work;
4. create/claim that task in repository-visible state when needed;
5. execute at least the first meaningful step immediately;
6. persist both the watched thread and the parallel progress made.

This operating state may be described as **WATCH + PARALLEL_ADVANCE**, while the required top-level classification remains exactly one of `RESUME`, `WATCH` or `ADVANCE`.


## HUMAN VISUAL GATE ROUTING — ARTIST must run before waiting

A pending human decision is not, by itself, permission for SIGA to become idle. During **RECONCILE / ROUTE**, SIGA MUST classify every pending human gate by domain owner before deciding that the current item can only wait.

When the current item has a human gate about **visual direction, scene concept, UI/art concept, target-relative runtime parity, or post-implementation visual acceptance**, that gate is owned by `ARTIST`. Before SIGA may return `WATCH` or `BLOCKED` for that gate, SIGA **MUST invoke `.agents/skills/artist/SKILL.md` in the same invocation**.

Mandatory ARTIST routing:

1. **Concept gate not yet materialized/current** -> invoke `ARTIST <scene>` (or the correct bounded scene/object activation), create or revise exactly one current concept, and present it for explicit human `ACCEPT / REVISE / REJECT`.
2. **Runtime visual acceptance pending** -> invoke `ARTIST review <scene>` against fresh exact-head LENTE/runtime evidence and present the target-relative review package.
3. **Valid current ARTIST package already exists but the human has not answered** -> invoke ARTIST to reconcile and re-present that exact current gate package. Do not silently regenerate, supersede or mutate an accepted/current artifact merely because SIGA was invoked.
4. ARTIST returns domain control to SIGA after the gate package is materialized/presented. SIGA preserves branch/PR, strict-roadmap, exact-head and merge authority.

Only **after** ARTIST has materialized or re-presented the valid visual gate artifact, when the sole remaining action is the human decision, may SIGA classify the item as `WATCH` with blocker `HUMAN_GATE_PENDING`.

SIGA MUST NOT auto-accept, infer approval from silence, or convert green CI into human visual approval. `ACCEPT`, `REVISE` or `REJECT` remains a real human hard gate.

This rule applies **before** the strict-roadmap escape for a "required human/product decision": an ARTIST-owned visual gate is not a genuine no-safe-progress blocker until the ARTIST presentation step above has completed. Later strict-roadmap items remain locked while that decision is pending.

A non-visual human/product decision MUST route to its actual owning specialist or remain a truthful human blocker; SIGA must not call ARTIST for unrelated decisions.

## VISUAL PARITY P0 — target-relative convergence override

When the active repository roadmap is Feature 012 / ARTIST V1 Runtime Parity and any scene/certification item R04-R15 is not `PASS`, closing the concept-to-runtime visual gap is the **P0 product-delivery stream** for SIGA.

This is a priority rule, not a request to weaken engineering gates. SIGA MUST preserve gameplay, accessibility, performance, provenance, CI and delivery correctness while refusing to confuse those properties with visual completion.

Mandatory behavior:

1. The earliest non-`PASS` Feature 012 item outranks queued product features, speculative roadmap expansion, repository cosmetics, unrelated polish, reporting improvements and other optional work. Work outside the current item is allowed only when it directly removes a blocker for that same item.
2. **Technical green is necessary but never sufficient for visual parity.** Passing tests, clean browser logs, successful export/deploy, valid hotspots or a successful capture workflow cannot by themselves produce scene `PASS`.
3. Every scene review is **target-relative**: compare the locked global ARTIST board + the individually accepted scene concept + the exact-head runtime. The previous runtime build is regression evidence only; "better than before" is not an acceptance criterion.
4. If the exact-head runtime remains materially distant in composition, silhouette, depth, material language, prop density, focal hierarchy, lighting/atmosphere or pixel/graffiti treatment, classify `REVISE` even when the delta from the previous build is positive.
5. **Asset-production duty:** when the accepted target requires distinctive meshes, authored materials/textures/decals, props, vegetation, signage, scene dressing, lighting or atmosphere that the current primitives cannot express, route CENA/GODOT to create or replace the required production assets. Reuse convenience is not authority to preserve an inadequate blockout.
6. Historical `BLOCKOUT`, `PRODUCTION-CANDIDATE` or RB-13 labels do not prove Feature 012 parity. They are prior-state evidence until the current scene receives target-relative ARTIST/CENA runtime `ACCEPT`.
7. A structural mismatch must trigger recomposition/replacement under the existing structural-rebase rule; SIGA must not spend repeated turns adding cosmetic detail to a rejected scaffold.
8. While the current P0 item is waiting on concept review, rendered evidence or CI, same-item QA, decomposition, asset preparation, regression fencing and acceptance-package work remain valid progress; a later scene or Feature 013 implementation does not.
9. P0 visual-convergence priority ends only when R15 final V1 certification is `PASS`. R16 repository hygiene remains the strict successor, but it is cleanup rather than evidence that visual parity was solved.

Operationally, the desired loop is:

```text
LOCKED ART TARGET
  -> target decomposition
  -> production asset / scene implementation
  -> exact-head runtime capture
  -> target-delta review
  -> ACCEPT or structural/material REVISE
  -> PASS only on ACCEPT
```

## STRICT SEQUENTIAL ROADMAP OVERRIDE — mandatory when declared by active spec

An active Spec Kit feature may declare a checked-in roadmap with execution mode `STRICT_SEQUENTIAL` (for example Feature 012's `specs/012-artist-v1-runtime-parity/SIGA-ROADMAP.md`).

When such a roadmap exists and is active, it **overrides the normal later-task `WATCH + PARALLEL_ADVANCE` fallback for that roadmap**.

SIGA MUST:

1. find the earliest roadmap item that is not `PASS`;
2. treat it as the only mutable roadmap item;
3. keep later roadmap items `LOCKED`, even when their files do not overlap;
4. while the current item is `WATCH`, execute useful work only inside that same item (tests, diagnosis, capture preparation, evidence, reconciliation, acceptance package, safe fixes);
5. never start implementation, concept acceptance or delivery work for a later roadmap item merely to avoid idling;
6. mark the current item `PASS` only after its declared exit gates are verified and persisted;
7. unlock exactly one successor after that `PASS`.

The repository-wide non-stop-progress requirement still applies, but progress must remain **within the current strict item**. If no safe same-item progress is possible because of a real external dependency or required human/product decision, report `WATCH` or `BLOCKED` truthfully rather than violating sequence.

A strict roadmap can be superseded only by a newer explicit repository decision/spec or direct user instruction. Live repository/CI truth still outranks stale roadmap status, so SIGA must reconcile the item's real state before mutation.

## ARCHITECTURE OWNERSHIP FENCE — selected architecture controls implementation source

A final repository architecture/renderer/runtime decision constrains **how** production work is derived, not only which technology appears in the resulting files.

Before any player-facing implementation mutation, SIGA MUST resolve from the active repository spec/ADR:

1. the selected production architecture/renderer;
2. any lane marked `REFERENCE`, `FROZEN`, `ARCHIVED`, `EVIDENCE`, prototype-only or superseded;
3. the accepted product/ARTIST target from which production implementation must be decomposed;
4. which legacy contracts are explicitly reusable and which visual/runtime structures are non-authoritative.

For Feature 012 while `GODOT_NATIVE_V1` is locked:

- production derivation is `accepted ARTIST target -> CENA decomposition -> native Godot implementation`;
- `threejs/**`, renderer spikes and superseded generic low-poly/blockout composition are evidence/history only;
- semantic gameplay contracts, hotspot IDs, accessibility behavior and explicitly accepted shared Godot utilities may be reused;
- legacy visual geometry/camera/material structure does not survive merely because it already exists;
- adding neon, graffiti, lighting, pixel filtering or props over a structurally rejected legacy scaffold is not sufficient evidence of a Godot-native migration.

### Structural REVISE recovery

When ARTIST/CENA runtime review classifies a mismatch as structural — composition, massing, geometry language, focal hierarchy, density or pixel-surface language — SIGA MUST replace/recompose the rejected structure instead of starting another additive cosmetic pass on the same scaffold.

If the same structural mismatch class survives two consecutive runtime `REVISE` decisions, classify the current scene:

`STRUCTURAL_REBASE_REQUIRED`

In that state:

- keep the same current roadmap item;
- stop additive visual revisions;
- re-decompose the scene from its accepted target;
- preserve only explicitly reusable gameplay/hotspot/accessibility contracts;
- build a clean native implementation boundary;
- require fresh exact-head QA/LENTE/ARTIST evidence before progression.

### Strict-roadmap write fence applies to preparation too

When an active roadmap is `STRICT_SEQUENTIAL`, a locked successor cannot receive **any mutation merely labeled preparation**.

While a strict-roadmap item is current, this forbids every later locked item:

- implementation;
- ARTIST acceptance;
- branch/PR creation;
- preflight/spec-only preparation;
- task decomposition;
- successor handoff mutation.

Running CI, LENTE, deployment or review does not weaken this fence. Useful work while waiting must stay inside the current roadmap item.

The active roadmap/spec owns the current item identifier. This orchestrator MUST NOT hard-code a moving current roadmap item or revision number into the skill itself.

### Fallback order when the main thread is waiting

Choose the first safe option supported by repository evidence:

1. resume another already-documented incomplete task with no semantic/file collision;
2. advance the next documented Spec Kit task;
3. create/advance the next bounded spec/plan/tasks artifact so implementation is ready to start;
4. advance repository-local LORE canon/content work that is already justified by the product direction;
5. improve a repository-local skill/protocol when the missing capability is itself blocking repeated progress.

Do not invent random busywork merely to satisfy the rule. The fallback must be bounded, useful and traceable to repository evidence.

### Create-and-execute rule

If SIGA needs to create the next task, creation alone is insufficient. In the same invocation it MUST also execute at least one meaningful atomic step of that task, such as committing the first spec section, canon delta, test, implementation slice, acceptance artifact or skill update.

### Safety and concurrency boundaries

Non-stop progress does not authorize unsafe mutation.

- Never weaken required gates merely to keep moving.
- Never write through a semantic collision that requires an unresolved product/canon decision.
- Prefer a disjoint branch from the newest safe base for parallel work.
- If a safe stacked dependency is required, declare it explicitly and preserve bottom-up delivery order.
- Repository identity failure, missing write permission, or an unresolved destructive/semantic collision may still fail closed; these are exceptional inability states, not normal `WATCH` outcomes.

## MASTER ORCHESTRATOR — SIGA owns routing and delivery

`SIGA` is the repository-local **master command**. The user does not need to manually choose a specialist skill before asking the project to continue.

SIGA MUST discover and use active skills only from `.agents/skills/**/SKILL.md` in `az1nn/growing-rio`. Global registries, chat memory, templates and external repository state are never routing authority.

Before routing a specialist, SIGA MUST validate the specialist contract:

- its repository identity is `az1nn/growing-rio` or it makes no independent repository claim;
- it does not relocate canonical SIGA state/authority;
- it returns branch/PR, exact-head verification and final delivery control to SIGA;
- any contradictory repository or SIGA-ownership statement is `PROTOCOL_DRIFT` and must be repaired before that specialist is used for mutation.

Specialists may own domain decisions and implementation, but they cannot override SIGA's repository lock, top-level `RESUME/WATCH/ADVANCE` classification, concurrency protocol, exact-head gate policy or merge authority.

Known specialist ownership includes:

- `ARTIST` — locked V1 art direction, isolated concepts, human concept approval and post-implementation visual review;
- `CENA` — visual production/materialization, composition, assets/provenance, lighting/material treatment and rendered visual acceptance;
- `GODOT` — Godot runtime/engine implementation: SceneTree, signals/input, Resources/imports, SubViewport/render mechanics, performance, debugging and Web export behavior;
- `QA` — automated quality gates: structural/headless regressions, browser E2E, input/accessibility, save migration, export, deterministic visual regression and measurable performance budgets;
- `LENTE` — exact-head screenshots/videos, object inventory and multimodal observation/critique;
- `LORE` — narrative canon and the `CÂNONE / RUMOR / ABERTO` authority boundary;
- `RELATORIO` — read-only compact CAVEMAN repository status reporting;
- `3JS` — **REFERENCE/FROZEN for V1**. Route implementation here only when an explicit active architecture spec selects Three.js again; otherwise it remains historical/prototyping evidence;
- `siga-concurrency` — mandatory helper for mutating waves and merge safety.

Additional repository-local skills may be routed when their checked-in `SKILL.md` establishes ownership of the bounded concern.

Routing rules:

- SIGA remains responsible for repository identity, live-state reconciliation, top-level `RESUME / WATCH / ADVANCE` classification, branch/PR coordination, concurrency, exact-head verification, merge and final persistence.
- A specialist skill owns its domain decision/implementation, but it MUST return repository delivery control to SIGA.
- Direct standalone specialist commands such as `Artist`, `Cena`, `Godot`, `QA`, `Lente`, `Lore` or `Relatorio` remain supported as expert shortcuts; they do not revoke SIGA's merge-safety and repository-truth rules.
- When more than one specialist is needed, route by ownership and dependency. The default visual/runtime chain is `ARTIST -> CENA -> GODOT -> QA -> LENTE -> ARTIST/CENA acceptance -> SIGA delivery`. Skip specialists that are not applicable; never invoke 3JS merely because historical prototypes exist.
- Do not invoke a specialist merely because its name appeared in chat. Route from live repository evidence and the active bounded work.
- Do not reopen a completed specialist wave unless live evidence shows regression, an unfinished task, a failing gate or a new bounded spec.

## MERGE AUTHORITY — automatic when verified safe

SIGA is explicitly authorized to **resolve merge conflicts and merge without additional user confirmation** when all applicable repository conditions are satisfied.

Before merge, SIGA MUST verify at minimum:

- the PR is still open and mergeable/reconcilable against its intended base;
- the exact current head SHA is known;
- required automated tests/checks are successful for that exact head;
- required rendered/human acceptance evidence is satisfied when the active specialist contract requires it;
- required provider/deployment status is successful, unless repository policy explicitly classifies it as a non-required soft gate;
- no unresolved semantic collision, dependency-order violation or superseding sibling implementation remains;
- a fresh open-PR overlap scan does not invalidate the merge plan.

When these conditions hold, SIGA SHOULD merge immediately rather than pausing for confirmation. Use the current expected head SHA as a merge guard when supported, then verify the resulting default-branch commit and applicable post-merge gates.

A real failing required gate still blocks merge. A required provider gate under explicit `SOFT_GATE_RATE_LIMIT` remains merge-deferred under the repository's existing rate-limit policy. Competing sibling candidates MUST be reconciled or one explicitly classified `SUPERSEDED` before either is delivered.

## CONCURRENCY CONTROL — mandatory for mutating waves

SIGA MUST load and follow `.agents/skills/siga-concurrency/SKILL.md` whenever a continuation may mutate repository state.

Concurrency handling is part of **RECONCILE**, **EXECUTE** and **PERSIST**, not an optional cleanup step.

Before the first mutation, SIGA MUST capture an expected concurrency snapshot containing the current default-branch HEAD, working-branch HEAD, open PR heads, relevant workflow heads and blob SHAs for files it expects to change.

For every mutating session on an **existing open PR branch**, SIGA MUST also establish a same-branch writer epoch keyed by the exact observed branch HEAD. Blob-SHA protection is not sufficient: the logical batch must publish by atomic branch-head CAS/fast-forward against that expected HEAD. If the ref moved, classify `BRANCH_LEASE_LOST`, publish nothing to the shared branch, and reconcile before retrying.

Once required exact-head CI/LENTE/deployment is dispatched for a candidate SHA, that branch is under `GATE_FREEZE`: no code, handoff, task, status, or docs-only mutation may change the PR head until the evidence for that exact SHA reaches a terminal state and is consumed into an explicit decision. A head move during the freeze is both `BRANCH_LEASE_LOST` and `GATE_STALE`.

SIGA MUST use the helper skill to:

- create/select a dedicated branch before feature mutation;
- publish a repository-visible session claim and pass the post-claim concurrency barrier before substantive mutation;
- re-read live state before logical write batches;
- detect default-branch, branch, PR, file, spec, handoff and CI drift;
- classify drift as `CLEAR`, `PARALLEL_SAFE`, `RECONCILE`, `COLLISION`, `SUPERSEDED` or `GATE_STALE`;
- scan open PRs for file/contract overlap before implementation and before merge;
- reconcile concurrent handoff edits from live facts rather than overwriting a newer copy;
- integrate newer default-branch work without discarding concurrent commits;
- use current blob SHA guards for same-path writes **plus** atomic branch-head CAS/fast-forward publication for shared/open PR branches;
- treat GitHub Contents API blob guards alone as insufficient to lease a shared branch head;
- enter `GATE_FREEZE` after dispatching required exact-head evidence and forbid all mutations on that branch until that evidence is consumed;
- classify an unexpected same-branch head move as `BRANCH_LEASE_LOST` and recompute from live state;
- invalidate green CI whenever the current head SHA differs from the validated SHA;
- require green validation for the exact current PR head;
- use an expected-head guard for PR merge when available;
- validate the resulting default-branch merge commit and any later final-handoff HEAD required by repository exact-head policy.

Force updates MUST NOT be used as a normal concurrency mechanism. A rejected optimistic-concurrency write means state must be re-read and reconciled.

Concurrency state constrains the SIGA route but does not replace it. If concurrent work changes the evidence for `RESUME`, `WATCH` or `ADVANCE`, SIGA MUST recompute the route immediately.

See `docs/SIGA-CONCURRENCY.md` for the repository concurrency model.

## SPEC KIT — feature delivery contract

When `.specify/memory/constitution.md` exists, SIGA MUST treat Spec Kit artifacts as part of the repository evidence set.

During **RECONCILE**, inspect when applicable:

- the ratified constitution;
- the active or next bounded feature under `specs/`;
- that feature's `spec.md`, `plan.md`, `tasks.md` and requirements checklist;
- whether implementation scope still matches the spec;
- whether completed code has corresponding completed tasks and acceptance evidence.

During **CLASSIFY**:

- use `RESUME` when a dispatched feature has unfinished spec tasks or failed acceptance criteria;
- use `WATCH` when the implementation is complete but exact-head CI/review gates remain active;
- use `ADVANCE` only after the previous feature is merged/validated and the next feature is either already specified or can first be specified as the new wave.

During **EXECUTE** for a new capability:

1. establish or select the bounded feature spec before coding;
2. keep technical decisions in the feature plan rather than silently embedding them in the spec;
3. keep dependency-ordered work in `tasks.md`;
4. implement only work justified by the active spec/plan;
5. update tasks and artifacts when scope materially changes;
6. converge implementation against acceptance criteria before exact-head CI/merge.

Bug fixes that restore already-specified behavior may use a smaller repair path and do not require a new feature spec unless they introduce new product behavior.

Spec Kit does not replace SIGA or LORE. SIGA remains the continuation router; LORE remains the narrative-canon router.


## EXTERNAL BUILD RATE LIMIT — NEVER BLOCK DEVELOPMENT OR MERGE

Repository law:

```text
RATE LIMIT NEVER BLOCKS DEVELOPMENT.
RATE LIMIT NEVER BLOCKS MERGE WHEN REQUIRED TESTS AND VALIDATIONS PASS.
```

A deployment/build-provider **rate limit, quota window or temporary scheduling throttle** is external capacity debt only when all of the following are true:

- the failure is explicitly identified as provider capacity/rate/quota limiting;
- repository validation for the relevant code is green;
- Godot/application build logic is not reporting a real compile, import, test, export or runtime failure;
- no semantic collision or repository safety gate requires work to stop.

Classify this state as `SOFT_GATE_RATE_LIMIT`.

`SOFT_GATE_RATE_LIMIT` rules:

- it MUST NOT force the repository or PR into an idle state;
- SIGA MUST continue safe bounded development;
- it MUST NOT prevent merge when all required repository tests, exact-head validations and applicable acceptance checks have passed;
- SIGA is authorized to merge such a PR immediately with the normal expected-head and concurrency guards;
- a provider rate-limit result MUST NOT be counted as a failed code/build validation and MUST NOT be included in the required-gates predicate for merge;
- downstream work may continue normally; stacking is allowed only for real semantic dependencies, never merely because a provider is rate-limited;
- after merge, public deployment parity remains **unverified** until the provider later produces successful deployment evidence;
- the handoff/graph must distinguish `MERGED_WITH_PROVIDER_RATE_LIMIT` from a fully deployment-verified release when that distinction matters.

A provider result caused by a real source/build/configuration/runtime failure is **not** `SOFT_GATE_RATE_LIMIT`. Treat it as a normal failing gate and `RESUME` the concrete defect.

This law overrides older repository text that described provider rate limiting as merge-deferred.

## LONG-RUNNING TESTS / CHECKS — progressive check windows

A required exact-head test, workflow, visual capture or deployment that is `queued` or `in_progress` MUST NOT cause tight polling or an indefinitely open SIGA turn.

For each unchanged exact head, use this bounded progressive cadence:

```text
t0      -> initial live status read
+15s    -> recheck 1
+30s    -> recheck 2
+60s    -> recheck 3
+120s   -> recheck 4 (final same-invocation polling window)
```

The delays are minimum windows, not a requirement to busy-wait. If the execution environment cannot pause efficiently, skip sleeping: perform safe parallel progress and use the next live read as the next eligible check window.

Polling rules:
- key the watch to `repository + PR + exact head SHA + workflow/check id`;
- between windows, execute the bounded `WATCH + PARALLEL_ADVANCE` work required by this skill instead of repeatedly reading CI;
- use lightweight status/check/run metadata only while a gate is running;
- do not refetch PR diffs, repository trees, artifacts or full logs on every poll;
- fetch job steps/logs/artifacts only after a concrete failure, required acceptance review, or completion makes them necessary;
- if the PR/head SHA changes, classify prior evidence `GATE_STALE`, reset the schedule for the new head and verify from t0;
- if all required gates become green, immediately continue normal merge/delivery logic;
- if a real required gate fails, stop polling that gate and diagnose the smallest failing job/step;
- if the fourth recheck is still pending, stop same-invocation polling. Persist the exact pending gate plus next eligible check window, finish any safe progress unit, emit the compact developer report, and return. A later `Siga` invocation resumes from live state rather than pretending background monitoring exists.

A session MUST NOT remain open solely to wait for CI after the bounded polling budget is exhausted.

## CI STARTUP / RUNNER FAILURE RECOVERY

A GitHub Actions failure is not automatically evidence that repository code or tests failed.

When a workflow run concludes `failure`, inspect its jobs before classifying the gate. If the failed job has no executed step evidence (for example `steps` is null/empty and no step log exists), classify it as:

```text
CI_STARTUP_INFRA_FAILURE
```

This means the job failed before repository commands executed.

Recovery rules:

- preserve the exact PR head SHA; do not create a no-op commit merely to manufacture a new run;
- if the provider/API supports it, rerun the failed workflow jobs once on the same exact head;
- after dispatch, re-read the run/jobs and require normal exact-head success before merge;
- if the retry reaches repository steps and a step fails, classify and repair the concrete repository defect normally;
- if the retry again fails before any step executes, keep the required gate unsatisfied and record the infrastructure failure; do not loop retries indefinitely in one SIGA invocation;
- a pre-step failure never counts as green evidence and never authorizes weakening or bypassing a required gate;
- while that gate is pending, apply the normal WATCH + PARALLEL_ADVANCE rule so the repository still receives safe, bounded progress elsewhere.

This classification is distinct from `SOFT_GATE_RATE_LIMIT`: rate limiting is a deployment/provider capacity condition, while `CI_STARTUP_INFRA_FAILURE` is a workflow-runner startup condition.

### Hosted-runner allocation failure and provider-neutral validation

When the GitHub job API reports all of the following for a failed job:

- `runner_id = 0`;
- empty `runner_name`;
- `steps` null or empty;
- no downloadable job log;
- completion within seconds before checkout/setup can run;

classify the failure as the more specific subtype:

```text
CI_RUNNER_ALLOCATION_FAILURE
```

This is runner-dispatch evidence, not test execution evidence.

Recovery and delivery rules:

- one controlled same-head retry remains allowed; repeated allocation failure MUST NOT trigger no-op commits or retry loops;
- the canonical repository validation command is `bash tools/ci_validate.sh`;
- GitHub Actions `Validate project` and any configured independent provider fallback MUST execute that same canonical script rather than maintain divergent test lists;
- Vercel may satisfy the **project-validation** gate for an exact head only when the exact-head deployment used the checked-in `vercel.json` whose `buildCommand` executes `bash tools/ci_validate.sh`, and the deployment concluded successfully;
- a historical Vercel success produced before that build contract existed is not validation evidence;
- provider-neutral fallback satisfies only the project-validation gate. It never substitutes for required rendered Visual/CENA/3JS acceptance;
- rendered acceptance is not product-applicable to a PR whose live changed-file set contains no render-impacting product/runtime path;
- a visual workflow file may include itself in `pull_request.paths` so CI-infrastructure edits exercise dispatch/syntax when runners are available, but that workflow-file change alone does not create a rendered-product acceptance requirement;
- if runtime/visual files changed and required rendered acceptance cannot execute, merge remains blocked even if canonical project validation succeeds elsewhere;
- a provider rate limit remains `SOFT_GATE_RATE_LIMIT`; it may be ignored for merge only when all required validation evidence has already been obtained from another valid execution path.

This fallback exists to remove GitHub-hosted runner allocation as a single point of failure without weakening the exact-head test contract.

## WEB DELIVERY — playable browser build

When this Godot repository has a browser export or deployment path configured, the playable Web build is part of the real operational state that SIGA must reconcile.

During **RECONCILE**, inspect when applicable:

- Godot Web export configuration (for example `export_presets.cfg`);
- CI workflow(s) that build/test/export the Web target;
- deployment configuration for the selected provider (for example Vercel or GitHub Pages);
- the latest relevant Actions/deployment result;
- the current public playable URL, when one is configured.

During **CLASSIFY**:

- classify as `RESUME` when the current milestone requires Web delivery and export/deploy is missing or broken;
- classify as `WATCH` when the Web build/deployment is already dispatched and its gate is still running;
- classify as `ADVANCE` only after the required code/tests plus Web export/deployment gates are green for milestones where browser delivery is part of the acceptance criteria.

During **EXECUTE**:

- keep Web export/deployment reproducible from repository configuration and CI;
- prefer automated promotion from the validated default branch rather than manual uploads;
- do not publish a failing or unvalidated build as the stable public playable version;
- preview deployments may be used for branches/PRs when the provider supports them, without replacing the stable build.

During **PERSIST**, record Web delivery state in `docs/SIGA-HANDOFF.md` when relevant: provider, public/preview URL, workflow/run or deployment reference, last verified commit, gate result and next action.

If Web delivery is not configured yet and is not required by the current milestone, its absence is not by itself a failure. Once Web delivery becomes an accepted project capability or milestone, SIGA must preserve and verify it on subsequent continuations.

Trust order: **REAL STATE / CI > ratified constitution > active spec/plan/tasks > repository handoff/canon/docs > conversation context**.

Do not use chat memory as canonical project state. Do not create a second global SIGA state outside this repository.
