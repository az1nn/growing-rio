# LENTE HANDOFF

## Current state

- Route: **LENTE-CAPTURE -> verification pending**
- Feature: `LENTE-001 — Exact-head multimodal visual feedback loop`
- Branch: `feat/lente-visual-model-lab`
- Base: `master@5ff274a79ffda5e37304f7f98857da00150a03a8`

## Delivered structure

- repository-local skill: `.agents/skills/lente/SKILL.md`
- canonical capture manifest: `tools/visual_lab/manifest.json`
- scene/inventory validator: `tools/visual_lab/build_inventory.py`
- isolated Godot runner: `tools/visual_lab/visual_lab_runner.tscn`
- Playwright capture harness: `tools/visual_lab/capture.cjs`
- exact-head workflow: `.github/workflows/visual-lab.yml`
- multimodal prompts under `tools/visual_lab/prompts/`
- Spec Kit: `specs/lente-001-visual-feedback-loop/`

## Evidence contract

Default run captures:
- 11 canonical page states × 2 portrait sizes;
- 11 isolated scene/phase states × 2 portrait sizes;
- 11 deterministic diagnostic WebM videos;
- scene/object inventory;
- browser/page error evidence.

Targeted object capture is opt-in by scene id and exact MeshInstance3D node name.

## Ownership

LENTE observes and proposes. CENA remains visual authority; 3JS owns Three.js implementation; SIGA owns generic engineering/delivery; LORE owns canon.

Image/video model outputs are hypotheses or reference material until accepted by the owning specialist.

## Concurrency

The implementation is intentionally additive and does not mutate the active Feature 011 semantic-hotspot scene/runtime files. The isolated runner is selected only in the CI worktree for the second export; committed `project.godot` keeps the normal GameShell main scene.

## Pending verification

1. Open PR from `feat/lente-visual-model-lab`.
2. Run exact-head LENTE workflow.
3. Verify inventory + page + isolated scene + WebM evidence and empty browser error artifact.
4. Mark T009 complete.
5. Guarded merge after required gates; verify resulting master and mark T010 complete.

## Next action

Run the LENTE workflow on the PR exact head and diagnose only concrete failures from that run.
