# SIGA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Repository-local SIGA: `.agents/skills/siga/SKILL.md`
- Concurrency helper: `.agents/skills/siga-concurrency/SKILL.md`
- Ratified constitution: `.specify/memory/constitution.md`
- Live repository / CI always overrides this handoff.

## Current route
**WATCH**

The prior V0.5 research feature 004 is complete. A production Web-delivery defect was then repaired through PR #39. The repair is functionally deployed and validated at the merge commit, but the Web export workflow generated one additional default-branch artifact commit afterward. This handoff commit is intentionally being used to restore an exact-head validation event for the final default-branch state.

When the exact HEAD carrying this handoff passes `Validate project`, recompute the route. If no newer engineering work supersedes this state, the route becomes **ADVANCE**.

## Completed — feature 004
- Spec: `specs/004-research-material-compatibility-review/`
- PR #37: merged.
- Final PR head: `f810acc4119800957b7a2e8d7808423a80505cc5`.
- Exact-head validation: run #176 / 35899327508 — SUCCESS.
- Merge commit: `03064e3063ecfe62898242818e74610b02b08e42`.
- Post-merge validation: run #177 / 35899443403 — SUCCESS.
- The fifth research step remains evidence-bounded: material compatibility does not prove exact Onda provenance, original four-mark order/common origin, or continuous historical/genetic lineage.
- Save schema remains v10.

## Completed — Web/Vercel repair
- PR #39: **MERGED** — `fix(web): publish Godot Web build for Vercel`.
- Final PR head: `ecc44fd426643cfebc51c92a43e0ed71ee739c22`.
- Merge commit: `029ea21dd892b978c1bb5233b8c9588b6fad4c99`.
- `Validate project` run #186 / 35903061290 on the merge commit — **SUCCESS**.
- `Export Godot web build` run #4 / 35903061376 on the merge commit — **SUCCESS**.
- Vercel status on the resulting stable deployment — **SUCCESS**.
- Web delivery now includes:
  - Godot 4.7.2 Web export preset;
  - reproducible export workflow;
  - committed `web/` build;
  - `vercel.json` with `outputDirectory: web`.
- The export workflow then produced `db5ff5cb8558acb1b072dff3d100f7edacfd6e08` (`chore(web): refresh exported build`), changing only `web/index.pck`.
- Because GitHub Actions bot pushes do not automatically create a follow-up validation run, `db5ff5c…` had no exact-head `Validate project` evidence. This handoff update closes that evidence gap by creating a user-authored default-branch HEAD that must validate.

## Concurrent work
- Open PR #38: `docs(lore): add Act III codex archive set 02`.
- Current reconciled lore head observed before this handoff write: `d5d7b5fab3a7130c86d737553bd1fcfcefa5cac9`.
- PR #38 touches only:
  - `docs/lore/CODEX-ARCHIVE-SET-02.md`;
  - `docs/lore/LORE-HANDOFF.md`;
  - `docs/lore/README.md`.
- Classification relative to SIGA/Web work: **PARALLEL_SAFE**.
- This SIGA handoff update will move `master`; therefore PR #38 must re-reconcile current `master` before its own final merge gate.

## Next engineering action
After exact-head validation of this handoff/default-branch HEAD:
1. Reconcile live `master`, open PRs and CI again.
2. If no newer engineering feature supersedes the roadmap, classify **ADVANCE**.
3. Define the next smallest Spec Kit feature that makes the canonical Ato IV evidence gate naturally reachable through playable campaign progression.
4. Preserve `event_foto_estrela` boundaries:
   - material compatibility is limited evidence;
   - do not prove exact Onda provenance;
   - do not prove original four-mark order/common origin;
   - do not authenticate a continuous historical/genetic DA LATA lineage.
5. Keep Ato V reconstruction/finale implementation out of scope until the V0.5 research-chain roadmap item is explicitly closed by repository evidence.
6. Route the capability through spec -> plan -> tasks -> implementation -> exact-head validation.

## Boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract risk/reward with no real-world logistics or evasion guidance.
- Institutional/political gameplay remains fictional and systemic; no real politicians, parties, elections or targeted persuasion.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state.
