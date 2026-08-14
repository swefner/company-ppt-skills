export function arrayBufferToBase64(buffer) {
  const bytes = new Uint8Array(buffer);
  const chunkSize = 0x8000;
  let binary = "";
  for (let offset = 0; offset < bytes.length; offset += chunkSize) {
    binary += String.fromCharCode(...bytes.subarray(offset, offset + chunkSize));
  }
  return btoa(binary);
}

export async function sha256Hex(buffer) {
  const digest = await crypto.subtle.digest("SHA-256", buffer);
  return Array.from(new Uint8Array(digest), (byte) => byte.toString(16).padStart(2, "0"))
    .join("")
    .toUpperCase();
}

export function findDeckByHash(catalog, hash) {
  const normalized = String(hash || "").toUpperCase();
  return catalog.decks.find((deck) => deck.sha256.toUpperCase() === normalized) || null;
}

export function buildInsertOptions({ formatting, targetSlideId, sourceSlideIds }) {
  const options = { formatting };
  if (targetSlideId) options.targetSlideId = targetSlideId.endsWith("#") ? targetSlideId : `${targetSlideId}#`;
  if (sourceSlideIds?.length) options.sourceSlideIds = sourceSlideIds;
  return options;
}
