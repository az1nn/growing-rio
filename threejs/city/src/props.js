import * as THREE from './vendor/three.module.js';

function box(root,name,size,position,material,rotation=[0,0,0]) {
  const mesh=new THREE.Mesh(new THREE.BoxGeometry(...size),material);
  mesh.name=name;
  mesh.position.set(...position);
  mesh.rotation.set(...rotation);
  root.add(mesh);
  return mesh;
}

function instancedScaledBoxes(root,name,items,material) {
  const geometry=new THREE.BoxGeometry(1,1,1);
  const mesh=new THREE.InstancedMesh(geometry,material,items.length);
  mesh.name=name;
  const matrix=new THREE.Matrix4();
  const pos=new THREE.Vector3();
  const quat=new THREE.Quaternion();
  const scale=new THREE.Vector3();
  items.forEach((item,index)=>{
    pos.set(...item.position);
    scale.set(...item.scale);
    matrix.compose(pos,quat,scale);
    mesh.setMatrixAt(index,matrix);
  });
  mesh.instanceMatrix.needsUpdate=true;
  root.add(mesh);
  return mesh;
}

function terraces(root,m) {
  box(root,'TerrainLower',[8.8,0.42,2.35],[0,-0.20,1.80],m.concrete);
  box(root,'TerrainMiddle',[8.2,0.62,2.35],[0.20,0.18,-0.20],m.concrete);
  box(root,'TerrainUpper',[7.3,0.82,2.25],[-0.10,0.62,-2.20],m.concrete);

  box(root,'RetainingLower',[8.65,0.52,0.14],[0,0.18,0.72],m.metal);
  box(root,'RetainingMiddle',[8.05,0.68,0.14],[0.20,0.62,-1.30],m.metal);
  box(root,'RetainingUpper',[7.15,0.88,0.14],[-0.10,1.16,-3.16],m.metal);

  box(root,'OverlookDeck',[4.3,0.18,0.82],[-1.65,0.15,3.05],m.wood);
  box(root,'OverlookRail',[4.3,0.10,0.10],[-1.65,0.92,2.72],m.metal);
  box(root,'OverlookRailPostA',[0.10,1.45,0.10],[-3.75,0.72,2.72],m.metal);
  box(root,'OverlookRailPostB',[0.10,1.45,0.10],[0.45,0.72,2.72],m.metal);
}

function buildings(root,m,model) {
  instancedScaledBoxes(root,'UrbanBlocksPlaster',model.plasterBlocks,m.plaster);
  instancedScaledBoxes(root,'UrbanBlocksTeal',model.tealBlocks,m.teal);
  instancedScaledBoxes(root,'UrbanBlocksTerracotta',model.terracottaBlocks,m.terracotta);

  box(root,'SkylineTowerA',[0.95,3.85,0.92],[2.95,2.45,-3.45],m.plaster);
  box(root,'SkylineTowerB',[0.72,3.15,0.74],[4.00,2.05,-3.10],m.teal);
  box(root,'SkylineCapA',[1.05,0.12,1.02],[2.95,4.43,-3.45],m.metal);
  box(root,'SkylineCapB',[0.82,0.12,0.84],[4.00,3.69,-3.10],m.metal);
}

function warmWindows(root,m,model) {
  const geometry=new THREE.BoxGeometry(0.28,0.18,0.05);
  const mesh=new THREE.InstancedMesh(geometry,m.warmLight,model.warmWindows.length);
  mesh.name='WarmNeighborhoodWindows';
  const matrix=new THREE.Matrix4();
  model.warmWindows.forEach((position,index)=>{
    matrix.makeTranslation(...position);
    mesh.setMatrixAt(index,matrix);
  });
  mesh.instanceMatrix.needsUpdate=true;
  root.add(mesh);
}

function vegetation(root,m,model) {
  const trunkGeometry=new THREE.CylinderGeometry(0.08,0.10,0.56,7);
  const trunks=new THREE.InstancedMesh(trunkGeometry,m.wood,model.trees.length);
  trunks.name='CityTreeTrunks';

  const canopyGeometry=new THREE.ConeGeometry(0.34,0.82,8);
  const canopies=new THREE.InstancedMesh(canopyGeometry,m.foliage,model.trees.length);
  canopies.name='CityTreeCanopies';

  const matrix=new THREE.Matrix4();
  model.trees.forEach((position,index)=>{
    matrix.makeTranslation(position[0],position[1],position[2]);
    trunks.setMatrixAt(index,matrix);
    matrix.makeTranslation(position[0],position[1]+0.62,position[2]);
    canopies.setMatrixAt(index,matrix);
  });
  trunks.instanceMatrix.needsUpdate=true;
  canopies.instanceMatrix.needsUpdate=true;
  root.add(trunks,canopies);
}

function districtBreaks(root,m) {
  box(root,'DistrictBreakA',[0.16,0.08,2.10],[-2.05,0.76,-0.22],m.metal,[0,0.20,0]);
  box(root,'DistrictBreakB',[0.16,0.08,2.25],[1.85,1.08,-1.42],m.metal,[0,-0.18,0]);
  box(root,'QuietZoneEdge',[0.10,0.12,3.15],[-4.30,0.22,1.15],m.metal);
}

export function populateCity(root,materials,model) {
  // Fictional presentation only; no real maps, routes or operating parameters.
  terraces(root,materials);
  buildings(root,materials,model);
  warmWindows(root,materials,model);
  vegetation(root,materials,model);
  districtBreaks(root,materials);
}
