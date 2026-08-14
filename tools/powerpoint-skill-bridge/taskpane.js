import { arrayBufferToBase64, buildInsertOptions, findDeckByHash, sha256Hex } from "./core.mjs";

const state = {
  catalog: null,
  deck: null,
  base64: null,
  sourceName: null,
  officeReady: false,
  mock: new URLSearchParams(location.search).has("mock")
};

const elements = {
  componentList: document.querySelector("#componentList"),
  componentTemplate: document.querySelector("#componentTemplate"),
  deckTabs: document.querySelector("#deckTabs"),
  fileInput: document.querySelector("#fileInput"),
  fileName: document.querySelector("#fileName"),
  hostState: document.querySelector("#hostState"),
  insertButton: document.querySelector("#insertButton"),
  reloadButton: document.querySelector("#reloadButton"),
  selectAll: document.querySelector("#selectAll"),
  status: document.querySelector("#status")
};

function setStatus(message, tone = "") {
  elements.status.textContent = message;
  elements.status.className = `status ${tone}`.trim();
}

function selectedComponents() {
  return [...document.querySelectorAll(".component-check:checked")]
    .map((input) => state.deck?.components.find((component) => component.id === input.value))
    .filter(Boolean);
}

function updateInsertState() {
  const count = selectedComponents().length;
  elements.insertButton.disabled = !state.base64 || count === 0;
  elements.insertButton.textContent = count > 0 ? `插入所选组件 (${count})` : "插入所选组件";
  const allChecks = [...document.querySelectorAll(".component-check")];
  elements.selectAll.checked = allChecks.length > 0 && allChecks.every((check) => check.checked);
  elements.selectAll.indeterminate = allChecks.some((check) => check.checked) && !elements.selectAll.checked;
}

function renderComponents() {
  elements.componentList.replaceChildren();
  for (const component of state.deck?.components || []) {
    const fragment = elements.componentTemplate.content.cloneNode(true);
    const check = fragment.querySelector(".component-check");
    const preview = fragment.querySelector(".component-preview");
    check.value = component.id;
    check.checked = true;
    check.addEventListener("change", updateInsertState);
    if (component.preview) {
      preview.src = component.preview;
      preview.alt = `${component.title} 预览`;
    } else {
      preview.remove();
      fragment.querySelector(".component-row").style.gridTemplateColumns = "18px minmax(0, 1fr)";
    }
    fragment.querySelector(".component-meta").textContent = `${component.code} · 源第 ${component.sourceSlide} 页`;
    fragment.querySelector(".component-title").textContent = component.title;
    fragment.querySelector(".component-question").textContent = component.question;
    elements.componentList.append(fragment);
  }
  updateInsertState();
}

function renderDeckTabs() {
  elements.deckTabs.replaceChildren();
  for (const deck of state.catalog.decks) {
    const button = document.createElement("button");
    button.type = "button";
    button.className = "deck-tab";
    button.textContent = deck.name;
    button.setAttribute("role", "tab");
    button.setAttribute("aria-selected", String(deck.id === state.deck?.id));
    button.addEventListener("click", () => activateDeck(deck));
    elements.deckTabs.append(button);
  }
}

async function bufferToSource(buffer, expectedDeck, sourceName) {
  const actualHash = await sha256Hex(buffer);
  const matchedDeck = findDeckByHash(state.catalog, actualHash);
  if (expectedDeck && actualHash !== expectedDeck.sha256) {
    throw new Error(`资产校验失败：${sourceName} 与目录中的 SHA-256 不一致。`);
  }

  state.deck = matchedDeck || {
    id: "arbitrary-pptx",
    name: sourceName,
    components: [{ id: "all-slides", code: "PPTX", title: "整个演示文稿", question: "插入源文件中的全部幻灯片。", sourceSlide: "全部" }]
  };
  state.base64 = arrayBufferToBase64(buffer);
  state.sourceName = sourceName;
  elements.fileName.textContent = sourceName;
  renderDeckTabs();
  renderComponents();
  const proof = matchedDeck?.templateProof ? ` · ${matchedDeck.templateProof}` : "";
  setStatus(matchedDeck ? `资产已校验 · ${actualHash.slice(0, 12)}${proof}` : "未登记文件 · 将插入全部幻灯片", matchedDeck ? "success" : "");
}

async function activateDeck(deck) {
  try {
    state.deck = deck;
    state.base64 = null;
    renderDeckTabs();
    renderComponents();
    setStatus(`正在加载 ${deck.name}`);
    const response = await fetch(deck.sourceUrl, { cache: "no-store" });
    if (!response.ok) throw new Error(`资产读取失败：HTTP ${response.status}`);
    await bufferToSource(await response.arrayBuffer(), deck, deck.fileName);
  } catch (error) {
    state.base64 = null;
    updateInsertState();
    setStatus(error.message, "error");
  }
}

async function handleFileChange(event) {
  const file = event.target.files?.[0];
  if (!file) return;
  if (!file.name.toLowerCase().endsWith(".pptx")) {
    setStatus("请选择 .pptx 文件。", "error");
    return;
  }
  try {
    setStatus(`正在读取 ${file.name}`);
    await bufferToSource(await file.arrayBuffer(), null, file.name);
  } catch (error) {
    setStatus(error.message, "error");
  }
}

function getSelectedSlideId() {
  return new Promise((resolve, reject) => {
    Office.context.document.getSelectedDataAsync(Office.CoercionType.SlideRange, (result) => {
      if (result.status === Office.AsyncResultStatus.Failed) {
        reject(new Error(result.error.message));
        return;
      }
      const id = result.value?.slides?.[0]?.id;
      id ? resolve(String(id)) : reject(new Error("请先在当前文稿中选择一页幻灯片。"));
    });
  });
}

async function insertSelected() {
  const components = selectedComponents();
  if (!state.base64 || components.length === 0) return;
  const formatting = document.querySelector('input[name="formatting"]:checked').value;
  const position = document.querySelector('input[name="position"]:checked').value;
  try {
    elements.insertButton.disabled = true;
    setStatus("正在插入原生可编辑幻灯片");
    let targetSlideId = null;
    if (position === "after-selected" && !state.mock) targetSlideId = await getSelectedSlideId();
    const sourceSlideIds = components.map((component) => component.sourceSlideId).filter(Boolean);
    const options = buildInsertOptions({ formatting, targetSlideId, sourceSlideIds });

    if (state.mock) {
      await new Promise((resolve) => setTimeout(resolve, 250));
    } else {
      await PowerPoint.run(async (context) => {
        context.presentation.insertSlidesFromBase64(state.base64, options);
        await context.sync();
      });
    }
    setStatus(`已插入 ${components.length} 个组件 · ${formatting === "KeepSourceFormatting" ? "保留源格式" : "使用当前主题"}`, "success");
  } catch (error) {
    setStatus(`插入失败：${error.message}`, "error");
  } finally {
    updateInsertState();
  }
}

async function initialize() {
  elements.fileInput.addEventListener("change", handleFileChange);
  elements.insertButton.addEventListener("click", insertSelected);
  elements.reloadButton.addEventListener("click", () => state.deck && activateDeck(state.deck));
  elements.selectAll.addEventListener("change", () => {
    document.querySelectorAll(".component-check").forEach((check) => { check.checked = elements.selectAll.checked; });
    updateInsertState();
  });

  const response = await fetch("./catalog.json", { cache: "no-store" });
  state.catalog = await response.json();
  state.deck = state.catalog.decks[0];
  renderDeckTabs();
  renderComponents();
  await activateDeck(state.deck);
}

if (state.mock) {
  state.officeReady = true;
  elements.hostState.textContent = "浏览器测试模式";
  initialize().catch((error) => setStatus(error.message, "error"));
} else {
  Office.onReady((info) => {
    state.officeReady = info.host === Office.HostType.PowerPoint;
    elements.hostState.textContent = state.officeReady ? "PowerPoint 已连接" : "请在 PowerPoint 中打开";
    if (!state.officeReady) elements.insertButton.disabled = true;
    initialize().catch((error) => setStatus(error.message, "error"));
  });
}
