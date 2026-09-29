# CENA-017 — executable 3D completeness audit contract

## Purpose

T004 must fail deterministically when any required player-facing surface loses the structural contract needed by CENA-017. It complements rendered evidence; it does not replace visual acceptance.

## Canonical rows

| Row | Runtime source | Phase |
| --- | --- | --- |
| Operation | `res://scenes/main/main.tscn` | destination |
| Market | `res://scenes/market/market_surface.tscn` | destination |
| City | `res://scenes/city/city_surface.tscn` | destination |
| Institutional | `res://scenes/institutional/institutional_surface.tscn` | destination |
| Archive | `res://scenes/archive/archive_surface.tscn` | destination |
| Campaign | `res://scenes/visual/campaign_diorama.tscn` | modal |
| Narrative | `res://scenes/visual/narrative_diorama.tscn` | modal |
| Finale | `res://scenes/visual/finale_diorama.tscn` | selection/handoff |
| Coda/recap | `res://scenes/visual/finale_diorama.tscn` | coda/recap |

Coda/recap intentionally shares the Finale tableau, but must be exercised through its distinct presentation phases.

## Hard structural assertions

Every row must instantiate successfully and expose:

1. at least one `Node3D`;
2. an explicit `Camera3D`;
3. a `WorldEnvironment`;
4. at least one `Light3D`;
5. authored `MeshInstance3D` geometry;
6. an intended `Area3D` plus `CollisionShape3D` interaction target;
7. an accessible `Button` fallback;
8. a live pointer/touch contract where the scene API exposes `has_pointer_interaction()`;
9. a live accessible fallback contract where the scene API exposes `has_accessible_button_fallback()`.

For Campaign, Narrative and Finale, the audit must additionally invoke the presentation-only activation method and prove that the emitted context is the expected one. It must not invoke domain completion, save/load or ending-selection APIs.

## Finale phase assertions

The Finale tableau must accept exactly the presentation phases required by CENA-016:

- `selection`
- `handoff`
- `coda`
- `recap`

Unknown phases must be rejected. Coda/recap therefore receives an explicit audit row even though it shares the same scene resource.

## Failure semantics

The audit must identify the failed canonical row and missing contract in its error. A generic scan of all `.tscn` files is insufficient because CENA-017 certifies named player-facing surfaces, not merely repository-wide presence of 3D nodes.

## CI integration boundary

T004 produces `res://tests/three_d_completeness_audit_test.gd`.

T005, on a reconciled branch after T004 integration, adds that test to `tools/ci_validate.sh`.
