// Presentation-only fictional placements. No real maps, roads, routes, addresses or district geometry.
const freezeTransforms = list => Object.freeze(list.map(item => Object.freeze({
  position:Object.freeze(item.position),
  scale:Object.freeze(item.scale),
})));

export const cityPresentationModel = Object.freeze({
  sceneId:'city',
  styleStatus:'CANDIDATE',
  referencePack:'docs/visual-references/3js-city',
  plasterBlocks:freezeTransforms([
    {position:[-3.15,0.70,1.55],scale:[1.10,1.30,0.95]},
    {position:[-1.82,0.62,1.72],scale:[0.92,1.12,0.84]},
    {position:[-0.45,0.92,0.62],scale:[1.18,1.72,0.92]},
    {position:[1.08,1.10,0.38],scale:[0.98,2.02,0.88]},
    {position:[2.52,1.45,-0.66],scale:[1.10,2.35,0.96]},
    {position:[3.65,1.28,-0.82],scale:[0.82,1.98,0.78]},
  ]),
  tealBlocks:freezeTransforms([
    {position:[-2.55,1.28,-0.28],scale:[0.86,1.34,0.82]},
    {position:[-1.25,1.55,-1.20],scale:[1.02,1.62,0.90]},
    {position:[0.15,1.72,-1.55],scale:[0.92,1.72,0.82]},
    {position:[1.45,1.96,-2.22],scale:[0.98,1.98,0.88]},
  ]),
  terracottaBlocks:freezeTransforms([
    {position:[-3.45,1.46,-1.25],scale:[0.78,1.26,0.72]},
    {position:[-2.05,1.86,-2.18],scale:[0.90,1.62,0.82]},
    {position:[-0.55,2.16,-2.66],scale:[0.82,1.56,0.74]},
    {position:[0.78,2.42,-3.05],scale:[0.86,1.66,0.76]},
  ]),
  warmWindows:Object.freeze([
    Object.freeze([-3.15,0.84,2.05]),
    Object.freeze([-1.82,0.72,2.17]),
    Object.freeze([-0.45,1.16,1.10]),
    Object.freeze([-2.55,1.45,0.18]),
    Object.freeze([-1.25,1.80,-0.74]),
    Object.freeze([0.15,2.00,-1.10]),
  ]),
  trees:Object.freeze([
    Object.freeze([-3.75,0.78,0.30]),
    Object.freeze([-2.95,1.22,-0.72]),
    Object.freeze([-1.95,1.54,-1.58]),
    Object.freeze([0.82,1.62,-0.64]),
    Object.freeze([2.10,1.72,-1.46]),
    Object.freeze([3.30,1.15,0.48]),
  ]),
});
