import fs from "node:fs";
import http from "node:http";
import https from "node:https";
import path from "node:path";
import { fileURLToPath } from "node:url";
import devCerts from "office-addin-dev-certs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, "../../..");
const port = Number(process.env.PORT || 3000);
const qaPort = Number(process.env.QA_PORT || 3001);
const allowedPaths = [
  "tools/powerpoint-skill-bridge/",
  "domains/yuhong/assets/components/"
];
const allowedFiles = new Set([
  "domains/yuhong/assets/reference-decks/yuhong-template.pptx"
]);

const contentTypes = {
  ".css": "text/css; charset=utf-8",
  ".html": "text/html; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".json": "application/json; charset=utf-8",
  ".mjs": "text/javascript; charset=utf-8",
  ".png": "image/png",
  ".pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation"
};

function resolveRequestPath(url) {
  let pathname;
  try {
    pathname = decodeURIComponent(new URL(url, `https://localhost:${port}`).pathname);
  } catch {
    // Malformed request URL (e.g. "//", unparseable) must not crash the bridge.
    return null;
  }
  const relativePath = pathname === "/" ? "tools/powerpoint-skill-bridge/taskpane.html" : pathname.slice(1);
  if (!allowedPaths.some((prefix) => relativePath.startsWith(prefix)) && !allowedFiles.has(relativePath)) {
    return null;
  }
  const fullPath = path.resolve(repoRoot, relativePath);
  return fullPath.startsWith(repoRoot + path.sep) ? fullPath : null;
}

function serveStatic(request, response) {
  const filePath = resolveRequestPath(request.url || "/");
  if (!filePath || !fs.existsSync(filePath) || !fs.statSync(filePath).isFile()) {
    response.writeHead(404, { "Content-Type": "text/plain; charset=utf-8" });
    response.end("Not found");
    return;
  }

  response.writeHead(200, {
    "Cache-Control": "no-store",
    "Content-Type": contentTypes[path.extname(filePath).toLowerCase()] || "application/octet-stream"
  });
  if (request.method === "HEAD") {
    response.end();
    return;
  }
  fs.createReadStream(filePath).pipe(response);
}

const httpsOptions = await devCerts.getHttpsServerOptions();
const server = https.createServer(httpsOptions, serveStatic);
const qaServer = http.createServer(serveStatic);

server.listen(port, () => {
  process.stdout.write(`PPT Skill Bridge: https://localhost:${port}/tools/powerpoint-skill-bridge/taskpane.html\n`);
});

qaServer.listen(qaPort, () => {
  process.stdout.write(`Browser QA: http://localhost:${qaPort}/tools/powerpoint-skill-bridge/taskpane.html?mock=1\n`);
});
