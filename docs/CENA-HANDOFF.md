# CENA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Reconciled product HEAD: `947381910d815648293cd855d39e13c97c8793aa`
- Product PR: `#49` — merged
- Product merge commit: `7df5e3d71f86c424e5de9beb6e6164bc8b96dae2`
- Export-generated Web commit: `947381910d815648293cd855d39e13c97c8793aa`
- Repository-local skill: `.agents/skills/cena/SKILL.md`
- Live repository / CI always overrides this handoff.

## Route
**CENA-ADVANCE**

The first player-visible 3D presentation slice is implemented, merged and exported. Vercel rate limiting remains an unresolved deployment gate, but it is now classified as `SOFT_GATE_RATE_LIMIT`: merge/deployment validation debt, not a development lock. CENA may advance with bounded visual work and stack PRs while preserving the unresolved provider gate.

## Visual target delivered to repository
Operation / grow-space diorama behind the existing management UI, with no gameplay or save-schema changes.

## Implemented
- `scenes/visual/operation_diorama.tscn`
  - Node3D scene root;
  - orthographic `Camera3D` with portrait-oriented `KEEP_WIDTH`;
  - `WorldEnvironment` using a dark cool background + color ambient light;
  - one cool `DirectionalLight3D`;
  - one warm non-shadowed `OmniLight3D`;
  - primitive room shell, counter, shelves, storage and abstract plant-volume blockout;
  - restrained concrete / tile / metal / wood / terracotta / green palette.
- `scenes/main/main.tscn`
  - instances the 3D diorama;
  - preserves existing `Control` gameplay UI;
  - adds a non-interactive translucent `AtmosphereVeil` between 3D and UI.
- `tools/validate_project.py`
  - requires the visual scene and CENA docs;
  - asserts Camera3D, WorldEnvironment, lights, orthographic portrait camera contract and main-scene integration.
- `docs/VISUAL-DIRECTION.md`
  - records research evidence and the resulting visual grammar.
- `web/**`
  - regenerated from the merged Godot scene by the successful Web export workflow.

## Research performed
### Godot / platform
- https://docs.godotengine.org/en/4.7/classes/class_camera3d.html
- https://docs.godotengine.org/en/latest/tutorials/rendering/renderers.html
- https://docs.godotengine.org/en/latest/tutorials/performance/optimizing_3d_performance.html
- https://docs.godotengine.org/en/4.7/engine_details/architecture/internal_rendering_architecture.html

Decision:
- keep Compatibility/Web;
- orthographic portrait camera;
- primitive geometry;
- reused materials;
- two lights, neither shadow-casting.

### Rio-adjacent material references
Reference-only; no image or mesh copied into the game:
- Huma Arquitetura / Apartment IPA — exposed concrete, saturated ceramic tile, warm timber:
  https://architizer.com/idea/3902201/
- Flamengo renovation — concrete, green tile and warm timber:
  https://www.revistahabitare.com.br/post/reforma-transforma-apartamento-no-flamengo-em-espa%C3%A7o-moderno
- Laranjeiras renovation — warm timber and compact layered interior:
  https://www.youcanfind.com.br/postagem/arquitetura/interiores/ape-antigo-inspira-com-decor-e-afeto-1706016261

## Asset manifest
All runtime visual content in this wave is authored as Godot-native primitives/resources:
- room shell — `ORIGINAL / BLOCKOUT`
- counter/worktop — `ORIGINAL / BLOCKOUT`
- shelves/storage — `ORIGINAL / BLOCKOUT`
- abstract planters/canopies — `ORIGINAL / BLOCKOUT`
- materials — `ORIGINAL / BLOCKOUT`
- camera/environment/lighting — `ORIGINAL / PRODUCTION-CANDIDATE`

Third-party runtime assets: **none**.
License-unknown assets: **none**.
Attribution requirements: **none**.

## Validation evidence
### PR exact head
- `25486bc211e887e2edbbb5ee48110c664814301b`
- Validate project run #237: **success**
- Vercel preview for that head: **success**

### Post-merge product commit
- `7df5e3d71f86c424e5de9beb6e6164bc8b96dae2`
- Validate project run #238: **success**
- Export Godot web build run #22: **success**
  - project import: success
  - Web export: success
  - generated Web artifact commit step: success

### Current product head
- `947381910d815648293cd855d39e13c97c8793aa`
- Commit message: `chore(web): refresh exported build`
- Produced by the successful run #22.
- Vercel status: **failure — build rate limit**
- No GitHub Actions run was instantiated on this bot-authored commit.
- Therefore repository/export evidence is green, but public deployment parity is **not yet proven**.

## Boundaries preserved
- existing management mechanics unchanged;
- no save-schema change;
- no new narrative canon;
- cultivation remains abstract/non-operational;
- no real-world market-evasion/logistics detail;
- no political persuasion content introduced.

## Known visual debt
- current environment geometry and most materials remain BLOCKOUT quality;
- visual acceptance still needs real screenshot/device inspection;
- no external production prop/texture set has been introduced;
- public Vercel delivery of this exact wave remains blocked by platform build-rate limiting.

## Next action
On the next standalone `CENA`:
1. reconcile current `master`, this handoff and Vercel status;
2. treat explicit Vercel build-rate limiting as `SOFT_GATE_RATE_LIMIT`: keep affected merge/deploy validation pending but continue safe visual development;
3. stack dependent visual PRs explicitly when their base is not yet merged;
4. when provider capacity returns, validate/merge the oldest unresolved dependency first and reconcile the stack;
5. next visual production slice: replace the highest-impact blockout surfaces/props with a small production-candidate asset/material pass while preserving the proven camera/lighting grammar unless visual inspection rejects it;
5. if deployment requires infrastructure/configuration work rather than simple gate recovery, route that dependency through SIGA.

## Canonical-state rule
`REAL REPOSITORY STATE > CENA HANDOFF > VISUAL DIRECTION > CHAT/MEMORY`


## Rate-limit stacking policy update
- Explicit provider build/deploy rate limits are soft external gates.
- They defer merge/public-deploy proof for the affected PR but do not lock CENA development.
- Dependent work may be stacked with explicit PR bases and inherited pending provider validation.
- Real build/import/test/export/configuration failures remain hard gates.


## Stacked visual wave 002
- Stack base PR: **#55**
- Base branch: `chore/rate-limit-stacking-policy`
- Base head at claim: `3db5dbd92aa748f56fb74f220ce448c35f14ca88`
- Working branch: `feat/cena-002-material-props-pass`
- Inherited external state: `SOFT_GATE_RATE_LIMIT` (Vercel)
- Rate-limit effect: merge/provider-validation debt only; development continues.

### Scope
- externalize seven reusable material resources;
- promote planter/canopy silhouettes from cube blockout to low-segment primitives;
- add restrained window trim and service-pipe dressing;
- preserve camera, UI overlay, gameplay semantics and Compatibility/Web constraints.

### Provenance
All wave-002 runtime assets are original Godot resources/primitives. No third-party runtime asset is introduced.

### Gate
Exact-head repository/Godot validation is required for this stacked head. Provider rate limiting remains pending external validation and is not a stop-work lock.


## Stack reconciliation
- PR #55 was validated and merged bottom-up into `master` at `647687a8f10db15691ae8acefc4b08e47f8a26dc`.
- PR #56 was retargeted from `chore/rate-limit-stacking-policy` to `master`.
- Wave-002 Web export run #29 succeeded and generated branch artifact commit `926f0fd172bd3713ccad970ced852b2649091942`.
- Vercel remains `SOFT_GATE_RATE_LIMIT`; this does not invalidate the visual implementation/export, but it defers provider-validation/merge where required.
- Current reason for `CENA-WATCH`: exact-head repository validation must run on the retargeted PR head. This is an internal hard gate, not the Vercel rate limit.


## Wave-002 exact-head validation
- Validated head: `340642038840c2fe92c7d6870519cd7024c19d8c`
- Validate project run #253: **success**
  - structural validator: success
  - Godot headless import: success
  - full regression suite: success
- Vercel: `SOFT_GATE_RATE_LIMIT`
- Route implication: external throttling is merge/provider-validation debt only; CENA may continue with further bounded work.


## Stacked visual wave 003
- Parent visual PR: **#56**
- Stack base branch: `feat/cena-002-material-props-pass`
- Stack base head: `dd8a9e58b60a926a5b3805f944f9fcfcc816f251`
- Working branch: `feat/cena-003-fixture-detail-pass`
- Inherited external state: `SOFT_GATE_RATE_LIMIT` (Vercel on parent visual delivery)
- Development route: **CENA-ADVANCE** — provider throttling does not lock this bounded dependent visual slice.

### Visual target
Promote the highest-impact remaining operation fixtures without changing gameplay or introducing an external asset pack:
- counter/cabinet front rhythm and handles;
- steel shelf cross-bracing;
- compact shelf storage-bin silhouettes.

### Research
Reference-only architecture review:
- Apartamento Cosme Velho / Venta Arquitetos — concrete work surface, integrated storage and exposed metallic conduit:
  https://www.archdaily.com.br/pt/1042780/apartamento-cosme-velho-venta-arquitetos
- Flamengo Apartment / Nop Arquitetura — demountable metalwork shelving:
  https://www.archdaily.com/957602/flamengo-apartment-nop-arquitetura
- FM Apartment / Zanatta Figueiredo — exposed concrete with custom steel shelving:
  https://www.archdaily.com/1064144/fm-apartment-zanatta-figueiredo

Implementation decision: keep the visual language structural and lightweight, using only existing repository materials plus original Godot BoxMesh detail geometry. No source image or third-party runtime asset is imported.

### Runtime changes
- `scenes/visual/operation_diorama.tscn`
  - adds three warm-wood counter fronts and dark-metal handles;
  - adds crossed dark-metal shelf braces;
  - adds three compact storage-bin volumes using the existing teal/metal/terracotta palette;
  - preserves camera, environment, two-light strategy, UI overlay and Compatibility/Web renderer assumptions.

### Provenance
- new fixture/detail geometry: `ORIGINAL / PRODUCTION-CANDIDATE`
- third-party runtime assets: **none**
- license-unknown assets: **none**
- attribution requirements: **none**

### Concurrency
This wave is intentionally stacked on PR #56 because it edits the same operation-diorama scene and depends on wave-002 reusable materials. It must not be retargeted to `master` until #56 is merged/reconciled bottom-up.

### Validation gate
- repository/Godot exact-head validation: **pending on the final PR head**
- external Vercel provider validation: inherited `SOFT_GATE_RATE_LIMIT`; merge/deploy proof debt only
- real Godot import/export/test failure remains a hard gate and must not be reclassified as rate limiting.

### Remaining visual debt
- solid storage crates remain BLOCKOUT;
- structural room shell remains BLOCKOUT;
- screenshot/device visual acceptance remains outstanding;
- public deployment parity remains unproven while the provider rate limit persists.

### Next visual action
After exact-head validation of wave 003, the next CENA run should reconcile the stack first. If repository/engine gates are green and only the provider throttle remains, continue with the next smallest player-visible slice rather than waiting: likely storage-crate/room-shell silhouette promotion or screenshot-driven composition corrections, whichever live evidence ranks higher.


## CENA resume — 2026-09-23

### Reconciled live state
- canonical repository: `az1nn/growing-rio`;
- `master`: `647687a8f10db15691ae8acefc4b08e47f8a26dc`;
- parent visual PR: **#56** — open, mergeable, base `master`;
- current visual PR: **#57** — open, mergeable, stacked on #56;
- pre-resume PR #57 head: `d3b1c8a9cc3e8b28044f01b68fee83ebcd2a1f3c`;
- Vercel: `SOFT_GATE_RATE_LIMIT`;
- GitHub exact-head validation on the pre-resume #57 head: no workflow run observed.

### Route
**CENA-RESUME**

Wave 003 is implemented but not yet complete because repository/Godot exact-head validation evidence is missing. The provider rate limit remains soft and does not lock development; however, the missing internal engine/repository gate is not reclassified as rate limiting.

### Resume action
- inspected the PR #57 scene diff against the repository-local visual direction;
- confirmed the changes stay inside the bounded visual slice and reuse the established material/camera/light grammar;
- no additional runtime geometry is added in this resume step;
- this repository-local handoff persistence intentionally creates a new branch commit so branch/PR automation can instantiate exact-head validation;
- do not claim wave-003 completion until structural validation, Godot headless import and regression evidence are green on the resulting head.

### Next decision
- exact-head internal gates green + only provider throttle remains -> `CENA-ADVANCE`;
- internal validation running with no safe evidence-driven mutation needed -> `CENA-WATCH`;
- real scene/import/test/export failure -> `CENA-RESUME` on the failing wave;
- unresolved art/canon/license dependency -> `CENA-BLOCKED`.


### Post-persist verification
- persistence commit: `ac1ce3b9a511fb165ace039df9b986330f4919cd`;
- PR #57 remains open and mergeable;
- GitHub Actions workflow runs on this exact head: **0**;
- Vercel remains explicit `build-rate-limit` / `SOFT_GATE_RATE_LIMIT`.

### Routed technical dependency
The missing GitHub Actions instantiation on the new PR head is an engineering/delivery concern rather than visual production work. Route investigation through **SIGA** before calling wave 003 internally validated. CENA remains `CENA-RESUME`; no wave 004 should be claimed complete on top of an unvalidated engine/repository head.


### Exact cause of missing validation run
Repository inspection of `.github/workflows/validate.yml` shows:

```yaml
on:
  push:
    branches: [master]
  pull_request:
    branches: [master]
```

PR #57 intentionally targets `feat/cena-002-material-props-pass`, not `master`. Therefore the current stacked PR is outside the workflow's `pull_request.branches: [master]` trigger and will not instantiate `Validate project` merely from additional commits.

Classification:
- visual implementation failure: **no evidence**;
- provider rate-limit lock: **no**;
- stacked-PR CI coverage gap: **confirmed**;
- owner: **SIGA / engineering delivery**.

CENA must preserve the stack and visual work, but must not misreport exact-head engine validation as complete until SIGA provides a valid stacked-branch validation path or the stack is reconciled bottom-up onto an eligible base.

## CENA advance — wave 004

### Reconciled live state
- canonical repository: `az1nn/growing-rio`;
- `master`: `647687a8f10db15691ae8acefc4b08e47f8a26dc`;
- PR #56: open, mergeable, base `master`, exact head `f0a97ed99944a8a8c2cceb2648c87f8b82dadf06`;
- PR #56 Validate project: runs #257 and #258 **success**;
- PR #57: open, mergeable, stacked on #56, exact head `228a0530d01e00f6b93f89793100ea4d796e8950`;
- PR #57 Validate project: runs #256 and #259 **success**;
- PR #58: open, mergeable, exact head `9019d1cf06026705d71bb627cf0b9d41a654a9a5`;
- PR #58 Validate project #255: **success**;
- Vercel on the active heads: explicit `build-rate-limit` / `SOFT_GATE_RATE_LIMIT`.

### Route
**CENA-ADVANCE**

Wave 003 now has exact-head repository/Godot validation evidence. The only remaining provider signal is the explicit Vercel rate-limit soft gate, so development continues without claiming public deployment parity or merging the rate-limited visual stack.

### Wave 004 work claim
- parent visual PR: **#57**;
- base branch: `feat/cena-003-fixture-detail-pass`;
- base head at claim: `228a0530d01e00f6b93f89793100ea4d796e8950`;
- working branch: `feat/cena-004-shell-crate-pass`;
- target: promote the remaining storage-crate silhouettes and add restrained room-shell/doorway framing;
- dependency mode: intentional stacked PR because the scene depends on waves 002–003.

### Runtime changes
- `scenes/visual/operation_diorama.tscn`
  - adds dark-metal wall baseboards;
  - adds dark-metal doorway framing;
  - adds front-frame/slat silhouettes to both storage crates using existing meshes/materials;
  - preserves camera, environment, lighting, overlay and Compatibility/Web assumptions.
- `docs/VISUAL-DIRECTION.md`
  - records the wave-004 reuse/research decision and promotion status.

### Provenance
All added runtime geometry is original repository-authored Godot primitive composition using existing resources.
Third-party runtime assets: **none**.
License-unknown assets: **none**.
Attribution requirements: **none**.

### Validation gate
The final wave-004 PR head must pass repository structure validation, Godot headless import and regression tests. Vercel rate limiting remains provider proof debt only and must not be reported as successful deployment.

### Wave 004 PR persistence
- PR: **#59** — `feat(cena): refine operation shell and storage crates`;
- base: `feat/cena-003-fixture-detail-pass` / PR #57;
- initial PR head: `4d50b351b53e5acbb69ca2e7531ba6c4a607ba32`;
- merge remains deferred while provider proof is rate-limited;
- completion requires exact-head internal validation on the latest PR #59 head.



## CENA advance — wave 005

### Reconciled live state
- canonical repository: `az1nn/growing-rio`;
- parent visual PR: **#59** — open, mergeable;
- parent exact head: `44a16e25288e108fd7868aee6e5d299ebfd6550a`;
- parent Validate project run #261: **success**;
- parent Vercel status: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`;
- working branch: `feat/cena-005-surface-breakup-pass`;
- dependency mode: intentional stacked PR on PR #59.

### Route
**CENA-ADVANCE**

Wave 004 is internally validated on its exact head. The unresolved provider quota is a soft external gate, so the next bounded player-visible slice proceeds without claiming public deployment parity.

### Visual target
Promote the broad room-shell surfaces that still read as flat blockout while preserving the established composition and runtime budget.

### Runtime changes
- adds `resources/visual/materials/plaster_warm.tres`;
- applies warm plaster to the two structural wall masses while retaining concrete floor separation;
- adds low-cost teal lower-wall bands to the back/side shell;
- adds a dark-metal doorway threshold;
- preserves camera, environment, lights, UI overlay, gameplay semantics and save schema.

### Provenance
All wave-005 runtime content is original repository-authored Godot material/primitive composition.
Third-party runtime assets: **none**.
License-unknown assets: **none**.

### Validation gate
The final wave-005 PR head must pass exact-head `Validate project` including structural validation, Godot headless import and regressions. Vercel quota remains provider proof debt only.

### Next visual action
After wave 005 is exact-head green, reconcile the full stack. If only the provider quota remains, prefer screenshot/device-driven composition acceptance before adding a broader external prop/texture set.


### Wave-005 pre-closure validation
- validated implementation head: `d25c38cc65b07edebad5f4344344999e842c7fe0`;
- Validate project run #263 / `36004446009`: **success**;
- structure validation: success;
- Godot 4.7.2 headless import: success;
- full regression suite: success;
- Vercel preview status on that head: **success**.

This handoff persistence creates the final closure head. Do not reuse run #263 as exact-head evidence after this commit; require a fresh `Validate project` run on the resulting PR head before declaring wave 005 complete.


## CENA stack reconciliation — 2026-09-24

### Verified live state
- canonical repository: `az1nn/growing-rio`;
- current observed `master`: `fd7a2ba5ae763f9df80c12051a5979ee223d1559`;
- PR #56 / wave 002: **merged** after conflict-safe reconciliation with current master;
- PR #56 final validated human head before merge: `37bfa73dc5846d84933a0ab93c9cbfe32616de82`;
- PR #56 Validate project run #282: **success**;
- PR #56 Vercel preview on that head: **success**;
- PR #57 / wave 003 reconciled head: `d8becf0c1fd90dc3357aa42d9f576886fadf2f3e`;
- PR #57 Validate project run #287: **success**;
- PR #57 Vercel: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`;
- PR #59 / wave 004 reconciled head: `7a75b6a83ca4f8790455ce6591a1fb9668c775e2`;
- PR #59 Validate project run #288: **success**;
- PR #59 Vercel: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`;
- PR #61 / wave 005 reconciled implementation head: `75f947ce420e6860f4f1894432cb97a252f3afa3`;
- PR #61 Validate project run #289: **success**;
- PR #61 Vercel: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`.

### Reconciliation method
The visual stack had diverged from a newer `master`. Reconciliation preserved the current repository tree and reapplied only each bounded visual delta:
- no stale `web/**` artifact was allowed to overwrite a newer exported build;
- no older CI workflow was allowed to replace the current validation workflow;
- wave 003 retained only its CENA handoff, visual-direction and diorama delta;
- wave 004 retained only its CENA handoff, visual-direction and diorama delta;
- wave 005 retained only its CENA handoff, visual-direction, warm-plaster material and diorama delta.

A GitHub Actions generated `web/**` commit moved the wave-002 head during merge preparation. It was detected rather than force-merged; a fresh human no-op head was then validated exactly before PR #56 merged.

### Route
**CENA-ADVANCE**

The visual implementation through wave 005 is internally green. Provider throttling remains an external soft gate, so it does not invalidate or lock bounded visual development. It does, however, keep PRs #57, #59 and #61 unmerged until exact-head provider validation is available.

### Merge order when provider capacity returns
1. re-check exact live heads and `master`;
2. obtain successful provider validation for the oldest unresolved PR;
3. merge #57;
4. reconcile/revalidate #59 against its new base, then merge;
5. reconcile/revalidate #61 against its new base, then merge;
6. verify final exported Web head and public deployment parity.

Never skip bottom-up reconciliation and never reuse a green status from a superseded head.

### Next visual action
Once the remaining stack is deliverable, prefer **screenshot/device-driven composition acceptance** of the operation diorama before adding a broader external prop/texture set. Inspect framing, UI legibility, silhouette hierarchy, clipping/z-fighting and portrait/mobile readability. If obtaining deterministic visual captures requires new engineering infrastructure, route that dependency through SIGA rather than silently expanding CENA scope.


## CENA reconciliation closure snapshot — 2026-09-24

This snapshot supersedes the intermediate head SHAs in the earlier `CENA stack reconciliation — 2026-09-24` section. Historical entries remain useful as an audit trail, but the heads below are the current reconciled visual stack.

### Current verified repository state
- canonical repository: `az1nn/growing-rio`;
- observed `master`: `fd7a2ba5ae763f9df80c12051a5979ee223d1559`;
- concurrent RB-02 product work is present on master and was explicitly preserved during every visual reconciliation;
- PR #56 / wave 002: **merged**;
- PR #57 / wave 003 final exported human-validation head: `4c8f3293b3c106b9783f659c062ef5d0e34b0fb4`;
- PR #57 Validate project run #293: **success**;
- PR #57 Vercel: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`;
- PR #59 / wave 004 final exported human-validation head: `d7d0050b86c7817279483456722d946985ebab18`;
- PR #59 Validate project run #297: **success**;
- PR #59 Vercel: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`;
- PR #61 / wave 005 source reconciliation head: `ba34992b683d285fd7a4925c2e3b73954f1219dd`;
- PR #61 Validate project run #298: **success**;
- PR #61 export-web run `36009103615`: **success**;
- PR #61 generated Web head: `4fa078bf406ce0ff965c9bc0bdf1cd3b233a929f`;
- PR #61 Vercel on the exported head: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`.

### Concurrency result
The live `master` advanced during CENA because RB-02 merged concurrently. CENA detected the divergence and rebuilt the visual stack from current repository state instead of force-merging stale binary exports.

Each reconciliation used the newer parent tree and overlaid only the bounded visual delta. Generated `web/**` artifacts from stale bases were discarded and regenerated from the combined source state. This preserves both RB-02 and CENA changes.

### Current route
**CENA-ADVANCE**

Internal repository/Godot validation is green through wave 005. The remaining Vercel failures are explicit provider quota failures, so they remain `SOFT_GATE_RATE_LIMIT`, not visual/runtime failures and not a development lock.

However, delivery is intentionally held: do not merge #57, #59 or #61 while exact-head provider proof is missing. When provider capacity returns, merge bottom-up with fresh reconciliation after every parent merge.

### Delivery queue
1. refresh provider validation on #57 current head;
2. if green, re-check `master`, merge #57 and let Web export settle;
3. reconcile #59 against the new base, require exact-head Validate project + provider success, then merge;
4. reconcile #61 against the new base, require exact-head Validate project + provider success, then merge;
5. verify the final generated Web head and public deployment parity.

### Visual next
After delivery closure, run screenshot/device-driven visual acceptance before introducing a broader prop/texture pack. The acceptance pass should evaluate portrait framing, UI-over-3D legibility, silhouette hierarchy, material separation, clipping/z-fighting and Web/mobile readability.

If deterministic visual capture requires a new browser/screenshot or regression subsystem, record that as a SIGA engineering dependency instead of expanding CENA silently.


## CENA wave 006 — foliage silhouette pass

### Claim
- route: **CENA-ADVANCE**;
- stack base: PR #61 / `feat/cena-005-surface-breakup-pass`;
- claimed base head: `729099c83611ed23f6cf3fc937ab9133abec1f92`;
- working branch: `feat/cena-006-foliage-silhouette-pass`;
- inherited provider state: `SOFT_GATE_RATE_LIMIT` (Vercel).

### Visual target
Replace the most visible remaining single-mass plant placeholders with a layered, abstract low-poly silhouette pass while preserving the proven operation-diorama camera, lighting, material palette and 2D UI overlay.

### Implementation
- each of the three existing planters keeps its current footprint and core canopy;
- lightweight foliage-colored stems are composed from existing primitive geometry;
- each canopy gains offset upper/side masses to break the spherical blockout silhouette;
- no new texture, external mesh, dynamic light or transparent material is introduced;
- the structural validator now requires representative wave-006 foliage nodes.

### Provenance
All additions are original repository-authored Godot primitive composition using existing repository materials and meshes.

Third-party runtime assets: **none**.
License-unknown assets: **none**.

### Boundaries
- no gameplay or persistence change;
- no lore/canon mutation;
- no botanical measurements, labels or operational cultivation instruction;
- GL Compatibility/Web/mobile constraints preserved.

### Validation gate
Require exact-head **Validate project** success (structural validator + Godot headless import + regressions). Vercel build-rate limiting remains an inherited soft external gate and does not lock further bounded development.

### Next
After exact-head validation, keep this PR stacked and unmerged while provider proof is unavailable. The next CENA decision should prefer screenshot/device-driven composition acceptance before expanding into broader prop or texture sourcing.


## CENA live reconciliation — 2026-09-24

### Reconciled repository state
- canonical repository: `az1nn/growing-rio`;
- live master used as rebuild base: `3a3cff67b2f361ca043f86d81f7ce9ccd79c0882`;
- PR #57 / wave 003 reached `master`;
- PR #59 / wave 004 and PR #61 / wave 005 were marked merged into their stacked parent branches, not into `master`;
- old PR #67 was retargeted to `master` only as a probe and became non-mergeable because current master also contains RB-02 validator changes;
- stale generated `web/**` from the old visual stack is intentionally not copied into this reconciliation.

### Route
**CENA-RESUME**

Rebuild the remaining visual delta from current live `master`, preserving concurrent product/CI work and replaying only the bounded CENA source changes for waves 004–006.

### Reconciliation contents
- preserve current-master `tools/validate_project.py` and add only the six wave-006 foliage contract tokens;
- replay the current visual-direction documentation;
- replay the operation-diorama source through wave 006;
- add the warm-plaster material used by wave 005;
- preserve CENA handoff history;
- omit old `web/index.html` and `web/index.pck`; regenerate Web only from the reconciled source after delivery.

### Gate
The rebuilt branch must receive fresh exact-head `Validate project` evidence. Provider rate limiting remains `SOFT_GATE_RATE_LIMIT`; it is deployment proof debt, not permission to overwrite concurrent source or claim public parity.

### Next visual action
After the reconciled PR is exact-head green and delivery-safe, perform screenshot/device-driven acceptance before expanding the prop/texture vocabulary.


## CENA acceptance checkpoint — 2026-09-24

### Verified live state
- `master`: `3a3cff67b2f361ca043f86d81f7ce9ccd79c0882`;
- PR #69: open, mergeable, base `master`;
- validated PR head before this persistence: `9e85805c3f75c7cec161d1381c8743ab38a95285`;
- Validate project run #312: **success**;
- Vercel: explicit `api-deployments-free-per-day` / `SOFT_GATE_RATE_LIMIT`;
- repository tree contains no screenshot/capture/browser regression subsystem for deterministic visual acceptance.

### Route
**CENA-ADVANCE**

The reconciled waves 004–006 are internally green. Provider quota remains deployment-proof debt only and does not invalidate the visual source. The next CENA milestone is screenshot/device-driven acceptance; structural inspection of `.tscn` is not accepted as a substitute for rendered evidence.

### Dependency routed to SIGA
Before expanding the prop/texture vocabulary, obtain a deterministic rendered capture path for the exact candidate head (or equivalent exact-head device/browser evidence). If that requires CI, browser automation, artifact capture or deployment plumbing, it belongs to SIGA/engineering delivery rather than CENA.

### Acceptance contract
Rendered evidence must cover at minimum:
- portrait/mobile framing;
- UI-over-3D legibility;
- operation-scene silhouette hierarchy;
- separation between plaster/concrete/metal/wood/foliage materials;
- clipping or z-fighting;
- readability after the wave-006 foliage silhouette pass.

Do not start a broader asset/texture wave until this acceptance is recorded or a concrete visual defect from rendered evidence is selected for correction.

## CENA rendered acceptance repair — 2026-09-24

### Evidence before repair
- acceptance infrastructure: PR **#71** / `chore/visual-acceptance-capture`;
- exact capture-infrastructure head: `72c1cea7226534ec838ca2165b9391a1d2f2e311`;
- Validate project run #322: **success**;
- Visual acceptance capture run #2: **success**;
- rendered evidence at 540x960 and 1080x1920 showed the shell/UI but **no operation diorama**;
- browser console/page error artifact: empty.

### Root cause
`GameShell/Background` is an opaque 2D `ColorRect`. The previous CENA diorama was a root-viewport `Node3D`, so it rendered behind the shell canvas and was completely occluded even though the Godot scene imported and the Web build ran successfully.

Classification: **CENA-RESUME** — real rendered acceptance defect, not a Vercel/provider failure.

### Repair
- repair PR: **#73** — `fix(cena): make operation diorama visible in shell`;
- repair implementation head: `33e6dfc4cec1ccf37292cc50e51c9c55ea9fa2ba`;
- generated Web refresh after the repair: `c67b9b06faef37d35fb68d43ac3d4c99f64c6c2a`;
- `scenes/main/main.tscn` intentionally remains untouched to avoid a new collision with concurrent RB-03 work;
- `scenes/visual/operation_diorama.tscn` now owns a full-rect `SubViewportContainer`;
- the existing 3D world renders inside a child `SubViewport` and is composited as part of the Operation canvas before `AtmosphereVeil` and the management UI;
- camera, lighting, materials, geometry, gameplay, persistence and lore semantics are unchanged.

### Validation and rendered acceptance
On repair implementation head `33e6dfc4cec1ccf37292cc50e51c9c55ea9fa2ba`:
- Validate project run #324: **success**;
- Visual acceptance capture run #3: **success**;
- artifact id: `10820220064`;
- browser console/page error artifact: empty;
- 540x960: diorama visible behind UI, portrait framing retained, core silhouettes/material groups remain readable;
- 1080x1920: diorama visible behind UI, operation composition and foliage silhouettes remain legible;
- no obvious clipping or z-fighting observed in the captured frames.

Acceptance result: **PASS for the repaired 2D/3D compositing contract**.

### Visual debt retained
- the legacy management/narrative panels still consume substantial screen area and reduce the amount of environment visible;
- 540px-wide shell status text remains dense; that is a shell/UI refinement concern, not evidence that the 3D layer is missing;
- broader prop/texture production should remain bounded and must not regress the new SubViewport compositing path.

### Route after repair
**CENA-ADVANCE**, subject to fresh exact-head validation after this handoff persistence.

Vercel remains `SOFT_GATE_RATE_LIMIT`: public deployment parity is still unproven and affected stack merges remain deferred under the repository delivery policy.

### Next visual action
After the final documentation head is exact-head green, the next standalone CENA may begin the next bounded production-candidate visual slice. Prefer one high-impact environment/prop/material improvement informed by the accepted screenshots rather than a broad asset dump.



## CENA wave 007 — rendered readability light pass

### Verified input evidence
- stack base: PR **#73** / `fix/cena-visible-diorama-composite`;
- exact accepted base head: `77ea23edc239e2f15725e222b2532a52e7a8cb92`;
- Validate project run #330: **success**;
- Visual acceptance capture run #5: **success**;
- artifact: `10820055848`;
- browser console/page error artifact: empty;
- 540x960 and 1080x1920 captures confirm the repaired diorama is visible and compositionally correct.

### Route
**CENA-ADVANCE**

Rendered evidence exposes the next bounded visual defect: the 3D environment remains materially darker than the foreground UI, especially at 540x960. The scene is readable, but fixture, foliage and shell separation is weaker than necessary behind the management overlay.

### Visual target
Improve operation-diorama readability without changing composition or broadening scope.

### Implementation
- keep the accepted SubViewport compositing path unchanged;
- keep camera position/projection and all geometry unchanged;
- keep the existing two-light grammar and reusable material set;
- lift the environment background slightly;
- increase ambient energy from `0.62` to `0.76`;
- increase the cool directional key from `0.74` to `0.88`;
- increase the warm practical from `1.72` to `1.92`;
- add no new dynamic lights, textures, meshes, shaders or external assets.

### Research / provenance
No new external research is required for this wave: the target is a screenshot-driven calibration of the already-established and accepted visual grammar.

Runtime assets introduced: **none**.
Third-party assets: **none**.
License/attribution dependency: **none**.

### Boundaries
- no gameplay or persistence change;
- no shell/UI layout change;
- no lore/canon mutation;
- no real-world cultivation instruction;
- GL Compatibility/Web/mobile constraints preserved;
- concurrent RB product surfaces remain untouched.

### Validation gate
Require fresh exact-head:
1. **Validate project** success;
2. **Visual acceptance capture** success at 540x960 and 1080x1920;
3. empty browser console/page error artifact;
4. rendered confirmation that the diorama remains visible, UI remains legible, material/silhouette separation improves, and no clipping/z-fighting is introduced.

Vercel remains `SOFT_GATE_RATE_LIMIT`: public deployment parity and merge stay deferred by provider proof, but the quota failure is not a development lock.

### Next
If exact-head rendered acceptance passes, keep Wave 007 stacked and unmerged while provider validation is unavailable. On the next standalone CENA, reconcile the live stack and use the new captures to decide whether the next smallest gap is a bounded prop/material promotion or composition refinement. Do not start a broad asset pack.
