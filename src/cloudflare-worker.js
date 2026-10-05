const WASM_PATH = "/index.wasm";
const WASM_KEY = "index.wasm";

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

      const object = await env.GAME_ASSETS.get(WASM_KEY);

      if (!object) {
        return new Response("Godot WebAssembly artifact not found", {
          status: 503,
          headers: {
            "content-type": "text/plain; charset=utf-8",
            "cache-control": "no-store",
          },
        });
      }

      const headers = new Headers();
      object.writeHttpMetadata(headers);
      headers.set("content-type", "application/wasm");
      headers.set("etag", object.httpEtag);
      headers.set("content-length", String(object.size));
      headers.set("cache-control", "public, max-age=0, must-revalidate");

      return new Response(request.method === "HEAD" ? null : object.body, {
        status: 200,
        headers,
      });
    }

    return env.ASSETS.fetch(request);
  },
};
