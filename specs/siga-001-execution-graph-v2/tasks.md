# SIGA-001 — Execution Graph v2 tasks

**Execution:** SIGA / siga-concurrency / QA  
**Parent sequence:** Feature 013 AQ-05 -> AQ-08 -> AQ-09  
**Roadmap rule:** this child task graph refines Feature 013 work; it is not a second product roadmap.  
**Implementation gate:** Feature 012 R16 PASS under the current repository sequence unless explicitly reprioritized.

## Phase 0 — Spec Kit / claim

- [x] [S001] Reconcile repository identity, master head, open PRs, constitution, Feature 013 and current SIGA concurrency contract.
- [x] [S002] Create dedicated branch + repository-visible draft PR claim and pass post-claim overlap barrier.
- [x] [S003] Define bounded SIGA Graph v2 problem, authority rules, requirements and acceptance scenarios.
- [x] [S004] Define deterministic architecture, graph views, source packet, frontier and collision model.
- [x] [S005] Define implementation task graph and requirement checklist.
- [x] [S006] Bind SIGA-001 to Feature 013 AQ-05/AQ-08 without creating Feature 016 or a second roadmap.

## AQ-05 / SG-01 — Source packet and graph contracts

- [ ] [G010] Define normalized live source-packet schema for repository, PR/session, branch/head, gate/provider and observation identity.
- [ ] [G011] Define stable node/edge/state enums and canonical id rules.
- [ ] [G012] Define canonical semantic serialization/hash rules excluding non-semantic volatile timestamps.
- [ ] [G013] Implement graph validator for enum, identity, endpoint and duplicate-node invariants.
- [ ] [G014] Add deterministic serialization + malformed graph regression fixtures.

## AQ-05 / SG-02 — Deterministic builder

- [ ] [G020] Parse repository-local roadmap/task/spec/session-claim inputs into normalized graph nodes/edges.
- [ ] [G021] Ingest normalized PR/session/branch/exact-head gate source records without ad-hoc network logic inside graph algorithms.
- [ ] [G022] Build separate Execution DAG and Evidence/History Graph projections.
- [ ] [G023] Add source provenance/derivation references to graph records.
- [ ] [G024] Verify same source packet produces identical canonical graph hash.

## AQ-05 / SG-03 — Execution frontier

- [ ] [G030] Implement task readiness and dependency propagation.
- [ ] [G031] Implement STRICT_SEQUENTIAL earliest-non-PASS locking.
- [ ] [G032] Implement blockers for CI/provider/human gates and stale exact-head evidence.
- [ ] [G033] Implement deterministic frontier ordering plus selected/rejected reason output.
- [ ] [G034] Implement advisory RESUME/WATCH/ADVANCE evidence projection.
- [ ] [G035] Add representative RESUME, WATCH and ADVANCE regression fixtures.

## AQ-05 / SG-04 — Concurrency graph

- [ ] [G040] Model task-key, semantic-contract, path, exclusive-roadmap and dependency-assumption overlap.
- [ ] [G041] Preserve earliest-PR/lower-number deterministic claim ownership.
- [ ] [G042] Model writer epoch and BRANCH_LEASE_LOST.
- [ ] [G043] Model GATE_FREEZE and exact-head GATE_STALE behavior.
- [ ] [G044] Add same-task duplicate-claim fixture.
- [ ] [G045] Add same-contract/disjoint-path collision fixture.
- [ ] [G046] Add truly disjoint PARALLEL_SAFE fixture.

## AQ-05 / SG-05 — Queries and generated projections

- [ ] [G050] Implement required deterministic query set for frontier, blockers, ownership, reverse dependencies, exact-head validation and collisions.
- [ ] [G051] Generate compact SIGA graph/ownership projection from the deterministic model.
- [ ] [G052] Add projection freshness/source-hash validation.
- [ ] [G053] Integrate graph results as advisory inputs to SIGA/siga-concurrency without changing authority order.
- [ ] [G054] Run canonical exact-head validation and deliver Feature 013 AQ-05.

## AQ-08 / SG-06 — Graphify adapter pilot

- [ ] [G060] Freeze representative deterministic-core query answers and collection/build cost baseline.
- [ ] [G061] Add Graphify only as a reversible adapter/index over the same canonical graph semantics.
- [ ] [G062] Run identical dependency/coverage/collision/frontier questions through both paths.
- [ ] [G063] Compare correctness, latency/context cost, maintenance burden and operator value.
- [ ] [G064] Persist explicit ADOPT or REJECT decision.
- [ ] [G065] Remove rejected adapter artifacts or document bounded replaceable-adapter maintenance contract.
- [ ] [G066] Deliver Feature 013 AQ-08.

## AQ-09 / SG-07 — Integration and certification

- [ ] [G070] Reconcile SIGA, siga-concurrency and generated graph contracts after the pilot decision.
- [ ] [G071] Verify no graph state became a higher authority or required external single point of failure.
- [ ] [G072] Verify no second roadmap/master orchestrator exists.
- [ ] [G073] Run canonical exact-head regression/certification.
- [ ] [G074] Remove temporary SIGA-001 claim before final delivery when this specification PR is ready to merge.
