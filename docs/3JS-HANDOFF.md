# 3JS HANDOFF v1

## Identity

Repository:

```text
az1nn/growing-rio
```

Skill:

```text
.agents/skills/3js/SKILL.md
```

Architecture contract:

```text
docs/3JS-ARCHITECTURE.md
```

## Verified bootstrap state — 2026-09-26

Verified default branch:

```text
master
```

Verified base HEAD used to claim this bootstrap wave:

```text
56f05518a0dd6a9e4c898851be7cd99c40416b4c
```

Open PRs observed immediately before branch claim:

- #97 — `feat/cena-016-foreground-floor-depth` -> `master`
- #98 — `feat/cena-017-foreground-apron-transition` -> PR #97 branch
- #100 — `docs/siga-20260925-live-reconciliation` -> `master`
- #101 — `feat/cena-018-foreground-service-plinth` -> PR #98 branch

The active CENA stack owns `docs/CENA-HANDOFF.md`, `docs/VISUAL-DIRECTION.md`, `scenes/visual/operation_diorama.tscn`, related scene tests and validator changes. This 3JS bootstrap intentionally does **not** edit those files.

PR #102 (Act I lore event library) was verified merged into `master` before this branch was created.

## Bootstrap branch

```text
feat/3js-scene-workflow
```

## Route

```text
3JS-ADVANCE
```

There was no existing Three.js implementation, branch, PR or indexed Three.js code in the verified repository at bootstrap time.

The requested capability is therefore initialized as a new repo-local continuation discipline rather than treated as unfinished runtime work.

## User direction encoded

- create a standalone command/skill named **3js**;
- use **SIGA + LORE + CENA** as coordinated authorities;
- implement and refine 3D scenes with Three.js;
- preserve the visual style already present because the current direction is accepted;
- do not use the existence of Three.js as permission for an unbounded redesign or engine migration.

## Style lock

Until CENA explicitly changes direction, 3JS preserves:

- orthographic diorama composition;
- 2D/3D hybrid presentation;
- portrait-first 540x960 and 1080x1920 framing;
- concrete / warm plaster / dark metal / teal / terracotta palette;
- restrained low-poly foliage;
- cool/warm lighting grammar;
- strong silhouette and architectural rhythm;
- UI legibility over the 3D scene.

## Architecture decision

Godot remains the canonical runtime at bootstrap.

Three.js starts through an **additive parity proof**. No stable boot path, gameplay state, persistence contract or generated Godot Web export is replaced in 3JS-000.

This follows the engineering constitution: the first player-facing Three.js runtime capability must receive a bounded Spec Kit feature before implementation.

## Delivered in 3JS-000

- `.agents/skills/3js/SKILL.md`
- `docs/3JS-ARCHITECTURE.md`
- `docs/3JS-HANDOFF.md`

No runtime dependency is added in this bootstrap wave.

## Next bounded wave

```text
3JS-001 — OperationDiorama parity proof
```

On the next standalone `3js` invocation:

1. reconcile live repository state and the active CENA stack;
2. classify RESUME/WATCH/ADVANCE/BLOCKED from live evidence;
3. create/select the bounded 3JS-001 Spec Kit feature before runtime code;
4. define the Three.js integration path without hand-editing generated `web/` export artifacts;
5. reproduce the accepted OperationDiorama visual grammar in an additive/reversible Three.js proof;
6. connect only through a read-only presentation model;
7. validate 540x960 + 1080x1920 captures, console/page errors and Web performance;
8. do not discuss runtime replacement until parity and performance evidence exist.

## Dependencies

### SIGA
Required for repository identity, Spec Kit, concurrency, CI, Web delivery and merge safety.

### CENA
Required for visual target, visual acceptance, asset/provenance decisions and any future art-direction change.

### LORE
Required only when a Three.js scene depicts narrative facts not already safely derivable from canonical documents.

## Known debt

- Three.js is not yet an installed runtime dependency.
- No 3JS Spec Kit feature exists yet.
- No Three.js scene exists yet.
- No parity/performance evidence exists yet.
- The CENA foreground stack is still active and must be reconciled before 3JS-001 derives its final OperationDiorama geometry/composition baseline.

These are expected bootstrap facts, not failures.
