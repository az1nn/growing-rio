# Feature 011 implementation plan

## Architecture

Keep the existing per-surface Godot dioramas and their `object_activated(context_id, object_id)` signal. Expand each scene from one primary presentation hotspot to a small set of stable semantic hotspots. Surface scripts remain the routing layer that maps those identifiers to existing controls using focus/scroll/highlight behavior.

No diorama script receives `GameState` access. No hotspot calls gameplay commands.

## Delivery order

1. Archive: evidence desk -> research; archive wall -> narrative history.
2. City: district overlook -> district list; community marker -> community feedback.
3. Institutional: compliance desk -> compliance; proposal row -> policy/participation.
4. Market: deal counter -> buyer/sale controls; contract tray/loading area -> contracts.
5. Operation: cultivation object -> cultivation controls; management object -> staff/upgrades.

Each slice adds/updates scene nodes, diorama signal identifiers, surface routing and regression tests before the next surface.

## Validation

- per-diorama regression tests for node presence, stable IDs and both input/fallback paths;
- structural checks preserving the presentation-only boundary;
- canonical `bash tools/ci_validate.sh`;
- final portrait rendered acceptance at 540x960 and 1080x1920 for all affected surfaces.

## Safety / persistence

Feature 011 is presentation-only. Save schema remains unchanged. Existing domain services, RNG, economy, campaign and lore contracts remain untouched.
