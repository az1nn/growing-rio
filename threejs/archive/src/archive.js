import * as THREE from './vendor/three.module.js';
import { createArchiveCamera } from './camera.js';
import { addArchiveLighting } from './lighting.js';
import { createArchiveMaterials } from './materials.js';
import { populateArchive } from './props.js';
import { archivePresentationModel } from './presentationModel.js';
import { styleTokens } from './styleTokens.js';

export function createArchive(width,height) {
  const scene=new THREE.Scene();
  scene.background=new THREE.Color(styleTokens.palette.background);
  scene.fog=new THREE.Fog(styleTokens.palette.background,18,36);

  const root=new THREE.Group();
  root.name='ArchiveEvidenceRoom';
  scene.add(root);

  const materials=createArchiveMaterials();
  populateArchive(root,materials,archivePresentationModel);
  addArchiveLighting(scene);
  const camera=createArchiveCamera(width,height);
  return {scene,camera,materials};
}

export function disposeArchive(scene) {
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
