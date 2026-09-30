# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Constitution: `.specify/memory/constitution.md`
- Truth order: live repository/CI > constitution > active spec/plan/tasks > this handoff > chat/model memory.

## Current route
**ADVANCE — Feature 012 / R04 Operation V1 production scene.**

Feature 012 is governed by `specs/012-artist-v1-runtime-parity/SIGA-ROADMAP.md` in `STRICT_SEQUENTIAL` mode. R03 is PASS; R04 is the only current roadmap item. R05+ remain locked.

## Verified transition — 2026-09-30
- Renderer architecture is locked to `GODOT_NATIVE_V1`.
- R01 renderer evidence and R02 decision are PASS.
- R03 shared ARTIST V1 runtime visual system was delivered through PR #197.
- R03 merge commit on `master`: `a9c33ddbfc02a7c5d049a86d78cd7288a4864e5a`.
- Exact PR head before merge: `43adb3f53bdc4cd50dae38c8819caa4e3ec1ef18`.
- Exact-head PR Validate project run `36768664756`: **SUCCESS**.
- Post-merge Validate project run `36769045231`: **SUCCESS**.
- Post-merge Export Godot web build run `36769045314`: **SUCCESS**.
- Vercel reports the free-tier deployment quota limit; repository policy classifies it as `SOFT_GATE_RATE_LIMIT`, not a code/build failure.

## R03 delivered contract
- scene-only pixel policy with 2× nearest-neighbor baseline while authored UI remains full resolution;
- reusable V1 material vocabulary and Godot material builder;
- reusable fictional graffiti/stencil shader + surface rules;
- runtime provenance manifest;
- normalized composition/hotspot metadata covering all 11 canonical scene targets;
- structural validator executed by the existing canonical Python test suite;
- measured Web/mobile budget from persisted R01 evidence, with missing Godot frame instrumentation explicitly deferred to R04 rather than invented.

Canonical R03 artifacts live under:
- `scenes/visual/v1/`
- `resources/visual/v1/`
- `specs/012-artist-v1-runtime-parity/v1-visual-system.md`
- `specs/012-artist-v1-runtime-parity/v1-performance-budget.md`
- `tools/validate_v1_visual_system.py`

## Current R04 authority
Operation is the only production scene currently authorized.

Visual authority, in order:
1. approved global ARTIST V1 board + written style guide;
2. accepted Operation isolated concept, run `20260930T103636Z/operation`;
3. actual 3D runtime evidence.

R04 must preserve real 3D, semantic hotspots, pointer/touch interaction and accessible fallback. A flat reference image cannot satisfy the runtime contract.

R04 exit requires:
- Operation style-conformance/build sheet;
- V1 3D implementation using the shared R03 system;
- semantic hotspot/gameplay regressions green;
- exact-head LENTE at 540×960 and 1080×1920;
- ARTIST/CENA runtime `ACCEPT`.

## Concurrent open work
- PR #196 is a documentation-only renderer-rationale delta touching `renderer-decision.md`; it does not authorize a renderer reversal.
- PR #189 is a draft Finale implementation from the earlier stream. Finale production belongs to later locked roadmap items R11–R14; do not treat #189 as acceptance or permission to skip sequence.
- Reconcile both against live state before any mutation/merge; neither changes R04's current authority.

## Next engineering action
Run SIGA on R04 only:
1. reconcile current `master`, open PRs and exact-head CI;
2. complete the Operation style-conformance/build sheet against the accepted concept;
3. claim a dedicated R04 branch/PR;
4. implement the smallest Operation V1 production slice using the R03 shared visual system;
5. validate interactions and exact-head runtime evidence;
6. obtain ARTIST/CENA runtime acceptance before marking R04 PASS or unlocking Market/R05.

## Persistent boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward.
- Institutional/political gameplay remains fictional and systemic.
- No real politicians, parties, elections or targeted persuasion are modeled.
- Historical inspiration remains distinguishable from fictional canon.
- Provider rate limits never become fake repository failures or development locks.
