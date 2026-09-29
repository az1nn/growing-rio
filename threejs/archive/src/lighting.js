import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function addArchiveLighting(scene) {
  const ambient=new THREE.AmbientLight(0x43616a,styleTokens.lighting.ambientIntensity);
  ambient.name='CoolArchiveAmbient';
  scene.add(ambient);

  const key=new THREE.DirectionalLight(0xb6d5ed,styleTokens.lighting.keyIntensity);
  key.name='CoolArchiveKey';
  key.position.set(6.4,9.4,7.0);
  key.target.position.set(-0.2,1.0,0.2);
  scene.add(key,key.target);

  const rim=new THREE.DirectionalLight(0x6c9fb9,styleTokens.lighting.rimIntensity);
  rim.name='CoolArchiveRim';
  rim.position.set(-6.2,5.4,-4.5);
  rim.target.position.set(0,1.35,-0.7);
  scene.add(rim,rim.target);

  const practical=new THREE.PointLight(0xff9652,styleTokens.lighting.practicalIntensity,styleTokens.lighting.practicalDistance,2);
  practical.name='WarmEvidenceDeskPractical';
  practical.position.set(0.38,2.72,1.35);
  scene.add(practical);
}
