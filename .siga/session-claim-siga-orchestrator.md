# SIGA session claim — orchestrator scope hardening

SIGA-TASK-KEY: SIGA:ORCHESTRATOR-SCOPE
Base SHA: `5ac663a271e92f77a0d94e7b8eeeb10f61b48534`
Repository: `az1nn/growing-rio`

Intended paths:
- `.agents/skills/siga/SKILL.md`
- `.agents/skills/artist/SKILL.md`
- `tests/test_siga_protocol.py`
- `tools/ci_validate.sh`

Semantic scope:
- make SIGA the unambiguous repository-local master orchestrator;
- forbid SIGA routing/reads/mutations outside `az1nn/growing-rio`;
- remove stale foreign SIGA ownership from ARTIST;
- align phase naming/order and add a regression guard.

Temporary coordination file; remove before merge.
