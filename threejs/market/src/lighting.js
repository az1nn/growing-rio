import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function addMarketLighting(scene) {
  const ambient=new THREE.AmbientLight(0x43616a,styleTokens.lighting.ambientIntensity); ambient.name='CoolIndustrialAmbient'; scene.add(ambient);
  const key=new THREE.DirectionalLight(0xb4d3f1,styleTokens.lighting.keyIntensity); key.name='CoolIndustrialKey'; key.position.set(5.8,9.4,8.2); key.target.position.set(0,0.9,0.4); scene.add(key,key.target);
  const rim=new THREE.DirectionalLight(0x6c9fb9,styleTokens.lighting.rimIntensity); rim.name='CoolAisleRim'; rim.position.set(-6.6,5.4,-3.4); rim.target.position.set(0.5,1.2,1); scene.add(rim,rim.target);
  const warm=new THREE.PointLight(0xff8b48,styleTokens.lighting.practicalIntensity,styleTokens.lighting.practicalDistance,2); warm.name='WarmVendorPractical'; warm.position.set(-1.3,3.25,0.45); scene.add(warm);
  const back=new THREE.PointLight(0xffa05a,styleTokens.lighting.backPracticalIntensity,styleTokens.lighting.backPracticalDistance,2); back.name='WarmLoadingPractical'; back.position.set(2.55,2.75,-2.8); scene.add(back);
}
