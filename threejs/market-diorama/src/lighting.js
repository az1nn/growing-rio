import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function addMarketLighting(scene) {
  const ambient = new THREE.AmbientLight(0x43616a, styleTokens.lighting.ambientIntensity);
  ambient.name = 'CoolAmbient';
  scene.add(ambient);

  const coolKey = new THREE.DirectionalLight(0xb4d3f1, styleTokens.lighting.keyIntensity);
  coolKey.name = 'CoolKey';
  coolKey.position.set(6.4, 8.8, 7.4);
  coolKey.target.position.set(-0.65, 1.0, 0.95);
  scene.add(coolKey, coolKey.target);

  const coolRim = new THREE.DirectionalLight(0x6c9fb9, styleTokens.lighting.rimIntensity);
  coolRim.name = 'CoolRim';
  coolRim.position.set(-6.2, 5.8, -2.8);
  coolRim.target.position.set(0.5, 1.2, 1.35);
  scene.add(coolRim, coolRim.target);

  const warmPractical = new THREE.PointLight(
    0xff8b48,
    styleTokens.lighting.practicalIntensity,
    styleTokens.lighting.practicalDistance,
    2
  );
  warmPractical.name = 'WarmPractical';
  warmPractical.position.set(-1.05, 2.75, 3.0);
  scene.add(warmPractical);

  const warmBackPractical = new THREE.PointLight(
    0xffa05a,
    styleTokens.lighting.backPracticalIntensity,
    styleTokens.lighting.backPracticalDistance,
    2
  );
  warmBackPractical.name = 'WarmBackPractical';
  warmBackPractical.position.set(-2.65, 2.85, -1.95);
  scene.add(warmBackPractical);
}
