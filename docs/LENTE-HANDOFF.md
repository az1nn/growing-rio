# LENTE HANDOFF

## Route

**LENTE-CAPTURE -> final exact-head verification pending**. Feature `LENTE-001` lives on PR #184 / `feat/lente-visual-model-lab`, based on `master@5ff274a79ffda5e37304f7f98857da00150a03a8`. Other open work (#178, #179) owns Feature 011 semantic hotspots and does not overlap this branch's tooling paths.

## Verified baseline

The first successful LENTE run (`36654219243`) checked out `804ec60747783bc4ea46233799ef3549d9d1348d`. Artifact `11071629916`, digest `sha256:c05ed5f46267253e3df16f40f794a2b95028376d7c1c12c4cea993055324dcf1`, contains 22 page PNGs, 22 isolated scene PNGs, 11 WebMs, inventory, and an empty browser-error file. Independent `Validate project` and `Visual acceptance capture` jobs passed.

Two defects were found by **inspecting the actual artifact**, despite the successful workflow:
- artifact/metadata used the PR synthetic merge SHA instead of the checkout's exact head;
- each video included ~2 seconds of Godot loading before the diagnostic scene appeared.

Both have been corrected on the working branch: explicit `LENTE_EXACT_SHA`, post-ready WebM trimming, and workflow duration/metadata assertions. The trim command was separately exercised against the downloaded original Operation video: result was exactly 4.000 seconds and its early sampled frame showed the actual 3D room, not the splash screen.

## Review output

`docs/lente/reviews/2026-09-30-baseline.md` contains baseline visual observations and bounded candidates:
- `SCENE-finale-01` — improve tableau visibility in the full-page presentation without changing ending semantics;
- `SCENE-city-01` — test stronger city focal hierarchy;
- `SCENE-operation-01` — test UI-over-3D legibility;
- `MOTION-all-01` — fix diagnostic video integrity (implemented; full workflow recheck pending).

Only the **capture defect** has been implemented in this branch. Other candidates remain unaccepted CENA hypotheses; they must not be silently materialized as new art direction.

## Gates and next action

1. Freeze the final PR head and run its required `Validate project`, `Visual acceptance capture`, and `LENTE visual model lab` checks.
2. Download and inspect the new exact-head LENTE artifact; verify 22+22 frames, 11 real post-ready videos, correct `capture-metadata.json` SHA and empty browser errors. Sample initial/middle/end video frames rather than trusting durations alone.
3. Mark T009 done only when these pass. Complete T010 via expected-head guarded merge and post-merge verification; external explicit Vercel rate limits alone are non-blocking per SIGA.
4. Start CENA review of `SCENE-finale-01` as the next visual quality slice. Preserve all gameplay, save, lore and Feature 011 boundaries.

Do not claim that the new capture correction is verified by the old artifact.
