# CENA-014 — Campaign Godot 3D

## Intent

Promote the player-facing **Campanha** overlay to a dedicated, visible and interactive Godot 3D presentation while preserving the existing campaign/save controller as the only authority for create, continue, overwrite and reset actions.

## Player-visible contract

- The Campaign menu and startup resume prompt render a dedicated 3D diorama in the overlay, not the generic background-only 3D contract.
- Portrait Web/mobile remains first-class: the 3D viewport must stay visibly framed above or alongside the existing campaign choices without hiding required actions.
- The composition should read as a campaign desk / yearly ledger: calendar blocks, campaign ledger, save-slot object and day/progress cues. It is a fictional UI metaphor, not a real-world cultivation guide.
- At least one authored object is pointer/touch interactive through Area3D + CollisionShape3D.
- An accessible Button fallback triggers the same presentation-only activation.

## Behavioral boundaries

The diorama is **presentation-only**.

It MUST NOT:
- create a campaign slot;
- load/continue a campaign;
- overwrite or reset a campaign;
- advance the day/calendar;
- mutate GameState, save schema, RNG, economy, inventory, lifecycle or narrative state.

Activation may only:
- emit a semantic signal such as `object_activated("campaign", "campaign_ledger")`;
- update local visual feedback;
- focus/scroll the existing campaign controls.

`campaign_flow_controller.gd` and the existing shell campaign actions remain authoritative.

## Integration target

Primary integration points:
- `scenes/shell/game_shell.tscn`
- `scenes/shell/game_shell.gd`
- new `scenes/visual/campaign_diorama.*`

The runtime pass must not broaden into navigation redesign or save-system changes.

## Acceptance gates

1. Campaign overlay visibly contains Camera3D, WorldEnvironment, Light3D and authored MeshInstance3D geometry.
2. Pointer/touch Area3D picking is live.
3. Accessible button fallback is visible and enabled.
4. Dedicated regression proves activation cannot mutate campaign/save/domain state.
5. Existing campaign-flow and shell-navigation tests remain green.
6. Canonical `tools/ci_validate.sh` runs the new regression.
7. Visual Acceptance and Vercel exact-head deployment pass before guarded merge.
