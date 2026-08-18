# 雨虹课件研发 · Agent 交接文档

> 交接对象：新 Agent（任务 = 东方雨虹县域经销商课件研发）
> 交接时间：2026-08-17 ｜ 全局交接见仓库根 `HANDOFF.md`（先读）
> 交接人要求：**本任务必须开启引导模式**（见第 1 节），禁止直接进入构建。

## 1. 进入任务的第一步（引导模式开启）

收到任务后，按以下顺序工作，**不要直接构建 PPT**：

1. 复述你的理解：任务目标、当前阶段、交付物、最关键约束；
2. 检查材料（实际打开文件，不要凭文档声称已读）：本文件第 3 节列出的所有路径；
3. 检查 `git status`，保留所有未提交改动；
4. **问 1-3 个改变方向的问题**（这是硬要求，不是可选项）：
   - 有没有参考样例？（用户觉得好的经营/课件 PPT，要路径）
   - 给谁看、什么场合？（老板自读 / 讲师授课 / 大会展示）
   - 风格期望？（数据密集 / 教学互动 / 汇报大气）
   - 没有视觉参考时，明确说"没有参考，我按 X 假设构建，先出 1-2 页样张确认"；
5. **先出样张**：视觉方向确认前，先做 1-2 页样张给用户看，确认方向后再批量构建；
6. 蓝图 → 用户确认 → Build 契约 → 构建 → 验收。

## 2. 当前基线（2026-08-15 收盘）

- **15 页老板版课件已 Build 并验收**：`outputs/县域机会诊断_看趋势与判状态_老板版_V0.1.pptx`
- 蓝图（V0.3，15 页含 DC-08 行动承诺页 P14）：`plans/county-opportunity-boss-mode-blueprint-15p.md`
- 构建工具链（内容数据化 + COM 构建）：`outputs/build-content.json` + `build-county-course.ps1`
- 组件库：7 个可执行组件（DC-01/02/03/04/17/20/08），源 deck `assets/components/yuhong-county-course-components-branded.pptx`（SHA-256 `EAC0CD92...`，7 页）

## 3. 必读文件（按顺序，实际打开）

1. `domains/yuhong/SKILL.md`（Truthful Build Claims、组件门禁）
2. `references/guided-mode.md`、`references/build-execution-contract.md`、`references/executable-component-store.md`
3. `references/decision-component-store.md`（组件卡片 + 防伪/语义条款 + Navigation Index）
4. `assets/components/component-slots.json`（槽位合同、容量、不变式）
5. `assets/components/previews/component-store-render-sheet.png`（大字图册，Agent 选组件前先看图）
6. `assets/reference-decks/yuhong-template.pptx`（母版基座，1 页）
7. `references/acceptance-checklist.md`（验收清单：勾选 + 参考值）
8. 内容稿（本地 E 盘，仅本地）：`E:\xwechat_files\wxid_7n9c1ll9861c22_5097\msg\file\2026-08\雨虹县域课程_机会诊断_看趋势与判状态内容稿_V0.1.md`（+ HTML 版）

## 4. 最重要的教训（2026-08-17 复盘，必须遵守）

### 4.1 设计：先参考，再动手（本次最大的失败教训）

- **做任何新页面/新组件，第一步是参考现有设计资产**，不是从零排文本框：
  - 雨虹 7 个可执行组件（源 deck 打开看布局）
  - 樱桃库 141 页逻辑图（索引：`domains/ufs/assets/reference-decks/cherry-red-logic-index.md`）
  - `trader-to-service-provider-course.pptx`（216 页完整课件设计）
  - 失败反例：`C:\Users\Swefner\OneDrive\Desktop\演示文稿1.pptx`（红顶栏灰卡片，禁止模仿）
- 参考 ≠ 复制：樱桃库是**逻辑参考**，必须在雨虹母版上重建；
- **先出样张（1-2 页）确认方向，再批量**。批量做完才发现偏离 = 流程失败。

### 4.2 组件规则（硬约束）

- 匹配的可执行组件：**复制源页 + 替换命名槽位**，禁止重画；
- 组件语义不可改写：四力 = 品牌/渠道/场景/产品；四阶段名 = 进得去/站得住/卖得动/做得深（固定）；
- 槽位容量约束：源页文本 = 设计容量，超容量内容压缩到 notes 或拆页，禁止缩字硬塞；
- 选组件：先看 contact sheet 图册 → 描述布局 → 核对卡片；读不到图写「图片未读取」。

### 4.3 构建技术（已验证，直接复用）

- 环境：PowerPoint COM 16.0、python-pptx 1.0.2、PowerShell（`-ExecutionPolicy RemoteSigned`，禁止 Bypass）；
- 流程：打开组件源 deck → InsertFromFile 模板（引入母版）→ AddSlide（模板 layout + FollowMasterBackground）→ 槽位替换（Shapes.Item(name)）→ 删 COMPONENT_ID → SaveAs；
- 坑：①组件页插入新页后索引 +6；②PS 5.1 中文走 JSON（内容数据化）；③COM 路径必须绝对路径；④溢出检查用真实渲染 BoundHeight（估算模型不可靠）；⑤**禁止"打开 A 又保存覆盖 A"**（文件锁）——先存临时文件再替换。

### 4.4 数据安全（红线）

- 真实经营数据（涪陵等经销商数据）**不得进入公开仓库**（.gitignore 已排除，见根 `.gitignore`）；
- 雨虹内容稿在 E 盘本地，不在仓库——课件页面内容来自内容稿，构建脚本只含结构，数字/文案从本地 JSON 读。

### 4.5 验收（每次构建后）

- `check-overflow.ps1`（真实渲染溢出 = 0）+ 像素品牌区验证（右上角 dark=2146/red=1987）+ `acceptance-checklist.md` 逐项；
- **文件大小 ≤ 5MB**（构建后检查）；
- 最终以用户在 PowerPoint 打开目视为准（本环境 Read 不支持图片）。

## 5. 下一步方向（与用户确认后再动）

1. **课件续作**：下一模块（渠道精耕 / 产品战役）——先出页级蓝图 + 样张；
2. **15 页课件改进**：根据用户目视反馈调整（视觉方向问题先问：参考样例/场合/风格）；
3. **DC-05 渠道驱动板**：构建脚本已有草稿（`assets/components/build-dc05.ps1` + `dc05-content.json`），源页未落地——做时按完整链路（源页+槽位+渲染+索引+图册）。

## 6. 关键路径索引

| 资产 | 路径 |
|---|---|
| 组件源 deck（7 页） | `domains/yuhong/assets/components/yuhong-county-course-components-branded.pptx` |
| 槽位合同 | `domains/yuhong/assets/components/component-slots.json` |
| 组件卡片 + 防伪条款 | `domains/yuhong/references/decision-component-store.md` |
| Build 契约 | `domains/yuhong/references/build-execution-contract.md` |
| 验收清单 | `domains/yuhong/references/acceptance-checklist.md` |
| 15 页成品 + 构建链 | `domains/yuhong/outputs/` |
| 15 页蓝图 V0.3 | `domains/yuhong/plans/county-opportunity-boss-mode-blueprint-15p.md` |
| 人用组件手册 | `domains/yuhong/guides/component-usage-guide.md` |
| 樱桃库索引（设计参考） | `domains/ufs/assets/reference-decks/cherry-red-logic-index.md` |
