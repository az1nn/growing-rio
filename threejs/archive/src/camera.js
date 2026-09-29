import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function createArchiveCamera(width,height) {
  const camera=new THREE.OrthographicCamera();
  camera.name='ArchiveCamera';
  camera.position.set(...styleTokens.camera.position);
  camera.near=styleTokens.camera.near;
  camera.far=styleTokens.camera.far;
  camera.lookAt(...styleTokens.camera.target);
  updateArchiveCamera(camera,width,height);
  return camera;
}

export function updateArchiveCamera(camera,width,height) {
  const aspect=Math.max(0.1,width/Math.max(1,height));
  const halfWidth=styleTokens.camera.orthographicWidth/2;
  const halfHeight=halfWidth/aspect;
  camera.left=-halfWidth;
  camera.right=halfWidth;
  camera.top=halfHeight+styleTokens.camera.verticalBias;
  camera.bottom=-halfHeight+styleTokens.camera.verticalBias;
  camera.updateProjectionMatrix();
}
