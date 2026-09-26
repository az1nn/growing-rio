import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function createMarketCamera(width, height) {
  const camera = new THREE.OrthographicCamera();
  camera.name = 'MarketCamera';
  camera.position.set(...styleTokens.camera.position);
  camera.near = styleTokens.camera.near;
  camera.far = styleTokens.camera.far;
  camera.lookAt(...styleTokens.camera.target);
  updateMarketCamera(camera, width, height);
  return camera;
}

export function updateMarketCamera(camera, width, height) {
  const safeHeight = Math.max(1, height);
  const aspect = Math.max(0.1, width / safeHeight);
  const halfWidth = styleTokens.camera.orthographicWidth / 2;
  const halfHeight = halfWidth / aspect;

  camera.left = -halfWidth;
  camera.right = halfWidth;
  camera.top = halfHeight + styleTokens.camera.verticalBias;
  camera.bottom = -halfHeight + styleTokens.camera.verticalBias;
  camera.updateProjectionMatrix();
}
