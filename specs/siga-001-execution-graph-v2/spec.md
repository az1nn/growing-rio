# SIGA-001 — Execution Graph v2 / Execution Frontier

**Status:** PLANNED — specification approved by direct user instruction on 2026-10-07  
**Owner:** SIGA / siga-concurrency / QA  
**Parent delivery:** Feature 013 — AQ-05 deterministic graph core; AQ-08 optional Graphify adapter  
**Implementation gate:** Feature 012 R16 PASS remains the product-roadmap prerequisite unless an explicit repository/user decision changes that sequencing  
**Runtime architecture:** unchanged; this feature does not modify gameplay, renderer, persistence, art or canon

## Authority invariant

SIGA Graph v2 is a **derived execution model**, never a new source of truth.

Canonical trust remains:

```text
LIVE REPOSITORY / CI
> RATIFIED CONSTITUTION
> ACTIVE SPEC / PLAN / TASKS
> REPOSITORY HANDOFFS / CANON / DOCS
> GENERATED GRAPH / PROJECTIONS
> CHAT OR MODEL MEMORY
```

A graph snapshot may be persisted for evidence or debugging, but it MUST be reproducible from its declared source packet and MUST NOT be manually promoted above live repository/CI state.

## Problem

SIGA already reasons about sessions, task dependencies, exact-head gates, strict roadmaps, stacked PRs, writer epochs and collisions. Today those graph semantics are distributed across skills, PR claims, Spec Kit files, CI state and handoffs.

The repository therefore has a graph-shaped protocol without one normalized, deterministic graph contract. This creates avoidable reconstruction work and makes several decisions harder to prove mechanically:

- which task is actually executable now;
- why SIGA classified a run as RESUME, WATCH or ADVANCE;
- whether two sessions collide semantically despite editing different files;
- whether a green gate validates the exact current head;
- whether a strict roadmap successor is truly unlocked;
- whether a generated ownership/impact view is fresh.

## Goals

1. Normalize SIGA execution state into a deterministic graph derived from live/repository evidence.
2. Separate the acyclic execution/dependency view from the richer evidence/history view.
3. Compute an explainable execution frontier for routing and continuation.
4. Strengthen concurrency detection beyond path overlap to task/contract/dependency overlap.
5. Preserve exact-head, writer-epoch, gate-freeze and strict-roadmap invariants.
6. Provide deterministic baseline queries before evaluating any external semantic-graph adapter.

## User scenarios

### US-1 — SIGA can explain what is executable
As the developer invoking SIGA, I want a deterministic frontier that identifies the current executable task(s), their blockers and their ownership so continuation is explainable rather than reconstructed ad hoc.

### US-2 — Route classification comes from evidence
As SIGA, I want RESUME/WATCH/ADVANCE inputs derived from current task, dependency, session and gate state so stale chat or handoff prose cannot silently choose the route.

### US-3 — Semantic collisions are visible
As a developer running parallel SIGA sessions, I want same-task, same-contract and exclusive-roadmap collisions detected even when the sessions touch disjoint files.

### US-4 — CI evidence cannot drift across commits
As QA/SIGA, I want validation edges tied to the exact commit they prove so a newer branch head automatically makes older gate evidence stale.

### US-5 — Strict roadmaps remain structurally locked
As the owner of a STRICT_SEQUENTIAL roadmap, I want later nodes to remain non-executable until the earliest non-PASS item satisfies its declared exit gates.

### US-6 — External graph tools are optional
As the maintainer, I want the core graph semantics and required queries to work without Graphify or any persistent graph database so adapters can be evaluated or removed without authority loss.

## Functional requirements

### Source and authority

- **FR-001:** Every graph build MUST identify repository `az1nn/growing-rio`, default branch and observed default-branch HEAD.
- **FR-002:** The builder MUST consume a normalized source packet whose live elements record their source identity and exact observed SHA/status where applicable.
- **FR-003:** Given the same normalized source packet and repository files, graph construction MUST be deterministic.
- **FR-004:** Every graph node and edge MUST be traceable to one or more source records or a deterministic derivation rule.
- **FR-005:** Generated graph state MUST NOT become an editable authority. Manual edits to generated projections MUST be overwritten or fail freshness validation.
- **FR-006:** Missing required evidence MUST remain UNKNOWN/BLOCKED/UNAVAILABLE as appropriate and MUST NOT be converted to PASS.

### Graph model

- **FR-007:** The minimum node vocabulary MUST support: `REPOSITORY`, `ROADMAP_ITEM`, `TASK`, `SESSION`, `BRANCH`, `COMMIT`, `CONTRACT`, `GATE`, `HUMAN_GATE`, `ARTIFACT` and `DEPLOYMENT`.
- **FR-008:** A `SESSION` node MUST preserve the existing canonical identity of an active PR claim: PR number + task key + head branch + exact head SHA.
- **FR-009:** The minimum edge vocabulary MUST support: `CONTAINS`, `DEPENDS_ON`, `CLAIMED_BY`, `OWNS`, `HEAD_AT`, `VALIDATES`, `BLOCKS`, `UNLOCKS`, `STACKED_ON`, `TOUCHES`, `CONFLICTS_WITH`, `SUPERSEDES`, `PRODUCES`, `DERIVED_FROM` and `TARGETS`.
- **FR-010:** The system MUST expose two logical views from the same source model:
  - an **Execution DAG** containing only ordering/readiness relations and required to be acyclic;
  - an **Evidence/History Graph** that may include symmetric/historical relations and therefore may contain cycles.
- **FR-011:** A cycle in the Execution DAG MUST fail graph validation with the involved node ids and edges.
- **FR-012:** Stable node ids MUST be deterministic from repository-observable identity rather than process-local/random ids.

### State and frontier

- **FR-013:** Task/roadmap execution state MUST distinguish at least `LOCKED`, `READY`, `CLAIMED`, `RUNNING`, `BLOCKED`, `DONE` and `SUPERSEDED`.
- **FR-014:** Gate state MUST distinguish at least `PENDING`, `PASS`, `FAIL`, `STALE`, `UNAVAILABLE` and human-decision pending where applicable.
- **FR-015:** The execution frontier MUST contain only tasks that are dependency-ready, roadmap-legal, not superseded and not blocked by an unsatisfied hard gate.
- **FR-016:** For a declared `STRICT_SEQUENTIAL` roadmap, only the earliest non-PASS roadmap item and safe same-item work MAY appear in the executable frontier; successors remain `LOCKED`.
- **FR-017:** The graph MUST provide the evidence used by SIGA to choose:
  - `RESUME` when unfinished current work has an active/continuable owner or current task;
  - `WATCH` when the mandatory current item is waiting on an unresolved gate/dependency and no legal continuation changes the route;
  - `ADVANCE` when the predecessor is verifiably complete and the next documented successor becomes ready.
- **FR-018:** Frontier selection MUST be deterministic when multiple legal nodes exist, using repository-defined priority before stable task-key ordering; it MUST NOT depend on chat order.

### Concurrency and collision semantics

- **FR-019:** Collision analysis MUST consider at least: same task key, same semantic contract, overlapping paths, exclusive roadmap ownership and incompatible dependency assumptions.
- **FR-020:** Different paths MUST NOT automatically imply `PARALLEL_SAFE` when the sessions implement or mutate the same contract.
- **FR-021:** Session-claim ownership MUST preserve the current deterministic rule: earliest overlapping PR `created_at`, then lower PR number as tie-breaker.
- **FR-022:** Same-branch writer epoch MUST be representable as repository + PR/session + branch + expected head SHA.
- **FR-023:** `GATE_FREEZE` MUST bind a session/branch to one frozen exact head and forbid treating evidence for another SHA as current.
- **FR-024:** A branch-head move during gate freeze MUST make the previous evidence `STALE` and expose `BRANCH_LEASE_LOST` / `GATE_STALE` diagnostics.
- **FR-025:** Default-branch advancement MUST be represented as new source identity that can invalidate assumptions and force RECONCILE before delivery.

### Queries and projections

- **FR-026:** The deterministic core MUST answer at least:
  - what is executable now and why;
  - what blocks a task;
  - who owns/claims a task;
  - what depends on a task/contract;
  - which exact commit a gate validates;
  - which sessions collide and by which rule;
  - which successor becomes unlocked after a PASS.
- **FR-027:** Human-readable graph output MUST be compact and bounded; raw graph dumps are debugging artifacts, not the normal SIGA chat report.
- **FR-028:** Generated ownership/impact documentation MUST be a projection of the graph/source model, not separately maintained truth.
- **FR-029:** The deterministic core MUST NOT require a graph database or external SaaS.
- **FR-030:** Any Graphify integration MUST be an optional adapter over the same semantics and benchmark queries, removable without loss of required behavior or canonical data.

### Safety and scope

- **FR-031:** This sub-spec MUST NOT modify gameplay, economy, progression, persistence, art direction, canon or renderer architecture.
- **FR-032:** This sub-spec MUST NOT create a second master orchestrator or second Feature 013 roadmap.
- **FR-033:** Existing SIGA and siga-concurrency invariants remain authoritative until each graph-backed replacement/derivation is proven by regression tests and explicitly integrated.

## Acceptance scenarios

1. Two builds from the same fixture/source packet produce byte-equivalent canonical graph serialization or the same canonical graph hash.
2. A fixture with roadmap item -> task -> PR/session -> branch -> commit -> validation gate produces an execution frontier containing the current legal task and an evidence chain to the exact validated SHA.
3. Moving the session branch head without new validation marks the previous validation relation stale and prevents completion.
4. Two concurrent claims with the same task key select the earliest PR as owner and classify the later session as superseded/conflicting.
5. Two claims with disjoint paths but the same semantic contract are classified as a collision rather than `PARALLEL_SAFE`.
6. Two disjoint claims with distinct task keys/contracts remain `PARALLEL_SAFE`.
7. A STRICT_SEQUENTIAL fixture exposes only the earliest non-PASS item; later roadmap items remain locked.
8. A human visual gate pending on the current item is represented as a blocker without being auto-accepted by green CI.
9. An intentional dependency cycle in the Execution DAG fails validation with an actionable cycle trace.
10. Removing any optional Graphify adapter leaves all required deterministic queries and graph validation operational.

## Success criteria

- **SC-001:** A versioned graph schema/model and validator cover every mandatory node/edge/state enum in this spec.
- **SC-002:** Determinism, execution-DAG cycle detection, strict-roadmap locking, exact-head staleness and claim-ownership behavior have automated regression fixtures.
- **SC-003:** Same-contract/different-path collision and disjoint parallel-safe cases have automated fixtures.
- **SC-004:** The frontier query can produce a bounded explanation for representative RESUME, WATCH and ADVANCE fixtures.
- **SC-005:** Feature 013 AQ-05 uses the deterministic graph core for generated ownership/impact and advisory routing/overlap diagnostics.
- **SC-006:** Feature 013 AQ-08 benchmarks Graphify against the deterministic baseline and records explicit ADOPT/REJECT.
- **SC-007:** No gameplay/runtime/save/canon surface changes as a side effect of SIGA Graph v2.

## Dependencies

- Existing `.agents/skills/siga/SKILL.md` orchestration contract.
- Existing `.agents/skills/siga-concurrency/SKILL.md` claim, writer-epoch and gate-freeze contract.
- Feature 013 AQ-05/AQ-08 parent sequencing.
- Feature 012 R16 PASS before implementation under the current roadmap; this does not block specification work.

## Out of scope

- replacing GitHub, Spec Kit or CI as canonical state;
- a mutable central graph service;
- always-on database infrastructure;
- changing the DA LATA product/runtime;
- making Graphify mandatory;
- using graph state to bypass human ARTIST/CENA acceptance;
- replacing optimistic Git concurrency with a global lock;
- duplicating `docs/ROADMAP.md` or creating a SIGA-001 roadmap.
