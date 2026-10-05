# Feature 014 — Validation Latency Contract

**Status:** IMPLEMENTING — approved bounded infrastructure slice  
**Owner:** SIGA / QA  
**Execution authority:** this Spec Kit package + `docs/VALIDATION-LATENCY-BUDGETS.md`  
**Runtime architecture:** unchanged; `GODOT_NATIVE_V1` remains authoritative

## Problem

DA LATA has trustworthy validation, but several feedback loops have accumulated avoidable wall time. Before optimizing implementation details, the repository needs one canonical definition of what "fast enough" means and how time is measured.

## User Scenarios

### US-1 — A screenshot has an explicit latency contract
As the developer reviewing exact-head visual evidence, I want screenshot latency measured only after the runtime reports READY so that provider queue or bootstrap time is never confused with image capture time.

### US-2 — A video takes approximately its media duration
As the developer invoking LENTE, I want active video acquisition bounded by the requested media duration so that a four-second observation cannot legitimately spend minutes in the capture stage.

### US-3 — Slow validation is attributable
As QA/SIGA, I want queue, bootstrap, readiness, execution and artifact transfer measured separately so that the system can optimize the stage actually responsible for delay.

### US-4 — Future optimizations cannot silently weaken the contract
As the maintainer, I want a machine-readable contract plus a structural validator so that later workflow changes cannot relax hard media invariants without an explicit repository change.

## Functional Requirements

- **FR-001:** The repository MUST define one canonical human-readable latency contract.
- **FR-002:** The same contract MUST have one machine-readable representation.
- **FR-003:** Still capture after READY MUST have a hard ready-to-file limit of 1000 ms.
- **FR-004:** Video active acquisition MUST target no more than requested media duration; only bounded scheduler tolerance may be modeled separately.
- **FR-005:** Queue, bootstrap, readiness, execution and artifact time MUST be distinguishable.
- **FR-006:** A structural validator MUST fail on malformed or weakened hard invariants.
- **FR-007:** SIGA, QA and LENTE MUST reference the canonical contract without changing their unrelated ownership.
- **FR-008:** Existing workflow runtimes MUST be recorded as baseline evidence so future changes can prove improvement.
- **FR-009:** A timeout MUST remain a safety ceiling, never the declared expected latency.
- **FR-010:** Meeting a latency budget MUST NOT authorize weakening exact-head, functional or human visual gates.

## Acceptance Scenarios

1. The machine-readable contract parses and validates with the repository structural validator.
2. Changing the still hard limit away from 1000 ms makes the structural validator fail.
3. Removing any required clock dimension makes the structural validator fail.
4. SIGA, QA and LENTE all point to the same canonical timing authority.
5. The baseline includes the sampled 2026-10-05 GitHub Actions workflow timing evidence.

## Success Criteria

- **SC-001:** `tools/validate_validation_latency_budgets.py` passes on the exact feature head.
- **SC-002:** Canonical `tools/ci_validate.sh` invokes the latency contract validator.
- **SC-003:** Hard still/video invariants are represented consistently in human and machine contracts.
- **SC-004:** Six timing dimensions are defined: queue, bootstrap, readiness, execution, artifact and total.
- **SC-005:** Exact-head canonical validation remains green after introducing the contract.
- **SC-006:** No workflow capture implementation, caching behavior, test sharding or polling cadence is changed in Feature 014.

## Dependencies

- Existing SIGA, QA and LENTE skill contracts.
- Existing GitHub Actions timing evidence used as the pre-optimization baseline.
- Existing Feature 012 renderer/roadmap lock remains unchanged.

## Out of Scope

- reimplementing LENTE video capture;
- deleting or archiving Three.js workflows;
- adding toolchain caches;
- splitting or sharding the QA suite;
- adding fast/full validation routing;
- changing progressive polling;
- historical latency regression CI enforcement;
- changing gameplay, art direction, canon or renderer architecture.
