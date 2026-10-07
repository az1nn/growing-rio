const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

const workspace = process.env.GITHUB_WORKSPACE || process.cwd();
const manifestPath = process.env.LENTE_MANIFEST || path.join(workspace, 'tools/visual_lab/manifest.json');
const inventoryPath = process.env.LENTE_INVENTORY || path.join(workspace, 'visual-lab/inventory.json');
const latencyContractPath = path.join(workspace, 'tools/validation_latency_budgets.json');
const outputDir = process.env.LENTE_OUTPUT || path.join(workspace, 'visual-lab');
const appUrl = process.env.LENTE_APP_URL || 'http://127.0.0.1:8080/';
const sceneUrl = process.env.LENTE_SCENE_URL || 'http://127.0.0.1:8081/';
const captureObjects = (process.env.LENTE_CAPTURE_OBJECTS || 'false').toLowerCase() === 'true';
const objectSceneFilter = process.env.LENTE_OBJECT_SCENE || '';
const objectNameFilter = process.env.LENTE_OBJECT_NAME || '';

const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
const inventory = JSON.parse(fs.readFileSync(inventoryPath, 'utf8'));
const latencyContract = JSON.parse(fs.readFileSync(latencyContractPath, 'utf8'));
const hardLatency = latencyContract.hard_invariants;
const STILL_BUDGET_MS = hardLatency.still_ready_to_file_ms;
const VIDEO_SCHEDULER_TOLERANCE_MS = hardLatency.video_active_capture_scheduler_tolerance_ms;
const VIDEO_FINALIZE_BUDGET_MS = hardLatency.video_postprocess_target_ms;

fs.mkdirSync(outputDir, { recursive: true });
fs.mkdirSync(path.join(outputDir, 'pages'), { recursive: true });
fs.mkdirSync(path.join(outputDir, 'scenes'), { recursive: true });
fs.mkdirSync(path.join(outputDir, 'videos'), { recursive: true });
fs.mkdirSync(path.join(outputDir, 'objects'), { recursive: true });

const errors = [];
const stillMetrics = [];
const videoMetrics = [];

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

async function waitPageReady(page, pageId) {
  await waitCanvas(page);
  await page.waitForFunction(
    expected => window.__DALATA_PAGE_READY__ === expected,
    pageId,
    { timeout: 30000 },
  );
}

async function waitSceneReady(page, sceneId) {
  await waitCanvas(page);
  await page.waitForFunction(
    expected => window.__DALATA_VISUAL_LAB_READY__ === expected,
    sceneId,
    { timeout: 30000 },
  );
}

const screencasts = new WeakMap();

async function startScreencast(page, label) {
  const session = await page.context().newCDPSession(page);
  const state = {
    session,
    label,
    sequence: 0,
    latest: null,
    waiters: [],
  };
  screencasts.set(page, state);

  session.on('Page.screencastFrame', event => {
    state.sequence += 1;
    state.latest = { sequence: state.sequence, data: event.data };
    session.send('Page.screencastFrameAck', { sessionId: event.sessionId }).catch(error => {
      errors.push(`[screencast:${label}] ack failed: ${error.message}`);
    });

    const pending = [];
    for (const waiter of state.waiters) {
      if (state.sequence > waiter.after) waiter.resolve(state.latest);
      else pending.push(waiter);
    }
    state.waiters = pending;
  });

  await session.send('Page.startScreencast', {
    format: 'png',
    everyNthFrame: 1,
  });
  return state.sequence;
}

function screencastCheckpoint(page) {
  const state = screencasts.get(page);
  if (!state) throw new Error('screencast not started');
  return state.sequence;
}

async function waitBufferedFrame(page, afterSequence) {
  const state = screencasts.get(page);
  if (!state) throw new Error('screencast not started');
  if (state.latest && state.latest.sequence > afterSequence) return state.latest;

  return new Promise((resolve, reject) => {
    let timer;
    const waiter = {
      after: afterSequence,
      resolve: frame => {
        clearTimeout(timer);
        resolve(frame);
      },
    };
    state.waiters.push(waiter);
    timer = setTimeout(() => {
      const index = state.waiters.indexOf(waiter);
      if (index >= 0) state.waiters.splice(index, 1);
      reject(new Error(
        `screencast frame did not arrive within ${STILL_BUDGET_MS}ms after rendered READY`
      ));
    }, STILL_BUDGET_MS);
  });
}

async function stopScreencast(page) {
  const state = screencasts.get(page);
  if (!state) return;
  screencasts.delete(page);
  try {
    await state.session.send('Page.stopScreencast');
  } catch (_) {
    // The target may already be closing; the evidence file is authoritative.
  }
  await state.session.detach().catch(() => {});
}

async function captureBufferedPngWithinBudget(page, outputPath, label, afterSequence) {
  const started = performance.now();
  const frame = await waitBufferedFrame(page, afterSequence);
  const bytes = Buffer.from(frame.data, 'base64');
  fs.writeFileSync(outputPath, bytes);
  const elapsed = performance.now() - started;
  stillMetrics.push({
    label,
    ready_to_file_ms: elapsed,
    bytes: bytes.length,
    frame_sequence: frame.sequence,
    capture_method: 'cdp.screencast-buffer',
  });
  if (elapsed > STILL_BUDGET_MS) {
    throw new Error(
      `${label}: buffered PNG ready-to-file ${elapsed.toFixed(1)}ms exceeds ${STILL_BUDGET_MS}ms`
    );
  }
}


async function capturePages(browser) {
  const shortcuts = manifest.pages.filter(item => item.kind === 'shortcut');
  const fixtures = manifest.pages.filter(item => item.kind === 'fixture');

  for (const size of manifest.page_sizes) {
    if (shortcuts.length) {
      const context = await browser.newContext({
        viewport: { width: size.width, height: size.height },
        deviceScaleFactor: 1,
      });
      const page = await context.newPage();
      attachErrors(page, `page:${size.id}`);
      const initialSequence = await startScreencast(page, `page:${size.id}`);
      await page.goto(appUrl, { waitUntil: 'networkidle', timeout: 120000 });
      await waitPageReady(page, 'operation');
      const canvas = page.locator('canvas').first();
      await canvas.evaluate(element => element.focus());

      for (const target of shortcuts) {
        let afterSequence = initialSequence;
        if (target.id !== 'operation') {
          afterSequence = screencastCheckpoint(page);
          await page.keyboard.press(target.key);
          await waitPageReady(page, target.id);
        }
        await captureBufferedPngWithinBudget(
          page,
          path.join(outputDir, 'pages', `${target.id}-${size.id}.png`),
          `page:${target.id}:${size.id}`,
          afterSequence,
        );
      }
      await stopScreencast(page);
      await context.close();
    }

    for (const target of fixtures) {
      const fixtureContext = await browser.newContext({
        viewport: { width: size.width, height: size.height },
        deviceScaleFactor: 1,
      });
      const fixturePage = await fixtureContext.newPage();
      attachErrors(fixturePage, `page:${target.id}:${size.id}`);
      const afterSequence = await startScreencast(
        fixturePage,
        `page:${target.id}:${size.id}`,
      );
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

      await captureBufferedPngWithinBudget(
        fixturePage,
        path.join(outputDir, 'pages', `${target.id}-${size.id}.png`),
        `page:${target.id}:${size.id}`,
        afterSequence,
      );
      await stopScreencast(fixturePage);
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
    await startScreencast(page, `isolated:${size.id}`);

    for (const target of manifest.isolated_scenes) {
      const afterSequence = screencastCheckpoint(page);
      const url = new URL(sceneUrl);
      url.searchParams.set('scene', target.id);
      url.searchParams.set('chrome', 'off');
      if (target.phase) url.searchParams.set('phase', target.phase);

      await page.goto(url.toString(), { waitUntil: 'networkidle', timeout: 120000 });
      await waitSceneReady(page, target.id);
      await captureBufferedPngWithinBudget(
        page,
        path.join(outputDir, 'scenes', `${target.id}-${size.id}.png`),
        `scene:${target.id}:${size.id}`,
        afterSequence,
      );
    }

    await stopScreencast(page);
    await context.close();
  }
}

async function recordCanvasMedia(page, durationMs, fps, schedulerToleranceMs) {
  return page.evaluate(async ({ durationMs, fps, schedulerToleranceMs }) => {
    const canvas = document.querySelector('canvas');
    if (!canvas) throw new Error('capture canvas missing');
    if (typeof canvas.captureStream !== 'function') {
      throw new Error('HTMLCanvasElement.captureStream unavailable');
    }
    if (typeof MediaRecorder === 'undefined') {
      throw new Error('MediaRecorder unavailable');
    }

    const candidates = [
      'video/webm;codecs=vp9',
      'video/webm;codecs=vp8',
      'video/webm',
    ];
    const mimeType = candidates.find(
      value => !MediaRecorder.isTypeSupported || MediaRecorder.isTypeSupported(value)
    );
    if (!mimeType) throw new Error('no supported WebM MediaRecorder MIME type');

    const stream = canvas.captureStream(fps);
    const chunks = [];
    const recorder = new MediaRecorder(stream, {
      mimeType,
      videoBitsPerSecond: 2500000,
    });

    const stopped = new Promise((resolve, reject) => {
      recorder.addEventListener('dataavailable', event => {
        if (event.data && event.data.size > 0) chunks.push(event.data);
      });
      recorder.addEventListener('error', event => {
        reject(event.error || new Error('MediaRecorder error'));
      });
      recorder.addEventListener('stop', resolve, { once: true });
    });

    const stopLeadMs = Math.min(durationMs, schedulerToleranceMs);
    const scheduledStopMs = Math.max(0, durationMs - stopLeadMs);
    const startedAt = performance.now();
    recorder.start(250);
    await new Promise(resolve => setTimeout(resolve, scheduledStopMs));
    const stopRequestedAt = performance.now();
    recorder.stop();
    await stopped;
    const finalizedAt = performance.now();
    stream.getTracks().forEach(track => track.stop());

    const blob = new Blob(chunks, { type: mimeType });
    const bytes = new Uint8Array(await blob.arrayBuffer());
    let binary = '';
    const chunkSize = 0x8000;
    for (let offset = 0; offset < bytes.length; offset += chunkSize) {
      binary += String.fromCharCode(...bytes.subarray(offset, offset + chunkSize));
    }

    return {
      base64: btoa(binary),
      mime_type: mimeType,
      bytes: bytes.length,
      acquisition_ms: stopRequestedAt - startedAt,
      finalize_ms: finalizedAt - stopRequestedAt,
      scheduled_stop_ms: scheduledStopMs,
    };
  }, { durationMs, fps, schedulerToleranceMs });
}

async function captureSceneVideos(browser) {
  const size = manifest.video.size;
  const fps = manifest.video.fps || 8;
  const durationMs = manifest.video.duration_ms || 4000;

  for (const target of manifest.isolated_scenes) {
    const context = await browser.newContext({
      viewport: { width: size.width, height: size.height },
      deviceScaleFactor: 1,
    });
    const page = await context.newPage();
    attachErrors(page, `video:${target.id}`);
    const afterSequence = await startScreencast(page, `video:${target.id}`);

    const url = new URL(sceneUrl);
    url.searchParams.set('scene', target.id);
    url.searchParams.set('chrome', 'off');
    url.searchParams.set('motion', manifest.video.motion || 'orbit');
    if (target.phase) url.searchParams.set('phase', target.phase);

    await page.goto(url.toString(), { waitUntil: 'networkidle', timeout: 120000 });
    await waitSceneReady(page, target.id);

    await captureBufferedPngWithinBudget(
      page,
      path.join(outputDir, 'videos', `${target.id}-first.png`),
      `video-poster:${target.id}`,
      afterSequence,
    );
    await stopScreencast(page);

    const media = await recordCanvasMedia(
      page,
      durationMs,
      fps,
      VIDEO_SCHEDULER_TOLERANCE_MS,
    );
    await context.close();

    const minAcquisitionMs = durationMs - VIDEO_SCHEDULER_TOLERANCE_MS;
    const maxAcquisitionMs = durationMs + VIDEO_SCHEDULER_TOLERANCE_MS;
    if (media.acquisition_ms < minAcquisitionMs || media.acquisition_ms > maxAcquisitionMs) {
      throw new Error(
        `video:${target.id}: acquisition ${media.acquisition_ms.toFixed(1)}ms outside ` +
        `${minAcquisitionMs}..${maxAcquisitionMs}ms`
      );
    }
    if (media.finalize_ms > VIDEO_FINALIZE_BUDGET_MS) {
      throw new Error(
        `video:${target.id}: finalize ${media.finalize_ms.toFixed(1)}ms exceeds ` +
        `${VIDEO_FINALIZE_BUDGET_MS}ms`
      );
    }
    if (!media.bytes) throw new Error(`video:${target.id}: MediaRecorder emitted zero bytes`);

    fs.writeFileSync(
      path.join(outputDir, 'videos', `${target.id}.webm`),
      Buffer.from(media.base64, 'base64'),
    );
    videoMetrics.push({
      scene: target.id,
      acquisition_ms: media.acquisition_ms,
      finalize_ms: media.finalize_ms,
      bytes: media.bytes,
      mime_type: media.mime_type,
      scheduled_stop_ms: media.scheduled_stop_ms,
    });
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
      const afterSequence = await startScreencast(
        page,
        `object:${target.id}:${meshName}`,
      );

      const url = new URL(sceneUrl);
      url.searchParams.set('scene', target.id);
      url.searchParams.set('chrome', 'off');
      url.searchParams.set('focus', meshName);
      if (target.phase) url.searchParams.set('phase', target.phase);

      await page.goto(url.toString(), { waitUntil: 'networkidle', timeout: 120000 });
      await waitSceneReady(page, target.id);
      await captureBufferedPngWithinBudget(
        page,
        path.join(outputDir, 'objects', `${target.id}--${safeName(meshName)}.png`),
        `object:${target.id}:${meshName}`,
        afterSequence,
      );
      await stopScreencast(page);
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
        schema_version: 2,
        commit: process.env.LENTE_EXACT_SHA || process.env.GITHUB_SHA || '',
        scope: process.env.LENTE_SCENE_SCOPE || 'full',
        scope_reason: process.env.LENTE_SCOPE_REASON || '',
        video_window: 'post_ready_media_recorder',
        video_fps: manifest.video.fps || 8,
        requested_video_duration_ms: manifest.video.duration_ms || 4000,
        generated_at: new Date().toISOString(),
        page_count: manifest.pages.length,
        isolated_scene_count: manifest.isolated_scenes.length,
        object_capture: captureObjects,
        object_scene_filter: objectSceneFilter,
        object_name_filter: objectNameFilter,
        image_format: 'png',
        video_format: 'webm',
        still_metrics: stillMetrics,
        video_metrics: videoMetrics,
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
