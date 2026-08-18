# Agent 边界：仓库侧 Agent 与 PowerPoint 内 Agent 的分工协议

> 目的：明确两个 Agent 的职责边界与交接点，防止越权执行、防止"声称看过没看的东西"、防止单侧重画资产。
> 背景：2026-08-17 复盘——上一轮最不好的地方是边界不清（仓库侧 agent 无读图/原生插入能力却从零设计组件页；PowerPoint 侧 agent 没看图编造布局、看对布局后改写语义）。
> 适用范围：所有涉及 `company-ppt-skills` 仓库 + PowerPoint 交互的课件/汇报/复盘任务。

---

## 0. 当前主线：两 Agent 协作流程（2026-08-17 拍板）

> 决策记录：曾试用「DeepSeek Design 三件套」做视觉，**结果不理想，弃用**。回归主线——两 Agent 协作，职责划分如下。

**Agent A · 大纲与内容侧（本环境，DeepSeek Harness 仓库侧 Agent）**
- 负责：引导模式开局 → 定大纲/蓝图 → 内容数据化（JSON/提示词/讲师备注）→ 组件选择与映射 → 资产与构建/验收工具维护 → 预览渲染
- 产出：页级蓝图、build-content.json、组件映射表、讲师备注、验收清单、预览图册 —— **提交并推送 `main` 后供 Agent B 消费**

**Agent B · 视觉执行侧（PowerPoint 内 GPT 插件 + skill-bridge 任务窗格）**
- 负责：读取 GitHub 上 Agent A 的蓝图与内容 → 按 contact sheet 图册选组件 → 经 bridge **原生插入**注册组件 → 按槽位合同替换命名对象 → 在用户当前打开的 PPT 里产出**最终成品课件**
- 依赖：Agent A 的产出已入库（`?raw=true` URL 可读）；最终视觉以用户在 PowerPoint 目视为准

**交接协议**：Agent A 入库 → Agent B 消费 → 用户目视验收。任何视觉/布局反馈回到 Agent A 修复资产或改蓝图，不由 Agent B 在活动文档里重画。
**与 COM 构建链的关系**：COM 链（build-county-course.ps1 等）保留为资产渲染、预览与验收工具；**最终成品课件默认走 Agent B 的 PowerPoint 原生插入**，除非用户明确指定仓库侧产出独立 PPTX。

---

## 1. 两个 Agent 是谁、在哪里跑

| 维度 | 仓库侧 Agent（如 DeepSeek Harness 会话） | PowerPoint 内 Agent（如 PowerPoint ChatGPT 会话） |
|---|---|---|
| 运行位置 | 本地开发环境，直接操作仓库 `pppt/company-ppt-skills` | PowerPoint 内，任务窗格（`tools/powerpoint-skill-bridge`）+ ChatGPT，经 bootstrap prompt 读 GitHub Skill Hub |
| 入口 | 本仓库（工作目录） | `bootstrap/powerpoint-chatgpt-prompt.md` / `natural-start-prompts.md` |
| 执行能力 | 读写仓库文件、PowerShell/COM/Python 构建与验收、git、内容数据化 | 读预览图（contact sheet）、在**用户当前打开的 PPT** 内经 bridge 原生插入已注册组件、编辑命名对象 |
| 能看到 | 文件系统 + 文本；**可能不支持读图**（读不了时必须写「图片未读取」） | 实时 PPT 页面 + **能看图册**（因此要求它描述图中实际看到的布局） |
| 看不到 | PowerPoint 交互会话、实时渲染 | 本地未提交的仓库改动、本地构建链、本地数据（E 盘内容稿等） |
| 产物 | 文件系统里的独立 .pptx + 资产 + 脚本 + 文档 | 用户当前的 live PPT 文档 |

---

## 2. 三层架构：决策层共享、内容层共享、执行层分离

```
决策层（共享，两个 Agent 必须遵守同一套，谁都无权改写）
   SKILL.md ｜ guided-mode.md ｜ decision-component-store.md（组件卡片语义）
   component-slots.json（槽位合同）｜ build-execution-contract.md（Truthful Build Claims）
   → 语义以卡片 + 槽位合同为准：四力、四阶段名固定，两边都不能改

内容层（共享素材，产出方看任务在哪一侧）
   内容稿 ｜ 单页提示词 ｜ 蓝图 ｜ 讲师备注 ｜ 验收清单

执行层（分离，互不替代）
   PowerPoint 侧 = skill-bridge 任务窗格          仓库侧 = COM 构建链
   原生插入源页（二进制由 bridge 完成）             build-content.json + build-county-course.ps1
   Agent 只做命名槽位文本替换                      + check-overflow.ps1 + verify-render.py
   产物：用户当前的 live PPT                     产物：文件系统里的独立 .pptx
```

**核心边界一句话**：PowerPoint Agent 是"消费资产、编辑文档"，仓库侧 Agent 是"维护资产、产出文件"；两边共享决策规则，但各自只对自己的执行层负责、只声称自己真实执行过的验证。

---

## 3. 职责清单

### 3.1 仓库侧 Agent（我）负责

- 维护组件资产全链路：源 deck、槽位合同、预览重渲染（`render-component-previews.ps1`）、contact sheet 图册（`build-contact-sheet.py`）、`component-index.json`、`catalog.json`、注册表；
- 内容数据化（build-content.json）+ 构建脚本 + 验收脚本（check-overflow / verify-render / acceptance-checklist）；
- 用 COM 链产出独立课件 PPTX 并做自动化验收（溢出 0 处、品牌像素 dark/red）；
- 蓝图、验收清单、人用手册、本文档等仓库文档；PPTX 二进制走"工作副本 + 入库"流程。

### 3.2 仓库侧 Agent 不做 / 不能做

- 不代替 PowerPoint 内的原生插入（没有 PowerPoint 交互会话；产出的是独立文件，不是改用户的 live deck）；
- 不声称看过预览图（当前环境不支持读图时必须写「图片未读取」，仅按槽位合同 + 源页结构判断）；
- 不经用户确认蓝图/方向直接 Build；
- 不引入未经授权的外部图片/Logo，不用红白配色冒充品牌，不从零重画匹配的组件页。

### 3.3 PowerPoint 内 Agent 负责

- 在用户打开的 PPT 里：读 contact sheet 图册 → 选组件 → 经 bridge 原生插入注册组件（`catalog.json` 中 id/code/sourceSlideId）→ 按 `component-slots.json` 替换命名对象 → 保留模板母版与品牌资产；
- 读图并如实描述实际看到的布局（它看得见图）；图片读取失败写「图片未读取」；
- 页面内容超出槽位容量时拆页或压缩到 notes，禁止缩字硬塞。

### 3.4 PowerPoint 内 Agent 不做 / 不能做

- 不修改仓库资产（它只有 GitHub 只读 URL，改了也回不去）；
- 不声称看了没看的图（防伪条款）；
- 不改写组件语义（四力/四阶段等以卡片 + 槽位合同为准）；
- 不把"看过预览图"当成"已按模板构建"——插入必须是 bridge 的原生插入。

---

## 4. 交接点（协作协议，防止越界）

1. **资产变更必须走仓库侧**：源页/槽位/预览/索引/图册/catalog 变更 → 仓库侧完成并提交推 `main` → PowerPoint 侧才能读到新版本（它读 GitHub main）。"先入库"是硬前置；PowerPoint 侧不能在活动文档里重画来"补"资产缺口。
2. **PowerPoint 侧发现的资产缺陷**（布局、槽位缺失、容量不足）→ 记录反馈 → 由仓库侧修复资产，而不是 PowerPoint 内自行重画。
2.5 **授权定制新建页例外**：当 Agent A 明确判定某页"无匹配组件"并书面授权时，Agent B 可在雨虹模板母版内以原生形状新建该页；此行为**不属于擅自重画组件**，但必须继承模板母版、品牌标记与页脚，不得从零仿制品牌（红白冒充）。授权与判定记录需入库可查（如交接包）。
3. **同一课件两份产物**（live deck vs 独立 PPTX）：交付哪个由用户指定；两份都必须过同一套组件门禁 / 品牌 / 验收规则。
4. **视觉验证分工**：PowerPoint 侧看实时渲染；仓库侧用像素脚本替代（右上角品牌区 dark=2146 / red=1987、左下角背景 mean≈(247,247,248)）；最终目视由用户在 PowerPoint 完成——任何一侧都不能把"替代验证"说成"人眼验收"。
5. **数据安全**：真实经营数据（涪陵等）与本地内容稿（E 盘）不进入公开仓库；任何一侧都不把未经脱敏的本地数据写进可推送内容。

---

## 5. 防伪条款映射（两边各自的验证手段，互不替代）

| 环节 | PowerPoint 侧 | 仓库侧 |
|---|---|---|
| 组件选择 | contact sheet 单图 + 卡片；描述图中实际布局 | 槽位合同 + 源页结构；读不了图写「图片未读取」 |
| 模板跟随 | bridge 原生插入 + KeepSourceFormatting | 构建契约指纹核对（SHA-256）+ 像素品牌区对比 |
| 内容不越界 | 卡片语义 + 槽位合同 | 蓝图 + acceptance-checklist |
| 最终验收 | 用户目视（唯一权威） | 用户目视（脚本验收只是替代，不能自称人眼验收） |

---

## 6. 上一轮教训的本质（为什么会有"做的最不好的地方"）

- 仓库侧 agent 在没有读图、没有原生插入能力时试图"从零设计组件页" → 越权做了自己没有执行基础、因而无法真实验证的事；
- PowerPoint 侧 agent 没看图编造布局（4/5 组件布局错误、编造"模板 33 页"）、看对布局后改写内容定义（把四力改成自定增长方向）→ 都是决策层/执行层混淆 + 声称无真实执行基础；
- 机制性修复 = 本文档的三层边界 + 两侧各自的防伪条款 + "先入库再消费"的交接协议。
