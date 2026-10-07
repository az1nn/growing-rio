# SIGA-001 requirements checklist

## Specification quality

- [x] Problem is repository-observable and bounded to SIGA orchestration/concurrency.
- [x] Live repository/CI remains explicitly above generated graph state.
- [x] Execution DAG and Evidence/History Graph are separated.
- [x] Node, edge and state minimum vocabularies are explicit.
- [x] Execution frontier behavior is specified.
- [x] RESUME/WATCH/ADVANCE inputs are explainable without moving final authority away from SIGA.
- [x] STRICT_SEQUENTIAL locking is preserved.
- [x] Same-contract collisions are specified even for disjoint file paths.
- [x] Existing deterministic session-claim ownership rule is preserved.
- [x] Writer epoch, gate freeze and exact-head staleness are represented.
- [x] Required baseline queries are explicit.
- [x] Graphify is optional and removable.
- [x] No Feature 016 or second Feature 013 roadmap is created.
- [x] Gameplay, persistence, art, canon and renderer changes are out of scope.

## Implementation gates

- [ ] Graph schema/model and validator implemented.
- [ ] Canonical serialization determinism proven.
- [ ] Execution DAG cycle detection proven.
- [ ] STRICT_SEQUENTIAL frontier fixture proven.
- [ ] RESUME/WATCH/ADVANCE fixtures proven.
- [ ] Same-task claim collision fixture proven.
- [ ] Same-contract/disjoint-path collision fixture proven.
- [ ] Disjoint PARALLEL_SAFE fixture proven.
- [ ] Writer-epoch/GATE_FREEZE stale-head fixture proven.
- [ ] Generated ownership projection freshness proven.
- [ ] AQ-05 exact-head canonical validation green.
- [ ] AQ-08 Graphify ADOPT/REJECT decision persisted.
