# 两 Agent 交接包：雨虹「看趋势」4 页教学课件路径实验

> 用途：Agent A（仓库侧 / 本环境）→ Agent B（PowerPoint 内 GPT + skill-bridge）的完整交接包。
> 实验目标：验证"仓库侧定大纲/内容 + PowerPoint GPT 视觉执行"这条主线的可行性与交接质量（上一轮失败点：编造布局、改写语义、溢出硬塞、句式同质）。
> 主线路定义见 `docs/agent-boundary.md` 第 0 节；**授权定制新建页例外**见第 4 节 2.5。

---

## 一、源路径表（素材溯源 + Agent B 读取方式）

| 素材 | 本地源路径（溯源） | 仓库路径（入库后） | Agent B 读取方式 |
|---|---|---|---|
| PPT 全局排版提示词 V0.1 | `C:\Users\Swefner\OneDrive\Desktop\朴道晟源\雨虹县域课程_PPT全局排版提示词_V0.1.md` | `domains/yuhong/inputs/雨虹县域课程_PPT全局排版提示词_V0.1.md` | GitHub raw URL（见下）或 bridge localhost |
| 机会诊断内容稿 V0.1 | `C:\Users\Swefner\OneDrive\Desktop\朴道晟源\雨虹县域课程_机会诊断_看趋势与判状态内容稿_V0.1.md` | `domains/yuhong/inputs/雨虹县域课程_机会诊断_看趋势与判状态内容稿_V0.1.md` | 同上 |
| 看趋势四页单页提示词测试版 V0.1 | `C:\Users\Swefner\OneDrive\Desktop\朴道晟源\雨虹县域课程_看趋势四页PPT单页提示词_测试版_V0.1.md` | `domains/yuhong/inputs/雨虹县域课程_看趋势四页PPT单页提示词_测试版_V0.1.md` | 同上 |
| 槽位合同 | — | `domains/yuhong/assets/components/component-slots.json` | GitHub raw URL |
| 通用视觉/版式规范 V0.3 | — | `shared/ppt-design-spec.md` | GitHub raw URL |
| 组件图册（读图） | — | `domains/yuhong/assets/components/previews/component-store-render-sheet.png` | GitHub `?raw=true` 或 bridge localhost |
| 品牌模板（二进制） | — | `domains/yuhong/assets/reference-decks/yuhong-template.pptx` | **附件上传给 Agent B，或 bridge 原生插入**；`?raw=true` 下载为备用 |
| 可执行组件源 deck（二进制） | — | `domains/yuhong/assets/components/yuhong-county-course-components-branded.pptx` | **附件上传给 Agent B，或 bridge 原生插入**；`?raw=true` 下载为备用 |

**GitHub raw URL 形式**（仓库约定，`raw.githubusercontent.com` 会超时）：
`https://github.com/swefner/company-ppt-skills/blob/main/<仓库路径>?raw=true`
（中文文件名若粘贴失败，可对路径做 URL 编码；或改用本地 skill-bridge 任务窗格地址 `https://localhost:3000/<仓库路径>` 读取。）

**前置条件（Build 前必须满足其一）**：①两个 PPTX 已作为附件提供给 Agent B；②skill-bridge 正在运行且可原生插入。两者皆不可用时**停止并报告**——禁止从零构建近似品牌页面（红白冒充模板，见 `build-execution-contract.md` 停止条件）。

---

## 二、交接包全文（发给 Agent B 的内容）

```
【交接包】Agent A（仓库侧）→ Agent B（PowerPoint 视觉执行）· V0.2
任务：东方雨虹「看趋势」4 页教学课件 · 两 Agent 路径实验 · M1-U1-01~04

一、你的角色与边界
- 你是视觉执行 Agent：在用户当前打开的 PPT 里，经 skill-bridge 原生插入/新建可编辑页面。
- 大纲、内容判断、组件核对由我（Agent A）完成并已入库；你负责视觉执行，不重新发明内容。
- 【授权例外】本任务四页均为 Agent A 判定的"无匹配组件定制页"，已书面授权：
  允许你在雨虹模板母版内使用原生形状构建这四页；该行为不视为擅自重画现有组件
  （边界协议 §4.2.5）。但必须继承模板母版、品牌标记与页脚，禁止红白冒充模板。
- 产出：4 页可编辑成品 + 讲师备注；最终以用户在 PowerPoint 目视为准。

二、必读源（用 ?raw=true 形式读，raw.githubusercontent 会超时）
1. 全局排版提示词（一页一任务/学员页-备注分离/品牌规范/15 项终检）
   domains/yuhong/inputs/雨虹县域课程_PPT全局排版提示词_V0.1.md
2. 单页提示词测试版（本任务的逐页规格，学员可见文案以此为准）
   domains/yuhong/inputs/雨虹县域课程_看趋势四页PPT单页提示词_测试版_V0.1.md
3. component-slots.json（槽位合同）
4. shared/ppt-design-spec.md（版式：无死白、字号≥16px、一页≤3 语义色）
5. 组件图册 component-store-render-sheet.png —— 读图并描述你实际看到的布局；
   读不到就写「图片未读取」，禁止声称看过。
6. 二进制：yuhong-template.pptx + yuhong-county-course-components-branded.pptx
   （附件或 bridge；若均不可达 → 停止报告，禁止近似仿制）

三、组件判断与 DNA 继承（V0.6 修正：无源页 ≠ 无组件）
- 组件体系共 6 层：①可执行源页（雨虹 7 个 DC-01/02/03/04/17/20/08）②决策组件卡片（13 个 DC-01~08/16~20）③互动课件组件（8 个 I1~I8）④工作坊组件（21 卡+4 配方）⑤视觉组件卡片（7 类 A~G）⑥樱桃库逻辑参考（141 页）。逐页判定：
  · P1 认知提问页 → **I1 Ask-Then-Reveal**（先问后揭示的前半段）；教学问题与 **DC-01 同源**（"县域机会是消失了，还是机会结构发生了变化？"）→ 视觉 DNA 继承 DC-01 三判断链的骨架语言（三链/三段节奏），弱化呈现，禁止自由发挥。
  · P2 政策证据页 → I1 节奏 + 樱桃库"政策→场景"类逻辑页参考；转译结构（政策信号→业务场景）必须有明确方向关系。
  · P3 趋势对比页 → **语义继承 DC-01**：中间"位置变了/形态变了"是 FROM→TO 判断链，必须沿用 DC-01 的 before→after 箭头语言与红蓝绿语义色（结构是左中右而非三竖道，但变化表达 DNA 必须同源）。
  · P4 消费逻辑页 → I1 先问后揭示（讲师口头提问再展开）+ 樱桃库路径类逻辑页参考；信任形成必须是"链/路径"，不是三组并列列表。
- 【DNA 继承 gate】每一页的"视觉源"字段必须写清楚：匹配源页=复制；无源页=**继承哪个组件的什么 DNA（骨架/箭头/语义色）+ 模板母版**。说不清 DNA 的页不得 Build。
- 模板母版继承是硬性停止条件：右上角品牌标识、页脚、背景必须继承 yuhong-template。**模板原生特征（2026-08-18 经模板渲染图核实）**：右上角为红色拱形标识 +「长虹计划 CHANGHONG PLAN」文字，背景为浅灰弧形条带纹理——**这是模板自带、正确的品牌元素，出现即代表继承成功，不是违规**（V0.6 曾误判为第三方标识，已撤销）。
- 【色系铁律】唯一色源 = 模板 theme1 主题色 + `shared/ppt-design-spec.md` 令牌（红 #E84C22 / 深红 #B22600 / 墨 #505046 / 底 #EEECE1 / 琥珀 #FFBD47）。**禁止 Office 默认主题色**（默认绿 #70AD47、蓝 #5B9BD5 等）——P4 样张的浅绿卡片即反例：新建形状未继承模板主题所致；KeepSourceFormatting 必须完整带入模板 theme1 主题。
- 禁止：为用组件而重画源页 / 硬套不匹配源页 / 做出"红顶栏+灰卡片"式咨询页。

四、内容铁律（优先级从高到低）
1. 【最高优先】单页提示词原文：学员可见文案不增删、标题不改写。
2. 四页数量是硬约束：若原文在 ≥16px 时无法适配 → 允许重组为短标签＋路径节点
   （不改写文字），仍不适配 → 停止并报告；禁止自动拆成 5-6 页、禁止删文案。
3. P1 A/B/C 视觉等权：C"机会仍然存在…"只是待表态的学员假设，不得用颜色/勾选/
   位置/动画暗示其为正确答案；P1 不得出现"需求下沉/机会仍在"等总结性结论。
4. 句式指纹为已知例外：P2/P3/P4 均为否定-肯定句式是测试规格原文，本次保留、
   只记录不改写；若你认为必须差异化，先停下问用户。
5. 简阳/周至访谈事实、政策出处 → 只进讲师备注，标注「内部素材，对外需保密」；
   页面不得出现未提供的数据。
6. P4 无动画版：完整展示，由讲师控制讲解顺序。

五、版式要点
- 16:9、继承模板母版/品牌标记/页脚；一页一任务。
- 无死白（P4 历史问题：栏内 45% 空白，按页型分档补教学落点）。
- 溢出 = 按"四、2"处理，禁止缩字硬塞。
- 4 页结构互不相同（提问/转译/对比/路径），保持，不要统一成卡片网格。

六、你的第一步输出（等我确认，不要直接动手）
1. 你对 4 页逐页的理解（教学任务 + 计划版式，各一句）
2. 组件判断复述（确认无匹配可执行组件；如你在图册看到可复用布局，描述你实际看到的）
3. 每页版式方案
4. 两个 PPTX 是否可达（附件/bridge/?raw=true），以及你的执行方式
5. 缺什么（素材/数据/决策）
等我 Continue / 调整 / Build 再执行。
```

---

## 三、实验流程（含冒烟测试）

1. Agent A：本交接包 + 素材入库并推送 `main`（已完成）；
2. Agent B：读交接包 → 输出第一步（六、）→ 用户确认；
3. **单页冒烟测试（Build 前必做）**：①经 bridge/附件插入 `yuhong-template.pptx` 一页；②验证母版、页脚、品牌标记继承；③新建一个原生文本/形状对象；④写入一段讲师备注；⑤保存、关闭、重新打开；⑥确认对象可编辑、备注仍在。冒烟通过后才批量执行 4 页；
4. 批量构建 4 页（原生形状新建 + 讲师备注）→ 用户目视验收；
5. 验收：单页提示词"四页连续性检查"10 项 + `shared/ppt-design-spec.md` 层 3 清单（句式指纹项按已知例外豁免）+ 用户在 PowerPoint 目视；
6. 反馈回路：视觉/布局问题回到 Agent A 修资产或改蓝图，不由 Agent B 重画。

---

## 四、Agent B 评审结论与修订记录（2026-08-18 入库）

Agent B 对交接包 V0.1 的评审（可行度：内容/协作 85%，skill-bridge 环境 75%，当前环境直接执行 60%），五个问题及修订：

| # | 冲突 | 修订 |
|---|---|---|
| 1 | "禁止重画" vs "原生形状新建" | 新增**授权定制新建页例外**（交接包"一、角色与边界" + 边界协议 §4.2.5） |
| 2 | "固定四页" vs "溢出就拆页" | 明确**优先级**：四页硬约束 → 原文不删 → 短标签/路径节点重组 → 停止报告（禁止自动拆页） |
| 3 | P1"不泄露答案" vs 选项 C 接近答案 | A/B/C **视觉等权**，C 仅作学员假设，不得以任何手段暗示正确 |
| 4 | 原文保留 vs 句式指纹规范 | **逐页规格原文最高优先**；重复句式记为已知例外，不触发改写 |
| 5 | 二进制模板/备注能力未证明 | 新增**单页冒烟测试**步骤（流程第 3 步）；两个 PPTX 可达性列为前置条件与第一步输出必答项 |

同时明确：Agent B 在无模板附件/bridge 时**不得承诺"严格继承雨虹母版"**，也不得从零仿制品牌页——此为停止条件。

---

## 四.5 bridge 就绪状态与追加指令（2026-08-18）

**bridge 已启动并验证**（本地 `https://localhost:3000`，后台运行）：
- `tools/powerpoint-skill-bridge/scripts/server.mjs` 修复了一个崩溃 bug（畸形请求路径如 `//` 会令服务崩溃），修复已推送（commit `7d1cbe7`）；
- 端点实测：`taskpane.html` → 200 text/html；两个 PPTX → 200（正确 pptx MIME）；畸形/穿越路径 → 404。

**两个 PPTX 的 bridge 路径 + 指纹**（Agent B 经任务窗格原生插入用，不再需要附件）：

| 文件 | bridge URL | SHA-256 |
|---|---|---|
| yuhong-template.pptx | `https://localhost:3000/domains/yuhong/assets/reference-decks/yuhong-template.pptx` | `A9F396CF0EB4074CDF02F2C9E7F02E93E5985BCFDEEBD76DF16D0D65291F263C` |
| yuhong-county-course-components-branded.pptx | `https://localhost:3000/domains/yuhong/assets/components/yuhong-county-course-components-branded.pptx` | `EAC0CD92DDDFAC74DA8BECD63E827675F040EB50064A4CEBF25E0520A82F0A0D` |

**给 Agent B 的追加指令（完整文本见下，可整段粘贴）**：
- 执行通道 = 「PPT Skill Bridge」任务窗格（bridge 就是二进制原生插入的执行层）；ChatGPT 会话描述需求，任务窗格执行插入；
- 若 `localhost:3000` 在会话内不可达，改用附件方式（桌面 `两Agent实验_上传附件\`），并先校验 SHA；
- 其余全部约束（组件判断/内容铁律/冒烟测试顺序）以本交接包 V0.2 为准。

> **架构事实（2026-08-18 实测结论，重要）**：bridge 任务窗格是**人工驱动**的执行层——模型（Agent B，云端）无法访问本机 `localhost:3000`，也无法驱动任务窗格（bridge 没有 MCP/action 接口）。**Agent B 唯一能自主控制的执行通道是"附件 + Office 文档工具"**。因此：
> - 两 Agent 流水线的 Agent B 执行正路 = **附件上传 + 核 SHA + 文档工具操作**；
> - bridge 仅适合"人 + AI 辅助"模式（人在窗格点按钮），或仓库侧验收/预览通道；不为 bridge 改变主线。
> - 若未来要让 bridge 模型可驱动，需给 server.mjs 增加 MCP 或"粘贴 JSON 指令批量执行"接口（待办，非本次实验范围）。

> **组件选择职责边界（2026-08-18 澄清）**：选组件是 **Agent A 的职责**——A 在蓝图/交接包中完成组件判断（含槽位合同映射），Agent B 只复述确认、不自行发现组件。B 的组件知识全部来自 **A 显式提供的文本契约**：`catalog.json`（sourceSlide/sourceSlideId：组件→源 deck 第几页）、`component-slots.json`（replaceable_objects：命名槽位）、`decision-component-store.md`（语义/不变式）、`previews/component-0N.png`（布局）。**附件 PPTX 对 B 只是执行素材，不是判断依据。**
> **未验证执行缺口**："复制源页 + 按命名槽位替换"要求 B 的文档工具支持①从附件 PPTX 插入指定页、②按形状名称定位并改文本——**两者均未验证**。当前 4 页实验全是新建页、不涉及槽位替换，故不阻塞；未来组件页课件须先在冒烟测试中验证第②项，若 B 做不到，组件页执行正路降级为"A 用 COM 链预构建组件页成品，B 只组装"。

---

## 五、变更记录

| 版本 | 日期 | 说明 |
|---|---|---|
| V0.7 | 2026-08-18 | **撤销 V0.6 误判**：经模板渲染图核实，「长虹计划」红色拱形标识与灰色弧形条带是 yuhong-template 原生品牌特征（继承成功=正确），非第三方/自造标识。新增色系铁律：唯一色源=模板 theme1 主题色+令牌，禁止 Office 默认主题色（P4 浅绿卡片 #70AD47 系为反例）。 |
| V0.6 | 2026-08-18 | 修正组件判断（初判"长虹计划"为无根页面，后经 V0.7 撤销该结论）：组件体系 6 层共约 190 项，无源页≠无组件；逐页补 DNA 继承映射（P1→I1+DC-01 骨架、P3→DC-01 FROM→TO/语义色、P2/P4→I1+樱桃库参考）；新增 DNA 继承 gate 与"模板母版继承=硬性停止条件"。 |
| V0.5 | 2026-08-18 | 澄清组件选择职责边界（选组件=Agent A，B 靠文本契约执行，附件只是素材）；记录未验证执行缺口（插入指定页/按名称改槽位文本），冒烟测试需补该项验证。 |
| V0.4 | 2026-08-18 | 记录架构事实：bridge 为人工驱动执行层，Agent B（云端模型）无法访问 localhost/驱动窗格，执行正路为附件+文档工具；修正此前"经任务窗格执行"的误导表述。 |
| V0.3 | 2026-08-18 | bridge 就绪：本地 HTTPS 服务已启动并验证（server.mjs 崩溃 bug 修复已推送）；两个 PPTX 提供 bridge URL + 指纹；新增"给 Agent B 的完整指令"文本。 |
| V0.2 | 2026-08-18 | 吸收 Agent B 评审五项修订：授权定制新建页例外、四页硬约束与溢出优先级、P1 A/B/C 视觉等权、句式指纹已知例外、单页冒烟测试与 PPTX 可达性前置条件；新增"Agent B 评审结论与修订记录"节。 |
| V0.1 | 2026-08-18 | 初版。三份课件素材入库并加源路径头注；交接包含源路径表 + 组件判断（4 页无匹配可执行组件）+ 内容铁律 + 版式要点。 |
