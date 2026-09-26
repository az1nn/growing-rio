import { copyFile, mkdir, rm } from 'node:fs/promises';
import { resolve } from 'node:path';

const root = resolve(import.meta.dirname, '..');
const dist = resolve(root, 'dist');

await rm(dist, { recursive: true, force: true });
await mkdir(resolve(dist, 'vendor'), { recursive: true });

await copyFile(resolve(root, 'index.html'), resolve(dist, 'index.html'));

for (const file of ['main.js', 'operationDiorama.js', 'presentationModel.js']) {
  await copyFile(resolve(root, 'src', file), resolve(dist, file));
}

await copyFile(
  resolve(root, 'node_modules', 'three', 'build', 'three.module.min.js'),
  resolve(dist, 'vendor', 'three.module.min.js')
);
