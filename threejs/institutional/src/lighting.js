import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function addInstitutionalLighting(scene) {
  const ambient=new THREE.AmbientLight(0x43616a,styleTokens.lighting.ambientIntensity);
  ambient.name='CoolInstitutionalAmbient';
  scene.add(ambient);

  const key=new THREE.DirectionalLight(0xb4d3f1,styleTokens.lighting.keyIntensity);
  key.name='CoolInstitutionalKey';
  key.position.set(6.2,9.8,7.6);
  key.target.position.set(0,1.1,0);
  scene.add(key,key.target);

  const rim=new THREE.DirectionalLight(0x6c9fb9,styleTokens.lighting.rimIntensity);
  rim.name='CoolInstitutionalRim';
  rim.position.set(-6.5,5.8,-4.2);
  rim.target.position.set(0,1.4,-0.6);
  scene.add(rim,rim.target);

  const left=new THREE.PointLight(0xff9856,styleTokens.lighting.practicalIntensity,styleTokens.lighting.practicalDistance,2);
  left.name='WarmPracticalLeft';
  left.position.set(-3.10,3.10,-0.45);
  scene.add(left);

  const right=new THREE.PointLight(0xff9856,styleTokens.lighting.practicalIntensity,styleTokens.lighting.practicalDistance,2);
  right.name='WarmPracticalRight';
  right.position.set(3.10,3.10,-0.45);
  scene.add(right);
}
