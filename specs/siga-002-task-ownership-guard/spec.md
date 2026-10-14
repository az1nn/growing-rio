# SIGA-002 — Task Ownership Guard

Status: IMPLEMENTATION CANDIDATE
Repository: az1nn/growing-rio

## User Scenarios

- Two sessions take one task: only the earlier PR stays owner; the later is SUPERSEDED.
- One session resumes stale branch state: current-head mismatch is BRANCH_LEASE_LOST.
- Two genuinely disjoint tasks proceed without a global lock.
- GitHub state unavailable: claimed work fails closed, never guesses task ownership.

## Functional Requirements

- FR-001 Read a live paginated GitHub pull-request snapshot including drafts.
- FR-002 Parse SIGA-TASK-KEY and Intended paths from PR bodies.
- FR-003 Mark identical keys or overlapping path claims as collisions, ordering by created_at and then PR number.
- FR-004 Reject losing claims in Validate project before running build/test gates.
- FR-005 Reject a stale expected PR head SHA.
- FR-006 Preserve earlier human gates, concurrent work, atomic branch CAS and GATE_FREEZE.
- FR-007 Include offline Python regression tests for collisions, disjoint work and stale heads.

## Success Criteria

- Duplicate newer task claim fails deterministically and reports owner PR.
- Stale current-head evidence fails deterministically.
- Disjoint task paths remain parallel-safe.
- CI retains exact-head validation, with zero changes to game files or active PRs.

## Out of Scope

- Overwriting in-flight PRs #230, #224, #213.
- Moving ownership by editing old claims.
- Replacing writer-epoch atomic branch publication.
- A global repository lock or automatic merges.
