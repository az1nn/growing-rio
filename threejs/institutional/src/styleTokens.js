export const styleTokens = Object.freeze({
  palette: Object.freeze({
    background:0x071014,
    concrete:0x465158,
    plaster:0x766351,
    teal:0x118b7f,
    metal:0x151b1f,
    wood:0x915b36,
    terracotta:0xc15d3e,
    foliage:0x315f4b,
    warmLight:0xffa25f
  }),
  camera: Object.freeze({
    position:Object.freeze([9.2,7.8,11.8]),
    target:Object.freeze([0,1.15,0.25]),
    orthographicWidth:10.8,
    verticalBias:0.78,
    near:0.1,
    far:60
  }),
  material: Object.freeze({
    flatShading:true,
    roughness:Object.freeze({
      concrete:0.96,
      plaster:0.94,
      teal:0.62,
      metal:0.4,
      wood:0.78,
      terracotta:0.9,
      foliage:0.92,
      warmLight:0.45
    })
  }),
  lighting: Object.freeze({
    ambientIntensity:0.84,
    keyIntensity:1.62,
    rimIntensity:0.68,
    practicalIntensity:20,
    practicalDistance:6.2
  }),
  render: Object.freeze({
    pixelRatioCap:1.5,
    shadows:false,
    toneMappingExposure:1.06,
    authoredTextureBudget:0
  }),
  scale: Object.freeze({
    gridUnit:0.5,
    minimumSilhouette:0.12,
    proposalSpacing:1.8
  })
});
