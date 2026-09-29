// Presentation-only Archive placements. No research, evidence or canon mutation.
const freezeTransforms=list=>Object.freeze(list.map(item=>Object.freeze({
  position:Object.freeze(item.position),
  scale:Object.freeze(item.scale),
  rotation:Object.freeze(item.rotation||[0,0,0]),
})));

export const archivePresentationModel=Object.freeze({
  sceneId:'archive',
  styleStatus:'CANDIDATE',
  referencePack:'docs/visual-references/3js-archive',
  archiveBoxes:freezeTransforms([
    {position:[0.10,0.92,-2.50],scale:[0.70,0.44,0.42]},
    {position:[0.98,0.92,-2.50],scale:[0.62,0.44,0.42]},
    {position:[1.80,0.92,-2.50],scale:[0.68,0.44,0.42]},
    {position:[2.70,0.92,-2.50],scale:[0.76,0.44,0.42]},
    {position:[0.22,1.66,-2.50],scale:[0.84,0.42,0.42]},
    {position:[1.30,1.66,-2.50],scale:[0.72,0.42,0.42]},
    {position:[2.34,1.66,-2.50],scale:[0.80,0.42,0.42]},
    {position:[3.14,1.66,-2.50],scale:[0.46,0.42,0.42]}
  ]),
  documents:freezeTransforms([
    {position:[-1.60,1.38,1.34],scale:[0.64,0.035,0.44],rotation:[0,-0.16,0]},
    {position:[-1.18,1.405,1.58],scale:[0.58,0.035,0.38],rotation:[0,0.10,0]},
    {position:[-0.78,1.43,1.30],scale:[0.52,0.035,0.34],rotation:[0,0.18,0]}
  ]),
  sideStorage:freezeTransforms([
    {position:[-3.05,0.42,-0.45],scale:[1.25,0.82,1.15]},
    {position:[-2.76,1.12,-0.62],scale:[0.82,0.58,0.82]}
  ])
});
