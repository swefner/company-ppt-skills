# Build Execution Contract

> 补充（2026-08-18 实测）：**二进制 PPTX 的 GitHub URL 可用性**——`https://github.com/.../blob/main/<路径>?raw=true` 对 .pptx 实测返回 `200 application/octet-stream`（本机验证 yuhong-template.pptx 886,710 B 完整）。文本/图片链路沿用 `decision-component-store.md` 的 `?raw=true` 约定。注意：**URL 可达 ≠ PowerPoint 原生插入可行**——Agent B 仍需要附件或 bridge 才能完成 InsertFromFile/打开文件操作（见 `bootstrap/two-agent-handoff-pack.md` 前置条件）。

Use this contract immediately before every `Build`. It prevents an agent from claiming that it followed the Skill or template when it only used a prompt summary or recreated a generic deck.

## 1. Source Read Receipt

Before creating or modifying slides, record a concise internal read receipt containing:

- Repository and exact commit or local Skill root.
- Every required rule file actually opened.
- Every binary PPTX asset actually downloaded or opened.
- Source deck slide count and file size.
- Any source that could not be accessed.

Seeing a Skill name in a tool list does not count as reading the Skill. Seeing a GitHub directory or HTML summary does not count as opening the referenced files. Never state that a fixed commit was read unless files from that exact revision were opened.

If a required file or binary asset cannot be opened, stop before Build and report the missing item. Do not silently replace it with a generic style.

## 2. Current Asset Fingerprints

Use these values to detect wrong files or empty substitutes. If the repository intentionally updates an asset, update this contract with the new fingerprint.

### Yuhong Visual Base

- Path: `assets/reference-decks/yuhong-template.pptx`.
- SHA-256: `A9F396CF0EB4074CDF02F2C9E7F02E93E5985BCFDEEBD76DF16D0D65291F263C`.
- Expected structure: 1 slide, 7 media assets, 9 layouts, 1 master.
- Role: brand visual base and inherited PowerPoint structure.
- Limitation: it is not a multi-page content-layout library. Do not claim to have selected many content reference pages from it.

### Executable Course Components

- Path: `assets/components/yuhong-county-course-components-branded.pptx`.
- SHA-256: `9622BE2F42F919918E08E93D2206B18D7095AF3D3667E793E59CD45E1B49FF0C`.
- Expected structure: 12 slides and 12 speaker-note pages.
- Role: editable content compositions for the twelve registered county-course components (DC-01/02/03/04/05/06/08/16/17/20 + I1/I3), already attached to the real Yuhong template master.
- Note: SHA changes whenever a source page is added via the work-copy pipeline; registry is the single source of truth and deck SHA is recomputed by `build-component-registry.py --update-catalog` (run after promote). History: EAC0CD92 -> 9EC9E58E (DC-05) -> 1DD3E475 (I1) -> E84FD46C (DC-16) -> CECA243C (DC-06) -> 9622BE2F (I3).

## 3. Required Build Route

For a new Yuhong county course:

1. Open and inspect `yuhong-template.pptx`.
2. Preserve or inherit its master, background, brand media, page furniture, and approved logo placement.
3. Open `yuhong-county-course-components-branded.pptx` and verify that each component follows the imported Yuhong master background.
4. Duplicate matching component source slides according to `component-slots.json`.
5. Combine the brand visual base with the duplicated component content while preserving editable native objects.
6. Add non-component pages only after defining their teaching action and visual source.

Do not use `insert_slides_from_html`, HTML-to-slide bulk generation, screenshot flattening, or a from-scratch generic deck as the primary route when these PPTX assets are available.

If the execution environment cannot import or duplicate source PPTX slides while preserving their objects, stop and report the capability gap. Do not pretend that a red-and-white rebuild is template following.

### PowerPoint Skill Bridge Route

When working inside the PowerPoint Office Add-in environment, binary access is delegated to the local task pane at `tools/powerpoint-skill-bridge`:

1. Start the bridge's local HTTPS service.
2. Open `PPT Skill Bridge` in PowerPoint.
3. Select the registered template or component source.
4. Insert the exact registered component with `KeepSourceFormatting`.
5. Only after native insertion succeeds, let the Agent replace the named content slots.

The task pane is the binary execution layer; the Skill remains the decision and content layer. A text-only Agent must not substitute a redraw when the bridge is available.

## 4. Brand Asset Rule

- Use only brand marks embedded in the approved source PPTX assets or another user-approved official asset.
- Do not use a logo from image search, third-party websites, or a manually recreated approximation.
- Do not treat a red palette or typed `东方雨虹` text as evidence of template fidelity.
- Preserve the source asset's crop, aspect ratio, clear space, and placement unless the user explicitly approves a change.

## 5. Editability Rule

Editability is required but does not outrank template fidelity.

- Keep content text, diagnostic labels, editable diagrams, and worksheet fields native where practical.
- Preserve approved background and brand media as inherited or image assets when that is how the source template is built.
- Do not replace branded assets with crude geometry merely to make every pixel editable.
- Do not flatten an entire component page to an image.

## 6. Required Build Evidence

Before declaring completion, verify and report internally:

- Actual source-template slide or master inheritance used in the output.
- Output slides mapped to executable component source slide numbers.
- Count of output slides using inherited template assets.
- Count of executable component slides duplicated.
- Count of interactive pages with real speaker notes.
- Whether any external logo or unapproved brand asset was introduced.
- Rendered visual comparison against the template and component previews.

Page count, lack of overflow, and lack of overlap are necessary but do not prove template fidelity.

## 7. Stop Conditions

Stop before or during Build when:

- The fixed commit or local Skill files were not actually opened.
- The required PPTX assets cannot be downloaded, opened, or imported.
- The output route cannot preserve source objects.
- The only available brand asset came from web search or an unapproved source.
- The resulting deck does not visibly retain the supplied template's background and brand language.

State the exact blocker and the closest compliant next step. Never claim successful Skill or template use without the evidence above.
