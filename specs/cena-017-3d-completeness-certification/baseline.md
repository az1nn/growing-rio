# CENA-017 structural baseline — 2026-09-29

This baseline is a source-structure audit only. It does **not** replace rendered CENA acceptance.

Observed canonical master: `22ee519548fe4b8a9a96d0f55443686fc4a9d5af`.

Observed concurrent candidates:
- Narrative: PR #165, runtime scene present on `feat/cena-015-narrative-godot-3d-runtime-20260929`.
- Finale: PR #166, isolated tableau present on `feat/cena-016-finale-diorama-core-20260929`.

## Structural inventory

| Surface | Source | Camera3D | MeshInstance3D | Area3D | Button fallback | Structural result |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| Operation | master | 1 | 86 | 1 | 1 | PASS |
| Market | master | 1 | 46 | 1 | 1 | PASS |
| City | master | 1 | 49 | 1 | 1 | PASS |
| Institutional | master | 1 | 33 | 1 | 1 | PASS |
| Archive | master | 1 | 28 | 1 | 1 | PASS |
| Campaign | master | 1 | 19 | 1 | 1 | PASS |
| Narrative | PR #165 candidate | 1 | 22 | 1 | 1 | CANDIDATE PASS |
| Finale | PR #166 candidate | 1 | 17 | 1 | 1 | CANDIDATE PASS |
| Coda/recap | intended to share Finale tableau | — | — | — | — | PENDING INTEGRATION |

Operation uses a SubViewport-backed 3D scene with its own environment/camera/geometry but does not declare a separate `World3D` resource. That is not by itself a certification failure; rendered evidence remains authoritative.

## What this proves

The merged six primary surfaces already have structural authored-3D and interaction primitives. Narrative and Finale also have structural candidates in their active PR branches.

## What this does not prove

It does not prove that:
- the 3D viewport is actually visible at runtime;
- the intended object receives pointer/touch events in Web;
- the accessible fallback is reachable;
- interaction preserves canonical state;
- portrait rendering is legible;
- Coda/recap mounts the Finale tableau correctly;
- one reconciled master commit contains all nine rows.

Those remain T003–T010 and require exact-head runtime + rendered evidence.
