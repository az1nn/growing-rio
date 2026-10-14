# SPEC-014 — requirements checklist

- [x] The request identifies the eight canonical top-level skill owners.
- [x] 3JS archival retains verbatim historical skill text and production renderer lock.
- [x] Concurrency is moved into SIGA without losing same-branch writer epoch, atomic CAS, or gate freeze.
- [x] Concurrent PR #213/#224 scopes are excluded from this wave.
- [x] CI integration has migration-specific paths and acceptance criteria.
- [ ] Required exact-head checks are green after changing validators.
- [ ] Master-branch merge is completed and verified.
