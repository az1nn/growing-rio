# LENTE HANDOFF — versioned history / CAVEMAN

## State

**RESUME / exact-head QA pending**, PR #184 on `feat/lente-visual-model-lab`, originally based on master `5ff274a79ffda5e37304f7f98857da00150a03a8`. The PR remains isolated from open Feature 011 semantic-hotspot PRs #178/#179.

## Completed work

The first LENTE execution succeeded (run `36654219243`, source head `804ec60747783bc4ea46233799ef3549d9d1348d`) and produced 22 page screenshots, 22 isolated screenshots and 11 scene videos, plus inventory and empty browser errors. Reviewing the actual artifact caught PR synthetic-merge SHA provenance and video splash-frame problems. The branch now uses post-ready 32-frame/8fps video encoding, creates 11 first-ready QA posters and records the exact checkout SHA.

**New permanent rule:** each explicit LENTE capture starts a distinct `visual-lab/runs/YYYYMMDDTHHMMSSZ-<sha12>-r<runid>-a<attempt>/`. In that folder `analyze_run.py` always generates `CAVEMAN.md`, `metrics.json`, and `MODEL_REVIEW_PROMPT.md` (even from partial evidence, marked INCOMPLETE). Artifact names also identify SHA/run ID/attempt.

**Archive:** `.github/workflows/lente-history.yml` (runs only after it reaches master) uses `workflow_run` to fetch a completed artifact with read access, then a trusted master checkout with write access calls `archive_run.py`. It validates exact-head metadata, source repo and file allowlist, and appends the whole run to independent **`lente-history`** branch. Never merge that binary branch into master. The branch holds `INDEX.md` links to every report and run folder. Explicit archive dispatch can backfill a versioned run ID.

## Review baseline

`docs/lente/CAVEMAN-BASELINE.md` captures human-inspected observations from the first artifact. Three unresolved visual hypotheses: `SCENE-finale-01` (scene emphasis; issue #185), `SCENE-city-01` (city focal hierarchy), `SCENE-operation-01` (UI-on-diorama legibility). They are **not approved CENA direction**. The previous artifact's video splash disqualifies it for motion acceptance.

## Gates

1. On PR #184's **final exact head**, run `Validate project`, `Visual acceptance capture` and `LENTE visual model lab`.
2. Inspect the new artifact: unique run folder, 22 page PNGs, 22 isolated PNGs, 11 WebMs and 11 post-ready posters, error-free browser log, exact source-head metadata, real `CAVEMAN.md` with scene-level observations and valid linked media.
3. Mark T009/T015 only after verification. Guarded merge T010 when exact-head validations and branch state pass; external Vercel rate-limit status is soft under SIGA.
4. After merge, run a new explicit LENTE capture or backfill a versioned PR run using the `LENTE archive visual history` workflow. Verify `lente-history/INDEX.md` and complete media folder before closing T016.
5. Pass `SCENE-finale-01` to CENA; after an owner-approved implementation run **another** LENTE version and compare before/after.

If Actions is delayed, do not tight-poll. Preserve run ID, source-head SHA, test status and next action in a compact handoff.
