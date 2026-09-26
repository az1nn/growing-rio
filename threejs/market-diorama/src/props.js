import * as THREE from './vendor/three.module.js';

export function populateMarketDiorama(root, materials, presentationModel) {
  const box = new THREE.BoxGeometry(1, 1, 1);
  const wheelGeometry = new THREE.CylinderGeometry(0.22, 0.22, 0.12, 10, 1, false);

  const addBox = (name, size, position, material, rotation = [0, 0, 0]) => {
    const mesh = new THREE.Mesh(box, material);
    mesh.name = name;
    mesh.scale.set(...size);
    mesh.position.set(...position);
    mesh.rotation.set(...rotation);
    root.add(mesh);
    return mesh;
  };

  const transform = new THREE.Object3D();
  const addInstances = (name, geometry, instances, material) => {
    const mesh = new THREE.InstancedMesh(geometry, material, instances.length);
    mesh.name = name;

    instances.forEach(({ position, scale = [1, 1, 1], rotation = [0, 0, 0] }, index) => {
      transform.position.set(...position);
      transform.scale.set(...scale);
      transform.rotation.set(...rotation);
      transform.updateMatrix();
      mesh.setMatrixAt(index, transform.matrix);
    });

    mesh.instanceMatrix.needsUpdate = true;
    root.add(mesh);
    return mesh;
  };

  // Original fictional wholesale/deal bay. These are presentation silhouettes only:
  // no real routes, quantities, timing, contacts, sourcing, concealment or logistics procedure.
  addBox('MarketFloor', [9.4, 0.28, 12.2], [0, -0.14, 1.0], materials.concrete);
  addBox('BackWall', [9.4, 5.6, 0.28], [0, 2.8, -4.9], materials.plaster);
  addBox('SideWall', [0.28, 5.6, 10.0], [-4.56, 2.8, -0.4], materials.plaster);
  addBox('ForegroundThreshold', [8.6, 0.18, 2.0], [0.1, -0.27, 7.35], materials.concrete);
  addBox('ForegroundThresholdEdge', [8.55, 0.08, 0.12], [0.1, -0.15, 8.3], materials.metal);

  addInstances('ServiceLaneInlays', box, [
    { position: [-0.65, 0.02, -0.2], scale: [0.08, 0.035, 8.2] },
    { position: [1.15, 0.02, -0.2], scale: [0.08, 0.035, 8.2] },
    { position: [0.25, 0.02, 4.4], scale: [2.0, 0.035, 0.08] },
  ], materials.teal);

  addBox('BackTealBand', [8.7, 0.7, 0.09], [0.05, 0.48, -4.71], materials.teal);
  addBox('SideTealBand', [0.09, 0.7, 9.0], [-4.37, 0.48, -0.35], materials.teal);

  // Foreground deal/contract counter.
  addBox('DealCounterBase', [4.35, 0.95, 1.15], [-1.0, 0.48, 3.55], materials.teal);
  addBox('DealCounterTop', [4.65, 0.16, 1.4], [-1.0, 1.03, 3.55], materials.wood);
  addInstances('DealCounterFrontRhythm', box, [
    { position: [-2.45, 0.55, 4.14], scale: [0.08, 0.62, 0.08] },
    { position: [-1.5, 0.55, 4.14], scale: [0.08, 0.62, 0.08] },
    { position: [-0.55, 0.55, 4.14], scale: [0.08, 0.62, 0.08] },
    { position: [0.4, 0.55, 4.14], scale: [0.08, 0.62, 0.08] },
  ], materials.metal);
  addInstances('CounterDressing', box, [
    { position: [-2.0, 1.18, 3.5], scale: [0.36, 0.16, 0.26] },
    { position: [-1.38, 1.14, 3.56], scale: [0.22, 0.1, 0.36] },
    { position: [-0.12, 1.16, 3.5], scale: [0.42, 0.13, 0.28] },
  ], materials.terracotta);

  // Mid-ground vendor/storage bay.
  addBox('VendorStorageBayHeader', [2.65, 0.16, 0.82], [-2.78, 2.75, -0.9], materials.wood);
  addInstances('VendorStoragePosts', box, [
    { position: [-3.92, 1.45, -0.9], scale: [0.11, 2.75, 0.11] },
    { position: [-1.64, 1.45, -0.9], scale: [0.11, 2.75, 0.11] },
  ], materials.metal);
  addInstances('VendorShelves', box, [
    { position: [-2.78, 0.42, -0.9], scale: [2.35, 0.1, 0.84] },
    { position: [-2.78, 1.08, -0.9], scale: [2.35, 0.1, 0.84] },
    { position: [-2.78, 1.75, -0.9], scale: [2.35, 0.1, 0.84] },
  ], materials.wood);
  addInstances(
    'StorageCrates',
    box,
    presentationModel.storageCrates.map(({ position, scale }) => ({ position, scale })),
    materials.terracotta
  );

  // Background service/loading rhythm: stylized architecture, not a logistics diagram.
  addBox('LoadingShutterFrame', [3.25, 3.4, 0.12], [2.3, 2.05, -4.63], materials.metal);
  addInstances('LoadingShutterRhythm', box, Array.from({ length: 9 }, (_, index) => ({
    position: [2.3, 0.58 + index * 0.37, -4.5],
    scale: [2.85, 0.08, 0.08],
  })), materials.teal);
  addInstances('LoadingSideFrame', box, [
    { position: [0.83, 2.05, -4.48], scale: [0.1, 3.5, 0.1] },
    { position: [3.77, 2.05, -4.48], scale: [0.1, 3.5, 0.1] },
  ], materials.metal);

  // Repeated roof/aisle structure strengthens longitudinal depth.
  addInstances('OverheadBayBeams', box, presentationModel.overheadBays.flatMap(({ position: [x, y, z] }) => [
    { position: [x, y, z], scale: [6.6, 0.12, 0.12], rotation: [0, 0.0, -0.035] },
    { position: [x - 2.7, y - 1.7, z], scale: [0.1, 3.4, 0.1] },
  ]), materials.metal);
  addInstances('OverheadPracticalBars', box, [
    { position: [-2.55, 3.62, -1.05], scale: [1.45, 0.07, 0.14] },
    { position: [-1.05, 2.55, 3.25], scale: [2.4, 0.07, 0.14] },
  ], materials.warmLight);

  // One generic commerce trolley silhouette; no route or distribution semantics.
  addInstances('CommerceTrolleySurfaces', box, [
    { position: [2.75, 0.78, 1.55], scale: [1.45, 0.12, 0.95] },
    { position: [2.75, 0.28, 1.55], scale: [1.25, 0.1, 0.78] },
  ], materials.wood);
  addInstances('CommerceTrolleyFrame', box, [
    { position: [2.2, 0.38, 1.18], scale: [0.08, 0.78, 0.08] },
    { position: [3.3, 0.38, 1.18], scale: [0.08, 0.78, 0.08] },
    { position: [2.2, 0.38, 1.92], scale: [0.08, 0.78, 0.08] },
    { position: [3.3, 0.38, 1.92], scale: [0.08, 0.78, 0.08] },
    { position: [3.55, 1.12, 1.55], scale: [0.65, 0.08, 0.08], rotation: [0, 0, -0.6] },
  ], materials.metal);
  addInstances('CommerceTrolleyWheels', wheelGeometry, [
    { position: [2.22, 0.09, 1.18], rotation: [0, 0, Math.PI / 2] },
    { position: [3.28, 0.09, 1.18], rotation: [0, 0, Math.PI / 2] },
    { position: [2.22, 0.09, 1.92], rotation: [0, 0, Math.PI / 2] },
    { position: [3.28, 0.09, 1.92], rotation: [0, 0, Math.PI / 2] },
  ], materials.metal);

  // Small lived-in accents leave the upper-right area deliberately quiet for UI.
  addInstances('MarketLooseDressing', box, [
    { position: [-3.75, 0.22, 4.7], scale: [0.72, 0.42, 0.62], rotation: [0, -0.08, 0] },
    { position: [-2.92, 0.16, 5.15], scale: [0.54, 0.32, 0.5], rotation: [0, 0.12, 0] },
    { position: [0.15, 0.11, 5.05], scale: [0.62, 0.22, 0.58] },
  ], materials.wood);

  return root;
}
