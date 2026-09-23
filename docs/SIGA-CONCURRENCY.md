# SIGA Concurrency Model

This document explains the repository concurrency model enforced by `.agents/skills/siga-concurrency/SKILL.md`.

## Why this exists

SIGA can run while other sessions, skills or humans are also updating the repository. The dangerous case is not concurrency itself; it is continuing from stale assumptions.

The protocol therefore uses **optimistic concurrency** rather than a global lock.

## Repository-visible coordination

The coordination primitives are ordinary GitHub state:

- default-branch HEAD;
- dedicated feature branches;
- open pull requests;
- file/blob SHAs;
- workflow runs tied to exact commit SHAs;
- Spec Kit artifacts;
- repository handoffs.

No chat-memory lock and no external/global SIGA state is authoritative.

## Safety barriers

### Read barrier
Reconcile repository state before a mutating wave.

### Branch barrier
Create/select a dedicated branch from the verified default-branch HEAD before feature mutation.

### Write barrier
Re-read branch/file identity before logical write batches and use current blob SHA guards.

### Integration barrier
If default branch advances, classify drift and integrate/reconcile before final CI.

### Merge barrier
Require green CI for the exact current PR head and use an expected-head guard.

### Completion barrier
Validate the merge commit and, if the final handoff changes default-branch HEAD, validate that final HEAD as well.

## Collision matrix

| Drift | Meaning | Default action |
| --- | --- | --- |
| CLEAR | No relevant change | Continue |
| PARALLEL_SAFE | Disjoint concurrent change | Integrate latest base before final validation |
| RECONCILE | Relevant base/head/file/spec moved | Stop mutation and reconcile |
| COLLISION | Same path/contract/state changed | Semantic merge |
| SUPERSEDED | Newer work replaces planned work | Recompute SIGA route |
| GATE_STALE | Green CI belongs to older SHA | Revalidate exact head |

## Special case: handoffs

Handoffs are frequently updated by independent SIGA/LORE waves. They are not mutex files.

If a handoff changes concurrently, reconstruct it from current GitHub/CI/spec facts rather than choosing the older or newer prose wholesale.

## Required observable behavior

A correct SIGA concurrency run should be able to demonstrate:

- which default-branch SHA the work started from;
- whether default branch moved during the wave;
- whether open PRs overlapped;
- how overlapping changes were reconciled;
- the final exact PR head SHA;
- the CI run validating that exact SHA;
- the merge commit;
- the post-merge/final-default-head validation evidence.

These facts belong in `docs/SIGA-HANDOFF.md` when they materially affect continuation.
