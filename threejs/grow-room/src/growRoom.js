import * as THREE from './vendor/three.module.js';
import { createGrowRoomCamera } from './camera.js';
import { addGrowRoomLighting } from './lighting.js';
import { createGrowRoomMaterials } from './materials.js';
import { populateGrowRoom } from './props.js';
import { growRoomPresentationModel } from './presentationModel.js';
import { styleTokens } from './styleTokens.js';

export function createGrowRoom(width, height) {
  const scene = new THREE.Scene();
  scene.background = new THREE.Color(styleTokens.palette.background);
  scene.fog = new THREE.Fog(styleTokens.palette.background, 16, 31);

  const root = new THREE.Group();
  root.name = 'GrowRoom';
  scene.add(root);

  const materials = createGrowRoomMaterials();
  populateGrowRoom(root, materials, growRoomPresentationModel);
  addGrowRoomLighting(scene);

  const camera = createGrowRoomCamera(width, height);

  return { scene, camera, materials };
}

export function disposeGrowRoom(scene) {
  const geometries = new Set();
  const materials = new Set();

  scene.traverse((object) => {
    if (object.geometry) geometries.add(object.geometry);
    if (!object.material) return;
    const objectMaterials = Array.isArray(object.material) ? object.material : [object.material];
    objectMaterials.forEach((material) => materials.add(material));
  });

  geometries.forEach((geometry) => geometry.dispose());
  materials.forEach((material) => material.dispose());
}
