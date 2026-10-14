# SIGA task ownership — enforced guard

Scope: az1nn/growing-rio only. Canonical SIGA and Spec Kit authority remain unchanged.

## Prevent stealing another session's task

1. RECONCILE all open PRs and current task statuses before picking new work.
2. A running PR with the same task key **owns that task**. A new SIGA tab or session does NOT inherit permission to write to the owner PR. It must WATCH, take a provably disjoint task or request an explicit handoff.
3. Every new SIGA mutating PR must announce SIGA-TASK-KEY and Intended paths in the PR description, then run the POST-CLAIM BARRIER before implementation.
4. Before each batch or resume, read the live open PR snapshot and check ownership:

    gh api --paginate --slurp 'repos/az1nn/growing-rio/pulls?state=open&per_page=100' > /tmp/siga-prs.json
    python3 tools/siga_claim_guard.py --snapshot /tmp/siga-prs.json --pr <PR> --expected-head <SHA>

5. SUPERSEDED means the later overlapping PR must stop; report and link owner_pr. BRANCH_LEASE_LOST means the remote PR head changed; discard stale work and reconcile. GITHUB_STATE_UNAVAILABLE fails closed.
6. The guard is **read-only**. Only a normal fast-forward or ref compare-and-swap using expected branch SHA can publish a batch to a shared PR branch. A read-check alone does not lock the branch.
7. GATE_FREEZE remains binding: no commit while exact-head validation or visual capture is pending, even for bookkeeping. Never auto-reclaim ownership based on elapsed time.
8. A pre-existing PR without claim metadata is UNCLAIMED_LEGACY only for backward compatibility. This is not permission to seize an open task. Perform the full semantic scan.
9. Unrelated scopes remain PARALLEL_SAFE. Never rewrite another PR's history, task state or human gates.

## CI behavior

Validate project reads all live open PRs (including drafts), compares declared task keys and path globs, and selects the earliest created PR; ties use the lowest PR number. Its loser exits nonzero before project validation. The guard also compares CI's expected head to the live PR head, blocking stale results.

This is **merge blocking, not an exclusive distributed mutex**. All publishers must keep using the established atomic expected-head rule. The check is additive to docs/SIGA-CONCURRENCY.md and can be integrated after the in-flight skill architecture refactor (#230), without mutating that PR.
