# Feature Specification: Validation Latency Contract

**Feature Branch**: `infra/014-validation-latency-contract`  
**Created**: 2026-10-05  
**Status**: Implemented in this bounded slice

## Problem

DA LATA has trustworthy validation, but several feedback loops have accumulated avoidable wall time. Before optimizing implementation details, the repository needs one canonical definition of what "fast enough" means and how time is measured.

## User outcome

As the developer running SIGA and its specialist chain, I can distinguish queue/bootstrap/readiness/execution/artifact time and immediately tell whether a still capture, video capture or validation workflow is within its intended latency envelope.

## Functional requirements

- **FR-001**: The repository MUST define one canonical human-readable latency contract.
- **FR-002**: The same contract MUST have one machine-readable representation.
- **FR-003**: Still capture after READY MUST have a hard ready-to-file limit of 1000 ms.
- **FR-004**: Video active acquisition MUST target no more than requested media duration; only bounded scheduler tolerance may be modeled separately.
- **FR-005**: Queue, bootstrap, readiness, execution and artifact time MUST be distinguishable.
- **FR-006**: A structural validator MUST fail on malformed or weakened hard invariants.
- **FR-007**: SIGA, QA and LENTE MUST reference the canonical contract without changing their unrelated ownership.
- **FR-008**: Existing workflow runtimes MUST be recorded as baseline evidence so future changes can prove improvement.

## Non-goals

- Reimplement LENTE video capture.
- Delete/archive Three.js workflows.
- Add caches.
- Split/shard the QA suite.
- Introduce fast/full routing.
- Change progressive polling.
- Add historical latency regression CI enforcement.

Those remain individually approved plan items 2–9.
