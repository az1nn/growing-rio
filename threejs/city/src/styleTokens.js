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
    position:Object.freeze([10.2,8.6,13.4]),
    target:Object.freeze([0.2,1.35,0.15]),
    orthographicWidth:12.4,
    verticalBias:0.94,
    near:0.1,
    far:64
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
    ambientIntensity:0.82,
    keyIntensity:1.58,
    rimIntensity:0.64,
    practicalIntensity:30,
    practicalDistance:7.0
  }),
  render: Object.freeze({
    pixelRatioCap:1.5,
    shadows:false,
    toneMappingExposure:1.05,
    authoredTextureBudget:0
  }),
  scale: Object.freeze({
    gridUnit:0.5,
    minimumSilhouette:0.12,
    clusterGap:0.28
  })
});
