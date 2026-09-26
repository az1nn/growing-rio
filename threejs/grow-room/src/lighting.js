import * as THREE from './vendor/three.module.js';
import { styleTokens } from './styleTokens.js';

export function addGrowRoomLighting(scene) {
  const ambient = new THREE.AmbientLight(0x43616a, styleTokens.lighting.ambientIntensity);
  ambient.name = 'CoolAmbient';
  scene.add(ambient);

  const coolKey = new THREE.DirectionalLight(0xb4d3f1, styleTokens.lighting.keyIntensity);
  coolKey.name = 'CoolKey';
  coolKey.position.set(5.6, 9.2, 6.6);
  coolKey.target.position.set(0, 1.0, 0.55);
  scene.add(coolKey, coolKey.target);

  const warmPractical = new THREE.PointLight(
    0xff8b48,
    styleTokens.lighting.practicalIntensity,
    styleTokens.lighting.practicalDistance,
    2
  );
  warmPractical.name = 'WarmPractical';
  warmPractical.position.set(0.15, 3.65, 0.35);
  scene.add(warmPractical);
}
