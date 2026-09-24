# CENA HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Reconciled baseline HEAD: `2b51cd4f0d26b1b12745e471d4810f69e61af5e1`
- Visual branch: `feat/cena-001-operation-diorama`
- Implementation commit: `4faa9471642c482e18f03f08517f9b20c8a5eaa4`
- Open PR collision scan at claim time: none
- Repository-local skill: `.agents/skills/cena/SKILL.md`
- Live repository / CI always overrides this handoff.

## Route
**CENA-WATCH**

The first player-visible 3D presentation slice is implemented and dispatched for exact-head validation. Do not start a competing visual wave until its validation/merge/delivery state is reconciled.

## Visual target
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
  - requires the new visual scene and CENA docs;
  - asserts Camera3D, WorldEnvironment, lights, orthographic portrait camera contract and main-scene integration.
- `docs/VISUAL-DIRECTION.md`
  - records research evidence and the resulting visual grammar.

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

## Boundaries preserved
- existing management mechanics unchanged;
- no save-schema change;
- no new narrative canon;
- cultivation remains abstract/non-operational;
- no real-world market-evasion/logistics detail;
- no political persuasion content introduced.

## Validation status
Pending exact-head gates after branch publication:
- repository structural validator;
- Godot 4.7.2 headless import;
- existing regression suite;
- Web export for changed `scenes/**`;
- deployment evidence if/when merged.

Human visual inspection is still needed before this blockout can be promoted from composition proof to production art.

## Next action
On the next standalone `CENA`:
1. reconcile the live PR/CI/export state for this exact branch head;
2. if gates are still running: remain `CENA-WATCH`;
3. if a gate fails: `CENA-RESUME` and fix only the failing visual slice;
4. if merged and delivered: `CENA-ADVANCE` to replace the highest-impact blockout surfaces/props with a small production-candidate asset/material pass, preserving this camera language unless playtest evidence rejects it.

## Canonical-state rule
`REAL REPOSITORY STATE > CENA HANDOFF > VISUAL DIRECTION > CHAT/MEMORY`
