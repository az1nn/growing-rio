import * as THREE from './vendor/three.module.js';
import { createInstitutionalCamera } from './camera.js';
import { addInstitutionalLighting } from './lighting.js';
import { createInstitutionalMaterials } from './materials.js';
import { populateInstitutional } from './props.js';
import { institutionalPresentationModel } from './presentationModel.js';
import { styleTokens } from './styleTokens.js';

export function createInstitutional(width,height) {
  const scene=new THREE.Scene();
  scene.background=new THREE.Color(styleTokens.palette.background);
  scene.fog=new THREE.Fog(styleTokens.palette.background,18,36);

  const root=new THREE.Group();
  root.name='InstitutionalForum';
  scene.add(root);

  const materials=createInstitutionalMaterials();
  populateInstitutional(root,materials,institutionalPresentationModel);
  addInstitutionalLighting(scene);
  const camera=createInstitutionalCamera(width,height);

  return {scene,camera,materials};
}

export function disposeInstitutional(scene) {
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
