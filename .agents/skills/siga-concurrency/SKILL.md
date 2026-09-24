# SIGA CONCURRENCY — repository-local concurrency control

This skill is a helper for `.agents/skills/siga/SKILL.md`. It does not replace SIGA routing. It provides the mandatory protocol for concurrent repository work.

Canonical truth order remains:

```text
LIVE REPOSITORY / CI
> RATIFIED CONSTITUTION
> ACTIVE SPEC / PLAN / TASKS
> REPOSITORY HANDOFFS / CANON / DOCS
> CHAT OR MODEL MEMORY
```

## Goal

Allow SIGA to continue safely when another actor, skill, session, branch, PR, workflow or direct default-branch commit changes the repository during the same work session.

Concurrency is expected. Stale assumptions are not acceptable.

## Core invariants

1. Never assume a previously read branch/PR/CI state is still current before a write or merge.
2. Never overwrite a newer same-path edit with content based on an older blob.
3. Never treat a green workflow as evidence for a different commit SHA.
4. Never merge a PR without verifying its exact current head SHA.
5. Never force-update a shared branch as a normal reconciliation mechanism.
6. Never silently discard work from another branch, skill or handoff.
7. Default-branch reality always overrides a stale handoff.
8. Handoff updates are state records, not locks.

## Concurrency snapshot

At the start of every mutating SIGA wave, capture a snapshot with:

- repository identity;
- default branch;
- default-branch HEAD SHA;
- intended working branch and HEAD SHA, if it exists;
- open PRs with number, base, head branch and exact head SHA;
- active/recent relevant workflow runs and their head SHAs;
- current blob SHA of every file SIGA expects to modify;
- current SIGA handoff blob SHA;
- current LORE handoff blob SHA when lore files may be touched;
- active Spec Kit feature and task state when applicable.

Call this the **expected snapshot**.

The snapshot is disposable evidence. It must be refreshed whenever drift is detected.

## Branch-first work claim

For a new mutating wave:

1. reconcile the repository first;
2. create/select a dedicated branch from the verified default-branch HEAD;
3. only then begin mutations;
4. prefer opening the PR early once the scope is coherent enough to advertise intent.

A branch/PR is the repository-visible work claim. Do not create a separate global lock or memory-based lease.

## Write barrier

Immediately before each logical write batch, re-read enough live state to prove the write is still safe.

At minimum verify:

- default-branch HEAD has not unexpectedly invalidated the plan;
- target branch HEAD is the one expected;
- the target file blob SHA is current;
- no relevant PR/head moved in a way that changes the feature base or acceptance evidence.

For same-path writes, always use the latest target-branch blob SHA. If the write is rejected because the blob moved, re-read and reconcile; do not retry with stale content.

## Drift classification

Classify newly observed drift before continuing.

### CLEAR
No relevant state changed.

Action: continue.

### PARALLEL_SAFE
Another change occurred, but it is disjoint from the active feature and does not alter its assumptions, acceptance criteria, shared state or files.

Action:
- record the newer default-branch/base state;
- bring the branch current before final validation/merge;
- continue only if the feature remains semantically valid.

### RECONCILE
The default branch, target branch, active PR, handoff, spec, workflow evidence or a file in the active change set moved.

Action:
- stop the intended mutation;
- compare old expected state with live state;
- reconcile before further feature writes.

### COLLISION
Concurrent work changes the same file, same contract, same persistent state, same spec requirement or equivalent behavior.

Action:
- perform a semantic merge;
- preserve both compatible intents;
- if intents conflict, repository authority/spec/canon decides;
- if no authority decides, leave the conflict explicit and do not invent a winner.

### SUPERSEDED
Newer repository work already implements, replaces or invalidates the planned capability.

Action:
- do not duplicate the work;
- reclassify SIGA from live evidence;
- update/persist the new continuation route.

### GATE_STALE
A commit was added after the last green exact-head workflow.

Action:
- green evidence is invalid for completion;
- rerun/await validation for the new exact head.

## Default-branch advancement

If the default branch advances after feature work begins:

1. compare the feature base against current default branch;
2. inspect changed-file overlap and semantic overlap;
3. if changes are disjoint, integrate current default branch into the feature branch using a normal merge/rebase mechanism that preserves history and does not discard commits;
4. if files overlap, fetch both current versions and perform a semantic merge;
5. rerun all acceptance gates affected by the integration.

Do not call a branch current merely because Git reports it as mergeable.

## Same-path semantic merge

When both concurrent work and SIGA changed the same path:

1. fetch the live default/upstream version;
2. fetch the live feature version;
3. identify the independent intents;
4. preserve non-conflicting additions from both;
5. resolve conflicts using this order:
   - ratified constitution;
   - active feature spec/plan/tasks;
   - canonical lore/docs for semantic content;
   - newest verified repository state;
6. validate the merged result;
7. record the reconciliation in the handoff or PR when materially relevant.

For state/handoff documents, preserve newer verified facts even if that means rewriting an older route decision.

## Handoff collision rules

`docs/SIGA-HANDOFF.md` and `docs/lore/LORE-HANDOFF.md` are especially likely to move concurrently.

Rules:

- never overwrite the other handoff with a stale copy;
- if only the other handoff changed, absorb its latest master content before final branch convergence;
- if the same handoff changed concurrently, rebuild the handoff from live repository facts instead of textually preferring either version;
- route labels such as ADVANCE/WATCH/RESUME must be recalculated from current state;
- handoff SHAs are evidence, not authority over newer GitHub state.

## Open-PR collision scan

Before implementation and again before merge:

- inspect all open PRs;
- identify PRs that touch the same files/contracts/specs;
- classify overlap as disjoint, compatible, conflicting or superseding;
- do not merge two branches whose combined semantics have not been reconciled when they touch the same state contract.

An open PR is not automatically a blocker. Undetected overlap is the blocker.


## Soft external gates and stacked PRs

Provider throttling is distinct from repository concurrency.

When a CI/deployment provider reports an explicit rate/quota/scheduling limit and internal repository validation is not failing, classify the provider state as:

```text
SOFT_GATE_RATE_LIMIT
```

This state does not create a global work lock.

### Stacking rules

- The rate-limited PR remains open if that provider validation is required for merge.
- A dependent wave may branch from the unresolved PR head and open a PR against that branch.
- Record the stack explicitly as `base PR -> dependent PR`.
- A disjoint wave should use the newest safe default-branch base instead of adding artificial stack depth.
- Open-PR collision scans and same-path semantic-merge rules still apply across the full stack.
- Each stack head needs its own available exact-head repository validation.
- Missing provider validation is inherited as pending delivery debt, not converted into fake green evidence.
- When provider capacity returns, validate and merge bottom-up.
- After a lower PR merges, re-read each dependent PR/base/head and rerun gates invalidated by the base transition.
- If a provider error is actually caused by source/build/configuration/runtime defects, classify it as a normal failing gate, not `SOFT_GATE_RATE_LIMIT`.

A stack is a dependency graph expressed by Git branches/PR bases, not a license to ignore exact-head or collision rules.

## CI freshness

Exact-head validation means:

```text
validated_sha == current_pr_head_sha
```

If not equal, CI evidence is stale.

Before merge:

1. fetch current PR head SHA;
2. fetch the validation run for that exact SHA;
3. require success;
4. re-fetch the PR immediately before merge;
5. merge using an expected-head SHA guard when available.

After merge:

1. verify the reported merge commit on default branch;
2. require post-merge validation when repository policy expects it;
3. if a final handoff commit is added afterward, validate that final default-branch HEAD too when the repository uses exact-head completion evidence.

## Safe mutation rules

- Prefer optimistic concurrency using file/blob SHA guards.
- Prefer expected-head guards on PR merge.
- Prefer normal merge/rebase integration over force pushes.
- Never use force as a shortcut for branch drift.
- A failed optimistic-concurrency write is a signal to re-read state, not a signal to bypass the guard.
- Keep change batches small enough that re-reading state is practical.

## SIGA route interaction

Concurrency state constrains, but does not replace, the top-level SIGA route.

- **RESUME**: unfinished work exists; concurrency protocol says how to safely continue it.
- **WATCH**: work is dispatched; concurrency protocol keeps gates/head evidence fresh.
- **ADVANCE**: previous work is complete; concurrency protocol ensures the new wave starts from live default-branch state.

If concurrent work invalidates the route, recompute the route immediately.

## Completion checklist

A concurrent wave is not complete until all applicable items are true:

- feature branch contains the required latest default-branch changes;
- no unresolved semantic collision remains;
- open-PR overlap has been checked;
- task/spec state matches implementation;
- exact current PR head passed required gates;
- merge used the current expected head;
- default branch contains the merge;
- required post-merge gate passed;
- final handoff was rebuilt from live facts;
- final default-branch HEAD was validated when exact-head policy requires it.


## Stacked-PR CI validation contract

Stacked pull requests must remain first-class CI citizens. A validation workflow that filters `pull_request.branches` to only the default branch is incompatible with repository-local stacked PRs, because that filter matches the PR **base** branch.

Repository policy:

- `Validate project` must trigger for pull requests targeting any branch;
- default-branch `push` validation remains enabled;
- `workflow_dispatch` must remain available as a manual recovery path for a selected branch/ref;
- pull-request validation must check out `github.event.pull_request.head.sha`, not the synthetic `refs/pull/<n>/merge`, whenever SIGA claims exact-head evidence;
- manual dispatch and default-branch push validation use `github.sha`;
- `pull_request_target` must not be used to execute PR code as a CI workaround;
- a missing run caused by branch-filter configuration is a CI coverage defect, not a green gate and not a provider rate-limit condition.

For a stacked PR created before this contract reached its base branch, propagate the validated workflow configuration into the stack bottom-up or use `workflow_dispatch` against the stacked branch after the workflow exists on the default branch. Never retarget a dependent PR to `master` merely to manufacture CI evidence.
