# LENTE-001 — Exact-head multimodal visual feedback loop

## Problem

DA LATA already produces exact-head visual-acceptance screenshots, but visual iteration still depends on manually opening artifacts and mentally separating UI, scene composition and object quality. The repository needs a repeatable agent-facing loop that can inspect every canonical page, inspect each 3D scene without shell chrome, produce short motion evidence, isolate named mesh objects on demand, and feed that evidence into image/video models without granting those models visual or narrative authority.

## User stories

### US1 — Current visual state
As a visual agent, I can obtain screenshots of every canonical player-facing page for the exact commit I am reviewing.

### US2 — Scene isolation
As a visual agent, I can view each canonical diorama isolated from the normal game shell at the same portrait resolutions used for acceptance.

### US3 — Time-dependent review
As a visual agent, I can inspect a short deterministic diagnostic clip for each isolated scene so occlusion, weak geometry and material/light issues visible across angles can be reviewed.

### US4 — Object study
As a visual agent, I can request an isolated frame for a specific MeshInstance3D without permanently altering production scenes.

### US5 — Model-assisted hypotheses
As a developer, I receive a bounded set of evidence-backed scene/object improvement hypotheses with explicit ownership and deterministic before/after validation.

## Acceptance criteria

- The capture manifest covers the same 9 canonical rows as `tests/three_d_completeness_audit_test.gd`.
- Every discovered `scenes/visual/*_diorama.tscn` is represented by the LENTE manifest or the validator fails.
- Exact-head capture produces 11 page states at 540x960 and 1080x1920.
- Exact-head capture produces 11 isolated scene/phase states at 540x960 and 1080x1920.
- Exact-head capture produces one short WebM diagnostic video for every isolated scene/phase state.
- Browser/page errors fail the evidence contract.
- Object isolation can target an exact MeshInstance3D by scene id and node name.
- Object capture is opt-in so normal capture does not create unbounded artifacts.
- The workflow does not commit or permanently edit `project.godot`; the isolated runner is selected only inside the Actions worktree before the isolated export.
- Generated image/video ideas are explicitly reference-only until accepted by CENA.
- Applying a LENTE hypothesis routes implementation through CENA, 3JS, SIGA or LORE as appropriate.

## Out of scope

- changing gameplay, persistence, economy or campaign semantics;
- replacing the canonical Godot boot path;
- treating model-generated images/videos as production assets automatically;
- inventing lore/canon;
- committing routine capture binaries to the repository;
- replacing CENA visual acceptance or 3JS implementation ownership.
