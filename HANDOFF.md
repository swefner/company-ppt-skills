# Company PPT Skills · Agent 交接说明（2026-08-14 更新）

> 用途：新 Agent 接手时快速恢复上下文。**先读此文件，再按第 1 节要求实际打开仓库文件**，不要凭本文件声称已读取任何资产。
> 旧版交接说明（本地路径，含更早的项目历史）：`C:\Users\Swefner\Documents\Codex\2026-08-12\referenced-chatgpt-conversation-this-is-an-2\新Agent交接说明_company-ppt-skills.md`

## 1. 给新 Agent 的第一条指令

1. 从本地真实仓库继续工作，不要仅凭本交接摘要声称已读取 Skill、模板或组件资产。
2. 检查 `git status`，保留所有现有未提交改动，不回退任何人的工作。
3. 根据任务读取对应 reference 文件、`component-slots.json` 和真实 PPTX 资产。
4. Build 前读取 `domains/yuhong/references/build-execution-contract.md`，记录 source-read receipt、核对 PPTX 指纹。
5. 用户确认 Build 前，不直接生成最终 PPT（引导模式流程，见 `domains/yuhong/references/guided-mode.md`）。

## 2. 当前状态（2026-08-14 收盘）

- 所有成果已提交并推送 `main`（含规则、组件、工具、课件产出、文档）。
- 分支注意：`main` 是唯一权威分支；本地旧分支 `agent/publish-yuhong-ppt-hub` 已并入 main，不再使用。
- 项目主线：东方雨虹 Yuhong 县域经销商课程（看趋势 + 判状态），**B 模式（固定老板模式）**已产出 14 页成品课件。

## 3. 本阶段里程碑（今天完成的）

| 成果 | 位置 | 说明 |
|---|---|---|
| 14 页老板版课件（试金石） | `domains/yuhong/outputs/县域机会诊断_看趋势与判状态_老板版_V0.1.pptx` | 6 页复制可执行组件源页 + 8 页母版继承新页，已通过结构与像素验收 |
| 构建工具链 | `domains/yuhong/outputs/build-content.json` + `build-county-course.ps1` + `check-overflow.ps1` + `render-preview.ps1` + `verify-render.py` | 内容数据化 + COM 确定性构建 + 自动验收；**下个课件直接复用，先改 build-content.json** |
| 渲染预览闭环 | `assets/components/render-component-previews.ps1` + `build-contact-sheet.py` + `previews/component-render-manifest.json` | 组件源页变更后一键重渲染 + 指纹防过期 |
| 大字图册（Agent 选择入口） | `assets/components/previews/component-store-render-sheet.png` | 3×2 图册，每格左上角大号 DC 编号；Agent 选组件必须读这一张 |
| 防伪条款三层 | `bootstrap/powerpoint-chatgpt-prompt.md`、`shared/component-selection.md`、`domains/yuhong/references/decision-component-store.md` | 见第 4 节 |
| 人用组件手册 | `domains/yuhong/guides/component-usage-guide.md` | 给同事/培训师看的文档，非 Agent 文档 |

## 4. 关键验证结论（实测数据，勿凭直觉修改）

### 4.1 PowerPoint 内 Agent 链路（2026-08-14 三轮实测）

- 文本链路：通。GitHub raw URL 可读规则文件。
- 图片链路：`raw.githubusercontent.com` 在 Agent 环境**会超时**；`https://github.com/swefner/company-ppt-skills/blob/main/<path>?raw=true` 形式**成功**。文档已记录此 URL 形式。
- 防伪条款前：Agent 声称"已查看预览图"却对 4/5 组件编造布局，还编出"模板 33 页"（真实模板只有 1 页）。
- 防伪条款后：6/6 组件布局描述真实（与槽位结构吻合）。
- **残余风险**：Agent 布局看对了仍会**改写组件内容定义**（如把四力改写成自己定义的增长方向）——语义条款已补，见下。

### 4.2 组件语义规则（Agent 必须遵守）

- **布局以预览图为准**（contact sheet 单图）。
- **内容定义以 `decision-component-store.md` 卡片 + `component-slots.json` 为准，不得改写**（如"四力"= 品牌/渠道/场景/产品；"四阶段"= 进得去/站得住/卖得动/做得深，均固定）。
- 图片读取失败必须写「图片未读取」，禁止声称已查看。
- 新 Agent 做任何组件相关文档修改时，保持这些规则一致。

## 5. 构建技术路线（已验证可复用）

- 环境：PowerPoint COM 16.0（机器已装 PowerPoint）、python-pptx 1.0.2、PowerShell 5.1（**执行策略用 `-ExecutionPolicy RemoteSigned`，不要用 Bypass**——安全分类器会拦截）。
- 流程：COM 打开 branded 源 deck → `InsertFromFile` 导入模板 slide（引入真实母版/版式）→ 删模板 slide → 新页 `AddSlide(index, layout)` + `FollowMasterBackground = -1` → 组件页槽位替换（`Shapes.Item(name).TextFrame.TextRange.Text`）→ 删除内部 `COMPONENT_ID` 角标 → `SaveAs`（格式 24）。
- **已踩的坑**：
  1. 插入 6 个新页后组件页位置偏移 +6，槽位替换必须用 `sourceSlide + 6` 取页；
  2. PS 5.1 无 BOM UTF-8 脚本中文乱码——中文内容全部放 JSON（UTF-8），脚本本体纯 ASCII；
  3. COM `Export`/文件路径必须绝对路径（PowerPoint 进程 cwd 不可靠）；
  4. 文本溢出检查**用真实渲染测量**（`TextRange2.TextRange.BoundHeight` vs 形状可用高度），不要用字符数估算模型（误差极大）。
- 验收：像素级品牌区对比（右上角品牌区 dark/red 像素数与模板逐像素一致）；`check-overflow.ps1` 真实溢出检查；`verify-render.py` 品牌继承检查。
- 非组件新页：模板 layout 无占位符，用自由文本框 `AddTextbox`；字体 Microsoft YaHei（Name + NameFarEast）。

## 6. 待办 / 下一步方向

1. **扩充可执行组件**：优先 DC-08（30 天行动板，课件收尾页缺口）和 DC-05（渠道驱动板，下一模块入口）。完整链路 = 源页 + 槽位合同 + 渲染预览 + 图册 + 注册表。PPTX 二进制不可并行编辑，走"工作副本 + 入库"流程。
2. **课件续作**：渠道精耕 / 产品战役模块（内容稿在 E 盘 WeChat 目录，见旧交接说明 §10）。
3. **UFS 追平**：UFS 无可执行组件、无 build 契约——是否追平属战略决策，未决。
4. **人眼终验**：本环境 Read 工具不支持图片，视觉验收靠像素特征；最终以用户在 PowerPoint 打开成品目视为准。

## 7. 关键路径索引

| 资产 | 路径 |
|---|---|
| 组件源 deck（7 页可编辑，DC-01/02/03/04/17/20/08） | `domains/yuhong/assets/components/yuhong-county-course-components-branded.pptx`（SHA-256 `DC05FE7B...`） |
| 视觉模板（1 页母版基座） | `domains/yuhong/assets/reference-decks/yuhong-template.pptx`（SHA-256 `A9F396CF...`） |
| 槽位合同 | `domains/yuhong/assets/components/component-slots.json` |
| 组件业务定义 | `domains/yuhong/references/decision-component-store.md` |
| 可执行组件规则 | `domains/yuhong/references/executable-component-store.md` |
| Build 契约 | `domains/yuhong/references/build-execution-contract.md` |
| 人用手册 | `domains/yuhong/guides/component-usage-guide.md` |
| 课件产出 + 构建脚本 | `domains/yuhong/outputs/` |
| 14 页蓝图 | `domains/yuhong/plans/county-opportunity-boss-mode-blueprint-14p.md` |
| Hub 入口（PowerPoint Agent 用） | `bootstrap/powerpoint-chatgpt-prompt.md`、`bootstrap/natural-start-prompts.md` |

## 8. 不要重复的错误

- 不要声称读取了未实际打开的文件（Truthful Build Claims，见 `domains/yuhong/SKILL.md`）。
- 不要用 HTML 批量生成、红白配色冒充模板、第三方 Logo、重绘组件页。
- 不要清理 dirty worktree、不要未经确认生成最终 PPT。
- 不要信任 PowerPoint 内 Agent 的组件描述——它可能编造或语义改写；以 contact sheet 图和卡片为准。
- 提交前检查 .gitignore（node_modules、渲染临时目录已被排除）。
