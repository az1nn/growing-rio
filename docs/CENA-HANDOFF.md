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


### Wave 007 acceptance result
Implementation/documentation head validated before this acceptance persistence: `110bcab5c41c01af97aa7450f12cbbfb72559b3e`.

- Validate project run #337: **success**;
- Visual acceptance capture run #6: **success**;
- rendered artifact: `10821790282`;
- browser console/page error artifact: **empty**;
- 540x960: diorama remains visible behind the UI; foliage, counter, shelving and shell edges gain modest separation without washing out foreground text;
- 1080x1920: accepted composition is preserved; warm practical/cool key separation remains coherent;
- no obvious clipping or z-fighting observed;
- screenshot comparison confirms the adjustment affects the 3D scene rather than the foreground UI.

Acceptance result: **PASS** for the bounded Wave 007 readability calibration.

Route after acceptance: **CENA-ADVANCE**, with delivery still deferred by the inherited Vercel `SOFT_GATE_RATE_LIMIT`. The next CENA invocation must reconcile the live stack before selecting another bounded visual slice.

## CENA wave 008 — floor surface rhythm

### Verified input state
- canonical repository: `az1nn/growing-rio`;
- live master base at claim time: `468401729addaf9faece48cb250a6a773e089a24`;
- open PR collision scan: none;
- Wave 007 is already merged to `master` through PR #75;
- master Vercel status remains explicit build-rate-limit failure, therefore `SOFT_GATE_RATE_LIMIT`, not a development lock.

### Route
**CENA-ADVANCE**

Wave 007 rendered acceptance passed and the live stack is closed. The next smallest player-visible debt is the operation-diorama floor, which remained the most prominent surface still explicitly marked as blockout in the visual direction.

### Visual target
Promote the floor from one uninterrupted concrete plane into a restrained production-candidate surface rhythm without expanding the asset vocabulary.

### Implementation
- branch: `feat/cena-008-floor-surface-rhythm`;
- preserve the existing slab, camera, SubViewport compositing path, lights and UI overlay;
- add `FloorJointRear`, `FloorJointCenter`, `FloorJointFront` and `FloorJointSpine`;
- reuse the existing dark-metal material and trim mesh;
- keep the joints slightly above the slab to avoid coplanar z-fighting;
- extend `tools/validate_project.py` so the four joint nodes become part of the CENA structural contract.

### Provenance / scope
All changes are original repository-authored Godot primitive composition.

Third-party runtime assets: **none**.
License/attribution dependency: **none**.

No gameplay, persistence, UI-layout, lore/canon, cultivation instruction, texture, shader, imported mesh or light-count change is introduced.

### Validation gate
Require exact-current-head:
1. **Validate project** success;
2. **Visual acceptance capture** success at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that floor breakup is visible but subordinate to fixtures/UI and introduces no clipping or z-fighting.

Vercel build-rate limiting remains external delivery debt and must not be misclassified as an internal CENA failure.

### Next
If rendered acceptance passes, treat Wave 008 as the floor-surface promotion milestone. The following CENA should choose at most one remaining bounded blockout family from accepted screenshots rather than beginning a broad prop pack.

## CENA wave 009 — wall bay rhythm

### Verified input state
- canonical repository: `az1nn/growing-rio`;
- stacked base: PR **#78** / `feat/cena-008-floor-surface-rhythm`;
- exact CENA-008 head: `25ce7440d62b86480ad4bcc5e831da589ec93e9e`;
- Validate project run **#370**: **success** on the exact PR head;
- Visual acceptance capture run **#14**: **success** on the exact PR head;
- rendered artifact: `10828698604`;
- browser console/page-error artifact: **empty**;
- 540x960 and 1080x1920 captures confirm the floor breakup is visible, subordinate to fixtures/UI, and introduces no obvious clipping or z-fighting;
- Vercel on PR #78 remains explicit build-rate-limit failure and therefore `SOFT_GATE_RATE_LIMIT`;
- concurrent product PR #79 is disjoint from this visual slice by declared scope; overlap must still be rescanned before merge.

### Route
**CENA-ADVANCE**

The provider quota is not a development lock. Because the next visual slice depends on the accepted CENA-008 scene state, Wave 009 is intentionally stacked on the unresolved CENA branch rather than pretending #78 is already on `master`.

### Visual target
Promote the remaining broad wall mass from a largely uninterrupted structural plane into a restrained bay/reveal rhythm while preserving the accepted material, lighting and portrait composition grammar.

### Implementation
- branch: `feat/cena-009-wall-bay-rhythm`;
- preserve BackWall, SideWall, camera, SubViewport compositing, lighting, wall finish, tile bands, baseboards, doorway/window trim and UI overlay;
- add `BackWallBayReveal`, `BackWallEdgeReveal`, `SideWallRearReveal` and `SideWallFrontReveal`;
- reuse the existing vertical trim mesh and dark-metal material;
- keep the reveals offset from the wall faces to avoid coplanar z-fighting;
- extend `tools/validate_project.py` so the four nodes become part of the CENA structural contract.

### Research / provenance
No new external research is required. This wave applies the already-established Rio-adjacent architectural grammar and repository-authored primitive/material vocabulary.

Runtime assets introduced: **none**.
Third-party assets: **none**.
License/attribution dependency: **none**.

### Boundaries
- no gameplay or persistence change;
- no shell/UI layout change;
- no lore/canon mutation;
- no real-world cultivation instruction;
- no texture, shader, transparency, imported mesh or extra light;
- GL Compatibility/Web/mobile constraints preserved.

### Validation gate
Require fresh exact-current-head:
1. **Validate project** success;
2. **Visual acceptance capture** success at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the wall rhythm adds readable depth without obscuring fixtures/UI or introducing clipping/z-fighting.

Vercel build-rate limiting remains external delivery debt: it defers provider-backed merge proof but does not invalidate internal CENA acceptance or lock bounded stacking.

### Next
If exact-head rendered acceptance passes, hold the stack while provider validation is unavailable and reassess the accepted screenshots before choosing another visual slice. Do not broaden into an asset pack or unrelated scene overhaul.



## CENA wave 009 — rendered acceptance result

### Exact-head evidence
- PR: **#80** — `feat/cena-009-wall-bay-rhythm`;
- exact implementation head: `71d55bf2d3e0c4ae6f8e52d8cbf1a089efce62ca`;
- Validate project run `36050136257`: **success**;
- Visual acceptance capture run `36050136273`: **success**;
- rendered artifact: `10829754894`;
- browser console/page-error artifact: **empty**;
- Vercel: explicit `build-rate-limit` failure, retained as `SOFT_GATE_RATE_LIMIT`.

### Rendered acceptance
- 540x960: operation diorama remains visible behind the UI; the wall-reveal rhythm is present but deliberately subordinate to the foreground controls and fixture silhouettes;
- 1080x1920: the vertical bay/reveal treatment reads more clearly across the back/side wall planes while preserving the accepted portrait composition;
- no obvious clipping or z-fighting was observed in either captured frame;
- the wall treatment does not obscure the window, counter, foliage or primary UI copy.

Acceptance result: **PASS** for Wave 009.

### Route after acceptance
**CENA-ADVANCE**

Provider throttling remains delivery proof debt only. Because the next visual slice depends on the accepted Wave 009 scene, further work must remain stacked on PR #80 until the provider gate clears and bottom-up delivery reconciliation can resume.

## CENA wave 010 — window pane rhythm

### Verified input state
- canonical repository: `az1nn/growing-rio`;
- stacked base: PR **#80** / `feat/cena-009-wall-bay-rhythm`;
- exact accepted base head: `71d55bf2d3e0c4ae6f8e52d8cbf1a089efce62ca`;
- branch: `feat/cena-010-window-pane-rhythm`;
- inherited Vercel state: `SOFT_GATE_RATE_LIMIT`.

### Visual target
Promote the large uninterrupted `WindowPanel` into a restrained four-pane architectural rhythm without changing the accepted room composition or introducing a new asset family.

### Implementation
- preserve the existing window panel, perimeter trim, wall reveals, camera, SubViewport compositing, lighting and UI overlay;
- add `WindowMullionVertical` at the panel centerline;
- add `WindowMullionHorizontal` at the panel mid-height;
- reuse `Mesh_trim_vertical`, `Mesh_trim_horizontal` and the existing dark-metal material;
- keep the mullions in front of the glazing plane so they do not become coplanar with `WindowPanel`;
- extend `tools/validate_project.py` so both mullions become part of the structural CENA contract.

### Research / provenance
No new external research is required. This is a screenshot-driven refinement using the already accepted Rio-adjacent architectural grammar and repository-authored primitive/material vocabulary.

Runtime assets introduced: **none**.
Third-party assets: **none**.
License/attribution dependency: **none**.

### Boundaries
- no gameplay or persistence change;
- no shell/UI layout change;
- no lore/canon mutation;
- no cultivation instruction;
- no texture, shader, transparency, imported mesh or additional light;
- GL Compatibility/Web/mobile constraints preserved.

### Validation gate
Require fresh exact-current-head:
1. **Validate project** success;
2. **Visual acceptance capture** success at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the mullions break the glazing plane without reducing UI readability or introducing clipping/z-fighting.

Vercel build-rate limiting remains external delivery debt and must not be treated as an internal CENA failure.

### Next
If Wave 010 rendered acceptance passes, keep the visual stack unmerged while provider proof is unavailable and reassess the new captures before selecting another bounded slice. Do not expand into a broad asset pack.


## CENA wave 010 — rendered acceptance result

### Exact-head evidence
- PR: **#82** — `feat/cena-010-window-pane-rhythm`;
- exact implementation head: `b902cd730480cdfdac076b47a4294ebf0cc71570`;
- Validate project run `36055638533`: **success**;
- Visual acceptance capture run `36055638494`: **success**;
- rendered artifact: `10831819214`;
- browser console/page-error artifact: **empty**;
- Vercel: explicit `build-rate-limit` failure, retained as `SOFT_GATE_RATE_LIMIT`.

### Rendered acceptance
- 540x960: the vertical mullion and horizontal transom remain visible in the right-side glazing while foreground controls stay readable;
- 1080x1920: the four-pane window rhythm reads clearly and remains subordinate to the overall operation composition;
- no obvious clipping or z-fighting was observed in either captured frame;
- the accepted camera, lighting, wall reveals, floor joints, fixtures and foliage silhouettes remain intact.

Acceptance result: **PASS** for Wave 010.

### Route after acceptance
**CENA-ADVANCE**

The provider throttle remains delivery proof debt only. Further bounded visual work may stay stacked while provider capacity is unavailable, but bottom-up merge/public-delivery claims still require fresh provider proof.

## CENA Wave 010 delivery reconciliation — 2026-09-24

### Real-state reconciliation
- PR #80 / CENA-009 merged into `master` at merge commit `e1770e60b755aa4daea284fd5c603124864342b2`;
- generated Web export advanced `master` afterward;
- PR #82 was retargeted to `master` and a real merge conflict was detected;
- Wave 010 was rebuilt from the verified delta `71d55bf2d3e0c4ae6f8e52d8cbf1a089efce62ca..b902cd730480cdfdac076b47a4294ebf0cc71570` onto live `master@adefc9dae62d0d29024485584d241d032075a67e`;
- concurrent master content was preserved; only the four-file Wave 010 insertion delta was replayed.

### Reconciled implementation head
- reconstruction commit: `20db55e6303b9b4cff005003a3afc63630510758`;
- PR #82 base: `master`;
- PR #82: mergeable after reconciliation;
- Vercel remains explicit `SOFT_GATE_RATE_LIMIT` and is not an internal failure.

### Gate
Require fresh exact-head Validate project + Visual acceptance on the post-handoff head before merge. If both pass, merge #82 and continue the stacked queue bottom-up.

## CENA wave 011 — planter rim rhythm

### Verified input state
- canonical repository: `az1nn/growing-rio`;
- live `master` observed before this wave: `468401729addaf9faece48cb250a6a773e089a24`;
- stacked base: PR **#82** / `feat/cena-010-window-pane-rhythm`;
- exact accepted base head: `b902cd730480cdfdac076b47a4294ebf0cc71570`;
- branch: `feat/cena-011-planter-rim-rhythm`;
- concurrent product PRs #79/#81/#83 do not declare ownership of `scenes/visual/operation_diorama.tscn`, `docs/CENA-HANDOFF.md`, `docs/VISUAL-DIRECTION.md` or the CENA structural validator tokens touched here;
- inherited Vercel state: `SOFT_GATE_RATE_LIMIT`.

### Visual target
Promote the repeated terracotta planter vessels from smooth single-mass cylinders into a slightly more authored prop silhouette while preserving the accepted abstract foliage grammar and portrait composition.

### Implementation
- add reusable `Mesh_planter_rim` as a shallow 12-segment cylinder;
- add `PlanterRimA`, `PlanterRimB` and `PlanterRimC` at the upper vessel edge;
- reuse the existing terracotta material;
- keep planter footprint, foliage positions, camera, SubViewport compositing, environment and lights unchanged;
- extend `tools/validate_project.py` so all three rim nodes are part of the structural CENA contract.

### Research / provenance
No new external research is required. This is a screenshot-driven refinement of repository-authored prop geometry using the established visual/material grammar.

Runtime assets introduced: **none**.
Third-party assets: **none**.
License/attribution dependency: **none**.

### Boundaries
- no gameplay or persistence change;
- no shell/UI layout change;
- no lore/canon mutation;
- no labels, measurements, equipment layout or cultivation instruction;
- no texture, shader, imported mesh or additional light;
- GL Compatibility/Web/mobile constraints preserved.

### Validation gate
Require fresh exact-current-head:
1. **Validate project** success;
2. **Visual acceptance capture** success at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the planter lips are readable without crowding foliage, clipping the floor, or competing with foreground UI.

Vercel build-rate limiting remains external delivery debt and must not be treated as an internal CENA failure.

### Next
If Wave 011 exact-head rendered acceptance passes, keep the visual stack merge-deferred while provider proof is unavailable and reassess the new captures before selecting another bounded slice.

## CENA wave 011 — rendered acceptance result

### Exact-head evidence
- PR: **#84** — `feat/cena-011-planter-rim-rhythm`;
- exact implementation head: `49b10aad8edfab766d322e72f5e8301ff837db06`;
- Validate project run `36060555657`: **success**;
- Visual acceptance capture run `36060555428`: **success**;
- rendered artifact: `10834446915`;
- browser console/page-error artifact: **empty**;
- Vercel: explicit `Deployment rate limited — retry in 24 hours`, retained as `SOFT_GATE_RATE_LIMIT`.

### Rendered acceptance
- 540x960: all three terracotta planter lips remain visible beneath the foliage masses; the added rim depth reads as a bounded prop-silhouette improvement without crowding foreground controls;
- 1080x1920: the repeated rim rhythm is clearer, while the accepted camera, foliage, counter/shelving, floor, glazing and lighting composition remains intact;
- no obvious clipping or z-fighting is visible in either capture;
- the foreground shell/UI remains readable over the diorama and no browser/page errors were captured.

Acceptance result: **PASS** for Wave 011.

### Concurrency reconciliation
A newer engineering branch now overlaps the same visual substrate:
- RB-12 / PR **#85** — `feat/rb-12-diorama-scene-system`;
- RB-12 base: CENA-010 / PR #82;
- observed RB-12 exact head: `37dc3250af839ea35620f15fb51f2d348a52bcfc`;
- RB-12 Validate project and Visual acceptance checks: **success**;
- RB-12 Vercel: `SOFT_GATE_RATE_LIMIT`;
- RB-12 edits the diorama presentation contract and structural validation that Wave 011 also extends.

Wave 011 therefore must not be followed by another direct edit to the same scene/validator line until the RB-12 structural host and this planter-rim delta are reconciled on one ancestry. Opening Wave 012 directly from PR #84 would create avoidable competing ownership of the same visual substrate.

### Route after acceptance
**CENA-WATCH**

This WATCH is caused by the active overlapping RB-12 structural branch, not by the Vercel quota alone. The provider rate limit remains a soft delivery gate and does not globally lock development.

### Next visual action
After RB-12 is reconciled into the visual ancestry, re-verify Wave 011 on top of the contextual diorama host with fresh exact-head repository + rendered evidence. Only then select the next smallest screenshot-driven production-candidate slice. Do not open a broad asset pack or a competing direct `operation_diorama.tscn` wave before that reconciliation.



## CENA-011 / RB-12 ancestry reconciliation — 2026-09-24

### Reconciled stack
- RB-12 parent: PR **#85** / `feat/rb-12-diorama-scene-system` at `37dc3250af839ea35620f15fb51f2d348a52bcfc`.
- CENA-011 child: PR **#84** / `feat/cena-011-planter-rim-rhythm`.
- Previous sibling base CENA-010 / PR #82 was replaced with the explicit dependency stack `#82 -> #85 -> #84`.
- The reconciliation is a normal two-parent merge; no force update is used.
- RB-12 contextual-host contracts and CENA-011 planter-rim visual contracts are both preserved in `tools/validate_project.py`.
- CENA-011 keeps its authored `operation_diorama.tscn`, visual-direction and provenance state while inheriting the RB-12 `ContextualSceneHost`, test, CI and Main integration.

### Route
**CENA-WATCH**

The reconciled CENA-011 head requires fresh exact-head **Validate project** and **Visual acceptance capture** evidence on top of RB-12. The parent RB-12 Vercel quota failure remains inherited `SOFT_GATE_RATE_LIMIT`: delivery/merge debt only, not a development lock.

Do not select the next visual production slice or RB-13 mutation until the reconciled rendered evidence is green.


## CENA wave 012 / RB-13 implementation start — 2026-09-24

### Verified input state
- canonical repository: `az1nn/growing-rio`;
- parent visual PR: **#84** / `feat/cena-011-planter-rim-rhythm`;
- parent current head before this wave: `615040bb2e3405bfd28f249a08bb37941ed913dd`;
- semantic reconciled parent commit: `be72fe5ad6a28fae1b5399ac5281ece0d41f7e17`;
- Validate project run **#405** on semantic parent: **success**;
- Visual acceptance capture run **#49** on semantic parent: **success**;
- Export Godot web build run **#127** on semantic parent: **success**;
- current parent head is the bot-authored exported-Web refresh on top of that accepted semantic commit; its empty-job `action_required` workflow records are not treated as a scene/test failure;
- Vercel remains explicit build-rate-limit failure: `SOFT_GATE_RATE_LIMIT`;
- RB-13 implementation branch: `feat/rb-13-visual-production-pass`, stacked on #84 so RB-12 + CENA-011 ancestry is preserved.

### Route
**CENA-ADVANCE -> CENA-WATCH**

RB-12/CENA-011 reconciliation is green on the semantic implementation head, so visual work may advance. Wave 012 starts RB-13 with the smallest cross-surface production slice and then waits only for its own exact-head repository/rendered evidence.

### Visual target
Normalize the shell/UI visual language without changing information architecture, gameplay, persistence or the accepted diorama composition.

### Implementation
- add `resources/ui/dalata_theme.tres` with reusable DA LATA label/button/panel treatment;
- add explicit keyboard/controller focus outline rather than removing focus affordance;
- apply the shared theme at both `GameShell` and standalone `Main` roots;
- extend `tools/validate_project.py` with RB-13 shared-theme and integration contracts;
- reconcile RB-13 spec/plan/tasks from "future" to active runtime implementation;
- record the visual-debt audit and provenance in `docs/VISUAL-DIRECTION.md`.

### Boundaries
- no domain or GameState mutation;
- no save-schema change;
- no navigation destination or interaction-hierarchy change;
- no lore/canon mutation;
- no external asset/font/texture/icon;
- no OperationDiorama geometry/light/camera mutation in this slice.

### Validation gate
Require fresh exact-current-head:
1. **Validate project** success;
2. **Visual acceptance capture** success at repository-defined portrait/wide targets;
3. no browser/page errors;
4. rendered confirmation that controls/panels read as one product language and focus/disabled states remain legible;
5. Vercel rate limiting remains delivery debt only and must not be mislabeled as a hard visual failure.

### Next
After exact-head Wave 012 acceptance, continue RB-13 with the next smallest evidence-ranked gap (OperationDiorama final production audit or responsive/fallback polish) rather than broad asset replacement.


## CENA wave 012 / RB-13 rendered acceptance — 2026-09-24

### Exact-head evidence
- PR: **#86** — `feat/rb-13-visual-production-pass`;
- accepted implementation head before this persistence: `6449d85063d942f9865ff681ccba16fb896162b4`;
- Validate project run **#414** / run id `36073283783`: **success**;
- Visual acceptance capture run **#58** / run id `36073283782`: **success**;
- rendered artifact id: `10839525405`;
- capture sizes: **540x960** and **1080x1920**;
- browser console/page-error artifact: **empty**;
- Vercel remains an explicit deployment rate-limit failure and is retained as `SOFT_GATE_RATE_LIMIT`.

### Rendered acceptance
- the shared DA LATA theme reads consistently across the shell, management controls, narrative/research panels and bottom navigation;
- focus/selected/disabled control states remain visually distinguishable;
- the accepted OperationDiorama remains visible behind the UI and the 2D/3D compositing contract is preserved;
- 1080x1920 keeps a coherent hierarchy with no obvious clipping or z-fighting;
- 540x960 remains functional and fully framed, but the top HUD, helper copy and some control labels are visually dense/small. This is retained as responsive typography/spacing debt rather than a Wave-012 failure.

Acceptance result: **PASS** for Wave 012 / the RB-13 shared visual-system slice.

### Concurrency probe after acceptance
An active child branch now owns the same shell substrate:
- RB-14 / PR **#88** — `feat/rb-14-campaign-progression-revalidation`;
- observed RB-14 head: `b483aa855b910deba5cd49e39ae70c50cea22b1a`;
- RB-14 is stacked directly on this RB-13 branch;
- RB-14 modifies both `scenes/shell/game_shell.gd` and `scenes/shell/game_shell.tscn`, so a new responsive CENA mutation on the RB-13 parent would create competing ownership and invalidate current RB-14 ancestry assumptions.

### Route after acceptance
**CENA-WATCH**

This WATCH is caused by active RB-14 overlap on the shell, not by the Vercel quota. Do not open a competing Wave 013 against `game_shell.gd` / `game_shell.tscn` while RB-14 is active.

### Next visual action
After RB-14 is reconciled/stabilized in the visual ancestry, re-run exact-head rendered capture and select one bounded responsive/fallback polish slice. First inspect the 540x960 density debt (top HUD, helper copy and compact control labels) while preserving navigation hierarchy, focus affordances, campaign semantics and the accepted diorama composition. Do not broaden into an asset pack.


## CENA Wave 013 — compact portrait HUD — 2026-09-25

### Reconciled real state
- canonical repository: `az1nn/growing-rio`;
- live base at claim: `master@703780873a43236f3f671b63eda2f78cfb939b0d`;
- open PR scan before claim: **none**;
- CENA-011, RB-13, RB-14 and RB-15 implementation heads are verified ancestors of current `master`;
- current `master` Vercel status: explicit build-rate-limit failure, retained as `SOFT_GATE_RATE_LIMIT`;
- working branch: `feat/cena-013-compact-portrait-hud`.

### Route
**CENA-ADVANCE -> CENA-WATCH**

The prior shell-overlap blocker is gone. The smallest accepted screenshot-driven debt is the 540x960 top-HUD density identified during RB-13 rendered acceptance. Wave 013 performs only that bounded calibration, then waits for exact-head repository/rendered evidence.

### Visual target
Reduce portrait HUD crowding at widths `<= 600px` without hiding information or changing shell/navigation/campaign semantics.

### Implementation
- `scenes/shell/game_shell.gd`
  - adds a `compact_portrait` density mode;
  - reduces outer shell margins and header/layout spacing only in compact portrait;
  - scales the title/destination treatment down modestly;
  - reduces Campaign button minimum footprint while retaining 44px height;
  - compacts five global-status labels to short two-line forms at 16px;
  - preserves 3-column portrait status/navigation structure and existing destination order.
- `tools/validate_project.py`
  - adds structural contracts for the compact portrait path and abbreviated status copy.
- `docs/VISUAL-DIRECTION.md`
  - records evidence, bounded decision and rendered acceptance target.

### Provenance
Runtime assets introduced: **none**.
Third-party assets: **none**.
License/attribution dependency: **none**.

### Boundaries
- no gameplay/domain change;
- no persistence/save-schema change;
- no campaign or ending behavior change;
- no destination or focus-order change;
- no OperationDiorama geometry/camera/light/material change;
- no lore/canon change;
- no external asset/font/texture/icon.

### Validation gate
Require the final PR exact head to pass:
1. **Validate project**;
2. **Visual acceptance capture** at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that 540x960 top-HUD crowding is reduced and 1080x1920 retains the accepted hierarchy.

Vercel build-rate limiting remains external delivery debt. It must not be misclassified as an internal visual/runtime failure, but merge/public-delivery claims remain deferred while provider proof is unavailable.

### Next decision
- exact-head repository + rendered evidence green, with only provider quota failing -> **CENA-ADVANCE** but keep delivery deferred;
- repository/rendered jobs still running and no additional safe mutation is needed -> **CENA-WATCH**;
- any compact-layout clipping, overlap, unreadable status or Godot regression -> **CENA-RESUME** on Wave 013.


### Wave 013 rendered repair
First rendered acceptance on PR #90 exposed that the compact path did **not** activate at the 540x960 browser size. The Web build keeps a 1080x1920 logical viewport while the browser canvas is physically 540x960, so `get_viewport_rect().size` was not valid evidence for device-density selection.

Repair:
- classify as **CENA-RESUME**;
- derive the responsive runtime input from `DisplayServer.window_get_size()`, with logical viewport fallback only when a physical window size is unavailable;
- preserve `apply_layout_for_size(Vector2(...))` as the deterministic test boundary;
- extend the RB-13 visual regression to prove 540px activates compact density and wide layout clears it.

The repaired head must receive fresh exact-head Validate project + Visual acceptance + provider evidence before any merge decision.


### Wave 013 repaired acceptance — PASS
Accepted implementation head before this persistence: `665b1a61192f68cc208964d73ed734408a37b587`.

Exact-head evidence:
- Validate project **#446** / run `36117702683`: **SUCCESS**;
- Visual acceptance capture **#85** / run `36117702566`: **SUCCESS**;
- rendered artifact: `10856500230`;
- browser console/page-error artifact: **empty**;
- Vercel on the accepted head: **SUCCESS**.

Rendered inspection:
- 540x960 now activates the compact physical-window path; the global HUD uses short two-line forms (`DIA`, `CAIXA`, `HEAT`, `REP.`, `INFL.`) with no prior long-label collision;
- compact margins/header spacing reclaim vertical room without hiding status information or changing navigation ownership;
- 1080x1920 retains the prior non-compact hierarchy and copy;
- the accepted OperationDiorama composition, controls and foreground readability remain intact;
- no obvious clipping or z-fighting was introduced.

Acceptance result: **PASS** for CENA Wave 013.

This handoff persistence changes the PR head. Require one final exact-head Validate project + Visual acceptance + Vercel success on the resulting documentation head before guarded merge.


## CENA Wave 013 — delivery closure — 2026-09-25

### Final repository evidence
- delivery PR: **#90** — merged;
- accepted final PR head: `02afc24b4830f217e16ec2a7430fdda4af7f7e7d`;
- final exact-head Validate project: **#447 / SUCCESS**;
- final exact-head Visual acceptance capture: **#86 / SUCCESS**;
- final PR-head Vercel: **SUCCESS**;
- merge commit on `master`: `4a8127322a2c616f4c388e04c8501193095d2439`;
- post-merge generated Web commit: `1e8d7b264dbbf2bf3230c6c6dccb30bcfee7161e`;
- generated Web delta updates `web/index.html` and `web/index.pck`;
- Vercel on the generated Web commit: **SUCCESS**.

### Delivered visual result
Wave 013 is fully delivered. The 540x960 browser presentation now selects compact shell density from the physical Web window size, reducing top-HUD crowding while retaining every canonical status and existing navigation/campaign semantics. The 1080x1920 presentation retains the established full-copy hierarchy.

### Route
**CENA-ADVANCE**

There is no unresolved Wave 013 implementation, repository, rendered-acceptance, export or provider gate. The next standalone CENA invocation must reconcile live state first, then select the next smallest screenshot-driven visual debt. Do not reopen Wave 013 unless new rendered evidence demonstrates a regression.

### Known retained debt
- compact presentation is intentionally conservative; lower operation panels still consume substantial portrait area;
- no broader prop/texture pack is justified by this wave;
- any next shell-density change must remain evidence-driven and preserve 64px primary portrait navigation targets and focus affordances.


## CENA Wave 014 — diorama breathing room — 2026-09-25

### Reconciled real state
- canonical repository: `az1nn/growing-rio`;
- base: `master@1e8d7b264dbbf2bf3230c6c6dccb30bcfee7161e`;
- PR #90 / CENA-013: merged at `4a8127322a2c616f4c388e04c8501193095d2439`;
- final CENA-013 exact-head evidence: Validate project #447 **SUCCESS**, Visual acceptance #86 **SUCCESS**, Vercel **SUCCESS**;
- current master is the successful post-merge Web export refresh;
- open PR scan at claim time: **none**.

### Route
**CENA-ADVANCE -> CENA-WATCH**

The accepted Wave 013 captures expose one bounded composition debt: in embedded Operation, the legacy event `LogPanel` keeps `SIZE_EXPAND_FILL` and stretches through most of the SurfaceHost. Its opaque panel treatment masks the accepted OperationDiorama and leaves the central player-visible area reading as a large empty card.

### Wave 014 target
Restore diorama breathing room while preserving the event message and all operation controls.

### Implementation
- `scenes/main/main.gd`
  - when `embedded_in_shell`, constrain the legacy event log to a 96px minimum height;
  - switch the log from expanding/filling the remaining VBox space to `Control.SIZE_SHRINK_BEGIN`;
  - keep standalone Main behavior unchanged.
- `tests/visual_production_pass_test.gd`
  - assert the shell-embedded log exists, stays within the 96px budget and does not retain an expanding size flag.
- `tools/validate_project.py`
  - require the Wave 014 presentation contract.

### Evidence selection
The decision comes from the final Wave 013 rendered artifact itself:
- 540x960: the log card occupies the dominant central/lower area despite containing only one short status sentence;
- 1080x1920: the same expanding panel visually suppresses the diorama for a large portion of the SurfaceHost.

No new moodboard or external asset research is required because this is a correction inside the already-accepted shell/diorama composition grammar.

### Boundaries
No gameplay/domain mutation, save-schema change, navigation change, campaign/ending behavior change, OperationDiorama geometry/camera/light/material edit, lore/canon change, or external runtime asset.

### Validation gate
Require exact-head:
1. Validate project;
2. Visual acceptance at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the status message remains readable, operation controls remain accessible, and materially more of the diorama is visible without introducing clipping/overlap.

Vercel provider proof is required for guarded merge. Any explicit provider quota is `SOFT_GATE_RATE_LIMIT`; real import/test/render failures remain hard failures.

### Concurrency reconciliation after Wave 013 closure
- live master advanced to `070591a0675190e405cd9420310ac6cfc1a16a8b` only to merge the repository-local Wave 013 delivery-closure handoff;
- Wave 014 runtime/test/validator files are disjoint from that closure PR;
- this branch now preserves both the Wave 013 closure evidence and the Wave 014 work claim in one handoff;
- no Wave 014 runtime delta was discarded or replaced during reconciliation.


## CENA Wave 014 — delivery closure — 2026-09-25

### Accepted evidence
- reconciled implementation head: `b7d2cce4fec8bf79b4b39dabedbd65a52fc8ef54`;
- Validate project **#452** / run `36119126654`: **SUCCESS**;
- Visual acceptance capture **#89** / run `36119126771`: **SUCCESS**;
- rendered artifact: `10856935112`;
- browser console/page-error artifact: **empty**;
- Vercel on the accepted implementation head: **SUCCESS**.

Rendered inspection:
- 540x960: the embedded log no longer expands over most of Operation; its message remains readable while materially more planter, fixture and floor composition is visible;
- 1080x1920: the foreground hierarchy remains coherent and a substantially larger continuous diorama area is exposed;
- operation controls, management entry, campaign shell, Wave 013 compact HUD behavior and portrait navigation remain intact;
- no obvious clipping, overlap or z-fighting was introduced.

Acceptance result: **PASS**.

### Delivered repository state
- PR **#92** merged from the accepted implementation head;
- merge commit: `8f457877310d0c55bfce63453ba0b9db3de4ac33`;
- post-merge generated Web commit: `3ca33bc048f728d043df2e7f8b132fc9a8f67951`;
- generated Web delta refreshed `web/index.html` and `web/index.pck`;
- Vercel on the generated Web commit: **SUCCESS**.

### Route
**CENA-ADVANCE**

Wave 014 has no unresolved implementation, validation, rendered-acceptance, export or provider gate. The next standalone CENA must reconcile live repository state first and choose the next smallest player-visible debt from rendered evidence. Do not reopen Wave 014 without new evidence of regression.


## CENA Wave 015 — lightweight feedback overlays — 2026-09-25

### Reconciled real state
- canonical repository: `az1nn/growing-rio`;
- live base at claim: `master@dbeacdf09abb76db5e4800c82109750ca9189223`;
- Wave 014 delivery PR **#92** and closure PR **#93** are merged;
- latest accepted Wave 014 render artifact: `10856935112`;
- open PR scan at claim time: **none**;
- working branch: `feat/cena-015-lightweight-feedback-overlays`.

### Route
**CENA-ADVANCE -> CENA-WATCH**

Wave 014 is fully delivered. Its accepted portrait captures show one smaller remaining foreground-composition debt: the operation feedback band and event-log band retain the global opaque panel treatment even though they carry low-priority informational copy over the accepted diorama.

### Visual target
Reduce foreground masking from the two informational bands without removing text, changing layout height or altering interaction semantics.

### Implementation
- add `resources/ui/dalata_overlay_panel.tres` as a shared translucent low-priority overlay StyleBox;
- apply it to `OperationSurface/VBox/FeedbackPanel`;
- apply it to `Main/Margin/VBox/LogPanel`;
- extend the visual production regression and structural validator to require the shared overlay and bounded alpha.

### Boundaries
No gameplay/domain mutation, save-schema change, navigation change, campaign/ending behavior change, OperationDiorama camera/geometry/light/material edit, lore/canon change, external asset, font, texture or icon.

### Validation gate
Require exact-head:
1. **Validate project**;
2. **Visual acceptance capture** at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that both messages remain readable and more underlying diorama detail remains visible;
5. Vercel provider proof before guarded merge; explicit quota/rate limiting remains a soft delivery gate only.

### Next decision
- repository/rendered evidence green + provider success -> guarded merge and post-merge export verification;
- checks still running -> **CENA-WATCH**;
- contrast, readability, clipping, import or test failure -> **CENA-RESUME** on Wave 015.


## CENA Wave 015 — delivery closure — 2026-09-25

### Verified evidence
- PR **#95** merged;
- accepted PR head: `5e6b952c273cfc1f740e471fac6632601896e9ee`;
- Validate project **#458**: **SUCCESS**;
- Visual acceptance capture **#93**: **SUCCESS**;
- rendered artifact: `10862260334`;
- browser console/page-error artifact: **empty**;
- merge commit: `17805a5e10ee7883a4670e89dc4c300952d9aac8`;
- post-merge Validate project **#460**: **SUCCESS**;
- Export Godot web build **#164**: **SUCCESS**;
- generated Web commit / live master at reconciliation: `4b131fcc65ce4f47bd7bbcf90e49b05f4f87189d`;
- Vercel on generated Web commit: **SUCCESS**;
- open PRs at reconciliation: **none**.

### Route
**CENA-ADVANCE**

Wave 015 is fully delivered. Its translucent informational overlays remain readable and expose more of the accepted OperationDiorama beneath them.

## CENA Wave 016 — foreground floor depth — 2026-09-25

### Reconciled real state
- canonical repository: `az1nn/growing-rio`;
- base: `master@4b131fcc65ce4f47bd7bbcf90e49b05f4f87189d`;
- no open PR existed at claim time;
- source evidence: accepted CENA-015 artifact `10862260334` at 540x960 and 1080x1920.

### Route
**CENA-ADVANCE -> CENA-WATCH**

### Visual target
Reduce the large empty lower portrait band by extending the existing room floor toward the foreground, while preserving the accepted orthographic camera, lighting, props, UI and bottom navigation.

### Implementation
- extend `Mesh_floor` depth from 8 to 11;
- shift `Floor` to z=1.5 so the rear boundary remains unchanged;
- add `FloorJointForeground` at z=4.9;
- recenter/extend `FloorJointSpine` across the promoted surface;
- add runtime and structural validation for the foreground-depth contract.

### Boundaries
No gameplay/domain change, save-schema mutation, camera change, lighting change, wall/prop change, navigation change, lore/canon change or external asset.

### Validation gate
Require exact-head:
1. **Validate project**;
2. **Visual acceptance capture** at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the lower dead band is materially reduced without clipping or making the foreground dominate;
5. Vercel provider proof before guarded merge.

Until those gates complete, remain **CENA-WATCH** and do not open Wave 017.


### Wave 016 rendered acceptance — PASS

Accepted implementation head before this persistence: `7436ea00650032b5cef5f2da0b05aae155cfd0cd`.

Exact-head evidence:
- Validate project **#462** / run `36133267307`: **SUCCESS**;
- Visual acceptance capture **#95** / run `36133267290`: **SUCCESS**;
- rendered artifact: `10862718302`;
- browser console/page-error artifact: **empty**;
- Vercel on the accepted implementation head: explicit build-rate-limit / `SOFT_GATE_RATE_LIMIT`.

Rendered inspection:
- 540x960: the foreground floor extends materially farther below the planter/fixture cluster, reducing the featureless lower environment band while the portrait navigation remains untouched;
- 1080x1920: the promoted floor and continued joint rhythm reduce the lower dead band without clipping the room silhouette or controls;
- accepted camera transform/projection, lighting, walls, props and foreground UI remain unchanged;
- no obvious clipping, overlap or z-fighting was introduced.

Acceptance result: **PASS** for the bounded CENA Wave 016 implementation.

This persistence changes the PR head. Require fresh exact-head Validate project + Visual acceptance on the resulting documentation head before treating internal validation as closed. Vercel rate limiting remains a soft delivery gate: it defers merge/public-delivery proof, but after internal exact-head gates are green it must not by itself force CENA-WATCH if another safe bounded visual slice is available.


## CENA Wave 016 — provider recovery reconciliation — 2026-09-26

### Verify-first evidence
- live default branch: `master@851bd50de53540af84dd9e651aebc7b70201c55b`;
- Wave 016 branch before this persistence: `02d6f2642a372a1ab1fed8051d45eb0d959d1347`;
- default-branch drift since the Wave 016 base is 13 commits and touches only 3JS, SIGA handoff and LORE paths; it does not overlap the Wave 016 scene/test/validator/CENA visual contract;
- concurrency classification: **PARALLEL_SAFE**;
- PR #104 exact head `35ebf05c5dec4a59a99207b73fee25c541629b04` now has Validate project #480 SUCCESS, Visual acceptance #110 SUCCESS and Vercel SUCCESS, proving provider capacity has recovered from the earlier quota-only failure.

### Route
**CENA-RESUME — guarded bottom-up delivery reconciliation.**

Wave 016 remains the oldest unresolved visual delivery. This persistence intentionally refreshes its exact head so repository/visual checks and provider proof are re-earned against the current live base context. Do not merge a child first.

### Gate
Require on the resulting exact PR #97 head:
1. Validate project SUCCESS;
2. Visual acceptance SUCCESS at 540x960 and 1080x1920 with empty browser console/page-error evidence;
3. Vercel SUCCESS;
4. PR mergeable against current `master`.

If all are green, merge #97 with an expected-head guard, then reconcile/revalidate #98 -> #101 -> #104 bottom-up.

## CENA Wave 017 — foreground apron transition — 2026-09-25

### Reconciled real state
- canonical repository: `az1nn/growing-rio`;
- stacked parent: PR **#97** / `feat/cena-016-foreground-floor-depth`;
- exact parent head: `02d6f2642a372a1ab1fed8051d45eb0d959d1347`;
- final parent Validate project **#463** / run `36133718056`: **SUCCESS**;
- final parent Visual acceptance capture **#96** / run `36133718076`: **SUCCESS**;
- final parent rendered artifact: `10862203498`;
- downloaded browser console/page-error artifact: **empty**;
- parent Vercel: explicit `api-deployments-free-per-day` / `SOFT_GATE_RATE_LIMIT`;
- Wave 016 final persistence differs from its accepted implementation by documentation only, so the accepted runtime/render contract is unchanged.

### Route
**CENA-ADVANCE -> CENA-WATCH**

The provider quota is not a development lock. Exact-head internal Wave 016 validation is closed, and the accepted captures expose one further bounded composition gap: a large uninterrupted environment band remains between the promoted floor termination and bottom navigation, especially at 1080x1920.

### Visual target
Turn the lower room termination into an intentional stepped foreground transition without enlarging the entire main floor again.

### Implementation
- branch: `feat/cena-017-foreground-apron-transition`, stacked on PR #97;
- add a 6.8 x 2.4 concrete `ForegroundApron` immediately beyond the existing room floor;
- step it slightly below the accepted slab so it reads as a foreground transition rather than another coplanar floor extension;
- add `ForegroundApronEdge` using the existing dark-metal trim vocabulary;
- add runtime and structural contracts for apron depth, placement and terminal edge.

### Boundaries
No gameplay/domain mutation, save-schema change, camera change, lighting change, wall/prop change, navigation change, shell-layout change, lore/canon change, external asset, texture, shader or new material family.

### Validation gate
Require exact-head:
1. **Validate project**;
2. **Visual acceptance capture** at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the residual lower environment band is materially reduced, the step reads as intentional, and the apron does not dominate or collide with bottom navigation;
5. Vercel provider proof remains required before guarded delivery merge; an explicit quota failure stays a soft gate only.

### Next decision
- internal checks/render still running -> **CENA-WATCH**;
- clipping, foreground dominance, navigation collision, z-fighting or runtime/import failure -> **CENA-RESUME**;
- exact-head internal/rendered acceptance passes and only provider quota remains -> **CENA-ADVANCE** may continue with another screenshot-driven bounded slice while delivery stays stacked.

## CENA Wave 018 — foreground service plinth — 2026-09-25

### Reconciled real state
- canonical repository: `az1nn/growing-rio`;
- parent delivery chain: PR **#97** -> PR **#98**;
- parent Wave 017 exact head at claim: `a0a22b0c3cbab7abd08ffb966042c73bfd173c02`;
- parent Validate project run `36136622679`: **SUCCESS**;
- parent Visual acceptance capture run `36136622739`: **SUCCESS**;
- parent rendered artifact: `10864491967`;
- parent browser console/page-error artifact: **empty**;
- parent Vercel: explicit `api-deployments-free-per-day` / `SOFT_GATE_RATE_LIMIT`;
- working branch: `feat/cena-018-foreground-service-plinth`;
- PR: **#101**, stacked on PR #98.

### Route
**CENA-ADVANCE -> CENA-WATCH**

The Wave 017 exact-head internal gates are green and its rendered evidence is acceptable, while Vercel remains only a provider quota soft gate. The accepted render still exposes a bounded player-visible composition debt below the apron, so CENA advances without pretending the delivery stack is mergeable.

### Visual target
Reduce the remaining lower portrait dead band with a distinct recessed service plinth, avoiding another full-width extension of the main room slab.

### Implementation
- add `Mesh_foreground_service_plinth` as a 5.8 x 2.8 bounded concrete continuation beyond the Wave 017 apron;
- step it lower than the apron so the foreground reads as layered architecture rather than one oversized slab;
- add `ForegroundServiceRailLeft` and `ForegroundServiceRailRight` using existing dark-metal trim;
- add `ForegroundServiceEdge` as the terminal visual boundary;
- extend `tests/diorama_scene_system_test.gd` and `tools/validate_project.py` with Wave 018 contracts.

### Boundaries
No gameplay/domain mutation, save-schema change, Camera3D transform/projection change, lighting change, room wall/prop change, shell-layout change, navigation change, lore/canon mutation, external asset, texture, shader or new material family.

### Validation gate
Require exact-head:
1. **Validate project**;
2. **Visual acceptance capture** at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the residual lower band is materially reduced without foreground dominance, clipping, z-fighting or navigation collision;
5. Vercel provider proof before guarded delivery merge; explicit quota remains a soft gate only.

### Next decision
- checks/render still running -> **CENA-WATCH**;
- structural/runtime/render regression -> **CENA-RESUME** on PR #101;
- exact-head internal/rendered acceptance passes and only provider quota remains -> **CENA-ADVANCE** may continue with another bounded screenshot-driven slice, while merge delivery remains bottom-up (#97 -> #98 -> #101).

## CENA Wave 018 acceptance / Wave 019 — foreground service landing — 2026-09-26

### Reconciled real state
- canonical repository: `az1nn/growing-rio`;
- live default branch before Wave 019 claim: `master@c0523ebaa2681963334165e05c2c586d2c72a874`;
- active visual dependency chain: PR **#97** -> PR **#98** -> PR **#101**;
- Wave 018 exact head: `e08b3d9478b1cc769cf54653b489d807113df3eb`;
- Wave 018 Validate project **#471** / run `36147983862`: **SUCCESS**;
- Wave 018 Visual acceptance capture **#103** / run `36147983931`: **SUCCESS**;
- Wave 018 rendered artifact: `10870338522`;
- browser console/page-error artifact: **empty**;
- Wave 018 Vercel: explicit `api-deployments-free-per-day` / `SOFT_GATE_RATE_LIMIT`;
- open PR **#100** touches only `docs/SIGA-HANDOFF.md`; open PR **#102** is lore-doc-only. Both are parallel-safe with this visual slice.

### Route
**CENA-ADVANCE -> CENA-WATCH**

Wave 018 is internally green and provider quota alone is not a development lock. Its accepted capture still shows a bounded lower foreground gap, so Wave 019 advances as a stacked visual slice and then waits for its own exact-head repository/render evidence.

### Wave 019 target
Close more of the remaining environment-background band with one final narrow recessed service landing, without another full-width room-floor extension.

### Implementation
- branch: `feat/cena-019-foreground-service-landing`, stacked on PR #101 / Wave 018;
- add `ForegroundServiceLanding` as a 4.6 x 3.6 concrete continuation beyond the Wave 018 plinth;
- step the landing down to preserve the layered foreground hierarchy;
- add `ForegroundServiceLandingEdge` using the existing dark-metal trim vocabulary;
- extend `tests/diorama_scene_system_test.gd` and `tools/validate_project.py` with CENA-019 contracts.

### Boundaries
No gameplay/domain mutation, save-schema change, Camera3D transform/projection change, lighting change, room wall/prop change, shell-layout change, navigation change, lore/canon mutation, external asset, texture, shader or new material family.

### Validation gate
Require exact-head:
1. **Validate project**;
2. **Visual acceptance capture** at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the residual lower band is materially reduced without foreground dominance, clipping, z-fighting or navigation collision;
5. Vercel provider proof before guarded delivery merge; explicit quota remains a soft gate only.

### Next decision
- checks/render running -> **CENA-WATCH**;
- structural/runtime/render regression -> **CENA-RESUME** on Wave 019;
- exact-head internal/rendered acceptance passes and only provider quota remains -> reconcile whether another visual slice is actually justified; do not extend the foreground indefinitely without new rendered evidence.


### Wave 019 generated-Web write barrier — 2026-09-26
- initial authored Wave 019 head: `661f7ab3546edb0ebf131b9952485cb153018c4d`;
- Export Godot web build refreshed generated `web/index.html` / `web/index.pck` and advanced the branch to `ee6d585857dc7f5aba3e2d0344545700bbada380`;
- Vercel on generated-Web head `ee6d585...`: **SUCCESS**;
- Validate/Visual runs created for that bot-authored generated head were `action_required`, so they are not accepted as execution evidence;
- the pre-export authored head completed Validate project **#477: SUCCESS**; its Visual acceptance became stale once the branch advanced;
- this documentation-only reconciliation is authored after the generated-Web commit, without force update and outside the export workflow path filter, so fresh exact-head Validate + Visual acceptance can run against the preserved runtime/export tree.


## CENA-020 — Market visual target — 2026-09-26

### VERIFY-FIRST state
- repository identity: `az1nn/growing-rio`;
- live base at claim: `master@bd4ef780649ee48fca91e2147872e06b3f1586d1`;
- open PR scan at the write barrier: **none**;
- 3JS-002 Grow Room delivery is complete and its style lock is **ACCEPT**;
- master Validate project: **SUCCESS**;
- master Vercel: **SUCCESS**.

### Classification
**CENA-ADVANCE -> CENA-WATCH**

There is no unfinished visual delivery to resume. The next smallest player-visible gap is Mercado: it follows Operação in the current management loop and remains a Control-only surface without a dedicated 3D scene.

### Action
CENA-020 defines and persists the Market visual target only:
- research/provenance brief: `docs/visual-references/3js-market/README.md`;
- visual direction updated with the Market spatial/composition contract;
- CENA/3JS ownership clarified so CENA remains the visual authority while `3js` owns Three.js runtime implementation.

No runtime scene, gameplay, persistence, economy, generated Web artifact, canon or external asset is changed.

### Research
Reference-only:
- CADEG / Mercado Municipal do Rio de Janeiro: industrial covered aisle, structural rhythm, mixed overhead/stall lighting, crate/cart commerce silhouettes;
- COBAL heritage material: roof volume, ventilation/natural-light character, modernizable market boxes.

The result is an original fictional market/deal bay, not a literal real-place recreation.

### Next visual action
Route implementation to `3js`:
1. reconcile live repository state;
2. create a bounded `3JS-003` Market Spec Kit package;
3. inherit the accepted Grow Room style tokens;
4. implement the Market scene additively/reversibly;
5. capture 540x960 and 1080x1920;
6. return the rendered result to CENA for explicit `ACCEPT` or `REVISE`.

Until that runtime spec is dispatched, CENA-020 waits only on its own exact-head repository/provider checks and guarded merge.


## CENA-020 / 3JS-003 Market rendered acceptance — 2026-09-26

### Returned 3JS evidence
- stacked runtime PR: **#116**;
- accepted implementation head: `eb19bae48edbd5698ac09872e718dea9932cf810`;
- `Validate project` run `36267671834`: **SUCCESS**;
- `Three.js market visual acceptance` run `36267671810`: **SUCCESS**;
- artifact: `10914735544`;
- browser console/page-error artifact: **empty**;
- renderer evidence at 540x960 and 1080x1920: 36 draw calls, 944 triangles, 8 material families, 0 authored scene textures, DPR 1, shadows disabled.

### Rendered review
The scene satisfies CENA-020:
- immediate fictional Market read through counter/storage/aisle/loading/trolley silhouettes;
- Grow Room visual continuity in orthographic miniature framing, material family and warm/cool light grammar;
- distinct Market composition rather than a Grow Room clone;
- legible portrait composition with a quiet dark UI reserve;
- no copied real-business signage/branding and no operational trafficking/logistics detail;
- no obvious clipping or z-fighting.

### Decision
**ACCEPT**.

The implementation may advance toward delivery, but this persistence changes the branch head and therefore requires fresh exact-head validation. Parent PR #114 still carries an explicit Vercel quota/rate-limit soft gate, so delivery remains stacked and merge-deferred until the dependency is valid for merge.


## CENA-020 / 3JS-003 delivery closure — 2026-09-26

The previously recorded **ACCEPT** decision is now delivered to the default branch.

- CENA-020 target PR #114 merged to `master`.
- Stacked 3JS-003 PR #116 was accepted but initially merged only into the already-delivered parent branch.
- SIGA detected that history-only delivery gap and created recovery PR #118 against `master`.
- #118 passed all exact-head repository/rendered/Three.js gates plus Vercel and merged as `7f5c1d890f82296f9ea4ceab771a7154253b5a9f`.
- Post-merge Validate is **SUCCESS**.
- Post-merge Vercel is currently `SOFT_GATE_RATE_LIMIT`; no visual/runtime defect is indicated.

### Route
**CENA-ADVANCE**. Mercado is accepted and delivered. Select a new bounded visual slice only from fresh rendered/player-visible evidence; do not reopen this scene without regression evidence.


## CENA-021 — City visual target — 2026-09-27

### VERIFY-FIRST state
- repository: `az1nn/growing-rio`;
- base: `master@f402713d2e3b9003aa49bcefb944e1bbc91dd903`;
- prior 3JS-003/Mercado delivery and documentation closure are merged;
- Vercel on the #119 merge commit is **SUCCESS**;
- open PR scan at work claim: none;
- `scenes/city/city_surface.tscn` is still Control-only;
- `threejs/` contains Operation/Grow Room and Market implementations, but no City package.

### Route
**CENA-ADVANCE → CENA-WATCH**

Cidade is the next smallest coherent player-visible gap in the canonical surface order after delivered Mercado. CENA-021 defines the target and research boundary; 3JS owns the implementation.

### Visual contract
Create an original fictional topographic city miniature:
- foreground retaining/overlook edge;
- three stepped urban elevation bands;
- low-rise clustered massing plus restrained taller background silhouettes;
- vegetation/retaining breaks that separate clusters without labels;
- inherited DA LATA material family and orthographic portrait grammar;
- cool structural light with a restrained warm practical cluster;
- a quiet/dark UI reserve;
- no real map, district name, landmark, road, address, business, political institution or route information.

### Research
Reference-only:
- Wikimedia Commons dense hillside settlement in Rio de Janeiro;
- Wikimedia Commons hillside houses in Arraial do Cabo, Rio de Janeiro;
- ArchDaily, “Putting Rio de Janeiro on the map” (2026).

Full provenance/translation notes: `docs/visual-references/3js-city/README.md`.

### Provenance
- third-party runtime assets: **none**;
- copied reference images: **none**;
- runtime asset decision: repository-authored procedural geometry only for the first 3JS-004 candidate.

### Next action
Route to **3JS-004**:
1. create bounded Spec Kit package;
2. implement an isolated `threejs/city/` package on top of this visual contract;
3. preserve gameplay/domain/save semantics;
4. capture 540x960 + 1080x1920 with renderer metrics and empty console evidence;
5. return exact-head rendered evidence to CENA for **ACCEPT** or **REVISE**.


## CENA-021 implementation dispatch — 3JS-004 — 2026-09-27

- CENA-021 visual target is delivered on `master@473cef46e4dd9926c1033318b7ad97cc05c68c41`.
- 3JS-004 has materialized the target under `threejs/city/` using repository-authored procedural geometry only.
- Candidate structure: stepped terrain, retaining/overlook edge, instanced fictional urban clusters, restrained skyline silhouettes, vegetation breaks, cool structural light and one warm neighborhood-practical cluster.
- Presentation remains non-map and fictional: no real district geometry, roads, routes, addresses, landmarks, institutions or civic guidance.
- Current visual state: **CANDIDATE**.

### CENA gate
Do not infer acceptance from source or CI alone. Require exact-head 540x960 + 1080x1920 rendered evidence with empty browser errors and budget pass, then record exactly **ACCEPT** or **REVISE**.


## CENA-021 first 3JS-004 review — 2026-09-27

### Evidence reviewed
- 3JS-004 head `6d44fd5470d326c026d999832fcb0c99916e50c3`;
- artifact `10928517376`;
- 540x960 + 1080x1920 rendered captures;
- 23 draw calls, 708 triangles, 8 materials, 0 authored textures, DPR 1, shadows disabled;
- empty browser console/page-error evidence.

### Decision
**REVISE**

The overall fictional hillside-city direction is coherent with CENA-021 and the accepted DA LATA grammar. The blocking visual defect is the large near-black `QuietZoneFrame` slab at frame-left: it reads as scene geometry/occlusion rather than negative UI space.

Revision 1 should only remove that visual obstruction by reducing it to a low edge. Do not redesign the camera, palette, skyline, terrain bands or material system unless the next rendered evidence exposes a new defect.


## CENA-021 Revision 1 — accepted — 2026-09-27

### Reviewed evidence
- runtime head: `7f25b29cee5f57e99526ef63cd1e9d47e923bd98`;
- artifact: `10928746311`;
- 540x960 and 1080x1920 renders inspected;
- 23 draw calls, 708 triangles, 8 materials, 0 authored textures, DPR 1, shadows disabled;
- empty browser console/page-error evidence.

### Decision
**ACCEPT**

The frame-left occlusion is removed. Cidade now reads as an original fictional topographic urban miniature through stepped bands, clustered blocks, vegetation breaks, overlook edge and restrained skyline. The quiet UI reserve remains legible without being authored as a giant scene wall. Grow Room / Mercado style continuity is preserved without copying either layout.

No additional visual mutation is requested before delivery. Any acceptance-status persistence still requires fresh exact-head automated/provider gates before merge.

## CENA-021 / 3JS-004 delivery reconciliation — 2026-09-27

### Delivered visual state
- CENA Revision 1 decision remains **ACCEPT**.
- Accepted runtime evidence: `7f25b29cee5f57e99526ef63cd1e9d47e923bd98`, artifact `10928746311`.
- Final delivery PR #121 subsequently reached head `a65d6f22cdd1834e9fc029ec1361ded914d57423` with all applicable repository/Three.js visual workflows green.
- PR #121 merged to `master` as `673da3f0158061537fb633a5e64fee77ae02036d`.
- Vercel on that merge commit is **SUCCESS**.
- Current `master@2cf90ce4d99198575212f1e42706eb2e8b694370` retains the City package; later Feature 009 work is unrelated to the accepted composition.

### Route
**CENA-ADVANCE** for visual product work.

Cidade is accepted and delivered. The open issue #122 is closure bookkeeping only and must not be interpreted as a request for another visual revision. PR #134 persists this fact while avoiding the concurrently edited `docs/SIGA-HANDOFF.md` path.



## CENA-010 — Godot Market 3D canonical pass — 2026-09-28

### Verified entry state
- canonical repository: `az1nn/growing-rio`;
- base: `master@365256bc7b27338e8041136161e8cecee154b94d`, after PR #153 fixed exact-checkout Vercel Web export;
- user device inspection confirmed the first Godot 3D layer is now visible;
- remaining defect: Market/City/Institutional/Archive still relied on the generic three-primitive `interactive_context_3d` blockout, and its activation only pulsed an object.

### Route
**CENA-ADVANCE -> CENA-WATCH**

The next bounded player-visible slice is Mercado because CENA-020 / 3JS-003 already has an accepted Market composition in this repository. This wave ports that accepted visual grammar into the canonical Godot runtime rather than inventing a competing direction.

### Implementation
- branch: `feat/cena-010-contextual-3d-scenes`;
- new `scenes/visual/market_diorama.tscn` + controller;
- authored Godot-native geometry for:
  - market shell and structural posts;
  - deal counter, contract tray and warm practical;
  - vendor bay and shelving;
  - crate cluster;
  - loading-bay rhythm;
  - trolley;
- dedicated orthographic camera, WorldEnvironment, cool key + warm practical;
- pointer/touch collision over the deal counter plus accessible button fallback;
- Market surface reserves a real top-of-screen 3D viewport instead of rendering the scene behind a full-screen ScrollContainer;
- activating the 3D counter now routes the player to the actual channels/contracts section instead of only pulsing the mesh;
- new `tests/market_3d_diorama_test.gd` locks the player-visible viewport footprint, geometry floor, pointer contract, accessible fallback and canonical `market/deal_counter` activation;
- CI suite includes the new regression.

### Provenance
- runtime assets: repository-authored Godot primitives/materials only;
- visual source: previously accepted in-repository CENA-020 / 3JS-003 Market composition;
- third-party runtime assets: none;
- copied external reference imagery: none;
- license-unknown assets: none.

### Validation gate
Before delivery:
1. exact-head `Validate project` / regression suite must pass;
2. exact-head Vercel build must prove Godot Web export from the same checkout;
3. mobile/portrait visual inspection must confirm the Market scene is unmistakably 3D and the UI remains readable;
4. a real click/tap on the counter or fallback button must expose the Market channels/contracts section.

### Next visual action
If CENA-010 passes, port the already accepted City composition into a dedicated Godot City diorama next, then continue with Institutional and Archive. Do not certify the four-screen objective complete until each context has a distinct player-visible 3D composition and useful interaction evidence.

## CENA-022 — Institutional visual target / 3JS-005 dispatch — 2026-09-28

### VERIFY-FIRST state
- repository: `az1nn/growing-rio`;
- claim base: `master@a8d1c3efae578e1325cd69783108a4f0aa5747b9`;
- 3JS-004 City is delivered and remains ACCEPT;
- Grow Room remains the accepted Three.js style lock;
- next canonical surface after City is Institutional;
- PR #148 / `feat/3js-005-institutional` owns task key `3JS-005`;
- post-claim overlap barrier: **CLEAR / PARALLEL_SAFE**;
- Feature 009 work owns `docs/SIGA-HANDOFF.md`, so CENA/3JS-005 does not edit that path.

### Route
**CENA-ADVANCE → CENA-WATCH**

CENA-022 defines the visual target and immediately routes runtime materialization to 3JS-005. The final scene remains CANDIDATE until exact-head rendered evidence is inspected.

### Visual contract
Create an original fictional administrative/civic forum with:
- public threshold and low waiting bench;
- generic participation desk;
- three equal proposal pedestals;
- archive/storage rhythm;
- abstract process rails;
- balanced cool/warm lighting;
- inherited DA LATA material family and orthographic portrait grammar;
- dark UI reserve.

### Political neutrality / fiction boundary
No proposal is visually ranked or recommended. No real institution, government body, party, election, ballot, law, politician, flag, seal, map, advocacy message or targeted persuasion is represented. Three.js must not contain policy semantics or decision logic.

### Next action
3JS implements the bounded candidate under `threejs/institutional/`, validates exact-head 540x960 + 1080x1920 captures and returns rendered evidence to CENA for exactly **ACCEPT** or **REVISE**.


## CENA-022 / 3JS-005 implementation dispatch — 2026-09-28

3JS-005 has materialized the Institutional target on PR #148.

Candidate structure:
- fixed orthographic fictional administrative/civic forum;
- public threshold + waiting bench;
- generic participation desk;
- three equal instanced proposal pedestals;
- archive/storage wall rhythm;
- abstract process rails and restrained decor;
- symmetric warm practicals so no proposal receives privileged lighting;
- accepted DA LATA material family;
- zero authored textures and no dynamic shadows.

Political/neutrality boundary remains explicit: no real institution, party, election, ballot, law, politician, symbol, advocacy or policy recommendation; no policy semantics are encoded in Three.js.

### CENA gate
Current visual state: **CANDIDATE**.

Require exact-head 540x960 + 1080x1920 rendered evidence, empty browser errors and budget pass. Then inspect composition, equal-treatment neutrality, portrait hierarchy and style continuity and record exactly **ACCEPT** or **REVISE**.


## CENA-022 / 3JS-005 rendered acceptance — 2026-09-28

### Recovered exact-head evidence
- evaluated branch head before master reconciliation: `83d0a9d32f80a32446eb54d320742b493080d803`;
- repository became public, restoring GitHub-hosted Actions capacity;
- rerun Validate project #700: **SUCCESS** with executable job steps;
- rerun Three.js institutional visual acceptance #2: **SUCCESS**;
- 540x960 and 1080x1920 renders inspected;
- browser console/page-error artifact: **empty**.

### Decision
**ACCEPT**.

The fictional civic forum reads clearly as 3D through the public threshold, low bench, participation desk, equal proposal pedestals, archive/storage rhythm and process rails. Warm practicals remain symmetric, no proposal receives visual preference, and no real institution, party, election, ballot, law, politician, flag, seal, map, advocacy message or policy recommendation is represented.

### Delivery state
Acceptance proves the authored 3JS-005 candidate. The branch must still be reconciled with current `master` and revalidated on its resulting exact head before merge.


## CENA-017 final certification closure — 2026-09-29

### Verified delivery
- Repository: `az1nn/growing-rio`.
- PR #172 merged into `master` as `33f97bcd8e5fb0e48e36ea67b501631f9290a797`.
- Validate project #818 / `36596189406`: **SUCCESS**.
- Visual acceptance #369 / `36596189548`: **SUCCESS**.
- Artifact `11046242559`: 22 portrait PNGs covering Operation, Market, City, Institutional, Archive, Campaign, Narrative, Finale selection/handoff, and Coda/recap at 540x960 and 1080x1920; browser-console/page-error file empty.
- Artifact digest: `sha256:c16d3d0df04b03a8c4c8c223f7cc70f493c577c97861b52418ba9542679e89e7`.
- Vercel status on the certified master commit: **SUCCESS**.
- No corrective runtime slice was required; all nine canonical certification rows are **ACCEPT**.

### Route
**CENA-ADVANCE** — CENA-017 is closed. Do not reopen the certification absent new regression evidence. The next visual task must be a new bounded claim derived from current product priorities.


## CENA-023 — Archive visual target / 3JS-006 dispatch — 2026-09-29

### VERIFY-FIRST state
- repository: `az1nn/growing-rio`;
- base: `master@8d60d7255bcd34cf824f04f4a1e692a52981eb0f`;
- Feature 010 / CENA-017 is closed;
- no open PR existed when the new visual target was selected;
- PR #176 / `feat/3js-006-archive` is the deterministic owner of `CENA-023+3JS-006`;
- mandatory post-claim overlap barrier: **CLEAR**;
- Three.js covers Operation/Grow Room, Market, City and Institutional; Archive is the remaining canonical top-level continuity gap.

### Route
**CENA-ADVANCE -> CENA-WATCH**

CENA-023 defines the Archive target and routes implementation to 3JS-006.

### Visual contract
Use the existing canonical Godot Archive as the semantic composition authority:
- evidence desk/tray as the main focal object;
- shelves and storage modules for archival rhythm/depth;
- abstract document/evidence forms;
- uncertainty/evidence rail;
- cool structural lighting with one restrained warm desk practical;
- accepted DA LATA fixed orthographic miniature and material grammar.

No research completion, evidence mutation, provenance authentication, narrative resolution, canon mutation or real-world cultivation detail may exist in the Three.js scene.

### Persisted progress
- `specs/3js-006-archive-continuity/spec.md` created;
- implementation plan created;
- task ledger created with T001-T003 complete;
- internal provenance/translation notes created at `docs/visual-references/3js-archive/README.md`.

### Next action
3JS-006 executes T004-T009: isolated Archive package, renderer contract, validator and exact-head portrait visual acceptance. Return rendered evidence to CENA for exactly **ACCEPT** or **REVISE**.


### CENA-023 / 3JS-006 rendered acceptance — 2026-09-29

Reviewed exact runtime head: `0b2c9b79f0e038a2a87817260c04665095c77619`.

Evidence:
- Validate project #841 / run `36624016711`: **SUCCESS**;
- Three.js Archive visual acceptance #2 / run `36624016700`: **SUCCESS**;
- artifact `11059757870`, digest `sha256:e338a4760d911f50787ccfc574ec5b7b8c1571b7c425d2da3cba860c7fd795ea`;
- 540x960 + 1080x1920 captures inspected;
- browser console/page-error evidence: **empty**;
- both sizes: 21 draw calls, 360 triangles, 7 material families, 0 authored scene textures, DPR 1, dynamic shadows disabled.

Decision: **ACCEPT**.

The evidence desk/tray remains the clear foreground focal point, archival shelves/boxes establish the memory-storage read, the teal uncertainty rail is legible without claiming evidentiary certainty, and the warm desk practical separates the review area from the cool structural envelope. The scene is compositionally distinct from the prior Three.js surfaces while remaining inside the accepted DA LATA miniature grammar. No clipping or portrait hierarchy defect requires revision.

The final delivery head still requires a fresh exact-head rerun after acceptance bookkeeping and temporary-claim removal; acceptance does not waive that gate.


## R05 Market V1 — Candidate 1 review / Candidate 2 route — 2026-10-03

### Reconciled evidence
- repository: `az1nn/growing-rio`
- PR: #205 / `feat/012-r05-market-v1`
- reviewed exact head: `164746808577bb0ea3a080ddc283da557bf4b471`
- Validate: run `37072634586` — **SUCCESS**
- bounded Visual Acceptance: run `37072634711` — **SUCCESS**
- Vercel: **SUCCESS**
- captured browser console errors: **0**

### ARTIST/CENA decision
**CENA-RESUME / IMPLEMENTATION_REVISE (STRUCTURAL).**

The current Market is mechanically sound but remains materially distant from the accepted ARTIST target. The gap is composition and authored scene information, not missing CI.

### Candidate 2 scope
- tighten orthographic portrait framing to remove blockout-distance read;
- apply shared V1 2× nearest-neighbor scene pixel policy;
- add one original stylized vendor silhouette behind the canonical counter;
- populate the existing vendor shelving with original low-cost package silhouettes;
- convert the Market channel focal into a large physical board with authored color rows;
- reduce the awning depth/occlusion so crown/graffiti/signage can read;
- preserve `market/deal_counter`, `market/contract_tray`, Market domain state and all accessibility fallbacks.

All new runtime geometry is original Godot primitive geometry. No third-party runtime asset is introduced.

### Next gate
Run exact-head repository/Godot validation and bounded 540×960 + 1080×1920 capture on Candidate 2; then compare against the accepted concept. No R05 PASS without ARTIST/CENA runtime ACCEPT.


## R05 Market V1 — Candidate 2 review / Candidate 3 structural rebase — 2026-10-03

### Candidate 2 exact-head
- head: `1362316e567f6b67581aa5c52e67980af62256c3`
- Validate: `37121398087` — **SUCCESS**
- Visual Acceptance: `37121398014` — **SUCCESS**
- Vercel: **SUCCESS**
- console errors: **0**

### Decision
**IMPLEMENTATION_REVISE / STRUCTURAL_REBASE_REQUIRED.**

Candidate 2 improved pixel treatment, vendor presence and shelf density, but the broad awning still occludes the identity wall, the channel board remains edge-cropped and the camera still reads as an elevated blockout rather than the accepted dense storefront target.

### Candidate 3 rebase
- retire the rejected broad awning from visible production composition;
- introduce `MarketV1AcceptedRebuild` with exposed lightweight ceiling beams and a dark mural field;
- author DA LATA / MARKET copy in-engine via Label3D instead of generated image text;
- bring the physical channel board inward and author abstract channel labels in-engine;
- shift to a lower, tighter, more frontal orthographic camera;
- preserve the accepted vendor/shelf/crate/counter visual anchors and all existing interaction semantics.

No third-party runtime asset is introduced.


## R05 Market V1 — Candidate 3 review / Candidate 4 bounded correction — 2026-10-03

### Exact-head
- head: `31bed312e04a17800250cb76abe48c0f8d7c3db2`
- Validate: `37121837958` — **SUCCESS**
- Visual Acceptance: `37121838020` — **SUCCESS**
- Vercel: **SUCCESS**
- console errors: **0**

### Decision
**CENA-RESUME / IMPLEMENTATION_REVISE (bounded).**

The structural rebase is retained. Candidate 4 changes only:
- hide the superseded legacy roof header that crosses the wordmark;
- move/shrink the authored wordmark for full portrait legibility;
- move the channel board inward and reduce its copy scale;
- tighten the camera slightly;
- extend the foreground floor toward the camera so the lower 20–25% remains a calm game-world safe band rather than black void.

No new mechanics, domain behavior, third-party asset or architecture change.


## R05 Market V1 — Candidate 4 review / Candidate 5 final bounded pass — 2026-10-03

### Candidate 4 exact-head
- head: `a51da684452ccc74211147f46e730f025aa22331`
- Validate: `37122154920` — **SUCCESS**
- Visual Acceptance: `37122154930` — **SUCCESS**
- Vercel: **SUCCESS**
- console errors: **0**

### Decision
**CENA-RESUME / IMPLEMENTATION_REVISE (bounded final legibility pass).**

Only the identity sightline remains materially wrong: legacy roof posts bisect the DA LATA / MARKET wordmark and crown.

### Candidate 5 scope
- retire only the two legacy roof posts that cross the mural identity;
- reposition crown/wordmark inside the accepted mural field;
- add one lightweight warm pendant cue using existing materials;
- preserve camera, floor, channel board, vendor, shelves, crates, hotspots, UI and domain behavior.

If exact-head render is clean, return `READY_FOR_HUMAN_RUNTIME_GATE`. Do not mark runtime ACCEPT without explicit human sign-off.


## R05 Market V1 — production-asset convergence / human runtime gate — 2026-10-03

### Final reviewed runtime head before bookkeeping
- head: `afb733167ec26bd16dc24710e23f33084993bb0e`
- Validate: `37123975673` — **SUCCESS**
- Visual Acceptance: `37123975676` — **SUCCESS**
- artifact: `11274223719`
- Vercel: **SUCCESS**
- console errors: **0**

### Target-relative convergence
After Candidate 5, CENA/SIGA did not self-accept the remaining blockout gap. The same R05 item received a bounded production-asset pass:
- original SVG mural/poster/rug/crate-label texture surfaces;
- denser storefront product and foliage dressing;
- tighter, more frontal portrait framing;
- restored visible vendor silhouette;
- green neon leaf signature;
- warm shelf/entry/string-light cues against the cool structural shell;
- no gameplay, save, economy, hotspot or accessibility contract changes.

### Decision
**READY_FOR_HUMAN_RUNTIME_GATE**.

This is explicitly not `ACCEPT`. Human runtime review must return exactly `ACCEPT` or `REVISE`. Until then PR #205 remains Draft and R06+ remain locked.


## CENA R06 City Candidate 4 — 2026-10-04

### Reconcile
- repository: `az1nn/growing-rio`
- active delivery: PR #213 / `feat/012-r06-city-v1`
- roadmap item: R06 City V1 only; R07+ remain locked
- accepted visual authority: `20261004T110406Z/city`
- route: `CENA-RESUME` → Candidate 4 structural convergence

### Implemented
Candidate 4 stays entirely inside native Godot presentation:
- added `Candidate4AuthoredDensity/FacadeRelief` for worn facade paint/patch rhythm;
- added `Candidate4AuthoredDensity/MuralFocal` with a large dark mural field and readable cyan/magenta/amber crown/stroke geometry;
- added `Candidate4AuthoredDensity/ShopfrontCluster` with awnings, shutters, warm windows, crates, utility poles and cable runs;
- added `Candidate4AuthoredDensity/FarCityLayer2` to prevent the background from collapsing into empty dark space;
- increased static City mesh detail from 330 to 376 MeshInstance3D nodes;
- added regression paths/tokens and a Candidate 4 authored-density floor in `tests/city_3d_diorama_test.gd`.

### Preserved
- Camera3D framing and viewport policy;
- semantic IDs `city/district_overlook`, `city/route_nodes`, `city/community_cluster`;
- gameplay/state/persistence;
- DA LATA UI V1 and portrait command band;
- Godot Compatibility/Web renderer and existing material vocabulary;
- no third-party runtime assets and no new canon.

### Provenance
All Candidate 4 geometry is original Godot-native BoxMesh composition using existing project materials. Third-party assets: none. License/attribution debt: none.

### Gate
Implementation is not runtime-accepted yet. Required next evidence:
`Validate → Visual Acceptance → LENTE (540×960 + 1080×1920) → ARTIST/CENA target-relative review`.

R07+ remain locked until explicit human runtime `ACCEPT`.


## CENA R06 City Candidate 6 — 2026-10-04

### Candidate 5 evidence consumed
- exact head: `8e860843f74209cad8da62f67333ff3d2760d426`
- Validate `37237100452`: SUCCESS
- Visual Acceptance `37237100475`: SUCCESS
- LENTE `37237100411`: SUCCESS / evidence complete
- Vercel: READY
- target-relative decision: `REVISE / TARGET_COMPOSITION_RECOMPOSE_REQUIRED`

### Candidate 6 bounded recompose
- camera occupancy tightened from orthographic size 9.45 → 8.10;
- cool-night ambient/key/fill lifted without switching to daylight/neon;
- added a large authored mural gateway in the mid-field;
- added foreground player, five neighborhood figures, plants/planters and larger shop awnings;
- strengthened stair side framing + practical route lights;
- added a taller six-mass far skyline band with warm depth cues;
- preserved gameplay/state/persistence, the three semantic hotspot IDs, DA LATA UI V1 and native Godot 3D.

### Gate
Run exact-head Validate → Visual Acceptance → LENTE at 540×960 and 1080×1920. No runtime ACCEPT is claimed until actual Candidate 6 pixels are inspected against `20261004T110406Z/city`.


## CENA R06 City Candidate 7 — 2026-10-04

### Reconcile
- repository: `az1nn/growing-rio`
- delivery: PR #213 / `feat/012-r06-city-v1`
- accepted target: `20261004T110406Z/city`
- Candidate 6 exact head: `2139ecb087325160ca137aed0aefb796ef127822`
- Candidate 6 gates: Validate `37240913345` SUCCESS; Visual Acceptance `37240913347` SUCCESS; LENTE `37240913341` SUCCESS
- decision: `REVISE / STREET_PERSPECTIVE_AND_AUTHORED_SURFACE_REQUIRED`

### Candidate 7 bounded implementation
- moved the native Godot camera from diagonal-isometric toward the descending stair corridor;
- lifted cool-night ambient/key readability without converting to daylight/neon;
- added authored foreground facades with patch rhythm and a large mural field;
- added balcony/shopfront depth, hanging laundry, market stalls, residents and foreground vegetation;
- preserved gameplay/state/persistence, all three semantic hotspot IDs, DA LATA UI V1 and real Godot 3D;
- raised structural regression to pin Candidate 7 paths/tokens and density.

### Gate
Run exact-head Validate → Visual Acceptance → LENTE at 540×960 and 1080×1920. Inspect actual pixels against the accepted concept before any runtime ACCEPT. R07+ remain LOCKED.


## R06 City — no-low-poly correction

**State:** `CENA-REJECT_LOW_POLY / VISUAL_CONSTRUCTION_REBASE_REQUIRED`

Candidate 7 exact head `5e4387d9a58e57ef8597bb99c25d813d622aefce` is not an acceptable V1 visual baseline. Although its camera/composition and engineering gates improved, the rendered City still materially reads as a low-poly miniature. That condition is now a hard rejection under ARTIST/CENA/VISUAL-DIRECTION and must not be treated as a normal incremental convergence pass.

The previously stated Candidate 8 instruction is superseded wherever it can be read as “refine the existing low-poly approach.” Candidate 8 must instead rebase the visible construction strategy while preserving gameplay and semantic anchors.

Required:
- preserve accepted concept `20261004T110406Z/city` as the immutable target;
- preserve camera corridor, gameplay/state/persistence, semantic hotspot IDs, DA LATA UI V1 and Godot-native real 3D;
- stop using visible primitive-box / smooth color-block architecture as the production visual language;
- replace the low-poly read with authored pixel-art surface/material treatment, patched masonry/tile/metal, non-generic facade silhouettes, readable mural/graffiti planes, lived-in props/vegetation/residents and layered urban depth;
- primitives may remain only as hidden/internal structural scaffolding when the rendered output no longer reads low-poly.

Forbidden corrective loop:
`more boxes → more primitive density → lighting tweak → call it next candidate`.

Required loop:
`accepted concept → authored asset/material strategy → rendered exact-head evidence → ARTIST target-relative review`.

Any next screenshot that still materially reads low-poly must be classified `REJECT / LOW_POLY_FORBIDDEN` immediately, regardless of CI status.


## ARTIST R06 Candidate 8 hard reject

**State:** `REJECT / LOW_POLY_FORBIDDEN`

Reviewed Candidate 8 implementation head: `df5a05ee4f7fe2ee549311f4f7ee8b393680b6c4`.

Exact-head Validate, City visual acceptance, Visual Acceptance, LENTE and Vercel all succeeded, but the player-facing render still materially reads as low-poly: flat primitive facades, smooth color-block masses, symbolic primitive residents/vegetation/clutter and insufficient authored pixel-textured masonry/graffiti surface language.

This is a hard visual reject under the canonical V1 gate. Do not continue the numeric candidate loop by adding primitives.

### Blocking test correction

Candidate 8 added a regression requirement of `>=650 MeshInstance3D`. That is not a valid visual-quality metric and actively incentivizes the rejected strategy.

Next CENA implementation must:
- remove primitive/mesh-count growth as an art acceptance proxy;
- stop using additional BoxMesh density as the corrective mechanism;
- introduce authored production facade/material/texture treatment and non-generic silhouettes;
- preserve gameplay/state/persistence, semantic hotspot IDs, DA LATA UI V1, camera corridor and real Godot 3D;
- return exact-head LENTE evidence only after the visible scene no longer reads low-poly.

Required route:
`ACCEPTED CONCEPT → VISUAL CONSTRUCTION REBASE → RUNTIME → LENTE → ARTIST`.

No new City concept is needed. R07+ remain locked.


## 2026-10-05 — R06 Candidate 8 hard rejection / Candidate 9 construction rebase

Candidate 8 exact implementation head `df5a05ee4f7fe2ee549311f4f7ee8b393680b6c4` completed Validate `37305099781`, Visual Acceptance `37305099787` and LENTE `37305099792` successfully. Visual artifact `11343298226` and LENTE artifact `11343537336` were inspected at 540×960 and 1080×1920 with zero browser-console errors.

**Decision:** `REJECT / LOW_POLY_FORBIDDEN`.

The stair-led composition is stronger, but the rendered City still visibly consists of smooth primitive/color-block architecture. Under the locked ARTIST/CENA/VISUAL-DIRECTION rule, this is a hard failure and cannot be promoted by adding more boxes or another lighting-only pass.

**Candidate 9 executed:** visible construction strategy rebased while preserving the R06 gameplay fence. Candidate 8's flat facade/graffiti/far-depth presentation is demoted from visible authority; new authored pixel-surface assets provide patched masonry, worn paint, tile, metal shutters, mural/graffiti and roof breakup. Candidate 9 uses textured QuadMesh facade skins plus ArrayMesh irregular roofline silhouettes, not a new BoxMesh density loop. Semantic hotspot IDs, gameplay/state/persistence, DA LATA UI V1, camera corridor and Godot-native 3D remain preserved.

**NEXT:** consume exact-head Candidate 9 Validate → Visual Acceptance → LENTE at both portrait sizes. ARTIST must immediately return `REJECT / LOW_POLY_FORBIDDEN` if the resulting screenshot still materially reads as low-poly. R07+ remain LOCKED.


## R06 City Candidate 9 rejection / Candidate 10 presentation rebase — 2026-10-05

Candidate 9 exact head `56bfd8426b2dea1393c1338c94b93736bf2eac42` passed Validate `37308810278`, Visual Acceptance `37308810007`, Vercel and the auxiliary scene gates. Visual artifact `11344518689` was inspected at 540×960 and 1080×1920. LENTE `37308810051` was superseded/cancelled after the hard visual decision.

**Decision:** `REJECT / LOW_POLY_FORBIDDEN`.

Authored surface textures improved material breakup, but the visible architecture still read as primitive-box massing. Candidate 10 therefore replaces the dominant presentation strategy rather than adding geometry: legacy Buildings/BackdropDepth and Candidate4–9 presentation layers are visually demoted, while transparent nearest-filtered pixel-art facade cards, irregular building silhouettes, graffiti focal cards, layered far-city strips and lived-in street clusters are placed on distinct 3D depth planes around the preserved stair corridor.

Preserved: native Godot 3D world, StairSpine, ground, camera corridor, semantic IDs/hitboxes, gameplay/state/persistence and DA LATA UI V1. Candidate 10 contains no corrective BoxMesh construction.

**NEXT:** exact-head Validate → Visual Acceptance → LENTE → ARTIST target-relative review. Any remaining material low-poly read is an immediate hard rejection. R07+ remain LOCKED.


## R06 City Candidate 11 exact-head review — 2026-10-05

Candidate 11 exact head `e9e5b9aed409f8c790d93141de8a980bf80a3e11` passed Validate `37311118312`, Visual Acceptance `37311118411`, Vercel and the auxiliary visual gates. Visual artifact `11345487303` was inspected at 540×960 and 1080×1920 against accepted concept `20261004T110406Z/city`. LENTE `37311118393` was still running when the target-relative decision became conclusive.

**Decision:** `IMPLEMENTATION_REVISE / AUTHORED_ASSET_PIPELINE_REQUIRED`.

Positive: the dominant low-poly read is gone; stair-led vertical composition, graffiti color rhythm and layered 2.5D depth are materially closer to the accepted direction.

Remaining material gap: near/mid facades, residents, plants and commerce read as deliberately simplified flat pixel cards rather than production-authored urban forms. The accepted target requires denser patched masonry/tile/metal detail, richer silhouettes, believable resident/vegetation scale and stronger foreground→midground→background depth. Candidate 11 therefore must not be promoted to human runtime ACCEPT.

**NEXT:** open the next append-only ARTIST/CENA production session for City and create/source production-grade pixel/graffiti facade, resident, vegetation and shop assets with provenance; then integrate those assets into the existing Candidate10/11 3D depth scaffold. Do not return to primitive geometry. R07+ remain LOCKED.


## R06 City — Candidate 11 human semi-approve

**Human verdict:** `SEMI_APPROVE`  
**ARTIST mapping:** `IMPLEMENTATION_REVISE / FINAL_POLISH_ONLY`  
**Preserved runtime baseline:** `e9e5b9aed409f8c790d93141de8a980bf80a3e11`

Candidate 11 is close to acceptance and is now the visual baseline that future work must preserve.

Do not rebase composition, camera, stair corridor or palette. Do not return to low-poly/primitive convergence and do not replace the accepted City concept. The next CENA slice is bounded final polish only: authored facade material/weathering, residents, vegetation, shop/street props and graffiti/mural richness.

Any next candidate must show a strict visual delta from Candidate 11 without regressing its approved-near composition.

R07+ remain locked until explicit human `ACCEPT`.


## R06 City — Candidate 12 final revise

**Human intent:** último revise antes de provável `ACCEPT`.  
**Baseline preservada:** Candidate 11 / `e9e5b9aed409f8c790d93141de8a980bf80a3e11`.  
**Scope:** `FINAL_POLISH_ONLY`.

Candidate 12 não altera câmera, corredor de escada, composição, gameplay, estado, persistência, hotspots ou direção de paleta. O delta é somente acabamento autoral:
- weathering/materialidade adicional sobre fachadas já aprovadas;
- reforço de mural/graffiti em escala de leitura;
- props urbanos/comerciais;
- vegetação mais orgânica;
- cluster adicional de moradores;
- remoção dos antigos floors de contagem de meshes como proxy de qualidade visual.

O gate continua sendo visual: Validate → Visual Acceptance → LENTE → comparação Candidate 11 vs Candidate 12 vs concept aprovado. R07+ continuam bloqueados até `ACCEPT` humano.


**Candidate 12 staging closure:** implementation + authored assets + regression contract assembled atomically for promotion to PR #213.


## R06 City — Candidate 12 human hard reject

**Exact runtime head:** `984967cb8f3448ba6d26309a0f6f0d665acae14c`  
**Human verdict:** `REJECT / LOW_POLY_FORBIDDEN`

The previous `SEMI_APPROVE` of Candidate 11 was provisional. Candidate 12's human review identifies the player-facing runtime as still low-poly, so all prior agent recommendations to accept Candidate 12 are superseded.

### Canonical state

- Candidate 12: rejected.
- Candidate 11/12: not accepted visual baselines.
- Green CI/LENTE does not override the human visual gate.
- `FINAL_POLISH_ONLY` is revoked for the current construction strategy.
- Required next state: `VISUAL_CONSTRUCTION_REBASE_REQUIRED`.

### Preserve

Keep the accepted City concept `20261004T110406Z/city`, gameplay/state/persistence, three semantic hotspot IDs, DA LATA UI V1 and native Godot 3D interaction.

### Change

Do not keep stacking flat pixel cards or primitive-derived presentation and call it polish. The next CENA implementation must materially change the player-facing asset/construction strategy until the runtime no longer reads as low-poly to human review.

R07+ remain locked until explicit human `ACCEPT`.


## R06 City — Candidate 13 volumetric construction rebase dispatched

**Route:** `RESUME / VISUAL_CONSTRUCTION_REBASE_REQUIRED`  
**Rejected runtime:** Candidate 12 / `984967cb8f3448ba6d26309a0f6f0d665acae14c`  
**Consumed exact-head state:** `0a5ee01c0cb39bb70078ebc68e3dc4253989aa1c` — Validate, Visual Acceptance, Vercel and LENTE `37332944888` all terminal SUCCESS.

The human `REJECT / LOW_POLY_FORBIDDEN` is the visual authority. Candidate 13 changes construction rather than adding another card/polish layer: dominant Candidate 10–12 facade/mural cards are demoted; near/mid architecture becomes textured, lit, extruded custom ArrayMesh geometry with irregular roof silhouettes, real facade depth, balcony/shutter/awning relief and mural relief; visible box-step geometry is replaced by textured authored step volumes; perspective depth replaces the flattened orthographic presentation. No corrective BoxMesh or new flat-card facade construction is introduced.

Preserved: accepted City concept `20261004T110406Z/city`, gameplay/state/persistence, semantic IDs `city/district_overlook`, `city/route_nodes`, `city/community_cluster`, DA LATA UI V1 and native Godot interaction.

**NEXT:** exact-head Validate → Visual Acceptance → LENTE → ARTIST target-relative review. R07+ remain LOCKED. If real pixels still read low-poly, reject immediately and continue the construction rebase rather than relabeling it as polish.


## CENA R06 City — Candidate 17 authored production consolidation — 2026-10-07

### Reconcile
- repository: `az1nn/growing-rio`
- delivery: PR #213 / `feat/012-r06-city-v1`
- consumed ARTIST review head: `6ea714c1402161b5e4158b62ff86b502aa95c4b5`
- accepted concept: `20261004T110406Z/city`
- decision consumed: `IMPLEMENTATION_REVISE / LOW_POLY_FORBIDDEN / VISUAL_CONSTRUCTION_REBASE_REQUIRED`
- route: **CENA-RESUME**

### Implemented
Candidate 17 replaces the live multi-candidate stack with one authored production stack:
- `_ready()` now executes runtime recovery then Candidate 17 only;
- rejected Candidate 11/12/14/15/16 implementations remain historical source/spec evidence and are not rebuilt live;
- new original assets:
  - `assets/city/v1/c17-facade-warm.svg`
  - `assets/city/v1/c17-facade-cool.svg`
  - `assets/city/v1/c17-shopfront.svg`
  - `assets/city/v1/c17-mural-pixo.svg`
  - `assets/city/v1/c17-far-neighborhood.svg`
- near/mid/upper architecture uses irregular textured ArrayMesh silhouettes with patch relief, shopfront depth, balconies, awnings, service pipes, roof breakup and embedded mural/pixo;
- City gains a 22-step vertical stair spine, authored residents, vegetation, cables, activity node and a volumetric far-neighborhood ridge;
- portrait layout allocates more vertical area to the game scene and moves the three DA LATA action buttons below it;
- all three existing semantic interaction IDs and accessibility fallbacks remain unchanged.

### Provenance
All Candidate 17 assets and geometry are original repository-authored work. Third-party runtime assets: **none**. License-unknown assets: **none**. Attribution requirements: **none**.

### Quality/runtime fence
Candidate 17 regression explicitly forbids flat-card/primitive-box corrective construction, requires the five authored production assets, requires the single live Candidate 17 stack and fails if rejected Candidate 14–16 runtime roots are rebuilt.

### Gate
Implementation is **not accepted yet**. Required exact-head sequence:
`Validate → City Visual Acceptance → Visual Acceptance / responsiveness → LENTE → ARTIST → human runtime gate`.

R06 remains CURRENT. R07+ remain LOCKED.


## R06 City Candidate 17 bounded polish — 2026-10-07

### Reconcile
- repository: `az1nn/growing-rio`
- delivery: PR #213 / `feat/012-r06-city-v1`
- accepted City concept: `20261004T110406Z/city`
- ARTIST input head: `b8c06e4eaae2c166e52369bf9c5b95ba73cc60ac`
- ARTIST decision: `IMPLEMENTATION_REVISE / LOW_POLY_VETO_CLEARED / TARGET_DENSITY_COMPOSITION_GAP`
- implementation commit: `8212148f0239f9bf019e56fb24d74b68a3452bf0`
- validation head: current branch HEAD containing this handoff; freeze after publication

### Bounded polish implemented
- extended the existing Candidate 17 authored scene into the lower portrait field and moved the local City action row below it;
- preserved the central 22-step stair spine while adding authored ArrayMesh foreground landing/kiosk depth;
- added two original pixel-surface variants, `c17-pixo-ladder.svg` and `c17-mural-fragments.svg`, and distributed them across dominant facades to remove stamped crown repetition;
- added bounded residents, plants, cables, micro-detail and side/far neighborhood layers;
- added restrained cool depth-separation lights so authored side/back surfaces remain legible during orbit;
- preserved gameplay/state/persistence, semantic City hotspot IDs, native Godot 3D and DA LATA UI V1;
- no third-party runtime assets and no new canon.

### Gate
Freeze this handoff commit as the next exact head, then consume:
`Validate → City Visual Acceptance → Visual Acceptance → LENTE → ARTIST review`.

R06 remains CURRENT. R07+ remain LOCKED until explicit human runtime `ACCEPT`.

## R06 City Candidate 17 stair-life convergence — 2026-10-07

### ARTIST input
- consumed head: `6ca0ac6493cd3152dcc314512ac375e3fd5d0210`
- LENTE: `37639750521` / artifact `11492931874`
- accepted concept: `20261004T110406Z/city`
- decision: `IMPLEMENTATION_REVISE / LOW_POLY_VETO_CLEARED / STAIR_LIFE_DENSITY_GAP`

### Bounded CENA delta
- retain the existing 22-step authored ArrayMesh spine but alternate authored tile/masonry/paint-wear materials to remove the uniform grey run;
- keep `c17-mural-pixo.svg` only on the central gateway as the crown signature;
- add two side shop/awning activity pockets using existing authored Candidate 17 assets;
- add four residents and two plants to the middle stair corridor;
- add one restrained cool mid-depth light; no global relight;
- preserve native Godot geometry, gameplay/state/persistence, semantic hotspot IDs and DA LATA UI V1.

No third-party runtime assets and no canon changes.

### Gate
Publish as one exact head, then run:
`Validate → City Visual Acceptance → Visual Acceptance → LENTE → Cloudflare → ARTIST`.

R06 remains CURRENT. R07+ remain LOCKED until explicit human runtime `ACCEPT`.

