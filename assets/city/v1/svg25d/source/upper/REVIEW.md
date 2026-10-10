# R06 City — upper SVG object approvals (2026-10-09)

**Decision:** Human explicitly said **“Aprovado como itens individuais, não como cena completa.”**  
**ARTIST:** two isolated source objects ACCEPTED, **no composed scene approval**.  
**Source exact-head:** [`6e5dc5b7fac702ea7310f33d8a1565b945d02856`](https://github.com/az1nn/growing-rio/commit/6e5dc5b7fac702ea7310f33d8a1565b945d02856).  
**Accepted concept target:** `20261004T110406Z/city` (unchanged).  
**Evidence type:** actual browser-rendered original SVG source images shown inline to the human, **not** Godot runtime frames.

## Coral Terrace House — item ACCEPT

![Coral Terrace House — original SVG preview](https://raw.githubusercontent.com/az1nn/growing-rio/6e5dc5b7fac702ea7310f33d8a1565b945d02856/assets/city/v1/svg25d/source/upper/coral-terrace-house.svg)

- Source: [SVG](https://raw.githubusercontent.com/az1nn/growing-rio/6e5dc5b7fac702ea7310f33d8a1565b945d02856/assets/city/v1/svg25d/source/upper/coral-terrace-house.svg)
- Source blob: `77df5e5f8b05fd06fa15fa10a51326c3d76ebf75`.
- Approval: `OBJECT_ART_ACCEPTED` for **this item only**.
- Godot import/render QA: `PENDING`.

## Ochre Shop Terrace — item ACCEPT

![Ochre Shop Terrace — original SVG preview](https://raw.githubusercontent.com/az1nn/growing-rio/6e5dc5b7fac702ea7310f33d8a1565b945d02856/assets/city/v1/svg25d/source/upper/ochre-shop-terrace.svg)

- Source: [SVG](https://raw.githubusercontent.com/az1nn/growing-rio/6e5dc5b7fac702ea7310f33d8a1565b945d02856/assets/city/v1/svg25d/source/upper/ochre-shop-terrace.svg)
- Source blob: `2bf03cabcafd9b476cec51aef96b38f735e747a4`.
- Approval: `OBJECT_ART_ACCEPTED` for **this item only**.
- Godot import/render QA: `PENDING`.

## Corrected ARTIST preview protocol

1. Visually display each **actual source artifact** in the human-facing reply as an inline rendered image (SVG display or faithful PNG conversion) *before* requesting human acceptance. XML/code, file path and link-only answers do not satisfy preview delivery.
2. Freeze the exact source commit/blob and show each item independently. Label it `SOURCE_ART_NOT_RUNTIME`.
3. If rendering/display fails, set `PREVIEW_NOT_DELIVERED`; do not ask the user for a decision on an unseen object. Re-deliver the actual image instead of substituting a newly generated artwork.
4. Preserve one human decision **per item** in `candidate-family.json`. Approval never cascades to sibling sprites, a family composition, the whole City scene, Godot import QA or runtime/release.
5. Keep provenance, image preview and acceptance record together for future ARTIST sessions.

## Stop conditions

- Upper family still `ORIGINAL_SPRITE_CANDIDATE`, no family-composite acceptance.
- `docs/art-direction/v1/SCENE-STATUS.json#city` stays `CONCEPT_ACCEPTED`, `accepted_runtime_run=null`.
- Old City runtime: **`REJECT_ALL`**, R05 `PASS`, R06 only current work item, R07+ `LOCKED`.
- No `layers.json`, no compositor mount, no new sprites, no changes to original SVGs.
- Next gate `R06-B-01B`: real Godot SVG import/rasterization QA for these two objects; **requires separate execution authorization**. R06-B-02 onward still unauthorized.
