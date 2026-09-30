# LENTE motion/video review prompt

Review the deterministic 4-second isolated-scene orbit clip together with the matching stills.

Focus on time-dependent issues that still images can hide:
- depth collapsing as camera angle changes;
- occlusion of focal or interactive objects;
- unstable silhouettes;
- flat or inconsistent material response;
- lighting that only works from one angle;
- distracting repetition;
- camera orbit exposing empty backsides or unfinished geometry;
- interaction affordances that disappear outside the hero angle.

Return up to 5 findings with:
- id: `MOTION-<scene>-NN`;
- timestamp/range when visible;
- evidence;
- hypothesis;
- affected scene/object;
- recommended owner;
- a deterministic before/after video check.

The orbit clip is diagnostic evidence, not a proposal to add orbiting camera motion to gameplay.
