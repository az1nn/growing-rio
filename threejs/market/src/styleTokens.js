export const styleTokens = Object.freeze({
  palette: Object.freeze({ background:0x071014, concrete:0x465158, plaster:0x665a4b, teal:0x118b7f, metal:0x151b1f, wood:0x915b36, terracotta:0xc15d3e, glass:0x184f5d, warmLight:0xffa25f }),
  camera: Object.freeze({ position:Object.freeze([9.2,7.6,11.8]), target:Object.freeze([0.15,1.0,0.45]), orthographicWidth:11.0, verticalBias:0.82, near:0.1, far:58 }),
  material: Object.freeze({ flatShading:true, roughness:Object.freeze({ concrete:0.96, plaster:0.94, teal:0.62, metal:0.4, wood:0.78, terracotta:0.9, glass:0.32, warmLight:0.45 }) }),
  lighting: Object.freeze({ ambientIntensity:0.84, keyIntensity:1.66, rimIntensity:0.66, practicalIntensity:38, practicalDistance:6.2, backPracticalIntensity:14, backPracticalDistance:5.0 }),
  render: Object.freeze({ pixelRatioCap:1.5, shadows:false, toneMappingExposure:1.06, authoredTextureBudget:0 }),
  scale: Object.freeze({ gridUnit:0.5, minimumSilhouette:0.12, propClusterGap:0.34 }),
});
