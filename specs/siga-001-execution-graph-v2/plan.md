# SIGA-001 — Execution Graph v2 implementation plan

## Delivery rule

This is a bounded SIGA sub-spec mapped into Feature 013:

- deterministic core, frontier and generated ownership: **AQ-05**;
- optional Graphify comparison/adapter: **AQ-08**;
- final normal-flow integration/certification: **AQ-09**.

The package does not create another product roadmap. Under the current repository sequence, implementation remains queued behind Feature 012 R16 PASS. The specification itself is valid repository planning work now.

## Architecture

```text
LIVE GITHUB / CI + REPOSITORY FILES
              |
              v
      NORMALIZED SOURCE PACKET
              |
              v
      DETERMINISTIC GRAPH BUILDER
          /                 \
         v                   v
  EXECUTION DAG       EVIDENCE/HISTORY GRAPH
         |                   |
         v                   v
  FRONTIER / ROUTE      IMPACT / COLLISION /
  EXPLANATION           PROVENANCE QUERIES
         \                   /
          v                 v
        GENERATED PROJECTIONS
              |
              v
            SIGA
       advisory inputs only
```

SIGA remains the decision/delivery authority. The graph packages evidence and deterministic derivations; it does not autonomously mutate repository state.

## Source packet

The builder should consume one normalized input document rather than fetch ad hoc inside graph algorithms.

Minimum source groups:

- repository identity, default branch and exact default HEAD;
- open PR/session claims with task key, base, head branch, exact head SHA, creation time and declared scope;
- relevant branch heads;
- exact-head workflow/check/provider states;
- repository-local Spec Kit roadmap/task data;
- session claim metadata;
- semantic contracts/ownership discoverable from repository files;
- optional artifact/deployment evidence;
- handoff data only as lower-authority advisory input.

Every live record includes source identity and observation metadata sufficient to explain staleness.

Network/provider collection time is separate from deterministic graph-build time.

## Stable identities

Recommended ids:

```text
repo:az1nn/growing-rio
roadmap:<feature>:<item>
task:<feature-or-scope>:<task-key>
session:S<pr-number>
branch:<ref>
commit:<sha>
contract:<stable-contract-key>
gate:<kind>:<provider-or-workflow>:<run-id-or-key>@<sha>
human-gate:<scope>:<key>
artifact:<path-or-stable-id>
deployment:<provider>:<stable-id>
```

IDs must not contain random UUIDs unless the underlying canonical source itself uses that UUID.

## Graph views

### Execution DAG

Contains only precedence/readiness semantics needed for scheduling, for example:

- `CONTAINS`
- `DEPENDS_ON`
- `BLOCKS`
- `UNLOCKS`
- `CLAIMED_BY`
- `STACKED_ON` when it expresses dependency order

Symmetric or historical relations such as `CONFLICTS_WITH` and `SUPERSEDES` are excluded from DAG cycle validation.

### Evidence / history graph

Contains the complete model, including:

- branch/head identity;
- exact-head validation;
- contract/path touch relations;
- collisions;
- supersession;
- generated artifacts;
- deployments;
- provenance/derivation.

Cycles are legal in this view when the relation semantics require them.

## Execution frontier algorithm

1. Reconcile source packet freshness and repository identity.
2. Parse roadmap/task state and dependency edges.
3. If a `STRICT_SEQUENTIAL` roadmap is active, identify its earliest non-PASS item and lock successors.
4. Remove DONE and SUPERSEDED nodes from candidate execution.
5. Apply dependency readiness.
6. Apply hard gate/human gate blockers.
7. Apply claim ownership and concurrency classification.
8. Expose safe same-item work when the top-level route is WATCH.
9. Produce a stable ordered frontier plus reasons for included/excluded candidates.
10. Project the frontier into SIGA route evidence; SIGA retains final RESUME/WATCH/ADVANCE authority.

The output should explain both:
- `selected`: why this node is legal/current;
- `rejected`: why nearby nodes are locked, blocked, stale, superseded or lower priority.

## Collision model

A session pair is not `PARALLEL_SAFE` merely because changed paths differ.

Evaluate:

```text
same_task
OR same_contract
OR overlapping_paths
OR exclusive_roadmap_item
OR incompatible_dependency_assumption
```

Classification should reuse current siga-concurrency vocabulary where possible:
`CLEAR`, `PARALLEL_SAFE`, `RECONCILE`, `COLLISION`, `SUPERSEDED`, `GATE_STALE`, `BRANCH_LEASE_LOST`.

The existing earliest-PR ownership rule remains unchanged.

## Exact-head model

Represent:

```text
SESSION -> BRANCH -> HEAD_AT -> COMMIT
GATE -> VALIDATES -> COMMIT
```

A gate authorizes completion only when its validated commit equals the current required head.

Gate freeze is represented as a session/branch constraint over one frozen SHA. A head move invalidates old gate use even if the old run was green.

## Proposed repository surfaces

Implementation paths may be reconciled before AQ-05, but the preferred bounded layout is:

```text
tools/siga_graph/
  schema.json
  model.py
  build.py
  validate.py
  frontier.py
  queries.py
  cli.py

tests/
  test_siga_graph.py
  fixtures/siga_graph/**

docs/generated/
  SIGA-GRAPH.md          # optional compact projection
  ARCH-OWNERSHIP.md      # Feature 013 projection
```

Prefer Python standard library and current repository tooling. Do not introduce a persistent graph database for the core.

## Canonical serialization

For determinism tests:

- stable sort nodes by `id`;
- stable sort edges by relation + source id + target id + canonical attributes;
- serialize maps with stable key ordering;
- omit volatile observation timestamps from the canonical semantic hash, while preserving them in the source packet/evidence envelope.

Two identical semantic source packets must yield the same semantic graph hash.

## Validation

The graph validator must fail on:

- repository identity mismatch;
- unknown mandatory enum values;
- duplicate stable node ids with incompatible payloads;
- dangling edge endpoints;
- Execution DAG cycles;
- task claim pointing to missing session/PR;
- exact-head gate marked current for a different commit;
- STRICT_SEQUENTIAL successor exposed as READY before predecessor PASS;
- generated projection/source hash mismatch.

## Query baseline

Before any Graphify pilot, record deterministic-core results for representative questions:

- execution frontier + reasons;
- blockers for a task;
- owner/session for a task;
- reverse dependencies;
- exact-head gate chain;
- collisions + collision rule;
- successor unlock after PASS;
- tests/specs/contracts touching a bounded surface when available.

AQ-08 must compare Graphify to these same questions rather than invent a different benchmark.

## Feature 013 integration

AQ-05 implements and proves the deterministic core.

AQ-08 may add Graphify only as an adapter/index. If adopted, the adapter is replaceable and the deterministic core remains sufficient for all blocking decisions. If rejected, remove the adapter without altering SIGA graph semantics.

AQ-09 wires only proven graph-backed diagnostics/projections into normal SIGA operation.

## Verification strategy

1. Schema/model unit validation.
2. Canonical serialization determinism.
3. Execution DAG cycle fixture.
4. RESUME/WATCH/ADVANCE frontier fixtures.
5. STRICT_SEQUENTIAL locking fixture.
6. same-task competing claim fixture.
7. same-contract/disjoint-path collision fixture.
8. genuinely disjoint `PARALLEL_SAFE` fixture.
9. writer-epoch/head-move fixture.
10. stale exact-head gate fixture.
11. generated ownership freshness fixture.
12. canonical repository validation on exact feature head.

## Rollback

The deterministic graph layer is derived infrastructure. Reverting it must leave GitHub branches/PRs, Spec Kit, existing SIGA/siga-concurrency contracts and gameplay state intact.
