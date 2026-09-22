# SIGA HANDOFF — Growing Rio

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`

## Current milestone
**V0.1 — Bootstrap vertical slice**

Implemented in the bootstrap package:
- Godot project scaffold.
- Mobile-first main scene.
- Abstract 30-day cultivation loop.
- Harvest and quality grading.
- Licensed vs. parallel-market strategic channels.
- Cash / Heat / Reputation / Influence.
- Institutional action kept fictional and abstract.
- Random operational events.
- Structural validator.
- GitHub Actions structural validation.
- GDD, architecture and roadmap.

## Design boundary
Cultivation, illicit-market activity and politics stay at strategy-game abstraction level. The project does not encode real cultivation recipes, trafficking/evasion procedures or targeted political persuasion.

## Gates
- `python tools/validate_project.py` must pass.
- Godot editor/runtime smoke test is still required when a Godot 4.7.x environment is available.

## Next action
After bootstrap is on `master`, verify GitHub Actions. If green, classify `ADVANCE` and begin V0.2 by introducing Resource-based content models and seeded simulation tests.
