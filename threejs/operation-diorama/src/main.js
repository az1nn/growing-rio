import * as THREE from './vendor/three.module.js';
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
const V1_PIXEL_SCALE = 2;
renderer.setPixelRatio(1);
renderer.domElement.style.imageRendering = 'pixelated';
mount.appendChild(renderer.domElement);

const { scene, camera, materials } = createOperationDiorama(window.innerWidth, window.innerHeight);
let disposed = false;

function countSceneTextures() {
  const textures = new Set();
  scene.traverse((object) => {
    if (!object.material) return;
    const objectMaterials = Array.isArray(object.material) ? object.material : [object.material];
    objectMaterials.forEach((material) => {
      Object.values(material).forEach((value) => {
        if (value?.isTexture) textures.add(value);
      });
    });
  });
  return textures.size;
}

function collectMetrics() {
  return Object.freeze({
    renderer: 'three@0.186.1',
    drawCalls: renderer.info.render.calls,
    triangles: renderer.info.render.triangles,
    points: renderer.info.render.points,
    lines: renderer.info.render.lines,
    geometries: renderer.info.memory.geometries,
    textures: countSceneTextures(),
    rendererTextures: renderer.info.memory.textures,
    materialCount: Object.keys(materials).length,
    pixelRatio: renderer.getPixelRatio(),
    pixelScale: V1_PIXEL_SCALE,
    width: window.innerWidth,
    height: window.innerHeight,
    framebufferWidth: renderer.domElement.width,
    framebufferHeight: renderer.domElement.height,
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
  renderer.setPixelRatio(1);
  renderer.setSize(Math.ceil(width / V1_PIXEL_SCALE), Math.ceil(height / V1_PIXEL_SCALE), false);
  renderer.domElement.style.width = `${width}px`;
  renderer.domElement.style.height = `${height}px`;
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
