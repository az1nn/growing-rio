# R05 Market — concept generation preflight

Status: READY_FOR_SINGLE_CONCEPT_GENERATION

## Identity lock

- Product: **DA LATA**
- Repository: `az1nn/growing-rio`
- Current roadmap item: **R05 — Market V1**
- Active PR: **#205** / `feat/012-r05-market-v1`
- PR head before this preflight: `840e85e6ff7efe26232e42eb63326b1a533a0c0a`
- Reconciled master: `c78fb67cf35f679e2cd41119615882d688d7aa49`

Foreign project identity is forbidden in the concept-generation prompt and rendered result. In particular, do not use or display **Maricá**, `marica-game`, its roadmap/task IDs, its dashboard copy, or its visual assets.

## Generation input

Use only:

1. `PROMPT.md` from this Market run;
2. `NEGATIVE.md` from this Market run;
3. the locked DA LATA V1 style board `assets/art-direction/v1/da-lata-v1-style-board.png`;
4. the Market scene delta already recorded in this run.

Do not use a previous generated dashboard/report as a visual reference for the Market concept.

## Required visible result

Exactly one isolated 9:16 **Market / banca de rua** concept for DA LATA:

- physical 3D urban diorama read, not a dashboard or flat UI;
- chunky pixel-art surface language;
- graffiti/crown/stencil identity;
- warm stall light against cool navy night;
- compact invented urban massing with no postcard landmark;
- three separated foreground silhouettes: vendor counter, fictional inventory crates, market channel sign;
- lower 20–25% kept calm for portrait UI-safe space;
- no readable generated branding/text inside the illustration.

## Gate

This preflight does **not** accept a concept and does not authorize runtime implementation.

After generation:
- record exactly one concept through the canonical ARTIST workflow;
- reject any render with foreign repository/project identity;
- request explicit human **ACCEPT / REVISE / REJECT**;
- only human concept ACCEPT unlocks CENA/Godot Market implementation.
