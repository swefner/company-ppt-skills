---
name: ufs-monthly-review-ppt
description: Generate UFS business-partner dealer monthly review, terminal-store advancement, and strategy co-creation PowerPoint decks and outlines. Use for UFS/生意合伙人项目/月会经营复盘/经销商老板汇报/终端单店进阶/战略共创会, using sales, target, customer, Jiale, SKU, lead, visit, task, business-model, and next-action data.
---

# UFS Monthly Review PPT

## Core Job

Create UFS 生意合伙人项目 monthly business review decks for dealer owners. The deck should help the owner understand:

- 本月经营结果怎么样
- 目标完成到什么程度
- 增长或下滑来自哪里
- 客户结构是否变好
- 家乐/SKU 是否做深
- 拜访与商机是否承接
- 下月管理动作抓什么

For strategic co-creation decks, also help the owner align on:

- 单店/单兵作战模型是否跑通
- 人、客、品、配四类能力短板
- 拜访效率、客户效率、产品效率、配送效率
- 目标共识与落地推进计划

## Default Mode

Use Guided Mode unless the user explicitly asks to build immediately:

1. Inspect source data and reference materials.
2. Produce a text outline or Component Cards first.
3. Ask for Continue / Go deeper / Replace / Build.
4. Build PPT only after confirmation.

## Required References

- Read `references/data-requirements.md` when checking whether user data is sufficient.
- Read `references/system-field-map.md` when mapping exported data or app/API fields to PPT pages.
- Read `references/business-logic.md` before writing diagnosis, conclusion, or next-month actions.
- Read `references/story-structure.md` before proposing a monthly review outline.
- Read `references/component-store/index.md` before selecting first-tier decision components.
- Read `references/component-cards.md` when using the cherry-red logic component library.
- Read `references/ufs-component-library.md` when selecting reusable pages from the UFS reference decks or building a component-card index.

## Asset Use

- Use `assets/reference-decks/nanchong-april-review.pptx` and `nanchong-june-review.pptx` as UFS monthly review examples.
- Use `assets/templates/nanchong-456-monthly-review-master-template.pptx` as the consolidated Nanchong April-May-June monthly review template. Read `assets/templates/nanchong-456-template-index.md` for source-month slide ranges.
- Use `assets/reference-decks/xian-yaosheng-co-creation.pptx` as the strategic co-creation / terminal-store advancement reference.
- Use `assets/reference-decks/cherry-red-logic-components.pptx` only as an optional component library.
- Do not treat online partner sites as primary data sources. Use them only as system口径 references unless the user provides login/exported data.

## 视觉优先级

生成或推荐 UFS PPT 页面时，按以下优先级选择视觉来源：

1. `nanchong-april-review.pptx` 和 `nanchong-june-review.pptx` 是月会经营复盘的主母版。
2. `xian-yaosheng-co-creation.pptx` 是战略共创、终端单店进阶、会议目录、人客品配模型、拜访模型、地图和落地计划的辅助母版。
3. `cherry-red-logic-components.pptx` 只作为局部逻辑组件增强，用于增长来源、家乐专项、SKU 做深、客户迁移、拜访效果和下月行动板等复杂逻辑页。
4. 自建可编辑形状是最后 fallback，不能作为默认风格来源。

不要让樱桃红逻辑库覆盖 UFS 月会母版。整套材料应像 UFS 项目推进复盘 / 月度经营会，而不是通用咨询公司汇报稿。

## 反咨询风约束

- 避免 McKinsey/BCG 式通用结构：KPI 卡片墙、过度干净的三栏卡片、抽象大标题、深色高管摘要面板、过度稀疏的页面。
- 优先继承真实 UFS 模板语法：白底、UFS 橙红强调、浅橙表格底纹、细橙分隔线、密集但可读的经营表格、重点数据色块、红框标注，以及从源页继承的 UFS/联合利华饮食策划页脚标识。
- 月会页允许有经营证据密度，不要把它简化成装饰性 dashboard。
- 标题保持项目复盘语气，例如“核心指标回顾”“客户结构分析”“销售增量来源分析”“家乐 SKU 做深”“Q3 动作”，不要写成口号式咨询标题。
- 源页支持时，在标题下方使用一行橙色判断句；判断句要具体，不要写抽象金句。
- 动作页优先使用“动作 / 证据 / 负责人 / 下次检查”表格，不要强行套复杂逻辑图。

## Writing Rules

- Write for 经销商老板, not for internal implementation.
- Lead each slide with a conclusion sentence.
- Prefer business language over field names.
- Do not invent missing metrics. Mark missing fields and downgrade the page.
- Preserve UFS vocabulary: 生意合伙人项目, 终端单店进阶, 单兵作战模型, 核心指标, 目标达成, 客户池, 活跃客户, 新开客户, 家乐, SKU做深, 拜访, 商机, 人客品配, 四大效率, 下月动作.
- Make actions inspectable: action, target customer/SKU/channel, owner, target, check metric.

## Build Boundary

For PPT generation, use the presentation workflow and verify rendered slides. If the user only asks for Skill or outline work, do not create a final PPT.
