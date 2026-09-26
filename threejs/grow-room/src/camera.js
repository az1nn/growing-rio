import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function createGrowRoomCamera(width, height) {
  const camera = new THREE.OrthographicCamera();
  camera.name = 'GrowRoomCamera';
  camera.position.set(...styleTokens.camera.position);
  camera.near = styleTokens.camera.near;
  camera.far = styleTokens.camera.far;
  camera.lookAt(...styleTokens.camera.target);
  updateGrowRoomCamera(camera, width, height);
  return camera;
}

export function updateGrowRoomCamera(camera, width, height) {
  const safeHeight = Math.max(1, height);
  const aspect = Math.max(0.1, width / safeHeight);
  const halfWidth = styleTokens.camera.orthographicWidth / 2;
  const halfHeight = halfWidth / aspect;

  camera.left = -halfWidth;
  camera.right = halfWidth;
  camera.top = halfHeight;
  camera.bottom = -halfHeight;
  camera.updateProjectionMatrix();
}
