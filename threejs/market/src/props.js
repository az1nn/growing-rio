import * as THREE from './vendor/three.module.js';

function box(root,name,size,position,material,rotation=[0,0,0]) {
  const mesh=new THREE.Mesh(new THREE.BoxGeometry(...size),material); mesh.name=name; mesh.position.set(...position); mesh.rotation.set(...rotation); root.add(mesh); return mesh;
}
function cylinder(root,name,radius,height,position,material,rotation=[0,0,0]) {
  const mesh=new THREE.Mesh(new THREE.CylinderGeometry(radius,radius,height,8),material); mesh.name=name; mesh.position.set(...position); mesh.rotation.set(...rotation); root.add(mesh); return mesh;
}
function shell(root,m) {
  box(root,'MarketFloor',[8.8,0.18,7.2],[0,-0.09,0],m.concrete);
  box(root,'BackWall',[8.8,4.4,0.18],[0,2.1,-3.42],m.plaster);
  box(root,'SideWall',[0.18,4.4,7.2],[-4.32,2.1,0],m.plaster);
  box(root,'TealBackBand',[8.6,0.72,0.08],[0,0.55,-3.30],m.teal);
  box(root,'TealSideBand',[0.08,0.72,7.0],[-4.20,0.55,0],m.teal);
  for(const x of [-3.45,-1.72,0,1.72,3.45]) {
    box(root,'AisleFloorJoint',[0.055,0.025,6.3],[x,0.025,-0.05],m.metal);
    box(root,'RoofPost',[0.12,3.6,0.12],[x,1.8,-2.95],m.metal);
    box(root,'RoofRib',[0.12,0.12,6.0],[x,3.55,-0.25],m.metal);
  }
  for(const z of [-2.55,-1.15,0.25,1.65,2.75]) box(root,'CrossFloorJoint',[8.05,0.025,0.05],[0.15,0.027,z],m.metal);
  box(root,'RoofHeader',[8.15,0.16,0.16],[0.05,3.55,-2.95],m.metal);
}
function counter(root,m) {
  box(root,'DealCounterBody',[3.05,1.05,1.05],[-1.15,0.56,2.08],m.teal);
  box(root,'DealCounterTop',[3.3,0.16,1.25],[-1.15,1.18,2.08],m.wood);
  box(root,'DealCounterFoot',[3.1,0.12,1.08],[-1.15,0.12,2.08],m.metal);
  box(root,'ContractTray',[0.78,0.08,0.52],[-1.55,1.31,1.92],m.plaster,[0,-0.12,0]);
  box(root,'CounterTerminal',[0.52,0.58,0.18],[-0.38,1.52,2.15],m.glass,[-0.12,0,0]);
  box(root,'WarmCounterLamp',[0.58,0.09,0.26],[-1.48,2.22,1.82],m.warmLight);
  box(root,'LampStem',[0.08,0.92,0.08],[-1.48,1.73,1.82],m.metal);
}
function vendorBay(root,m) {
  box(root,'VendorBayFrame',[2.85,0.14,0.14],[-2.62,2.8,-1.48],m.metal);
  for(const x of [-3.85,-2.62,-1.39]) box(root,'VendorBayPost',[0.12,2.65,0.12],[x,1.45,-1.48],m.metal);
  for(const y of [0.72,1.52,2.30]) box(root,'VendorShelf',[2.52,0.08,0.72],[-2.62,y,-1.82],m.wood);
  box(root,'VendorTealPanel',[2.45,0.68,0.08],[-2.62,0.55,-1.42],m.teal);
}
function crates(root,m,model) {
  const geometry=new THREE.BoxGeometry(1,1,1);
  const mesh=new THREE.InstancedMesh(geometry,m.terracotta,model.crateStacks.length); mesh.name='MarketCrates';
  const matrix=new THREE.Matrix4(),pos=new THREE.Vector3(),quat=new THREE.Quaternion(),scale=new THREE.Vector3();
  model.crateStacks.forEach((crate,index)=>{pos.set(...crate.position);scale.set(...crate.scale);matrix.compose(pos,quat,scale);mesh.setMatrixAt(index,matrix);});
  mesh.instanceMatrix.needsUpdate=true; root.add(mesh);
  for(const crate of model.crateStacks) box(root,'CrateSlat',[crate.scale[0]*0.92,0.055,0.05],[crate.position[0],crate.position[1],crate.position[2]+crate.scale[2]*0.51],m.metal);
}
function loading(root,m) {
  box(root,'LoadingHeader',[3.0,0.18,0.16],[2.45,3.1,-3.18],m.metal);
  for(const x of [1.15,1.58,2.01,2.44,2.87,3.30,3.73]) box(root,'LoadingShutterSlat',[0.23,2.45,0.08],[x,1.52,-3.22],m.metal);
  box(root,'LoadingThreshold',[3.0,0.10,0.55],[2.45,0.08,-2.98],m.concrete);
  box(root,'BackWarmFixture',[0.66,0.10,0.24],[2.35,2.86,-2.83],m.warmLight);
}
function trolley(root,m) {
  box(root,'TrolleyDeck',[1.45,0.16,0.82],[2.55,0.46,0.98],m.wood);
  box(root,'TrolleyFrame',[1.55,0.12,0.92],[2.55,0.35,0.98],m.metal);
  for(const x of [2.0,3.1]) {
    cylinder(root,'TrolleyWheel',0.18,0.12,[x,0.18,0.72],m.metal,[Math.PI/2,0,0]);
    cylinder(root,'TrolleyWheel',0.18,0.12,[x,0.18,1.24],m.metal,[Math.PI/2,0,0]);
  }
  box(root,'TrolleyHandleLeft',[0.10,1.25,0.10],[3.18,1.02,1.26],m.metal,[0,0,-0.16]);
  box(root,'TrolleyHandleTop',[0.10,0.10,0.82],[3.28,1.65,0.94],m.metal);
}
export function populateMarket(root,materials,model) {
  // Fictional presentation only; no real operating parameters or logistics procedures.
  shell(root,materials); counter(root,materials); vendorBay(root,materials); crates(root,materials,model); loading(root,materials); trolley(root,materials);
  box(root,'QuietZoneFrame',[0.10,2.1,2.65],[-4.05,2.05,1.65],materials.metal);
}
