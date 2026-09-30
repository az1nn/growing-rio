# LENTE-001 — Technical plan

## Architecture

```text
exact repository head
  -> tools/visual_lab/manifest.json
  -> build_inventory.py
       -> validates canonical-row + diorama coverage
       -> inventory.json
  -> production Web export
       -> full-page screenshots
  -> temporary CI-only project main-scene switch
       -> visual_lab_runner.tscn
       -> isolated scene screenshots
       -> deterministic orbit videos
       -> optional focused object screenshots
  -> Actions artifact
       -> image/video model review
       -> stable hypotheses
       -> CENA/3JS/SIGA/LORE routing
       -> recapture exact implementation head
```

## Runtime isolation

The repository remains configured with:

```text
run/main_scene="res://scenes/shell/game_shell.tscn"
```

The workflow exports player pages first. Only after that export does the workflow modify the checked-out `project.godot` in its ephemeral worktree to select `res://scenes/visual_lab/visual_lab_runner.tscn` for the second Web export.

No production runtime path is changed by the committed implementation.

## Evidence contract

Default artifact:

- `inventory.json`
- `capture-metadata.json`
- `browser-console-errors.txt`
- `pages/*.png`
- `scenes/*.png`
- `videos/*.webm`

Optional:

- `objects/*.png`

Artifact retention is 14 days; exact-head artifacts should be reused rather than regenerated.

## Model contract

Scene review receives one coherent packet:
- page screenshot;
- isolated screenshot;
- isolated diagnostic video;
- scene inventory entry;
- visual direction/acceptance excerpt.

Object review adds an isolated object frame but retains parent-scene evidence.

Model output is hypothesis data, not authority. CENA remains the visual decision owner.

## Concurrency

All implementation paths are new except README exposure. No Feature 011 semantic-hotspot runtime files are modified. The isolated runner consumes existing scenes read-only and should remain compatible with stacked visual feature work after branch reconciliation.

## Validation

- inventory validator must pass;
- Godot headless import must accept the new runner;
- both Web exports must succeed;
- Chromium capture must produce all required files;
- browser/page errors must remain empty;
- PR exact-head Actions evidence must be green before delivery.
