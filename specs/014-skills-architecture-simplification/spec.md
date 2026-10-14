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

## User Scenarios
- As a developer invoking SIGA, I see exactly eight active skill entrypoints and no executable route to frozen 3JS.
- As a concurrent contributor to PR #213 or #224, my in-flight commits, review gates, scopes and evidence remain intact.
- As a reviewer, I can verify exact-head guardrails and inspect historical 3JS and concurrency protocols after the migration.

## Functional Requirements
- FR-001: SIGA owns concurrency internally, including claim ownership, atomic branch-head CAS, GATE_FREEZE and expected-head merges; never rely on a blob-only lease.
- FR-002: Eight active skills must be the complete routable inventory; 3JS historical documentation is retained in a non-skill path.
- FR-003: No cross-repository access, no alteration to PR #213/#224-owned paths, no changed runtime/asset/gameplay behavior.
- FR-004: CI guardrails must check the archive/reference path rather than reintroduce archived active skills.
- FR-005: Visual acceptance remains human-owned; deterministic REPORT_V1 remains mandatory.

## Success Criteria
- SC-001: Active skill entrypoint count is exactly eight, verified by tests.
- SC-002: Original concurrency safety tokens remain present and validated.
- SC-003: Feature 012 renderer fence, full structural validation and Godot regression CI succeed for the exact PR head.
- SC-004: PR #213 and PR #224 remain unchanged and unblocked by this migration.
- SC-005: No merge without exact-head approval, green required gates and reconciling open-PR overlap.

## Out of Scope
- Changing Godot runtime, rendering implementation, art direction, gameplay, assets, scene acceptance or a parallel PR's branch.
- Deleting historical 3JS studies, evidence, acceptance logs or legacy source code.
- Editing concurrently owned ARTIST, CENA or LENTE skill contracts before their respective PRs land.
