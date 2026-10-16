# ARTIST CLI

Runs with Python 3.10+; all command-line operations other than `compare` use the standard library. `compare` requires Pillow (`pip install Pillow`) for the evidence triptych. No AI API key is stored or needed to create briefs/review them. For generation, supply `generation-request.json` and original V1 board to an available image model (ChatGPT image generation, an authorized video/image model, etc.), **one scene request at a time**, and then `record` each generated result. The model's image output path is an input to the `record` command — the script will not falsely claim to have called the model.

Run `python3 -m unittest discover -s tests -p test_artist.py -v`, then `python3 tools/artist/artist.py validate` before opening/merging ARTIST asset or workflow changes. The official approved board's SHA256 is checked to prevent unreviewed drift.

The `CAVEMAN.md` analysis is intentionally initially incomplete. Human/post-implementation approval **cannot** be automated by image similarity. Actual runtime UI interaction, accessibility and Web/mobile performance need execution evidence from CENA/SIGA. `start-all` scaffolds eleven independent queued briefs, not eleven model calls or completed reviews.

## Source-object preview-first gate (R06 City 2.5D)

Show the actual **image**, inline and tied to immutable source blob/commit, before asking the human to approve any SVG/PNG object. Source XML, metadata, paths or a text-only URL are not preview delivery. Missing image means `PREVIEW_NOT_DELIVERED`, not a gate request; render faithfully and re-present rather than inventing replacement artwork.

Object approval is recorded separately from parent-family, full-scene concept, runtime, Godot import/output QA and R06 PASS. Current example: `assets/city/v1/svg25d/source/upper/REVIEW.md` and per-object `candidate-family.json`. The scoped regression tests are `tests/test_r06_svg25d_upper.py`.
