# Spec Kit — Skills architecture 10 → 8

Status: APPROVED / IMPLEMENTATION IN PROGRESS
Repository: az1nn/growing-rio
Base: dcdad2150a0ed2a48f8f6ff64ef7bec040fd0567

## Intent
Reduce top-level operational skills from ten to eight without weakening gates, history, concurrent work, or runtime contracts.

## Canonical eight
SIGA, ARTIST, CENA, GODOT, QA, LENTE, LORE, RELATORIO.

## Requirements
- Archive 3JS as historical REFERENCE/FROZEN, never reactivate Three.js for V1 without a new ratified architecture spec.
- Fold siga-concurrency into SIGA as a mandatory internal reference. Preserve post-claim rescan, deterministic claim ownership, branch-head CAS/writer epoch, GATE_FREEZE, exact-head CI, collision classifications, and expected-head merge.
- Preserve ARTIST concept/human acceptance, CENA implementation, GODOT runtime, QA automated checks, LENTE rendered evidence, LORE canon, and deterministic REPORT_V1.
- Do not mutate or supersede open City PR #213 or LENTE PR #224. Verify their latest heads and changed paths before every batch and merge.
- Update routers, skill references, protocol tests and documentation atomically; do not delete historical evidence or prior approvals.

## Acceptance
1. Exactly eight active top-level skill directories; historical 3JS content retained under archive.
2. No live routing to 3JS; GODOT sole V1 production renderer.
3. All concurrency invariants unchanged and machine-verifiable.
4. Spec Kit validators, protocol tests, Godot headless and relevant exact-head CI green.
5. No regression to City/LENTE workflows; preserve existing open PRs.
6. Merge only on exact current PR head with applicable gates green, then verify master.

## Plan
T001 create spec and claim; T002 archive 3JS and migrate references; T003 integrate concurrency reference and routing; T004 update validators and tests; T005 verify exact-head and safely merge.

## Scope
No gameplay, art, canon, renderer, asset, or runtime change. No cross-repository mutation.
