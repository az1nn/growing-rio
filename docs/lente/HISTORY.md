# LENTE historical evidence

Every explicit LENTE capture is a **new, immutable version**. The main game branch contains only the capture scripts, test/contract code and short summaries. Bulk images/videos are versioned on a separate branch.

## Where to find the history

- Branch: `lente-history` (created by the first successful archival workflow after merge).
- Entry point: `INDEX.md` on that branch.
- Each directory: `runs/YYYYMMDDTHHMMSSZ-<sha12>-r<run-id>-a<attempt>/`.
- Contents: `pages/`, `scenes/`, `videos/`, opt-in `objects/`, `inventory.json`, `capture-metadata.json`, `metrics.json`, `CAVEMAN.md`, `MODEL_REVIEW_PROMPT.md`, and browser-error evidence.
- Artifacts: `lente-visual-evidence-<exact-sha>-r<run-id>-a<attempt>` (14-day fallback).
- Archiver: `.github/workflows/lente-history.yml` (triggered by completed capture runs after reaching `master`); explicit dispatch with an existing run ID supports backfilling.

The history branch is append-only and intentionally **must not be merged into master**. A manual model-assisted retrospective should create a new companion review or a new run, never edit older captured PNG/WebM evidence. The Git repository grows with each historical run; if retention needs exceed reasonable Git storage, migrate the append-only binary store to versioned object storage while preserving index, digests, and links.

## CAVEMAN operator contract

`CAVEMAN.md` is produced automatically on every run from actual captured pixels and diagnostic video frames. It gives a quick status, evidence coverage, up to five evidence-linked review candidates, scene-by-scene signals and bounded next actions.

Quantitative issues are marked as hypotheses, not accepted art-direction decisions. The attached `MODEL_REVIEW_PROMPT.md` directs a multimodal reviewer to inspect both portrait resolutions, isolated scenes, clips, and matching inventory. The reviewer must write **observations distinct from proposals**; where a model is not available, the automatic report explicitly remains a starting point, not fabricated visual interpretation.

Use `CAVEMAN.md` as the first document for a new LENTE session, compare against an earlier run key, and route accepted visual decisions through CENA. Any player-facing change must be recaptured with a NEW run/version.
