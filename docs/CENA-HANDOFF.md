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

## CENA Wave 016 exact-head closure / Wave 017 advance — 2026-09-25

### Reconciled real state
- repository: `az1nn/growing-rio`;
- live `master` at branch claim: `4b131fcc65ce4f47bd7bbcf90e49b05f4f87189d`;
- CENA-016 PR **#97** current head: `02d6f2642a372a1ab1fed8051d45eb0d959d1347`;
- final exact-head Validate project run `36133718056`: **SUCCESS**;
- final exact-head Visual acceptance capture run `36133718076`: **SUCCESS**;
- final visual artifact: `10862203498`;
- browser console/page-error artifact: **empty**;
- Vercel: explicit `upgradeToPro=build-rate-limit` / **SOFT_GATE_RATE_LIMIT**;
- PR #97 remains open and mergeable; provider proof still defers its guarded merge.

### Route
**CENA-ADVANCE -> CENA-WATCH**

The rate limit is not a development lock. Exact-head rendered evidence still shows a bounded lower-composition gap, so Wave 017 is stacked on the unresolved Wave 016 branch rather than pretending #97 is already in `master`.

### Wave 017 target
Create a narrow foreground apron that continues the accepted room floor toward portrait navigation without turning the entire lower viewport into floor mass.

### Working branch / dependency
- branch: `feat/cena-017-foreground-apron`;
- base: `feat/cena-016-foreground-floor-depth` / PR #97 exact head at claim;
- intended PR base: `feat/cena-016-foreground-floor-depth`;
- unrelated open SIGA documentation work is parallel-safe and does not own the diorama files.

### Implementation
- add `Mesh_floor_apron` as a 5.4 x 4.5 Godot-native concrete continuation;
- mount `FloorApron` flush from the CENA-016 foreground edge;
- add two transverse metal joints plus one longitudinal spine using the existing visual vocabulary;
- extend runtime and structural validation for the apron contract.

### Research / provenance
No external research is required: the target is derived from the accepted exact-head CENA-016 capture and reuses the established repository-authored material grammar.
Runtime assets introduced: **none**.
Third-party assets: **none**.
License/attribution dependency: **none**.

### Boundaries
No gameplay/domain, persistence, campaign, navigation, camera, lighting, wall/prop, lore/canon or external-asset change.

### Validation gate
Require the final Wave 017 exact head to pass:
1. **Validate project**;
2. **Visual acceptance capture** at 540x960 and 1080x1920;
3. empty browser console/page-error artifact;
4. rendered confirmation that the remaining lower dead band is reduced without apron dominance, clipping, z-fighting or navigation overlap.

Vercel provider proof remains required before bottom-up guarded delivery. Until fresh Wave 017 repository/rendered evidence exists, remain **CENA-WATCH**.
