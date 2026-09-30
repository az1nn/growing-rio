# LENTE scene review prompt

Use this with the **exact-head full-page screenshot**, the matching **isolated-scene screenshot**, the **scene orbit video**, and the inventory entry for the same scene.

## Objective

Generate concrete visual improvement hypotheses for DA LATA without changing gameplay, canon, or product semantics.

## Review dimensions

Evaluate:
- silhouette and first-read hierarchy;
- depth layering and focal path;
- camera/framing at portrait sizes;
- lighting direction, contrast and warm/cool balance;
- material coherence and repetition;
- architectural rhythm and environmental storytelling;
- interaction affordance for clickable 3D objects;
- UI-over-3D legibility in the full-page frame;
- visual identity consistency with the existing DA LATA language;
- motion stability and whether the scene reads from multiple angles.

## Output contract

Return no more than 7 opportunities. For each:
1. stable id: `SCENE-<scene>-NN`;
2. evidence: what is visibly weak or unclear;
3. hypothesis: the visual change to test;
4. affected nodes/materials if inferable from inventory;
5. expected player-facing effect;
6. risk: visual-only, implementation, performance, or canon dependency;
7. suggested owner: CENA, 3JS, SIGA, or LORE;
8. validation: what before/after capture would prove improvement.

Do not present taste as fact. Distinguish observed evidence from a proposed direction. Prefer one strong structural improvement over decorative detail.
