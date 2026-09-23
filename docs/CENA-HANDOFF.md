# CENA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified baseline HEAD: `5e0b7b6c8e43009145670c84fa427cefa91884db`
- Active visual PR at baseline: none
- Repository-local skill: `.agents/skills/cena/SKILL.md`
- Live repository / CI always overrides this handoff.

## Route
**CENA-ADVANCE**

There is no active CENA wave yet. The current playable project is mechanically/narratively developed but visually underbuilt.

## Verified visual state
- Godot 4.7.x project.
- Main scene: `scenes/main/main.tscn`.
- Main root is `Control`.
- Current player-facing composition is primarily Labels, Buttons, Panels, Grid/HBox/VBox containers and ProgressBar.
- No Camera3D is present in the verified main scene.
- No WorldEnvironment is present in the verified main scene.
- No 3D light node is present in the verified main scene.
- No player-facing 3D environment is present in the verified main scene.
- Renderer uses `gl_compatibility`.
- Portrait viewport is 1080x1920 with a 540x960 window override.
- Web export and Vercel delivery already exist and must remain viable.

## Visual problem
The game communicates systems and narrative through functional UI, but the repository currently lacks a visual scene layer capable of making the operation feel like a place.

This is not a request to replace working gameplay. The visual system should initially wrap/present the existing loop.

## First CENA objective
Establish one bounded player-visible 3D presentation slice around the existing grow-space/operation loop:

1. research a coherent visual direction compatible with DA LATA, Rio atmosphere, portrait framing, Godot GL Compatibility and Web/mobile constraints;
2. define a compact asset/material palette;
3. create a 3D environment blockout with Camera3D, environment and restrained lighting;
4. preserve the current management UI as an overlay or equivalent presentation layer;
5. integrate only assets required to prove the scene language;
6. validate scene loading, existing tests, Web export and visual readability;
7. persist the exact assets/scenes/provenance and next visual action here.

## Research requirements
Before production asset selection:
- research references for the selected environment rather than guessing;
- record which references affected composition/material decisions;
- separate real-world reference from fictional DA LATA interpretation;
- verify third-party licenses before import;
- prefer original, CC0 or public-domain sources where practical.

## Asset policy
Every runtime asset must be classified as one of:
- `ORIGINAL`
- `GENERATED_ORIGINAL`
- `CC0`
- `PUBLIC_DOMAIN`
- `LICENSED_WITH_ATTRIBUTION`
- `PLACEHOLDER`

Do not merge `LICENSE_UNKNOWN` assets.

For third-party assets, record:
- source;
- author/provider;
- license;
- local path;
- modifications;
- attribution requirement.

## Current visual debt
- no canonical visual-direction document existed before this wave;
- no dedicated asset library for environments/props;
- no 3D scene composition in the main player-facing scene;
- no established camera language;
- no established lighting language;
- no documented material palette;
- no visual performance budget beyond the existing GL Compatibility/Web/mobile constraints.

## Dependencies
### SIGA
Route to SIGA if the visual slice requires:
- a reusable scene-management subsystem;
- save-schema changes;
- gameplay/mechanics changes;
- broad architecture refactors;
- new delivery infrastructure.

### LORE
Route to LORE if the scene requires:
- new canonical location facts;
- new symbols/faction claims;
- character/campaign facts not already canonical;
- resolution of an intentionally open narrative question.

## Validation contract
A future CENA wave is complete only when applicable evidence confirms:
- scene/assets parse and load;
- current gameplay semantics remain intact;
- tests stay green;
- UI remains legible;
- Web/mobile constraints are respected;
- third-party provenance is documented;
- exact-head Web export/deployment evidence is used when publication is part of the wave.

## Next action
On the next standalone `CENA` invocation:

1. re-verify repository identity, `master` HEAD, open PRs and current scenes/assets;
2. recompute CENA route;
3. if still `CENA-ADVANCE`, research the first environment slice;
4. update `docs/VISUAL-DIRECTION.md` from evidence;
5. implement the smallest coherent 3D presentation proof;
6. validate and persist this handoff.

## Boundaries
- Visual work must not make cultivation more operational/instructional than the existing abstract strategy-game design.
- Parallel-market presentation remains fictional/abstract and must not introduce real-world evasion/logistics instruction.
- Real political actors/elections are outside the visual scope; institutional material remains fictional/systemic.
- Chat/model memory is not canonical project state.
