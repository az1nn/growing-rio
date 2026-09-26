import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

function material(color, roughness, metalness=0, extra={}) {
  return new THREE.MeshStandardMaterial({ color, roughness, metalness, flatShading:styleTokens.material.flatShading, ...extra });
}
export function createMarketMaterials() {
  const { palette, material:token } = styleTokens;
  return Object.freeze({
    concrete:material(palette.concrete,token.roughness.concrete),
    plaster:material(palette.plaster,token.roughness.plaster),
    teal:material(palette.teal,token.roughness.teal,0.04),
    metal:material(palette.metal,token.roughness.metal,0.68),
    wood:material(palette.wood,token.roughness.wood),
    terracotta:material(palette.terracotta,token.roughness.terracotta),
    glass:material(palette.glass,token.roughness.glass,0.08),
    warmLight:material(palette.warmLight,token.roughness.warmLight,0.02,{emissive:palette.warmLight,emissiveIntensity:0.58}),
  });
}
