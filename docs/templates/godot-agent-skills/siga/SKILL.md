---
name: siga
description: Resume or advance work in the Godot repository that contains this skill when the user invokes the standalone magic word `Siga`.
---

# SIGA — Godot repository continuation protocol

## Purpose

`Siga` means: continue this repository from verified real state.

This skill is local to the repository that contains it. It is not a global cross-project state machine.

Authority:

```text
REAL REPOSITORY STATE > docs/SIGA-HANDOFF.md > repository specs/docs > chat/model memory
```

Chat/model memory may help locate evidence but never overrides repository evidence.

---

## Trigger

Treat `Siga` as the continuation command when used standalone, ignoring case, surrounding whitespace and terminal punctuation.

Examples:

```text
Siga
siga
SIGA
Siga!
```

Prose that merely contains the word is not automatically a continuation invocation.

---

# Start protocol

Every standalone `Siga` begins VERIFY-FIRST.

## 1. RECONCILE

Inspect the smallest sufficient set of live repository evidence.

### RepoProbe
- repository identity;
- default branch;
- exact HEAD;
- recent relevant commits;
- working/open branches;
- active pull requests.

### GodotProbe
- `project.godot`;
- engine version when discoverable;
- main scene when relevant;
- autoloads when relevant;
- changed scenes, Resources and scripts;
- parse/import health when the repository has an automated way to verify it.

### WorkProbe
- `docs/SIGA-HANDOFF.md`;
- roadmap/spec/task documents;
- active PR description and unresolved review threads;
- TODOs that are explicitly canonical to the current milestone.

### EvidenceProbe
- exact PR/head SHA;
- CI/check status;
- mergeability;
- failed or running gates;
- whether evidence became stale after later commits.

### DeliveryProbe
When delivery is configured or required:
- `export_presets.cfg`;
- Web/desktop/mobile export configuration;
- deployment workflow/provider;
- latest relevant deployment result;
- public/preview playable URL;
- exact deployed commit when available.

Never infer green state from old checks.

---

## 2. DECIDE

Choose exactly one continuation route.

### RESUME

Use when unfinished work exists and safe work remains.

Examples:
- active feature branch has incomplete implementation;
- failing tests have an actionable repository-local fix;
- PR review requires changes;
- handoff names an unfinished coherent wave.

Action:

```text
RESUME
-> continue the same work
-> do not switch initiatives
-> verify
-> persist handoff
```

### WATCH

Use when the primary work is already dispatched and its remaining state is an active external gate.

Examples:
- CI is running;
- deployment is running;
- review/merge gate is pending.

WATCH is **non-terminal** for the overall SIGA invocation.

Action:

```text
WATCH
-> inspect and preserve the active gate/exact-head evidence
-> do not invent duplicate work
-> scan for a safe non-overlapping next task
-> execute at least one meaningful progress unit on that task
-> merge/promote the watched work only when repository policy permits
-> persist both watched state and parallel progress
```

Operationally this may be described as `WATCH + PARALLEL_ADVANCE`, while the top-level route remains `WATCH`.


### Progressive check windows for slow gates

When an exact-head gate is `queued` or `in_progress`, never tight-poll it or keep the invocation open indefinitely.

Use at most four same-invocation rechecks for an unchanged head:

```text
initial read -> +15s -> +30s -> +60s -> +120s
```

These are minimum windows. Between them, perform safe `WATCH + PARALLEL_ADVANCE` work. Poll only lightweight run/check metadata while running; fetch detailed logs/artifacts only on failure or when acceptance requires them. If the head changes, mark prior evidence stale and restart from the new exact head.

If the final +120s recheck is still pending, stop polling in that invocation, persist the pending gate and next check window, complete the bounded fallback progress unit, emit the compact developer-session report, and return. Never claim background monitoring.


### ADVANCE

Use only when the previous coherent work is verifiably complete.

Select the next smallest repository-supported milestone from, in order:

1. explicit next action in `docs/SIGA-HANDOFF.md`;
2. current roadmap/spec;
3. unresolved dependency blocking the current milestone;
4. next coherent capability already implied by implemented architecture.

Do not create roadmap scope merely to stay busy.

---

## 3. EXECUTE

Perform one coherent wave and do not return from a successful SIGA invocation without concrete repository progress.

### Non-stop progress invariant

A status-only result is not successful completion. Every invocation MUST leave at least one concrete progress unit, such as implementation, a repair, a test, a merge, a conflict reconciliation, a Spec Kit artifact, lore/canon work, or a repository-local skill improvement.

When the primary thread is waiting, choose the first safe repository-supported fallback:

1. another already-documented incomplete task with no semantic/file collision;
2. the next documented Spec Kit task;
3. create/advance the next bounded `spec.md`, `plan.md` or `tasks.md`;
4. advance repository-local LORE work justified by current product direction;
5. improve a repository-local skill/protocol when that missing capability blocks repeated progress.

If SIGA creates a next task, creation alone is insufficient: execute its first meaningful atomic step in the same invocation.

Required gates are never weakened merely to keep moving. Repository mismatch, missing write authority, or an unresolved destructive/semantic collision may still fail closed.

Perform one coherent primary wave; a waiting primary wave may carry one bounded, safe fallback advance.

Allowed work may include:

- gameplay implementation;
- architecture/refactor required by the current task;
- tests and validators;
- save/load changes and migrations;
- content data;
- scenes/Resources;
- CI;
- export/deployment;
- documentation;
- bug fixes;
- release/promotion work.

Rules:

- make the smallest coherent change;
- preserve existing project conventions;
- prefer repository-discovered commands over invented commands;
- run all applicable automated checks;
- bind gate claims to the exact tested HEAD;
- use a branch/PR when repository practice or task risk warrants it;
- do not mix unrelated initiatives into one wave.

If a required human decision blocks safe progress, state the precise blocker rather than fabricating a decision.

---

# Godot verification

Use only checks supported by the target repository.

Possible checks include:

- Godot headless import;
- scene/resource parse validation;
- GDScript/static checks;
- unit/regression tests;
- deterministic seeded simulation tests;
- save/load round-trip and migration tests;
- export smoke tests;
- Web build;
- deployment validation.

Do not claim a check was run if the repository has no such check or it was not actually executed.

---

# Web delivery

When browser delivery is configured or part of milestone acceptance, treat it as operational state.

During RECONCILE inspect:

- `export_presets.cfg`;
- Web export configuration;
- CI build/export workflow;
- deployment provider/config;
- latest deployment;
- public or preview URL;
- exact deployed commit when available.

During DECIDE:

- `RESUME` when required Web export/deploy is missing or broken;
- `WATCH` when build/deploy is actively running;
- `ADVANCE` only after required code/tests plus delivery gates are verified.

During EXECUTE:

- keep export/deployment reproducible from repository configuration;
- prefer automated promotion from validated repository state;
- never replace the stable playable build with a known failing/unvalidated build.

If Web delivery is not configured and is not part of current acceptance, absence alone is not a failure.

---

# Final developer-session report — mandatory

Every standalone `Siga` must end with a compact live report for the next developer/session. Keep it to **8 concise lines/bullets maximum** by default.

```text
SIGA <RESUME|WATCH|ADVANCE> — <task/milestone>
Repo: <branch/head-short-sha> | PR: <#n/state or none>
Done: <material progress from this invocation only>
Gates: <required exact-head gates only>
Wait: <next progressive-check window or none>
Blocker: <actionable blocker or none>
Next: <one next action>
```

Do not dump full diffs/logs, long file lists, old completed waves or the full persistent handoff into chat. Collapse equivalent green checks. Expand only a concrete failure that the next developer must act on.

---

## 4. PERSIST

Persistent continuation state lives only in:

```text
docs/SIGA-HANDOFF.md
```

Do not create a competing global state in chat memory, another repository or an external note.

After meaningful work, update the handoff with:

- repository/default branch;
- exact verified HEAD;
- active PR when any;
- route used;
- completed wave;
- exact gates and results;
- delivery state when relevant;
- blockers;
- next action;
- project-specific boundaries.

The handoff never overrides live repository state.

---

# Handoff format

Use:

```markdown
# SIGA HANDOFF — <GAME_NAME>

## Verified repository
- Repository:
- Default branch:
- Verified HEAD:
- Active PR:

## Current milestone
- ...

## Decision
RESUME | WATCH | ADVANCE

## Completed this wave
- ...

## Verified gates
- ...

## Delivery
- Export:
- Deployment:
- Playable URL:
- Verified deployment commit:

## Active gate
- ...

## Next action
1. ...

## Boundaries
- ...
```

---

# One-wave rule

A single `Siga` invocation should complete or materially advance one coherent primary wave.

When that primary wave is externally waiting, one bounded fallback task is required so the invocation still produces progress. The fallback must be traceable to repository evidence and concurrency-safe; it must not become arbitrary busywork.

Do not combine unrelated gameplay, lore, infrastructure and roadmap initiatives merely because all are available.

---

# Relationship to LORE

`Siga` is the general project continuation protocol.

`lore` is the narrative-specialized sibling.

Shared principles:

```text
VERIFY-FIRST
REAL STATE > HANDOFF > CHAT
RECONCILE -> DECIDE -> EXECUTE SOMETHING -> VERIFY -> PERSIST
NO STATUS-ONLY COMPLETION
NO FALSE COMPLETION
NO STALE GATE CLAIMS
ONE COHERENT WAVE
```

When the user invokes standalone `lore`, the narrower narrative skill owns that invocation.

---

# Repository boundary

This skill is valid only inside the repository that contains it.

If the current resolved repository is not the expected project or is not a valid Godot project:

```text
GODOT_REPO_MISMATCH
-> stop
-> show the resolved repository
-> perform no mutation
```

Repository renames must be discovered from live Git/GitHub state rather than retained from old chat state.
