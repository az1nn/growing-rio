import * as THREE from './vendor/three.module.min.js';
import { createOperationDiorama, disposeOperationDiorama, updateParityCamera } from './operationDiorama.js';

const mount = document.querySelector('#scene');
if (!mount) throw new Error('3JS mount #scene not found');

const renderer = new THREE.WebGLRenderer({
  antialias: true,
  alpha: false,
  powerPreference: 'high-performance',
});
renderer.outputColorSpace = THREE.SRGBColorSpace;
renderer.shadowMap.enabled = false;
renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 1.5));
mount.appendChild(renderer.domElement);

const { scene, camera, materials } = createOperationDiorama(window.innerWidth, window.innerHeight);
let disposed = false;

function collectMetrics() {
  return Object.freeze({
    renderer: 'three@0.186.1',
    drawCalls: renderer.info.render.calls,
    triangles: renderer.info.render.triangles,
    points: renderer.info.render.points,
    lines: renderer.info.render.lines,
    geometries: renderer.info.memory.geometries,
    textures: renderer.info.memory.textures,
    materialCount: Object.keys(materials).length,
    pixelRatio: renderer.getPixelRatio(),
    width: window.innerWidth,
    height: window.innerHeight,
    shadows: false,
  });
}

function render() {
  if (disposed) return;
  renderer.info.reset();
  renderer.render(scene, camera);
  window.__DA_LATA_3JS_METRICS__ = collectMetrics();
  window.__DA_LATA_3JS_READY__ = true;
}

function resize() {
  if (disposed) return;
  const width = Math.max(1, window.innerWidth);
  const height = Math.max(1, window.innerHeight);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 1.5));
  renderer.setSize(width, height, false);
  updateParityCamera(camera, width, height);
  render();
}

function destroy() {
  if (disposed) return;
  disposed = true;
  window.removeEventListener('resize', resize);
  disposeOperationDiorama(scene);
  renderer.dispose();
  renderer.domElement.remove();
  window.__DA_LATA_3JS_READY__ = false;
}

window.addEventListener('resize', resize, { passive: true });
window.__DA_LATA_3JS_DESTROY__ = destroy;
resize();
