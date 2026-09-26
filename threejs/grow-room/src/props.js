import * as THREE from './vendor/three.module.js';

export function populateGrowRoom(root, materials, presentationModel) {
  const box = new THREE.BoxGeometry(1, 1, 1);
  const planterGeometry = new THREE.CylinderGeometry(0.36, 0.46, 0.62, 10, 1, false);
  const planterRimGeometry = new THREE.CylinderGeometry(0.48, 0.48, 0.1, 10, 1, false);
  const stemGeometry = new THREE.CylinderGeometry(0.07, 0.09, 0.72, 7, 1, false);
  const canopyGeometry = new THREE.DodecahedronGeometry(0.49, 0);
  const ventGeometry = new THREE.CylinderGeometry(0.54, 0.54, 0.2, 14, 1, false);

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

  // Cutaway architecture.
  addBox('RoomFloor', [9.2, 0.28, 11.5], [0, -0.14, 1.15], materials.concrete);
  addBox('BackWall', [9.2, 5.5, 0.28], [0, 2.75, -4.58], materials.plaster);
  addBox('SideWall', [0.28, 5.5, 9.7], [-4.46, 2.75, -0.28], materials.plaster);
  addBox('ForegroundStep', [8.3, 0.2, 2.35], [0.15, -0.28, 8.0], materials.concrete);
  addBox('ForegroundEdge', [8.25, 0.08, 0.13], [0.15, -0.13, 9.13], materials.metal);

  addBox('BackTealBand', [8.55, 0.78, 0.09], [0.08, 0.52, -4.39], materials.teal);
  addBox('SideTealBand', [0.09, 0.78, 8.85], [-4.27, 0.52, -0.18], materials.teal);

  // Door/window masses communicate scale without source-specific copying.
  addBox('Door', [1.42, 2.55, 0.12], [-3.1, 1.28, -4.35], materials.metal);
  addBox('Window', [2.8, 1.72, 0.1], [2.18, 3.02, -4.37], materials.glass);

  addInstances('ArchitecturalTrim', box, [
    { position: [-3.1, 2.6, -4.27], scale: [1.68, 0.1, 0.1] },
    { position: [-3.86, 1.31, -4.27], scale: [0.1, 2.68, 0.1] },
    { position: [-2.34, 1.31, -4.27], scale: [0.1, 2.68, 0.1] },
    { position: [2.18, 3.93, -4.27], scale: [3.04, 0.1, 0.1] },
    { position: [2.18, 2.11, -4.27], scale: [3.04, 0.1, 0.1] },
    { position: [0.71, 3.02, -4.27], scale: [0.1, 1.92, 0.1] },
    { position: [3.65, 3.02, -4.27], scale: [0.1, 1.92, 0.1] },
    { position: [2.18, 3.02, -4.27], scale: [0.09, 1.92, 0.1] },
    { position: [2.18, 3.02, -4.27], scale: [3.02, 0.09, 0.1] },
    { position: [-4.23, 1.92, -2.1], scale: [0.09, 3.25, 0.1] },
    { position: [-4.23, 1.92, 1.0], scale: [0.09, 3.25, 0.1] },
    { position: [-4.23, 1.92, 4.1], scale: [0.09, 3.25, 0.1] },
  ], materials.metal);

  // Back work zone.
  addBox('BackWorktop', [4.25, 0.17, 1.05], [0.15, 1.02, -3.34], materials.wood);
  addBox('BackCabinet', [4.08, 0.9, 0.92], [0.15, 0.47, -3.34], materials.teal);
  addInstances('CabinetFrontRhythm', box, [
    { position: [-1.28, 0.5, -2.86], scale: [1.05, 0.64, 0.06] },
    { position: [0.12, 0.5, -2.86], scale: [1.05, 0.64, 0.06] },
    { position: [1.52, 0.5, -2.86], scale: [1.05, 0.64, 0.06] },
  ], materials.wood);
  addInstances('CabinetHandles', box, [
    { position: [-1.28, 0.62, -2.82], scale: [0.24, 0.05, 0.05] },
    { position: [0.12, 0.62, -2.82], scale: [0.24, 0.05, 0.05] },
    { position: [1.52, 0.62, -2.82], scale: [0.24, 0.05, 0.05] },
  ], materials.metal);

  // Two chunky central tables define the primary visual cluster.
  addInstances('WorktableTops', box, [
    { position: [-1.02, 0.68, -0.62], scale: [3.9, 0.14, 1.32] },
    { position: [0.23, 0.68, 1.38], scale: [4.35, 0.14, 1.32] },
  ], materials.wood);
  addInstances('WorktableFrames', box, [
    { position: [-2.7, 0.34, -0.62], scale: [0.12, 0.66, 1.16] },
    { position: [0.66, 0.34, -0.62], scale: [0.12, 0.66, 1.16] },
    { position: [-1.68, 0.34, 1.38], scale: [0.12, 0.66, 1.16] },
    { position: [2.14, 0.34, 1.38], scale: [0.12, 0.66, 1.16] },
  ], materials.metal);

  // Storage cluster gives the room authored density.
  addInstances('ShelfPosts', box, [
    { position: [-3.82, 1.52, 2.64], scale: [0.12, 3.05, 0.12] },
    { position: [-2.02, 1.52, 2.64], scale: [0.12, 3.05, 0.12] },
  ], materials.metal);
  addInstances('Shelves', box, [
    { position: [-2.92, 0.52, 2.64], scale: [1.95, 0.11, 0.82] },
    { position: [-2.92, 1.42, 2.64], scale: [1.95, 0.11, 0.82] },
    { position: [-2.92, 2.32, 2.64], scale: [1.95, 0.11, 0.82] },
  ], materials.wood);

  addInstances(
    'StorageCrates',
    box,
    presentationModel.storageCrates.map(({ position, scale }) => ({ position, scale })),
    materials.terracotta
  );

  // Abstract overhead bars add vertical layering only; they encode no real operating parameters.
  addInstances('CeilingPracticalBars', box, [
    { position: [-1.1, 3.55, -0.55], scale: [3.55, 0.12, 0.18] },
    { position: [0.38, 3.55, 1.45], scale: [4.0, 0.12, 0.18] },
    { position: [-1.1, 3.52, -0.18], scale: [3.55, 0.07, 0.12] },
    { position: [0.38, 3.52, 1.82], scale: [4.0, 0.07, 0.12] },
  ], materials.warmLight);
  addInstances('CeilingSupports', box, [
    { position: [-2.55, 4.15, -0.55], scale: [0.07, 1.18, 0.07] },
    { position: [0.35, 4.15, -0.55], scale: [0.07, 1.18, 0.07] },
    { position: [-1.35, 4.15, 1.45], scale: [0.07, 1.18, 0.07] },
    { position: [2.05, 4.15, 1.45], scale: [0.07, 1.18, 0.07] },
  ], materials.metal);

  // Living silhouettes remain intentionally stylized and non-instructional.
  const planterInstances = presentationModel.plantGroups.map(({ position }) => ({ position }));
  const rimInstances = presentationModel.plantGroups.map(({ position: [x, _y, z] }) => ({
    position: [x, 0.75, z],
  }));
  const stemInstances = presentationModel.plantGroups.map(({ position: [x, _y, z] }) => ({
    position: [x, 1.05, z],
  }));

  const canopyOffsets = [
    [0, 1.34, 0, [1.0, 0.78, 1.0]],
    [-0.3, 1.2, -0.06, [0.68, 0.58, 0.68]],
    [0.31, 1.22, 0.08, [0.68, 0.58, 0.68]],
  ];
  const canopyInstances = presentationModel.plantGroups.flatMap(({ position: [x, _y, z] }) =>
    canopyOffsets.map(([ox, oy, oz, scale]) => ({
      position: [x + ox, oy, z + oz],
      scale,
    }))
  );

  addInstances('Planters', planterGeometry, planterInstances, materials.terracotta);
  addInstances('PlanterRims', planterRimGeometry, rimInstances, materials.terracotta);
  addInstances('Stems', stemGeometry, stemInstances, materials.foliage);
  addInstances('Canopies', canopyGeometry, canopyInstances, materials.foliage);

  // Generic utilities and loose dressing make the miniature feel lived in.
  addBox('UtilityCabinet', [1.05, 1.85, 0.66], [3.55, 0.93, -2.65], materials.metal);
  addBox('UtilityInset', [0.72, 0.42, 0.06], [3.55, 1.14, -2.30], materials.teal);

  const vent = new THREE.Mesh(ventGeometry, materials.metal);
  vent.name = 'AbstractWallVent';
  vent.position.set(-4.24, 3.55, 3.45);
  vent.rotation.z = Math.PI / 2;
  root.add(vent);

  addInstances('LooseDressing', box, [
    { position: [2.88, 0.22, 4.48], scale: [0.95, 0.44, 0.72] },
    { position: [3.68, 0.17, 5.02], scale: [0.72, 0.34, 0.62] },
    { position: [1.72, 1.17, -3.32], scale: [0.54, 0.08, 0.34], rotation: [0, 0.12, 0] },
    { position: [-0.12, 0.13, 4.56], scale: [0.62, 0.26, 0.62] },
  ], materials.wood);

  return root;
}
