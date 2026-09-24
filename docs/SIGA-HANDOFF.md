# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Truth order: live repository / CI > constitution > active spec/plan/tasks > this handoff > chat/model memory.

## Current route
**WATCH — RB-12 is implemented in PR #85 and this handoff persistence advances its head. Require fresh exact-head Validate project + Visual acceptance evidence. Vercel remains an explicit SOFT_GATE_RATE_LIMIT: guarded merge/public delivery is deferred, but bounded development is not globally locked.**

## Live reconciliation — 2026-09-24
- Default branch: `master@468401729addaf9faece48cb250a6a773e089a24`.
- RB-09 PR #79: `5e5a30182a085cd128691bf57d1da5a0c7697bdf`; repository/visual green; Vercel rate-limited.
- RB-10 PR #81: `c7ce8caf8b53afe7184715a5584a6149aca61ca0`; repository/visual green; Vercel rate-limited.
- RB-11 PR #83: `91fa0903a5e7c3ad0b65151abee0a34c4c01f349`; Validate #395 + Visual #39 green; Vercel rate-limited.
- CENA-008/#78, CENA-009/#80 and CENA-010/#82 are repository/visual green with the same provider rate-limit classification.
- RB-12 PR #85 targets `feat/cena-010-window-pane-rhythm` and its pre-handoff implementation head is `1dbc1336c666987e2587e000140781f51c69f4d9`.
- RB-12 is based directly on CENA-010 head `b902cd730480cdfdac076b47a4294ebf0cc71570` to reconcile the known diorama/validator collision by ancestry.
- No force update was used.

## Active — RB-12 Diorama Scene System
- Spec: `specs/rb-12-diorama-scene-system/`.
- Branch: `feat/rb-12-diorama-scene-system`.
- PR: **#85 — `feat(rb-12): add contextual diorama scene system`**.
- Immediate base: CENA-010 / PR #82.
- `ContextualSceneHost` owns presentation-only mount/unmount, stable visual context identity, deterministic replace transitions and resource profile.
- Existing `OperationDiorama` is the first registered module; CENA retains ownership of its authored geometry, camera and lighting.
- Empty context is valid, proving 3D is optional for product surfaces.
- Normal SubViewport budget is 540x960; low-resource budget is 360x640.
- UI retains input ownership: host uses mouse-ignore and the nested viewport keeps GUI/local input disabled.
- Scene lifecycle calls no GameState/domain command, advances no simulation and consumes no gameplay RNG.
- `tests/diorama_scene_system_test.gd` verifies mount/remount/unmount, optional context, input ownership, resource profile and full canonical save-snapshot invariance.
- `.github/workflows/validate.yml` executes that regression for exact pull-request heads.
- Save schema remains v11; no persistence shape changes.

## Spec Kit task state
- T001-T009: complete.
- T010: open for the final live drift/overlap barrier immediately before merge.
- T011: open until the final persisted PR head receives fresh Validate project + applicable visual evidence.
- T012: complete.
- T013: open; guarded merge/post-merge closure requires full provider proof.

## Concurrency classification
- CENA operation diorama + structural validator overlap: **RECONCILED** by stacking directly on #82.
- RB-09 GameState work: **PARALLEL_SAFE**; RB-12 does not touch `autoload/game_state.gd`.
- RB-10/RB-11 canonical shell work: **PARALLEL_SAFE**; RB-12 changes the staged Main visual mount, host/test/validator/CI/docs and does not edit `game_shell.*`.
- Provider state: **SOFT_GATE_RATE_LIMIT** — merge-deferred, development-non-blocking.

## Next engineering action
1. Read PR #85's exact head after this handoff commit.
2. Require `Validate project` and `Visual acceptance capture` success for that exact head.
3. If either repository/visual gate fails, classify **RESUME** and repair only the concrete RB-12 defect.
4. If both succeed while Vercel remains rate-limited, keep #85 open/merge-deferred and classify safe development **ADVANCE**.
5. RB-13 — Visual Production Pass must reconcile with the active CENA stream before mutation; do not fork stale visual assets.
6. When provider capacity returns, validate and merge unresolved dependency stacks bottom-up with exact-head guards and rerun downstream gates invalidated by base transitions.
7. Finale expansion remains frozen until RB-14 explicitly records PASS/unfreeze.

## Persistent boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic.
- No real politicians, parties, elections or targeted persuasion are modeled.
- No faction, institutional form or ending is treated as morally correct or preferred.
- Real-history inspiration remains distinguishable from fictional canon.
- Chat/model memory is not canonical project state.
