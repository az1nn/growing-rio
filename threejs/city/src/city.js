import * as THREE from './vendor/three.module.js';
import { createCityCamera } from './camera.js';
import { addCityLighting } from './lighting.js';
import { createCityMaterials } from './materials.js';
import { populateCity } from './props.js';
import { cityPresentationModel } from './presentationModel.js';
import { styleTokens } from './styleTokens.js';

export function createCity(width,height) {
  const scene=new THREE.Scene();
  scene.background=new THREE.Color(styleTokens.palette.background);
  scene.fog=new THREE.Fog(styleTokens.palette.background,19,38);

  const root=new THREE.Group();
  root.name='City';
  scene.add(root);

  const materials=createCityMaterials();
  populateCity(root,materials,cityPresentationModel);
  addCityLighting(scene);
  const camera=createCityCamera(width,height);

  return {scene,camera,materials};
}

export function disposeCity(scene) {
  const geometries=new Set();
  const materials=new Set();
  scene.traverse(object=>{
    if(object.geometry) geometries.add(object.geometry);
    if(!object.material) return;
    const list=Array.isArray(object.material)?object.material:[object.material];
    list.forEach(material=>materials.add(material));
  });
  geometries.forEach(geometry=>geometry.dispose());
  materials.forEach(material=>material.dispose());
}
