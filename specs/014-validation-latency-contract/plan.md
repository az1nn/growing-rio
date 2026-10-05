# Implementation Plan: Validation Latency Contract

## Scope

Create the timing authority only. Do not optimize workflow behavior in this slice.

## Design

1. Persist `docs/VALIDATION-LATENCY-BUDGETS.md` as the human authority.
2. Persist `tools/validation_latency_budgets.json` as the machine contract.
3. Add `tools/validate_validation_latency_budgets.py` to protect identity, timing dimensions, ordering of p50/p90/hard targets and non-negotiable media limits.
4. Run that structural check inside `tools/ci_validate.sh`.
5. Bind SIGA, QA and LENTE to the contract.
6. Record the 2026-10-05 pre-optimization GitHub Actions baseline.

## Safety

- Dedicated branch from a fresh master snapshot.
- No overlap with open PR #213 or #221 paths.
- No workflow logic, capture implementation or polling cadence changes.
- No existing validation is weakened or removed.

## Exit criteria

- Machine contract parses and passes its validator.
- Canonical CI invokes the validator.
- SIGA/QA/LENTE point to the same authority.
- Exact-head CI remains green.
