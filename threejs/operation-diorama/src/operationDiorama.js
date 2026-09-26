import * as THREE from './vendor/three.module.js';
import { operationPresentationModel } from './presentationModel.js';

const palette = Object.freeze({
  background: new THREE.Color(0.034, 0.052, 0.061),
  concrete: new THREE.Color(0.245, 0.255, 0.24),
  teal: new THREE.Color(0.04, 0.255, 0.235),
  metal: new THREE.Color(0.105, 0.12, 0.125),
  wood: new THREE.Color(0.36, 0.215, 0.115),
  terracotta: new THREE.Color(0.52, 0.18, 0.085),
  foliage: new THREE.Color(0.065, 0.33, 0.16),
  glass: new THREE.Color(0.08, 0.29, 0.37),
  plaster: new THREE.Color(0.315, 0.29, 0.245),
});

function standard(color, roughness, metalness = 0) {
  return new THREE.MeshStandardMaterial({ color, roughness, metalness });
}

export function createOperationDiorama(width, height) {
  const scene = new THREE.Scene();
  scene.background = palette.background;

  const materials = Object.freeze({
    concrete: standard(palette.concrete, 0.93),
    teal: standard(palette.teal, 0.48, 0.04),
    metal: standard(palette.metal, 0.34, 0.72),
    wood: standard(palette.wood, 0.73),
    terracotta: standard(palette.terracotta, 0.9),
    foliage: standard(palette.foliage, 0.78),
    glass: standard(palette.glass, 0.24, 0.08),
    plaster: standard(palette.plaster, 0.96),
  });

  const box = new THREE.BoxGeometry(1, 1, 1);
  const planterGeometry = new THREE.CylinderGeometry(0.38, 0.48, 0.58, 12, 1, false);
  const planterRimGeometry = new THREE.CylinderGeometry(0.5, 0.5, 0.1, 12, 1, false);
  const canopyGeometry = new THREE.SphereGeometry(0.58, 10, 5);

  const root = new THREE.Group();
  root.name = 'OperationDiorama';
  scene.add(root);

  const addBox = (name, size, position, material, rotation = [0, 0, 0]) => {
    const mesh = new THREE.Mesh(box, material);
    mesh.name = name;
    mesh.scale.set(...size);
    mesh.position.set(...position);
    mesh.rotation.set(...rotation);
    root.add(mesh);
    return mesh;
  };

  const instanceTransform = new THREE.Object3D();
  const addInstances = (name, geometry, instances, material) => {
    const mesh = new THREE.InstancedMesh(geometry, material, instances.length);
    mesh.name = name;
    instances.forEach(({ position, scale = [1, 1, 1], rotation = [0, 0, 0] }, index) => {
      instanceTransform.position.set(...position);
      instanceTransform.scale.set(...scale);
      instanceTransform.rotation.set(...rotation);
      instanceTransform.updateMatrix();
      mesh.setMatrixAt(index, instanceTransform.matrix);
    });
    mesh.instanceMatrix.needsUpdate = true;
    root.add(mesh);
    return mesh;
  };

  addBox('Floor', [7.4, 0.22, 11], [0, -0.11, 1.5], materials.concrete);
  addBox('BackWall', [7.4, 4.8, 0.22], [0, 2.4, -3.89], materials.plaster);
  addBox('SideWall', [0.22, 4.8, 8], [-3.59, 2.4, 0], materials.plaster);

  addBox('WindowPanel', [2.55, 1.75, 0.12], [1.35, 2.72, -3.75], materials.glass);
  addBox('WindowTrimTop', [2.9, 0.1, 0.1], [1.35, 3.62, -3.67], materials.metal);
  addBox('WindowTrimBottom', [2.9, 0.1, 0.1], [1.35, 1.82, -3.67], materials.metal);
  addBox('WindowTrimLeft', [0.1, 1.95, 0.1], [-0.02, 2.72, -3.67], materials.metal);
  addBox('WindowTrimRight', [0.1, 1.95, 0.1], [2.72, 2.72, -3.67], materials.metal);
  addBox('WindowMullionVertical', [0.1, 1.95, 0.1], [1.35, 2.72, -3.67], materials.metal);
  addBox('WindowMullionHorizontal', [2.9, 0.1, 0.1], [1.35, 2.72, -3.67], materials.metal);

  addBox('MetalDoor', [1.2, 2.3, 0.12], [-2.18, 1.15, -3.75], materials.metal);
  addBox('DoorFrameTop', [1.45, 0.1, 0.1], [-2.18, 2.36, -3.66], materials.metal);
  addBox('DoorFrameLeft', [0.1, 2.34, 0.1], [-2.81, 1.18, -3.66], materials.metal);
  addBox('DoorFrameRight', [0.1, 2.34, 0.1], [-1.55, 1.18, -3.66], materials.metal);
  addBox('DoorThreshold', [1.35, 0.04, 0.42], [-2.18, 0.03, -3.43], materials.metal);

  addBox('TileCounter', [3.6, 0.9, 1.1], [0.65, 0.45, -2.25], materials.teal);
  addBox('CounterTop', [3.92, 0.13, 1.34], [0.65, 0.965, -2.25], materials.wood);
  for (const x of [-0.55, 0.65, 1.85]) {
    addBox(`CounterFront-${x}`, [0.98, 0.62, 0.06], [x, 0.47, -1.67], materials.wood);
    addBox(`CounterHandle-${x}`, [0.24, 0.05, 0.05], [x, 0.62, -1.625], materials.metal);
  }

  addBox('ShelfLeftPost', [0.12, 2.7, 0.12], [-3.05, 1.35, -0.45], materials.metal);
  addBox('ShelfRightPost', [0.12, 2.7, 0.12], [-1.02, 1.35, -0.45], materials.metal);
  for (const y of [0.7, 1.48, 2.28]) {
    addBox(`Shelf-${y}`, [2.2, 0.12, 0.72], [-2.04, y, -0.45], materials.wood);
  }

  addBox('BackWallTileBand', [3.1, 0.82, 0.06], [1.35, 0.58, -3.66], materials.teal);
  addBox('SideWallTileBand', [0.06, 0.82, 6.8], [-3.46, 0.58, 0.3], materials.teal);

  for (const z of [-2.45, 0, 2.45, 4.9]) {
    addBox(`FloorJoint-${z}`, [7.018, 0.012, 0.1], [0, 0.008, z], materials.metal);
  }
  addBox('FloorJointSpine', [10.498, 0.012, 0.1], [0.35, 0.008, 1.5], materials.metal, [0, Math.PI / 2, 0]);

  addBox('ForegroundApron', [6.8, 0.14, 2.4], [0, -0.18, 8.2], materials.concrete);
  addBox('ForegroundApronEdge', [6.67, 0.012, 0.1], [0, -0.095, 9.35], materials.metal);
  addBox('ForegroundServicePlinth', [5.8, 0.22, 2.8], [0, -0.33, 10.8], materials.concrete);
  addBox('ForegroundServiceRailLeft', [2.32, 0.012, 0.1], [-1.45, -0.208, 10.65], materials.metal, [0, Math.PI / 2, 0]);
  addBox('ForegroundServiceRailRight', [2.32, 0.012, 0.1], [1.45, -0.208, 10.65], materials.metal, [0, Math.PI / 2, 0]);
  addBox('ForegroundServiceEdge', [5.8, 0.012, 0.1], [0, -0.208, 12.15], materials.metal);
  addBox('ForegroundServiceLanding', [4.6, 0.18, 3.6], [0, -0.5, 14.1], materials.concrete);
  addBox('ForegroundServiceLandingEdge', [4.64, 0.012, 0.1], [0, -0.398, 15.85], materials.metal);

  const canopyOffsets = [
    [0, 0.75, 0, [1, 0.93, 1]],
    [-0.06, 1.09, -0.03, [0.6, 0.58, 0.6]],
    [-0.35, 0.78, -0.03, [0.5, 0.46, 0.5]],
    [0.33, 0.8, 0.06, [0.5, 0.48, 0.5]],
  ];

  const planterInstances = operationPresentationModel.planters.map(({ position }) => ({
    position,
  }));
  const rimInstances = operationPresentationModel.planters.map(({ position: [x, _y, z] }) => ({
    position: [x, 0.5, z],
  }));
  const stemInstances = operationPresentationModel.planters.map(({ position: [x, _y, z] }) => ({
    position: [x, 0.67, z],
    scale: [0.18, 0.82, 0.18],
  }));
  const canopyInstances = operationPresentationModel.planters.flatMap(({ position: [x, _y, z] }) =>
    canopyOffsets.map(([ox, oy, oz, scale]) => ({
      position: [x + ox, oy, z + oz],
      scale,
    }))
  );

  addInstances('Planters', planterGeometry, planterInstances, materials.terracotta);
  addInstances('PlanterRims', planterRimGeometry, rimInstances, materials.terracotta);
  addInstances('Stems', planterGeometry, stemInstances, materials.foliage);
  addInstances('Canopies', canopyGeometry, canopyInstances, materials.foliage);

  addBox('StorageCrateA', [1, 0.72, 0.82], [-2.7, 0.36, 2.55], materials.wood);
  addBox('StorageCrateB', [1, 0.72, 0.82], [-1.75, 0.36, 2.83], materials.metal);

  const ambient = new THREE.AmbientLight(new THREE.Color(0.26, 0.34, 0.31), 1.15);
  ambient.name = 'Ambient';
  scene.add(ambient);

  const coolKey = new THREE.DirectionalLight(new THREE.Color(0.72, 0.84, 0.94), 1.65);
  coolKey.name = 'CoolKey';
  coolKey.position.set(4.5, 8, 5.5);
  coolKey.target.position.set(0, 0.8, 1.5);
  scene.add(coolKey, coolKey.target);

  const warmPractical = new THREE.PointLight(new THREE.Color(1, 0.55, 0.31), 42, 5.2, 2);
  warmPractical.name = 'WarmPractical';
  warmPractical.position.set(0.7, 3.15, -1.05);
  scene.add(warmPractical);

  const camera = new THREE.OrthographicCamera();
  camera.name = 'ParityCamera';
  camera.position.set(...operationPresentationModel.camera.position);
  camera.rotation.set(...operationPresentationModel.camera.rotation);
  camera.near = operationPresentationModel.camera.near;
  camera.far = operationPresentationModel.camera.far;
  updateParityCamera(camera, width, height);

  return { scene, camera, materials };
}

export function updateParityCamera(camera, width, height) {
  const safeHeight = Math.max(1, height);
  const aspect = Math.max(0.1, width / safeHeight);
  const halfWidth = operationPresentationModel.camera.orthographicWidth / 2;
  const halfHeight = halfWidth / aspect;
  camera.left = -halfWidth;
  camera.right = halfWidth;
  camera.top = halfHeight;
  camera.bottom = -halfHeight;
  camera.updateProjectionMatrix();
}

export function disposeOperationDiorama(scene) {
  const geometries = new Set();
  const materials = new Set();
  scene.traverse((object) => {
    if (object.geometry) geometries.add(object.geometry);
    if (object.material) {
      const objectMaterials = Array.isArray(object.material) ? object.material : [object.material];
      objectMaterials.forEach((material) => materials.add(material));
    }
  });
  geometries.forEach((geometry) => geometry.dispose());
  materials.forEach((material) => material.dispose());
}
