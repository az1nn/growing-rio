# LENTE object review prompt

Use this with an isolated object frame plus the parent scene frame and inventory metadata.

## Objective

Improve a scene object as a readable component of the DA LATA visual system, not as a disconnected asset.

Inspect:
- silhouette;
- scale and proportion relative to the parent scene;
- material/readability;
- edge treatment and primitive repetition;
- relationship to nearby props;
- whether it communicates its semantic purpose;
- whether it looks clickable when it is interactive;
- whether added detail would survive portrait/mobile rendering.

## Output contract

Return up to 5 bounded object hypotheses:
- id: `OBJECT-<scene>-<object>-NN`;
- observed issue;
- proposed change;
- keep/remove/add geometry or material treatment;
- expected scene-level benefit;
- cost/performance risk;
- CENA acceptance question;
- exact screenshot needed to verify.

Never infer gameplay behavior from visual appearance. Do not add lore or real-world operational detail.
