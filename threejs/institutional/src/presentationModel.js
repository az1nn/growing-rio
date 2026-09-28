// Presentation-only fictional placements. No policy semantics, real institutions or electoral content.
const freezeTransforms = list => Object.freeze(list.map(item => Object.freeze({
  position:Object.freeze(item.position),
  scale:Object.freeze(item.scale),
})));

export const institutionalPresentationModel = Object.freeze({
  sceneId:'institutional',
  styleStatus:'CANDIDATE',
  referencePack:'docs/visual-references/3js-institutional',
  proposals:freezeTransforms([
    {position:[-1.8,0.54,0.10],scale:[1.10,0.92,1.10]},
    {position:[0.0,0.54,0.10],scale:[1.10,0.92,1.10]},
    {position:[1.8,0.54,0.10],scale:[1.10,0.92,1.10]},
  ]),
  archiveModules:freezeTransforms([
    {position:[-2.80,1.58,-2.30],scale:[1.05,2.65,0.52]},
    {position:[-1.52,1.58,-2.30],scale:[1.05,2.65,0.52]},
    {position:[1.52,1.58,-2.30],scale:[1.05,2.65,0.52]},
    {position:[2.80,1.58,-2.30],scale:[1.05,2.65,0.52]},
  ]),
  archiveCards:Object.freeze([
    Object.freeze([-2.80,1.72,-2.01]),
    Object.freeze([-1.52,1.72,-2.01]),
    Object.freeze([1.52,1.72,-2.01]),
    Object.freeze([2.80,1.72,-2.01]),
  ]),
  plants:Object.freeze([
    Object.freeze([-3.35,0.62,-0.95]),
    Object.freeze([3.35,0.62,-0.95]),
  ]),
});
