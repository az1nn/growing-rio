import * as THREE from './vendor/three.module.js';
import { createMarketCamera } from './camera.js';
import { addMarketLighting } from './lighting.js';
import { createMarketMaterials } from './materials.js';
import { populateMarket } from './props.js';
import { marketPresentationModel } from './presentationModel.js';
import { styleTokens } from './styleTokens.js';

export function createMarket(width,height) {
  const scene=new THREE.Scene();
  scene.background=new THREE.Color(styleTokens.palette.background);
  scene.fog=new THREE.Fog(styleTokens.palette.background,17,34);
  const root=new THREE.Group(); root.name='Market'; scene.add(root);
  const materials=createMarketMaterials();
  populateMarket(root,materials,marketPresentationModel);
  addMarketLighting(scene);
  const camera=createMarketCamera(width,height);
  return {scene,camera,materials};
}
export function disposeMarket(scene) {
  const geometries=new Set(),materials=new Set();
  scene.traverse(object=>{
    if(object.geometry) geometries.add(object.geometry);
    if(!object.material) return;
    const list=Array.isArray(object.material)?object.material:[object.material];
    list.forEach(material=>materials.add(material));
  });
  geometries.forEach(geometry=>geometry.dispose());
  materials.forEach(material=>material.dispose());
}
