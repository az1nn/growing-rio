import * as THREE from './vendor/three.module.js';
import { createMarketCamera } from './camera.js';
import { addMarketLighting } from './lighting.js';
import { createMarketMaterials } from './materials.js';
import { populateMarketDiorama } from './props.js';
import { marketPresentationModel } from './presentationModel.js';
import { styleTokens } from './styleTokens.js';

export function createMarketDiorama(width, height) {
  const scene = new THREE.Scene();
  scene.background = new THREE.Color(styleTokens.palette.background);
  scene.fog = new THREE.Fog(styleTokens.palette.background, 16, 31);

  const root = new THREE.Group();
  root.name = 'MarketDiorama';
  scene.add(root);

  const materials = createMarketMaterials();
  populateMarketDiorama(root, materials, marketPresentationModel);
  addMarketLighting(scene);

  const camera = createMarketCamera(width, height);
  return { scene, camera, materials };
}

export function disposeMarketDiorama(scene) {
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
