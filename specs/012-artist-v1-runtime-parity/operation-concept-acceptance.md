# ARTIST V1 — Operation concept ACCEPT (human decision)

**Decision:** `ACCEPT` — user statement on 2026-09-30: “Accept, por ora está ótimo.”  
**Interpretation:** approve the current Operation concept as the V1 implementation reference *for now*, without constraining future explicit revisions. This acceptance applies to the isolated image only; it is **not** approval of Godot/Three.js choice, implemented 3D runtime, actual gameplay screenshots or remaining ten scenes.

## Immutable reference

- Global board: `assets/art-direction/v1/da-lata-v1-style-board.png`, SHA-256 `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`.
- Individually accepted Operation candidate: `assets/art-direction/v1/scenes/operation.webp`, SHA-256 `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce`.
- Provenance: PR #190 (merged), isolated candidate. `board-candidate-audit.md` records the board comparison.
- Human review: `ACCEPT`, `2026-09-30`. No extra modifications requested at concept stage.

## Approved visible production reference

- Portrait, three-quarter compact cutaway workshop. Dark navy/ink structure, magenta/cyan crown/graffiti, restrained amber practical lamps, crisp chunky pixel treatment.
- Three spatially distinct visible foci: workbench, **abstract fictional** plant cluster and storage shelves.
- Preserve readable focal silhouettes and the lower 20–25% UI-safe region. The board remains the global binding authority where isolated detail conflicts with the written guide; do not introduce photorealism, baked UI wording, real-world instructional visuals or flat wallpaper.
- The scene's existing concept is an image target; real interactive 3D geometry and exact-head LENTE comparison are still mandatory.

## ARTIST CLI synchronization (not yet executed)

The prior `artifacts/artist/runs/20260930T103636Z/operation` is only a scaffold on `master`: its existing `manifest.json` does not yet record the generated PR #190 image. Therefore this spec records **the real human acceptance now**, but does **not** claim `tools/artist/artist.py` was run or that `docs/art-direction/v1/SCENE-STATUS.json` is already updated.

On a real repository checkout, the ARTIST operator must run the canonical script (on a dedicated branch; no manually invented image evidence):

```bash
python3 tools/artist/artist.py validate
python3 tools/artist/artist.py record \
  --run artifacts/artist/runs/20260930T103636Z/operation \
  --kind concept \
  --file assets/art-direction/v1/scenes/operation.webp
python3 tools/artist/artist.py review \
  --run artifacts/artist/runs/20260930T103636Z/operation \
  --stage concept --decision ACCEPT --reviewer 'Alan (human)' \
  --notes 'Approved current Operation V1 concept on 2026-09-30; por ora está ótimo.'
```

Commit the script-generated manifest, copied concept evidence and `SCENE-STATUS.json`; record their exact commit SHA in this evidence sheet and ledger. If another session has already recorded/approved this same evidence, reconcile first and do not overwrite the run.

## Next engineering gate

Proceed with renderer evidence and the Operation slice only against this accepted concept. Godot × Three.js ownership remains provisional until the same-viewport captures, minimal V1 treatment spike and measurable integration evidence are complete. Runtime acceptance still requires a separate human decision.
