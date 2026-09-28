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

1. **RECONCILE** — after the repository identity lock passes, inspect the real repository state: default branch, HEAD, working branches, PRs, Actions/checks, specs/docs and repository-local handoffs.
2. **CLASSIFY** — choose exactly one top-level continuation:
   - `RESUME`: unfinished work exists.
   - `WATCH`: work is dispatched and active gates/checks remain.
   - `ADVANCE`: previous work is verifiably complete; start the next documented milestone.
3. **ROUTE** — identify the smallest repository-local specialist skill(s) that own the active concern and delegate to them without surrendering SIGA's repository, concurrency, verification or delivery authority.
4. **EXECUTE** — execute the bounded work through the owning specialist skill(s), preserving active specs, authority boundaries and concurrency rules.
5. **VERIFY** — require applicable tests, rendered acceptance, CI, provider/deployment checks and exact-head evidence for the current work.
6. **MERGE** — when merge preconditions are satisfied, reconcile drift, resolve safe conflicts, merge with an expected-head guard when available, and verify the resulting default-branch state.
7. **CONTINUE** — before returning, prove that this invocation produced repository progress. A status-only/watch-only result is not a valid successful SIGA completion.
8. **PERSIST** — update the applicable repository-local handoff(s) with verified state, routing decisions, gates, merge evidence, work executed in this invocation and the next action.

## LIVE SESSION / TASK / CI-CD GRAPH — mandatory user-facing status

Every successful `Siga` invocation MUST show a compact live graph reconstructed from current repository state so the user can understand active work without opening GitHub.

The graph is generated from **live reads**, never copied from a stale handoff. It MUST be refreshed after material mutations and before the final response.

Minimum lanes:

```text
SESSIONS
S<PR> [OWNER|PARALLEL|WATCH|SUPERSEDED] <task key> -> <branch@short-sha>

TASKS
<completed task> -> <active task> -> <next task>

CI/CD
<PR/head> -> Validate <state> -> Visual <state> -> Three.js <state> -> Provider <state> -> Merge <state>
```

Requirements:
- show every open PR/session relevant to the active repository, including disjoint sessions when they help explain concurrency;
- show the canonical task key/scope for each active session;
- explicitly mark deterministic ownership, parallel-safe work, superseded duplicates and dependency stacks;
- show exact-head CI/CD state for applicable Actions and deployment/provider gates;
- distinguish real test failures from `SOFT_GATE_RATE_LIMIT`;
- show the immediate next task so progress direction is visible;
- use concise status symbols such as `✅`, `⏳`, `⚠️`, `❌`, `↔`, and `⊘` only as presentation; the underlying text state remains authoritative;
- do not require the user to visit GitHub to understand whether work is running, blocked, duplicated, superseded, green or mergeable.

The graph is observability, not authority. Repository/CI state remains canonical.

## NON-STOP PROGRESS — every SIGA run must execute a task

Inside the verified active repository, a successful `Siga` invocation MUST NOT terminate after only observing, reporting or waiting.

The invariant is:

```text
RECONCILE -> CLASSIFY -> EXECUTE SOMETHING -> VERIFY -> PERSIST
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

SIGA MUST discover and use repository-local skills only. It MUST NOT depend on a global skill registry, chat memory or a different repository to decide how this repository should continue.

Known specialist ownership includes:

- `CENA` — visual direction, composition, asset/provenance decisions and rendered visual acceptance;
- `3JS` — Three.js implementation, scene lifecycle, renderer budgets and visual-parity delivery;
- `LORE` — narrative canon and the `CÂNONE / RUMOR / ABERTO` authority boundary;
- `siga-concurrency` — mandatory helper for mutating waves and merge safety.

Additional repository-local skills may be routed when their checked-in `SKILL.md` establishes ownership of the bounded concern.

Routing rules:

- SIGA remains responsible for repository identity, live-state reconciliation, top-level `RESUME / WATCH / ADVANCE` classification, branch/PR coordination, concurrency, exact-head verification, merge and final persistence.
- A specialist skill owns its domain decision/implementation, but it MUST return repository delivery control to SIGA.
- A direct standalone specialist command such as `Cena`, `3js` or `Lore` remains supported as an expert shortcut; it does not revoke SIGA's merge-safety and repository-truth rules.
- When more than one specialist is needed, route in dependency order: authority/acceptance decision first when required, implementation next, then SIGA verification and delivery.
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

SIGA MUST use the helper skill to:

- create/select a dedicated branch before feature mutation;
- publish a repository-visible session claim and pass the post-claim concurrency barrier before substantive mutation;
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
- rendered acceptance is not applicable to a PR whose live changed-file set contains no render-impacting path according to the scoped workflow contract;
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
