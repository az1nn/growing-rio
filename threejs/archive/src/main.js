import * as THREE from './vendor/three.module.js';
import { updateArchiveCamera } from './camera.js';
import { createArchive, disposeArchive } from './archive.js';
import { archivePresentationModel } from './presentationModel.js';
import { styleTokens } from './styleTokens.js';

const mount=document.querySelector('#scene');
if(!mount) throw new Error('3JS archive mount #scene not found');

const renderer=new THREE.WebGLRenderer({
  antialias:true,
  alpha:false,
  powerPreference:'high-performance'
});
renderer.outputColorSpace=THREE.SRGBColorSpace;
renderer.toneMapping=THREE.ACESFilmicToneMapping;
renderer.toneMappingExposure=styleTokens.render.toneMappingExposure;
renderer.shadowMap.enabled=styleTokens.render.shadows;
renderer.setPixelRatio(Math.min(window.devicePixelRatio||1,styleTokens.render.pixelRatioCap));
mount.appendChild(renderer.domElement);

const {scene,camera,materials}=createArchive(window.innerWidth,window.innerHeight);
let disposed=false;

function countSceneTextures() {
  const textures=new Set();
  scene.traverse(object=>{
    if(!object.material) return;
    const list=Array.isArray(object.material)?object.material:[object.material];
    list.forEach(material=>Object.values(material).forEach(value=>{
      if(value?.isTexture) textures.add(value);
    }));
  });
  return textures.size;
}

function collectMetrics() {
  return Object.freeze({
    renderer:'three@0.186.1',
    scene:'archive',
    styleStatus:archivePresentationModel.styleStatus,
    drawCalls:renderer.info.render.calls,
    triangles:renderer.info.render.triangles,
    points:renderer.info.render.points,
    lines:renderer.info.render.lines,
    geometries:renderer.info.memory.geometries,
    textures:countSceneTextures(),
    rendererTextures:renderer.info.memory.textures,
    materialCount:Object.keys(materials).length,
    archiveBoxCount:archivePresentationModel.archiveBoxes.length,
    evidenceDocumentCount:archivePresentationModel.documents.length,
    pixelRatio:renderer.getPixelRatio(),
    width:window.innerWidth,
    height:window.innerHeight,
    shadows:renderer.shadowMap.enabled,
  });
}

function render() {
  if(disposed) return;
  renderer.info.reset();
  renderer.render(scene,camera);
  window.__DA_LATA_3JS_METRICS__=collectMetrics();
  window.__DA_LATA_3JS_SCENE__='archive';
  window.__DA_LATA_3JS_READY__=true;
}

function resize() {
  if(disposed) return;
  const width=Math.max(1,window.innerWidth);
  const height=Math.max(1,window.innerHeight);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio||1,styleTokens.render.pixelRatioCap));
  renderer.setSize(width,height,false);
  updateArchiveCamera(camera,width,height);
  render();
}

function destroy() {
  if(disposed) return;
  disposed=true;
  window.removeEventListener('resize',resize);
  disposeArchive(scene);
  renderer.dispose();
  renderer.domElement.remove();
  window.__DA_LATA_3JS_READY__=false;
}

window.addEventListener('resize',resize,{passive:true});
window.__DA_LATA_3JS_DESTROY__=destroy;
resize();
