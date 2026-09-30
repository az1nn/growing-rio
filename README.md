# LENTE visual history

This branch stores **append-only, immutable capture versions** from DA LATA.
Each run is saved under `runs/<UTC>-<SHA12>-r<run-id>-a<attempt>/` with images,
scene WebMs, metrics and a `CAVEMAN.md` improvement starting point.
Use INDEX.md to navigate captured runs.

This branch is maintained automatically by the trusted
`.github/workflows/lente-history.yml` workflow after that workflow reaches
master. It is intentionally **not to be merged into master**: source code
remains on master, heavyweight visual evidence lives here.

The initial inspected visual baseline (before automatic history capture was
installed) is in master/PR #184 at `docs/lente/CAVEMAN-BASELINE.md`.
Do not misrepresent this empty index as an archived capture.
