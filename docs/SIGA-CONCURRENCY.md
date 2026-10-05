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

### Session-claim barrier
Before substantive mutation, create a repository-visible draft PR claim carrying a stable task key and intended scope, then immediately rescan all open PRs. The rescan is mandatory even when the pre-claim scan saw zero open PRs.

If two claims overlap, the owner is deterministic: earliest PR `created_at`, then lower PR number as tie-breaker. Later overlapping sessions become `SUPERSEDED` before additional substantive writes.

This closes the race between “scan” and “start work” that can otherwise allow two sessions to independently decide the same task is free.

### Live session/task/CI-CD graph
Every SIGA response exposes a compact graph reconstructed from current GitHub state:

```text
SESSIONS
S127 [OWNER] 009:T004-T005 -> branch@sha
S129 [PARALLEL] SIGA-CONCURRENCY:... -> branch@sha

TASKS
T004 ✅ -> T005 active -> T006 next

CI/CD
PR127@sha -> Validate ✅ -> Visual ⏳ -> Three.js ✅ -> Vercel ⚠ rate-limit -> Merge blocked
```

The graph is refreshed after material mutations and before the final response. It is an observability surface only; GitHub/CI remains authoritative.

### Same-branch writer barrier
An existing PR branch has exactly one writer epoch at a time: `repository + PR + branch + expected_head_sha`.

Prepare a logical batch from that exact HEAD and publish it with a normal fast-forward push or a Git ref compare-and-swap (`force=false`, expected SHA when supported). File/blob SHAs remain useful for same-path safety, but **blob SHA alone is not a branch lease**.

If another session moves the branch before publication, the stale batch must not land. Classify `BRANCH_LEASE_LOST`, discard the unpublished candidate, and reconcile from the new head.

### Gate-freeze barrier
After required exact-head validation/capture/deployment is dispatched, freeze the branch at that SHA:

```text
GATE_FREEZE(pr, branch, frozen_head_sha)
```

No mutation — including handoff/status/docs-only bookkeeping — may move that branch until the evidence is terminal and consumed into an explicit decision. If the branch moves during the freeze, classify both `BRANCH_LEASE_LOST` and `GATE_STALE`; old evidence cannot authorize delivery.

Implementation, regression fences, and required task/handoff persistence should therefore be batched **before** entering the freeze.

### Write barrier
Re-read branch/file identity before logical write batches. Use blob SHA guards for paths and branch-head CAS/fast-forward for the batch.

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
| BRANCH_LEASE_LOST | Shared PR branch moved outside the current writer epoch | Publish nothing; reconcile new head |

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


## CI for stacked pull requests

GitHub evaluates `pull_request.branches` against the pull request's **base branch**. Therefore a workflow restricted to `branches: [master]` does not cover a manually stacked PR whose base is another feature branch.

DA LATA uses this validation model:

- automatic validation on every `pull_request`, regardless of base branch;
- `push` validation on `master`;
- `workflow_dispatch` as a branch/ref recovery mechanism;
- explicit checkout of the PR head SHA for exact-head evidence;
- read-only repository permissions for validation;
- no `pull_request_target` execution of PR code.

Why explicit checkout matters: the default `pull_request` checkout uses GitHub's synthetic merge ref. That is useful for merge-result testing, but it is not identical to SIGA's invariant `validated_sha == current_pr_head_sha`. The validation workflow therefore checks out the PR head SHA directly.

For stacks that predate this workflow contract, update the stack bottom-up so each base/head contains the current validation workflow, or manually dispatch `Validate project` against the desired branch once the dispatch-capable workflow exists on the default branch.

A green deployment/provider status is not a substitute for repository validation. If a stacked PR has a successful Vercel preview but no `Validate project` run for its exact head, classify repository validation as missing and keep merge blocked until the exact-head workflow evidence exists.
