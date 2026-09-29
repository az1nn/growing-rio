# Feature 010 implementation plan

## Architecture
Introduce a lightweight reusable `interactive_context_3d.tscn` presentation component. It owns a `SubViewport`, 3D world, fixed orthographic camera, environment, static lights, primitive geometry, an `Area3D` hit target and a button fallback. Surface scenes instantiate it with a context ID and label.

The accepted detailed `operation_diorama.tscn` remains intact and receives the same interaction contract. `contextual_scene_host.tscn` continues to mount it. `operation_surface.tscn` provides its own lightweight 3D context only when loaded outside the existing 3D parent, preventing duplicate render work in `main.tscn`.

## Validation

- static dependency-graph audit in `tools/validate_project.py`;
- exhaustive runtime instantiation in `tests/all_scenes_3d_interaction_test.gd`;
- interaction signal proof for both reusable and detailed dioramas;
- existing Godot regressions;
- Web export and two portrait rendered captures.

## Performance and safety
Primitive meshes, three material instances, one directional light and one local light per active context. Hidden shell destinations remain hidden with their parent surface. No dynamic shadow, texture, external mesh, gameplay command or persistent state is introduced.


## Delivery status

Implementation and validation are complete.

- runtime integration: PR #152 / `9619999fce37f50ad823e4c7cb88da50465c9546`;
- canonical regression + completeness audit: active on the delivered default-branch lineage;
- final exact-head certification: CENA-017 Validate #818 SUCCESS;
- final rendered acceptance: Visual #369 SUCCESS, artifact `11046242559`, 22 PNGs, empty browser-console/page-error output;
- provider/export proof: Vercel SUCCESS;
- closure documentation: PR #174 merged into current master.

No additional runtime slice is required to close Feature 010.
