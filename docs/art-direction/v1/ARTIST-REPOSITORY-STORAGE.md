# ARTIST — repository-only artwork storage

**Decision (2026-10-12):** `az1nn/growing-rio` is the single canonical storage location for Growing-Rio/DA LATA ARTIST source images, candidates, previews, final assets, review evidence and provenance. External design services (including Canva/Canvas) must not be used as the artwork store, handoff location or review link. This applies to new ARTIST sessions. This policy does not delete any historical external files.

## Required flow

1. Reconcile approved art and ownership first; create one isolated candidate only when the ARTIST gate authorizes production. Preserve all already-accepted originals and hashes.
2. Copy the **actual full-resolution generated/source bytes** to a versioned, append-only path in this repository, normally `artifacts/artist/runs/<session>/<scene>/images/concept/` for candidates and `assets/<scene>/` for approved production sources. Use a dedicated branch/PR, never overwrite an approved original. Images must be committed as real binary PNG/WebP/SVG as appropriate, not substituted by a screenshot, external link, placeholder or reduced thumbnail.
3. Record origin/tool, source dimensions, exact byte-level SHA-256, commit SHA/blob reference, visual role, status and human decision. Use the existing `tools/artist/artist.py` run/record/review mechanism where applicable.
4. Present the **actual repository-hosted inline preview** of the exact candidate, with matching source/ref, before asking for `ACCEPT / REVISE / REJECT`. No Canva links or hosted design documents as preview deliverables.
5. Concept acceptance is **not** asset import acceptance, scene composition acceptance or Godot runtime acceptance; only CENA/SIGA + LENTE exact-head checks can advance those separate gates.
6. When the original image bytes are missing, inaccessible or cannot be checksum-verified and committed, report `PREVIEW_NOT_REPO_ARCHIVED` and `ARTIFACT_NOT_DELIVERED`; do not fabricate a GitHub URL or claim concept delivery/acceptance. Reacquire the original before requesting a human visual gate. Never silently redraw an accepted asset.

## R06 City checkpoint (2026-10-12)

- Current source of truth remains the five principal City assets + one BG, with **05 protagonist REQUIRED**.
- A newly attempted external-service protagonist generation has **no verified original full-resolution repo artifact**. Its status is `05 / NOT_REPO_ARCHIVED / CONCEPT_NOT_ACCEPTED`; a prior external rendering is **not** production source or an ARTIST acceptance gate.
- Do not alter already approved BG/Coral/Ochre/commerce/stairs decisions, do not import into Godot, do not activate the compositor, and do not merge R06 on the strength of this documentation.
- Preserve `R05 PASS`, `R06 CURRENT`, old City runtime `REJECT_ALL`, `R07+ LOCKED`, and PR #213 Draft.

**Persistence contract:** `repo binary + provenance/hash + GitHub preview + explicit human gate`. Chat and image-generation services are transient execution surfaces, not canonical storage.
