const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const workspace = process.env.GITHUB_WORKSPACE || process.cwd();
const manifestPath = process.env.LENTE_MANIFEST || path.join(workspace, 'tools/visual_lab/manifest.json');
const inventoryPath = process.env.LENTE_INVENTORY || path.join(workspace, 'visual-lab/inventory.json');
const outputDir = process.env.LENTE_OUTPUT || path.join(workspace, 'visual-lab');
const appUrl = process.env.LENTE_APP_URL || 'http://127.0.0.1:8080/';
const sceneUrl = process.env.LENTE_SCENE_URL || 'http://127.0.0.1:8081/';
const captureObjects = (process.env.LENTE_CAPTURE_OBJECTS || 'false').toLowerCase() === 'true';
const objectSceneFilter = process.env.LENTE_OBJECT_SCENE || '';
const objectNameFilter = process.env.LENTE_OBJECT_NAME || '';

const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
const inventory = JSON.parse(fs.readFileSync(inventoryPath, 'utf8'));

fs.mkdirSync(outputDir, { recursive: true });
fs.mkdirSync(path.join(outputDir, 'pages'), { recursive: true });
fs.mkdirSync(path.join(outputDir, 'scenes'), { recursive: true });
fs.mkdirSync(path.join(outputDir, 'videos'), { recursive: true });
fs.mkdirSync(path.join(outputDir, 'objects'), { recursive: true });

const errors = [];

function safeName(value) {
  return value.replace(/[^a-zA-Z0-9._-]+/g, '-').replace(/^-+|-+$/g, '');
}

function attachErrors(page, label) {
  page.on('console', msg => {
    if (msg.type() === 'error') errors.push(`[${label}] ${msg.text()}`);
  });
  page.on('pageerror', err => errors.push(`[${label}] PAGEERROR ${err.message}`));
}

async function waitCanvas(page) {
  await page.waitForFunction(() => {
    const canvas = document.querySelector('canvas');
    return !!canvas && canvas.width > 0 && canvas.height > 0;
  }, { timeout: 120000 });
}

async function waitSceneReady(page, sceneId) {
  await waitCanvas(page);
  await page.waitForFunction(
    expected => window.__DALATA_VISUAL_LAB_READY__ === expected,
    sceneId,
    { timeout: 30000 },
  );
  await page.waitForTimeout(650);
}

async function capturePages(browser) {
  const shortcuts = manifest.pages.filter(item => item.kind === 'shortcut');
  const fixtures = manifest.pages.filter(item => item.kind === 'fixture');

  for (const size of manifest.page_sizes) {
    const context = await browser.newContext({
      viewport: { width: size.width, height: size.height },
      deviceScaleFactor: 1,
    });
    const page = await context.newPage();
    attachErrors(page, `page:${size.id}`);
    await page.goto(appUrl, { waitUntil: 'networkidle', timeout: 120000 });
    await waitCanvas(page);
    await page.waitForTimeout(2500);
    const canvas = page.locator('canvas').first();
    await canvas.evaluate(element => element.focus());

    for (const target of shortcuts) {
      await page.keyboard.press(target.key);
      await page.waitForTimeout(750);
      await page.screenshot({
        path: path.join(outputDir, 'pages', `${target.id}-${size.id}.png`),
        fullPage: false,
        animations: 'disabled',
      });
    }
    await context.close();

    for (const target of fixtures) {
      const fixtureContext = await browser.newContext({
        viewport: { width: size.width, height: size.height },
        deviceScaleFactor: 1,
      });
      const fixturePage = await fixtureContext.newPage();
      attachErrors(fixturePage, `page:${target.id}:${size.id}`);
      const url = new URL(appUrl);
      for (const [key, value] of new URLSearchParams(target.query)) {
        url.searchParams.set(key, value);
      }
      await fixturePage.goto(url.toString(), { waitUntil: 'networkidle', timeout: 120000 });
      await waitCanvas(fixturePage);

      if (target.ready === '__DALATA_NARRATIVE_READY__') {
        await fixturePage.waitForFunction(
          () => window.__DALATA_NARRATIVE_READY__ === true,
          null,
          { timeout: 20000 },
        );
      }
      if (target.ready_value) {
        await fixturePage.waitForFunction(
          expected => window.__DALATA_FINALE_READY__ === expected,
          target.ready_value,
          { timeout: 20000 },
        );
      }

      await fixturePage.waitForTimeout(650);
      await fixturePage.screenshot({
        path: path.join(outputDir, 'pages', `${target.id}-${size.id}.png`),
        fullPage: false,
        animations: 'disabled',
      });
      await fixtureContext.close();
    }
  }
}

async function captureIsolatedScenes(browser) {
  for (const size of manifest.page_sizes) {
    const context = await browser.newContext({
      viewport: { width: size.width, height: size.height },
      deviceScaleFactor: 1,
    });
    const page = await context.newPage();
    attachErrors(page, `isolated:${size.id}`);

    for (const target of manifest.isolated_scenes) {
      const url = new URL(sceneUrl);
      url.searchParams.set('scene', target.id);
      url.searchParams.set('chrome', 'off');
      if (target.phase) url.searchParams.set('phase', target.phase);

      await page.goto(url.toString(), { waitUntil: 'networkidle', timeout: 120000 });
      await waitSceneReady(page, target.id);
      await page.screenshot({
        path: path.join(outputDir, 'scenes', `${target.id}-${size.id}.png`),
        fullPage: false,
        animations: 'disabled',
      });
    }

    await context.close();
  }
}

async function captureSceneVideos(browser) {
  const size = manifest.video.size;
  for (const target of manifest.isolated_scenes) {
    const videoDir = path.join(outputDir, 'videos', '.raw');
    fs.mkdirSync(videoDir, { recursive: true });
    const context = await browser.newContext({
      viewport: { width: size.width, height: size.height },
      deviceScaleFactor: 1,
      recordVideo: {
        dir: videoDir,
        size: { width: size.width, height: size.height },
      },
    });
    const page = await context.newPage();
    attachErrors(page, `video:${target.id}`);

    const url = new URL(sceneUrl);
    url.searchParams.set('scene', target.id);
    url.searchParams.set('chrome', 'off');
    url.searchParams.set('motion', manifest.video.motion || 'orbit');
    if (target.phase) url.searchParams.set('phase', target.phase);

    await page.goto(url.toString(), { waitUntil: 'networkidle', timeout: 120000 });
    await waitSceneReady(page, target.id);
    await page.waitForTimeout(manifest.video.duration_ms || 4000);

    const video = page.video();
    await context.close();
    if (!video) {
      throw new Error(`missing Playwright video for ${target.id}`);
    }

    // Playwright records from page creation, including the Godot splash screen.
    // Capture lasts for the full requested interval *after* readiness; only the
    // final interval is valid diagnostic motion evidence.
    const rawPath = await video.path();
    const outputPath = path.join(outputDir, 'videos', `${target.id}.webm`);
    const durationSeconds = (manifest.video.duration_ms || 4000) / 1000;
    const ffmpeg = spawnSync(
      'ffmpeg',
      [
        '-hide_banner', '-loglevel', 'error', '-y',
        '-sseof', `-${durationSeconds}`,
        '-i', rawPath,
        '-t', String(durationSeconds),
        '-c:v', 'libvpx-vp9', '-b:v', '0', '-crf', '34',
        '-an', outputPath,
      ],
      { encoding: 'utf8' },
    );
    if (ffmpeg.status !== 0 || !fs.existsSync(outputPath) || fs.statSync(outputPath).size === 0) {
      throw new Error(`post-ready video trim failed for ${target.id}: ${ffmpeg.stderr}`);
    }
    fs.unlinkSync(rawPath);
  }
}

async function captureObjectFrames(browser) {
  if (!captureObjects) return;

  const size = manifest.video.size;
  const sceneIndex = new Map(
    inventory.isolated_scenes.map(item => [item.id, item])
  );

  for (const target of manifest.isolated_scenes) {
    if (objectSceneFilter && target.id !== objectSceneFilter) continue;
    const sceneInventory = sceneIndex.get(target.id);
    if (!sceneInventory) continue;

    const meshNames = sceneInventory.mesh_nodes || [];
    for (const meshName of meshNames) {
      if (objectNameFilter && meshName !== objectNameFilter) continue;
      const context = await browser.newContext({
        viewport: { width: size.width, height: size.height },
        deviceScaleFactor: 1,
      });
      const page = await context.newPage();
      attachErrors(page, `object:${target.id}:${meshName}`);

      const url = new URL(sceneUrl);
      url.searchParams.set('scene', target.id);
      url.searchParams.set('chrome', 'off');
      url.searchParams.set('focus', meshName);
      if (target.phase) url.searchParams.set('phase', target.phase);

      await page.goto(url.toString(), { waitUntil: 'networkidle', timeout: 120000 });
      await waitSceneReady(page, target.id);
      await page.screenshot({
        path: path.join(
          outputDir,
          'objects',
          `${target.id}--${safeName(meshName)}.png`
        ),
        fullPage: false,
        animations: 'disabled',
      });
      await context.close();
    }
  }
}

(async () => {
  const browser = await chromium.launch({
    headless: true,
    args: ['--use-angle=swiftshader', '--enable-webgl', '--ignore-gpu-blocklist'],
  });

  try {
    await capturePages(browser);
    await captureIsolatedScenes(browser);
    await captureSceneVideos(browser);
    await captureObjectFrames(browser);
  } finally {
    await browser.close();
  }

  fs.writeFileSync(
    path.join(outputDir, 'browser-console-errors.txt'),
    errors.join('\n')
  );
  fs.writeFileSync(
    path.join(outputDir, 'capture-metadata.json'),
    JSON.stringify(
      {
        schema_version: 1,
        commit: process.env.LENTE_EXACT_SHA || process.env.GITHUB_SHA || '',
        video_window: 'post_ready_only',
        generated_at: new Date().toISOString(),
        page_count: manifest.pages.length,
        isolated_scene_count: manifest.isolated_scenes.length,
        object_capture: captureObjects,
        object_scene_filter: objectSceneFilter,
        object_name_filter: objectNameFilter,
        image_format: 'png',
        video_format: 'webm',
      },
      null,
      2,
    ) + '\n',
  );

  if (errors.length) {
    throw new Error(`visual capture recorded ${errors.length} browser/page error(s)`);
  }
})().catch(error => {
  console.error(error);
  process.exit(1);
});
