export const styleTokens = Object.freeze({
  palette: Object.freeze({
    background:0x071014,
    concrete:0x353f44,
    plaster:0x645b4e,
    teal:0x118b7f,
    metal:0x151b1f,
    wood:0x895331,
    paper:0xb0a486,
    warmLight:0xff9b54
  }),
  camera: Object.freeze({
    position:Object.freeze([8.8,6.8,10.8]),
    target:Object.freeze([0,1.18,0.35]),
    orthographicWidth:10.2,
    verticalBias:0.76,
    near:0.1,
    far:56
  }),
  material: Object.freeze({
    flatShading:true,
    roughness:Object.freeze({
      concrete:0.95,
      plaster:0.93,
      teal:0.64,
      metal:0.42,
      wood:0.80,
      paper:0.96,
      warmLight:0.44
    })
  }),
  lighting: Object.freeze({
    ambientIntensity:0.80,
    keyIntensity:1.48,
    rimIntensity:0.62,
    practicalIntensity:19,
    practicalDistance:6.0
  }),
  render: Object.freeze({
    pixelRatioCap:1.5,
    shadows:false,
    toneMappingExposure:1.05,
    authoredTextureBudget:0
  }),
  scale: Object.freeze({
    gridUnit:0.5,
    minimumSilhouette:0.12
  })
});
