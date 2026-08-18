# 两 Agent 交接包：雨虹「看趋势」4 页教学课件路径实验

> 用途：Agent A（仓库侧 / 本环境）→ Agent B（PowerPoint 内 GPT + skill-bridge）的完整交接包。
> 实验目标：验证"仓库侧定大纲/内容 + PowerPoint GPT 视觉执行"这条主线的可行性与交接质量（上一轮失败点：编造布局、改写语义、溢出硬塞、句式同质）。
> 主线路定义见 `docs/agent-boundary.md` 第 0 节。

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
| 品牌模板 | — | `domains/yuhong/assets/reference-decks/yuhong-template.pptx` | bridge 原生插入（binary，不走 raw） |
| 可执行组件源 deck | — | `domains/yuhong/assets/components/yuhong-county-course-components-branded.pptx` | bridge 原生插入（binary，不走 raw） |

**GitHub raw URL 形式**（仓库约定，`raw.githubusercontent.com` 会超时）：
`https://github.com/swefner/company-ppt-skills/blob/main/<仓库路径>?raw=true`
（中文文件名若粘贴失败，可对路径做 URL 编码；或改用本地 skill-bridge 任务窗格地址 `https://localhost:3000/<仓库路径>` 读取。）

---

## 二、交接包全文（发给 Agent B 的内容）

```
【交接包】Agent A（仓库侧）→ Agent B（PowerPoint 视觉执行）
任务：东方雨虹「看趋势」4 页教学课件 · 两 Agent 路径实验 · M1-U1-01~04

一、你的角色与边界
- 你是视觉执行 Agent：在用户当前打开的 PPT 里，经 skill-bridge 原生插入/新建可编辑页面。
- 大纲、内容判断、组件核对由我（Agent A）完成并已入库；你负责视觉执行，不重新发明内容。
- 产出：4 页可编辑成品 + 讲师备注；最终以用户在 PowerPoint 目视为准。

二、必读源（用 ?raw=true 形式读，raw.githubusercontent 会超时）
1. 全局排版提示词（一页一任务/学员页-备注分离/品牌规范/15 项终检）
   domains/yuhong/inputs/雨虹县域课程_PPT全局排版提示词_V0.1.md
2. 单页提示词测试版（本任务的逐页规格，学员可见文案以此为准）
   domains/yuhong/inputs/雨虹县域课程_看趋势四页PPT单页提示词_测试版_V0.1.md
3. component-slots.json（槽位合同）
4. shared/ppt-design-spec.md（版式：无死白、字号≥16px、一页≤3 语义色、句式指纹）
5. 组件图册 component-store-render-sheet.png —— 读图并描述你实际看到的布局；
   读不到就写「图片未读取」，禁止声称看过。

三、组件判断（我已核对，你不要重新发明）
- 这 4 页【没有匹配的可执行组件】：
  P1 互动提问页、P2 政策转译、P3 左中右需求迁移（DC-01 是"三条判断竖道"结构，与本页不符）、P4 信任路径。
- 做法：继承 yuhong-template 母版 + 原生形状新建，按每页「建议组件方向」排版。
- 禁止：为用组件而重画源页 / 硬套不匹配组件 / 做出"红顶栏+灰卡片"式咨询页。

四、内容铁律
- 学员可见文案严格按单页提示词，不增删；标题不改写。
- 注意：P1 与 P3 都以"县城新房少了"开头、P2/P3/P4 都是否定-肯定句式——这是测试规格原文，
  保持原样；若你认为必须差异化，先停下问用户，不要擅自改。
- 简阳/周至访谈事实、政策出处 → 只进讲师备注，标注「内部素材，对外需保密」；
  页面不得出现未提供的数据。
- P1 是提问页：不得提前泄露"需求下沉/机会仍在"等结论。
- P4 无动画版：完整展示，由讲师控制讲解顺序。

五、版式要点
- 16:9、继承模板母版/品牌标记/页脚；一页一任务。
- 无死白（P4 历史问题：栏内 45% 空白，按页型分档补教学落点）。
- 溢出 = 拆页或进备注，禁止缩字硬塞。
- 4 页结构互不相同（提问/转译/对比/路径），保持，不要统一成卡片网格。

六、你的第一步输出（等我确认，不要直接动手）
1. 你对 4 页逐页的理解（教学任务 + 计划版式，各一句）
2. 组件判断复述（确认无匹配可执行组件；如你在图册看到可复用布局，描述你实际看到的）
3. 每页版式方案
4. 缺什么（素材/数据/决策）
等我 Continue / 调整 / Build 再执行。
```

---

## 三、实验流程

1. Agent A：本交接包 + 三份素材入库（`domains/yuhong/inputs/`）并推送 `main`；
2. Agent B：读交接包 → 逐页理解与版式方案 → 用户确认 → 视觉执行（原生插入/新建 4 页 + 讲师备注）；
3. 验收：单页提示词"四页连续性检查"10 项 + `shared/ppt-design-spec.md` 层 3 清单 + 用户在 PowerPoint 目视；
4. 反馈回路：视觉/布局问题回到 Agent A 修资产或改蓝图，不由 Agent B 重画。

## 四、变更记录

| 版本 | 日期 | 说明 |
|---|---|---|
| V0.1 | 2026-08-18 | 初版。三份课件素材入库并加源路径头注；交接包含源路径表 + 组件判断（4 页无匹配可执行组件）+ 内容铁律 + 版式要点。 |
