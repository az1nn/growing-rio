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

function shell(root,m) {
  box(root,'ForumFloor',[8.2,0.34,6.25],[0,-0.18,0.10],m.concrete);
  box(root,'BackWall',[8.2,3.55,0.28],[0,1.56,-2.95],m.plaster);
  box(root,'BackMetalBand',[8.0,0.18,0.12],[0,2.58,-2.76],m.metal);
  box(root,'LeftCutaway',[0.28,2.55,3.60],[-4.02,1.10,-1.12],m.plaster);
  box(root,'ThresholdDeck',[5.55,0.18,1.10],[0,0.08,2.82],m.wood);
  box(root,'ThresholdEdge',[5.65,0.16,0.12],[0,0.34,2.28],m.metal);
  box(root,'PublicBench',[3.45,0.34,0.64],[-1.15,0.38,2.02],m.wood);
  box(root,'PublicBenchBack',[3.45,0.78,0.12],[-1.15,0.82,2.29],m.metal);
}

function participationDesk(root,m) {
  box(root,'ParticipationDesk',[1.65,0.88,1.05],[2.92,0.44,1.72],m.teal);
  box(root,'ParticipationDeskTop',[1.82,0.12,1.16],[2.92,0.94,1.72],m.wood);
  box(root,'ParticipationDeskRail',[1.92,0.10,0.10],[2.92,1.25,1.20],m.metal);
}

function proposals(root,m,model) {
  // One instanced geometry + one material intentionally enforces equal visual treatment.
  const pedestals=instancedScaledBoxes(root,'ProposalPedestals',model.proposals,m.plaster);
  pedestals.userData.neutrality='equal-scale-material-lighting';

  const topGeometry=new THREE.BoxGeometry(0.94,0.08,0.94);
  const tops=new THREE.InstancedMesh(topGeometry,m.teal,model.proposals.length);
  tops.name='ProposalPedestalCaps';
  const matrix=new THREE.Matrix4();
  model.proposals.forEach((item,index)=>{
    matrix.makeTranslation(item.position[0],1.04,item.position[2]);
    tops.setMatrixAt(index,matrix);
  });
  tops.instanceMatrix.needsUpdate=true;
  root.add(tops);

  box(root,'ProposalProcessRail',[5.20,0.10,0.10],[0,1.34,-0.52],m.metal);
  box(root,'ProposalProcessRailTeal',[5.00,0.07,0.07],[0,1.54,-0.52],m.teal);
}

function archive(root,m,model) {
  instancedScaledBoxes(root,'ArchiveModules',model.archiveModules,m.metal);
  const cardGeometry=new THREE.BoxGeometry(0.72,0.42,0.08);
  const cards=new THREE.InstancedMesh(cardGeometry,m.terracotta,model.archiveCards.length);
  cards.name='ArchiveCards';
  const matrix=new THREE.Matrix4();
  model.archiveCards.forEach((position,index)=>{
    matrix.makeTranslation(...position);
    cards.setMatrixAt(index,matrix);
  });
  cards.instanceMatrix.needsUpdate=true;
  root.add(cards);

  box(root,'ArchiveHeaderRail',[6.95,0.12,0.16],[0,2.92,-2.62],m.teal);
}

function decor(root,m,model) {
  const potGeometry=new THREE.CylinderGeometry(0.22,0.28,0.46,8);
  const pots=new THREE.InstancedMesh(potGeometry,m.terracotta,model.plants.length);
  pots.name='ForumPlanters';
  const canopyGeometry=new THREE.IcosahedronGeometry(0.42,0);
  const canopies=new THREE.InstancedMesh(canopyGeometry,m.foliage,model.plants.length);
  canopies.name='ForumFoliage';
  const matrix=new THREE.Matrix4();
  model.plants.forEach((position,index)=>{
    matrix.makeTranslation(...position);
    pots.setMatrixAt(index,matrix);
    matrix.makeTranslation(position[0],position[1]+0.58,position[2]);
    canopies.setMatrixAt(index,matrix);
  });
  pots.instanceMatrix.needsUpdate=true;
  canopies.instanceMatrix.needsUpdate=true;
  root.add(pots,canopies);

  box(root,'WarmFixtureLeft',[0.18,0.18,0.18],[-3.10,2.84,-0.42],m.warmLight);
  box(root,'WarmFixtureRight',[0.18,0.18,0.18],[3.10,2.84,-0.42],m.warmLight);
  box(root,'QuietZoneEdge',[0.10,0.12,2.85],[-4.08,0.08,1.18],m.metal);
}

export function populateInstitutional(root,materials,model) {
  // Fictional presentation only. No real institution, electoral process or policy semantics.
  shell(root,materials);
  participationDesk(root,materials);
  proposals(root,materials,model);
  archive(root,materials,model);
  decor(root,materials,model);
}
