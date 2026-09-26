export const operationPresentationModel = Object.freeze({
  sceneId: 'operation-diorama',
  baseline: 'CENA-019',
  camera: Object.freeze({
    position: Object.freeze([6.5, 5.4, 8.5]),
    rotation: Object.freeze([-0.43, 0.66, 0]),
    orthographicWidth: 8.6,
    near: 0.1,
    far: 40,
  }),
  planters: Object.freeze([
    Object.freeze({ id: 'A', position: Object.freeze([-0.72, 0.25, 0.58]) }),
    Object.freeze({ id: 'B', position: Object.freeze([0.55, 0.25, 1.12]) }),
    Object.freeze({ id: 'C', position: Object.freeze([1.82, 0.25, 0.72]) }),
  ]),
});
