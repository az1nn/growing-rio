# Feature 013 — Agentic Quality Loop implementation plan

## Delivery rule

Feature 013 is planned now but implementation is **queued after Feature 012 R16 PASS**. SIGA will execute this plan through `tasks.md`.

There is no Feature-013-specific SIGA roadmap. The single product sequence is `docs/ROADMAP.md`; this file provides technical design, and `tasks.md` is the dependency-ordered execution ledger.

## Architecture

Feature 013 adds an evidence/orchestration layer around existing systems:

```text
SIGA
  |
  +--> reconcile / route / claim / exact-head delivery
  |
  +--> GAUNTLET (bounded quality specialist)
         |
         +--> baseline evidence
         +--> builder under owning specialist
         +--> LENTE/runtime capture
         +--> fresh critic
         +--> QA/rules
         +--> A/B comparator
         +--> regression hunter
         +--> ARTIST/CENA human gate when visual
         |
         '--> result back to SIGA
```

Authority remains:

- SIGA: orchestration, repository identity, roadmap, concurrency, merge/delivery;
- GODOT: runtime implementation;
- CENA: production scene/material/asset integration;
- LENTE: exact-head runtime observation;
- QA: automated measurable verification;
- ARTIST: visual direction and human visual acceptance;
- LORE: canon;
- Gauntlet: bounded process coordinator only.

## Proposed repository surfaces

Final paths may be adjusted by live reconciliation, but the intended boundaries are:

- `.agents/skills/gauntlet/SKILL.md` — engine-agnostic round contract;
- `.agents/skills/qa/SKILL.md` — mutation doctrine integration;
- `.agents/skills/lente/SKILL.md` — scene-state matrix capture contract where needed;
- `.agents/skills/siga/SKILL.md` — routing/integration only, preserving master authority;
- `tools/agentic/` — deterministic manifests, matrix composition, comparison and generated ownership helpers;
- `tools/qa/` or existing QA locations — mutation harness and browser E2E helpers;
- `docs/generated/ARCH-OWNERSHIP.md` — generated human-readable ownership/impact surface;
- `artifacts/agentic/` or workflow artifacts — large evidence packs;
- existing CI workflows — only bounded steps required to enforce freshness or E2E contracts.

Do not introduce a second domain model or duplicate gameplay state inside the evidence tooling.

## Data contracts

### Gauntlet round manifest

Each round should be machine-readable and include at minimum:

- repository;
- exact SHA;
- feature/task/scene;
- baseline evidence refs;
- candidate evidence refs;
- states/viewports covered;
- rule results;
- fresh-critic verdict;
- A/B findings;
- regressions;
- human acceptance requirement/state;
- next action.

### Scene-state matrix manifest

Each cell identifies:

- scene/surface;
- deterministic fixture/setup;
- semantic state name;
- viewport;
- UI/overlay state;
- exact SHA;
- capture artifact/path;
- console/page-error status.

### Mutation receipt

Each blocking rule introduced/modified by this feature records:

- rule id;
- defect/contract protected;
- good-state result;
- mutation description;
- proof the mutation actually applied;
- expected failure;
- observed failure;
- restore result.

### Asset / technical-art evidence row

At minimum:

- asset/surface id;
- source/author/provider;
- license/attribution;
- local path;
- modifications;
- quality tier;
- measured render/payload values when available;
- acceptance owner/status.

## Execution waves

### AQ-01 — Gauntlet foundation

Create the repository-local Gauntlet skill and round manifest contract. Integrate it as a SIGA-routed specialist without changing SIGA authority.

Pilot against a stable historical/runtime fixture after Feature 012 certification. The pilot is evidence/process validation, not a reason to alter an already accepted scene.

Exit:
- skill contract exists;
- round manifest schema exists;
- fresh critic boundary is explicit;
- exact-head and stop conditions are enforced;
- one bounded pilot report is produced.

### AQ-02 — QA mutation doctrine

Extend QA so new blocking rules require mutation receipts. Add the smallest harness needed to prove applied mutation, expected red state and restore.

Select three representative rules:
- interaction/accessibility;
- structural;
- Web/export.

Exit:
- all three demonstrate PASS -> FAIL -> PASS;
- failure messages identify the protected contract;
- unavailable measurement is not treated as green.

### AQ-03 — Scene State Matrix

Add deterministic state-matrix capture orchestration on top of existing LENTE/browser/runtime tooling.

Start with one certified scene, then make the contract reusable.

Exit:
- relevant states are enumerated from surface behavior;
- 540×960 and 1080×1920 are captured;
- manifest/contact sheet links every cell to exact SHA;
- a deliberate visual/state mutation can be localized to a matrix cell.

### AQ-04 — Fresh critic + Regression Hunter

Formalize two distinct review roles:

- fresh critic: “does candidate satisfy target/contract?”;
- regression hunter: “what got worse versus baseline?”

Neither role receives builder rationale before its first observation.

Exit:
- Gauntlet round contains both verdicts;
- regression output is `NONE` or evidenced findings;
- two consecutive no-movement rounds trigger stop/escalation rather than infinite churn.

### AQ-05 — Deterministic SIGA graph + generated architecture/ownership

Implement the bounded contract in `specs/siga-001-execution-graph-v2/`.

Build a deterministic graph core from normalized live-repository/CI input plus repository-observable contracts: roadmap items, tasks, PR/session claims, branches, exact commit heads, gates, semantic contracts, specs, tests and skill ownership. The core graph is a derived execution model; GitHub/CI/Spec Kit remain authoritative.

The implementation must separate:
- an acyclic execution/dependency view used for readiness/frontier selection;
- an evidence/history view that may contain symmetric or historical relations such as collisions, supersession and provenance.

Generate human-readable ownership/impact projections from the same graph rather than maintaining a parallel hand-edited model.

Exit:
- graph schema, deterministic builder and validator exist;
- the execution frontier can explain RESUME/WATCH/ADVANCE inputs without replacing SIGA authority;
- semantic overlap detects same-task/same-contract collisions even when paths differ;
- generated ownership covers canonical player-facing surfaces;
- stale source packets/generated output fail closed;
- representative concurrency/exact-head fixtures pass.

### AQ-06 — Browser E2E

Build exact-head Web-export interaction E2E.

Priority:
1. Operation;
2. Market;
3. City;
4. Institutional;
5. Archive;
6. campaign/narrative/finale only when stable and valuable.

A test should:
- boot exported Godot Web;
- use real pointer/touch/keyboard behavior;
- trigger a semantic hotspot/fallback;
- assert visible/presentation effect;
- close/back/return;
- fail on unexpected console/page errors.

Exit:
- first five surfaces each have one proven real interaction path or a documented repository-backed blocker.

### AQ-07 — Asset/provenance + technical-art ledger

Normalize distributed asset/provenance/performance evidence into one queryable contract without inventing values.

Exit:
- production surfaces can be traced to source/license/local asset status;
- measured payload/render evidence is linked;
- unknown metrics remain explicitly unknown;
- ARTIST/CENA remains art-acceptance authority.

### AQ-08 — Graphify adapter pilot

Only after AQ-05 / SIGA Graph v2 core.

Evaluate Graphify strictly as an optional adapter/index over the already-canonical deterministic graph contract for questions such as:
- what depends on Market?;
- which tests cover a hotspot?;
- which visual decisions constrain a scene?;
- which tasks/sessions/contracts are likely to collide?

Benchmark the adapter against the deterministic core's own query/frontier baseline. The pilot may improve ergonomics or semantic retrieval, but it must not redefine node/edge semantics, task readiness, ownership, exact-head evidence or collision authority.

Exit decision:
- `ADOPT` as a bounded replaceable adapter with measured workflow value; or
- `REJECT` and remove the dependency/pilot artifacts.

No canonical data or required query may exist only in Graphify.

### AQ-09 — SIGA integration and certification

Wire proven pieces into normal SIGA routing and complete documentation.

Exit:
- SIGA can route Gauntlet based on bounded trigger conditions;
- all relevant canonical gates are green on exact head;
- no second roadmap/orchestrator exists;
- all temporary claims/pilot-only artifacts are cleaned or intentionally preserved;
- final handoff records the certified SHA and any residual debt.

## Verification strategy

Every implementation wave must:

1. reconcile live repository and open work;
2. claim a dedicated task/PR under `siga-concurrency`;
3. run targeted tests first;
4. run canonical validation affected by the change;
5. run Web/browser evidence when the wave changes browser tooling;
6. prove exact-head identity;
7. keep provider throttling separate from code failure;
8. return evidence to SIGA for guarded delivery.

## Performance and cost

- prefer deterministic Node/Python/Godot-headless checks for contracts that do not require pixels;
- use browser/render captures only for properties that require the real rendered/exported world;
- never run multiple heavyweight capture sessions in parallel if doing so contaminates timing or boot reliability;
- large image/log evidence should be artifact-backed and summarized by path/hash/verdict.

Feature 013 must improve confidence without making the normal fast gate prohibitively slow. Expensive matrix/E2E work may remain a separate required workflow when appropriate.

## Risks and mitigations

- **Process overgrowth:** start with AQ-01..AQ-04 core before advanced graph work.
- **Self-confirming metrics:** mutation receipts and fresh critic separation.
- **Visual false positives:** automated diffs flag; ARTIST/CENA decides.
- **Flaky browser E2E:** deterministic fixtures, pinned browser/tooling and failure classification.
- **Authority drift:** SIGA and live repository remain above generated docs/graphs.
- **Graph lock-in:** Graphify is last, optional and reversible.
- **Feature 012 interference:** implementation blocked until R16 PASS; specification PR is documentation-only.
- **Context bloat:** manifests/artifacts carry evidence; chat gets compact conclusions.

## Rollback

Every AQ wave is independently revertible.

Core rule: removing Feature 013 infrastructure must not change saved game data or gameplay semantics. If a tool/graph/browser harness is removed, canonical runtime and existing specialist skills continue to function.
