import * as THREE from './vendor/three.module.js';

function box(root,name,size,position,material,rotation=[0,0,0]) {
  const mesh=new THREE.Mesh(new THREE.BoxGeometry(...size),material);
  mesh.name=name;
  mesh.position.set(...position);
  mesh.rotation.set(...rotation);
  root.add(mesh);
  return mesh;
}

function instancedBoxes(root,name,items,material) {
  const geometry=new THREE.BoxGeometry(1,1,1);
  const mesh=new THREE.InstancedMesh(geometry,material,items.length);
  mesh.name=name;
  const matrix=new THREE.Matrix4();
  const pos=new THREE.Vector3();
  const quat=new THREE.Quaternion();
  const euler=new THREE.Euler();
  const scale=new THREE.Vector3();
  items.forEach((item,index)=>{
    pos.set(...item.position);
    euler.set(...item.rotation);
    quat.setFromEuler(euler);
    scale.set(...item.scale);
    matrix.compose(pos,quat,scale);
    mesh.setMatrixAt(index,matrix);
  });
  mesh.instanceMatrix.needsUpdate=true;
  root.add(mesh);
  return mesh;
}

function shell(root,m) {
  box(root,'ArchiveFloor',[8.2,0.28,6.2],[0,-0.14,0],m.concrete);
  box(root,'ArchiveBackWall',[8.2,3.7,0.26],[0,1.75,-3.0],m.plaster);
  box(root,'ArchiveSideWall',[0.26,3.3,4.9],[-4.0,1.55,-0.60],m.plaster);
  box(root,'UncertaintyRail',[7.2,0.16,0.12],[0,2.75,-2.80],m.teal);
}

function archiveWall(root,m,model) {
  for (const [index,y] of [0.65,1.38,2.10].entries()) {
    box(root,`ArchiveShelf${index+1}`,[4.3,0.10,0.62],[1.50,y,-2.55],m.wood);
  }
  for (const [index,x] of [-0.55,1.50,3.55].entries()) {
    box(root,`ArchiveShelfPost${index+1}`,[0.12,2.95,0.12],[x,1.38,-2.55],m.metal);
  }
  const boxes=instancedBoxes(root,'ArchiveEvidenceBoxes',model.archiveBoxes,m.paper);
  boxes.userData.semantic='abstract-evidence-memory-no-provenance-claim';
}

function evidenceDesk(root,m,model) {
  box(root,'EvidenceDeskBody',[4.4,1.02,1.70],[-1.05,0.54,1.70],m.teal);
  box(root,'EvidenceDeskTop',[4.75,0.16,1.90],[-1.05,1.12,1.70],m.wood);
  box(root,'EvidenceTray',[1.10,0.08,0.72],[-1.45,1.28,1.48],m.metal,[0,-0.08,0]);
  instancedBoxes(root,'AbstractEvidenceDocuments',model.documents,m.paper);
  box(root,'EvidenceLampStem',[0.08,1.05,0.08],[0.42,1.72,1.42],m.metal);
  box(root,'EvidenceLampHead',[0.62,0.12,0.32],[0.18,2.25,1.42],m.warmLight,[0,0,-0.16]);
  box(root,'EvidenceBoundaryMarker',[1.30,0.08,0.08],[-1.45,1.52,0.95],m.teal);
}

function storage(root,m,model) {
  const woodItems=[model.sideStorage[0]];
  const concreteItems=[model.sideStorage[1]];
  instancedBoxes(root,'ArchiveSideWoodStorage',woodItems,m.wood);
  instancedBoxes(root,'ArchiveSideConcreteStorage',concreteItems,m.concrete);
  box(root,'QuietZoneEdge',[0.10,0.12,2.65],[-4.08,0.08,1.28],m.metal);
}

export function populateArchive(root,materials,model) {
  shell(root,materials);
  archiveWall(root,materials,model);
  evidenceDesk(root,materials,model);
  storage(root,materials,model);
}
