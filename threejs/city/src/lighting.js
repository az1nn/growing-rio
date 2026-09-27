import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function addCityLighting(scene) {
  const ambient=new THREE.AmbientLight(0x43616a,styleTokens.lighting.ambientIntensity);
  ambient.name='CoolCityAmbient';
  scene.add(ambient);

  const key=new THREE.DirectionalLight(0xb4d3f1,styleTokens.lighting.keyIntensity);
  key.name='CoolCityKey';
  key.position.set(6.6,10.4,8.8);
  key.target.position.set(0.2,1.3,0);
  scene.add(key,key.target);

  const rim=new THREE.DirectionalLight(0x6c9fb9,styleTokens.lighting.rimIntensity);
  rim.name='CoolRidgeRim';
  rim.position.set(-7.2,6.2,-4.8);
  rim.target.position.set(0.5,1.8,-0.8);
  scene.add(rim,rim.target);

  const warm=new THREE.PointLight(
    0xff9856,
    styleTokens.lighting.practicalIntensity,
    styleTokens.lighting.practicalDistance,
    2
  );
  warm.name='WarmNeighborhoodPractical';
  warm.position.set(-1.4,3.5,-0.6);
  scene.add(warm);
}
