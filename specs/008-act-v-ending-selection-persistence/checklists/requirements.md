# Requirements Checklist — Feature 008

- [x] Scope is bounded to selecting and persisting one eligible ending family.
- [x] Ending picker UI, codas, handoff event and arc completion are explicitly excluded.
- [x] Selection is immutable within a campaign.
- [x] Selection reuses eligibility rather than duplicating readiness predicates.
- [x] No ending is scored, ranked, recommended or treated as morally correct.
- [x] Selection is deterministic and RNG-free.
- [x] New canonical persisted state explicitly advances save schema to v11.
- [x] Schema v10 migration preserves prior campaign state and invents no ending choice.
- [x] Existing v1-v9 migrations remain supported.
- [x] Unknown persisted ending IDs are rejected.
- [x] Institutional content remains fictional/systemic.
- [x] Parallel-market references remain abstract and non-operational.
- [x] Exact-head regression/CI evidence is required before merge.
- [x] An external deployment-rate gate must not be bypassed by forced merge.
