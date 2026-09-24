# SIGA — repository continuation protocol

This skill is local to the repository that contains it. The repository is the source of truth.

## REPOSITORY IDENTITY LOCK — mandatory first gate

Canonical repository for this SIGA skill:

```text
az1nn/growing-rio
```

Repository identity MUST be resolved and verified **before** repository discovery, task discovery, PR/branch/CI inspection, handoff routing, or any mutation.

The first SIGA operation MUST be a direct identity probe against `az1nn/growing-rio` using the current project/application binding and/or direct Git/GitHub repository identity. Only after the exact full name matches may SIGA read operational state and continue with RECONCILE.

Bootstrap context may point to the canonical repository, but it never authorizes substituting a different repository. The exact repository lock in this skill and direct repository state are authoritative.

SIGA MUST NOT:

- search the user's GitHub account, organization, recent repositories, repository names, activity, PR history or similar candidates to infer which repository the current project means;
- choose a repository because it looks related, is recent, contains a SIGA skill, or matches remembered work;
- fall back to another repository when `az1nn/growing-rio` is unavailable;
- inspect another repository's operational backlog as a substitute for this repository;
- mutate any repository before the exact canonical identity is verified.

Identity outcomes are fail-closed:

- exact `az1nn/growing-rio` match → continue;
- another repository resolves → `REPO_MISMATCH`; report resolved vs required identity and stop with zero mutation;
- canonical identity cannot be directly verified → `REPO_UNRESOLVED`; stop with zero mutation and do not guess.

Cross-repository reads are allowed only **after** this lock passes and only when the active `growing-rio` task explicitly names an external dependency. Such reads never change the active repository identity and never authorize cross-repository mutation unless the user explicitly requests a separate task for that repository.

When the user says `Siga`:

1. **RECONCILE** — after the repository identity lock passes, inspect the real repository state: default branch, HEAD, working branches, PRs, Actions/checks, specs/docs and the handoff file.
2. **DECIDE** — classify the continuation as:
   - `RESUME`: unfinished work exists.
   - `WATCH`: work is dispatched and active gates/checks remain.
   - `ADVANCE`: previous work is verifiably complete; start the next documented milestone.
3. **EXECUTE** — make the smallest coherent change, run available automated checks, commit/push and use a PR when appropriate.
4. **PERSIST** — update `docs/SIGA-HANDOFF.md` with verified state, decisions, gates and the next action.

## CONCURRENCY CONTROL — mandatory for mutating waves

SIGA MUST load and follow `.agents/skills/siga-concurrency/SKILL.md` whenever a continuation may mutate repository state.

Concurrency handling is part of **RECONCILE**, **EXECUTE** and **PERSIST**, not an optional cleanup step.

Before the first mutation, SIGA MUST capture an expected concurrency snapshot containing the current default-branch HEAD, working-branch HEAD, open PR heads, relevant workflow heads and blob SHAs for files it expects to change.

SIGA MUST use the helper skill to:

- create/select a dedicated branch before feature mutation;
- re-read live state before logical write batches;
- detect default-branch, branch, PR, file, spec, handoff and CI drift;
- classify drift as `CLEAR`, `PARALLEL_SAFE`, `RECONCILE`, `COLLISION`, `SUPERSEDED` or `GATE_STALE`;
- scan open PRs for file/contract overlap before implementation and before merge;
- reconcile concurrent handoff edits from live facts rather than overwriting a newer copy;
- integrate newer default-branch work without discarding concurrent commits;
- use current blob SHA guards for same-path writes;
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

During **DECIDE**:

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


## EXTERNAL BUILD RATE LIMIT — non-blocking stack policy

A deployment/build-provider **rate limit, quota window or temporary scheduling throttle is a soft external gate**, not a repository development lock, when all of the following are true:

- the failure is explicitly identified as provider capacity/rate/quota limiting;
- repository validation for the relevant code is otherwise green or can still run independently;
- Godot/application build logic is not reporting a real compile, import, test, export or runtime failure;
- no semantic collision or repository safety gate requires work to stop.

Classify this state as `SOFT_GATE_RATE_LIMIT`.

`SOFT_GATE_RATE_LIMIT` rules:

- it MUST NOT force the whole repository into `WATCH` when safe, bounded work remains;
- SIGA MAY `ADVANCE` or `RESUME` other work and MAY create additional PRs;
- the PR whose required provider validation is unavailable MUST remain open and MUST NOT be merged until that required provider gate is actually validated;
- downstream work MAY be **stacked** on top of an open rate-limited PR when it depends on that PR;
- disjoint work SHOULD still branch from the newest safe repository base rather than creating unnecessary dependency depth;
- every stacked PR MUST declare its immediate base/dependency and inherited pending provider gate in its PR body/handoff;
- repository-local validation, tests and any available build/export checks MUST still run on each stack head; rate limiting waives only the unavailable provider gate;
- when the provider window clears, validate from the oldest unresolved dependency upward, then merge bottom-up; after each lower merge, refresh/reconcile downstream PR heads and exact-head validation as required;
- never mark public deployment parity as proven until the provider validates the exact relevant head.

A provider result caused by real build/configuration/runtime failure is **not** `SOFT_GATE_RATE_LIMIT`. Treat that as a normal failing gate and `RESUME` the defect.

Rate-limit state is therefore **merge-deferred, development-non-blocking**.

## WEB DELIVERY — playable browser build

When this Godot repository has a browser export or deployment path configured, the playable Web build is part of the real operational state that SIGA must reconcile.

During **RECONCILE**, inspect when applicable:

- Godot Web export configuration (for example `export_presets.cfg`);
- CI workflow(s) that build/test/export the Web target;
- deployment configuration for the selected provider (for example Vercel or GitHub Pages);
- the latest relevant Actions/deployment result;
- the current public playable URL, when one is configured.

During **DECIDE**:

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
