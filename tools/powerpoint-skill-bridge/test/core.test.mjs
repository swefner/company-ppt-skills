import assert from "node:assert/strict";
import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";
import { buildInsertOptions, findDeckByHash } from "../core.mjs";

const projectRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

test("buildInsertOptions normalizes the target slide id", () => {
  assert.deepEqual(buildInsertOptions({
    formatting: "KeepSourceFormatting",
    targetSlideId: "267",
    sourceSlideIds: ["256#", "258#"]
  }), {
    formatting: "KeepSourceFormatting",
    targetSlideId: "267#",
    sourceSlideIds: ["256#", "258#"]
  });
});

test("buildInsertOptions omits optional slide selectors", () => {
  assert.deepEqual(buildInsertOptions({ formatting: "UseDestinationTheme" }), {
    formatting: "UseDestinationTheme"
  });
});

test("findDeckByHash is case insensitive", () => {
  const deck = { id: "known", sha256: "AABB" };
  assert.equal(findDeckByHash({ decks: [deck] }, "aabb"), deck);
  assert.equal(findDeckByHash({ decks: [deck] }, "ccdd"), null);
});

test("catalog points to the fingerprinted branded Yuhong component deck", () => {
  const catalog = JSON.parse(fs.readFileSync(path.join(projectRoot, "catalog.json"), "utf8"));
  const deck = catalog.decks.find((item) => item.id === "yuhong-county-course-components");
  const deckPath = path.resolve(projectRoot, "../..", deck.sourceUrl.slice(1));
  const actualHash = crypto.createHash("sha256").update(fs.readFileSync(deckPath)).digest("hex").toUpperCase();

  assert.match(deck.fileName, /-branded\.pptx$/);
  assert.equal(actualHash, deck.sha256);
});
