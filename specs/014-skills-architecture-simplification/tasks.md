# SPEC-014 — tasks and verification ledger

- [x] T001 Create approved Spec Kit and PR #230 claim (SHA 82df96c).
- [x] T002 Archive the V1-frozen 3JS entrypoint with its full historical protocol; relocate concurrency into SIGA's internal mandatory reference.
- [x] T003 Update SIGA router, concurrency docs, GODOT/QA references; preserve open PR #213 ARTIST/CENA and #224 LENTE files unmodified.
- [x] T004 Add eight-entrypoint architecture tests and adapt SIGA protocol tests to the migrated path.
- [ ] T005 Run exact-head CI and targeted protocol tests; resolve failures, freeze tested head, and guard merge.

## Concurrency claim
Task key SKILLS-8:SPEC-014, PR #230, owned branch refactor/skills-8-spec-kit.
Excluded concurrently owned paths: PR #213 ARTIST/CENA and visual content; PR #224 LENTE and capture tooling.
Pre-publish expected HEAD: 82df96cbdb96377acb2df4230b561403090464bc.
Historical 3JS specifications, docs and rendered examples are retained; only active skill entrypoint is removed.
Pending cross-PR cleanup: ARTIST/CENA and LENTE references to historical 3JS are superseded by the SIGA master routing fence; update those files after the corresponding PRs land, without clobbering their work.
