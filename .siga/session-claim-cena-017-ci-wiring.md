# SIGA session claim — CENA-017 CI wiring

SIGA-TASK-KEY: `CENA-017:CI-WIRING`

## Ownership

This stacked branch owns only T005 CI wiring on top of the reconciled T004 audit head.

Reserved paths:
- `tools/ci_validate.sh`
- `.siga/session-claim-cena-017-ci-wiring.md`

It must not mutate runtime scenes or visual-acceptance workflow paths.

## Stack

Base task head: `8b5ebebf6374fe40e9c62cb4e2324cce9ca30273` (T004 / PR #169).

T005 is valid only if the exact-head `Validate project` workflow executes `res://tests/three_d_completeness_audit_test.gd` successfully.
