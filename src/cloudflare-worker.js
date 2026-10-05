const WASM_PATH = "/index.wasm";

async function compressedWasmResponse(request, env) {
  const acceptEncoding = request.headers.get("accept-encoding") ?? "";
  const candidates = [];

  if (acceptEncoding.includes("br")) {
    candidates.push({ path: "/index.wasm.br", encoding: "br" });
  }
  if (acceptEncoding.includes("gzip")) {
    candidates.push({ path: "/index.wasm.gz", encoding: "gzip" });
  }

  for (const candidate of candidates) {
    const assetUrl = new URL(candidate.path, request.url);
    const assetRequest = new Request(assetUrl, {
      method: request.method,
      headers: request.headers,
    });
    const asset = await env.ASSETS.fetch(assetRequest);

    if (!asset.ok) {
      continue;
    }

    const headers = new Headers(asset.headers);
    headers.set("content-type", "application/wasm");
    headers.set("content-encoding", candidate.encoding);
    headers.set("vary", "Accept-Encoding");
    headers.set("cache-control", "public, max-age=0, must-revalidate");

    return new Response(request.method === "HEAD" ? null : asset.body, {
      status: 200,
      headers,
    });
  }

  return new Response(
    "A supported compressed WebAssembly representation is not available.",
    {
      status: 406,
      headers: {
        "content-type": "text/plain; charset=utf-8",
        "cache-control": "no-store",
        "vary": "Accept-Encoding",
      },
    },
  );
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (url.pathname === WASM_PATH) {
      if (request.method !== "GET" && request.method !== "HEAD") {
        return new Response("Method Not Allowed", {
          status: 405,
          headers: { Allow: "GET, HEAD" },
        });
      }

      return compressedWasmResponse(request, env);
    }

    return env.ASSETS.fetch(request);
  },
};
