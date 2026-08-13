---
name: yuhong-ppt
description: Create or adapt Oriental Yuhong dealer courseware, workshops, case-teaching decks, existing PPTs, and business reviews. Use for 东方雨虹/雨虹县域经销商培训、渠道精耕、产品战役、零售专卖、家装渠道、案例教学、经销商工作坊、课件改编或经营复盘. Select page components from the teaching or management question, required input, learner output, and evidence before choosing a visual layout.
---

# Yuhong PPT

## Core Job

Create instructor-led 东方雨虹 dealer courseware first, while supporting existing-deck adaptation, case teaching, dealer workshops, and business reviews. Prioritize component selection by teaching or management question over decoration.

Default audience: 县域经销商老板 / 业务负责人. Write in concise Chinese with field language and clear decisions.

## Workflow

Default to Guided Mode for ambiguous or high-stakes deck requests. Read `references/guided-mode.md` before asking questions, analyzing data, proposing an outline, selecting components, or building slides.

1. Read `references/mode-selection.md` and select exactly one primary mode. Default to `Create Courseware` when the task is a new training deck.
2. Inspect available source data before drafting conclusions.
3. Read `references/data-requirements.md` when input fields, missing data, or calculation scope matter.
4. Read `references/metric-definitions.md` when defining or interpreting Yuhong dealer metrics.
5. Read `references/yuhong-business-logic.md` before writing business diagnosis or action recommendations.
6. Read `references/decision-component-store.md` before proposing a page-level outline. Every substantive page must map to one selected Decision Component or explicitly use `simple-evidence-page`.
7. Read `references/business-analysis-cards.md` before selecting business-analysis modules for channel, product/SKU, retail/member, home-decoration, visit, or action-plan pages.
8. Read `references/county-opportunity-course.md` when creating or adapting the county-market opportunity diagnosis course, especially modules on 看趋势, 判状态, 县域生意版图, 四力, 四阶段, 乡镇病症判断, or 盘区域衔接.
9. Read `references/course-story-structure.md` when creating or adapting instructor-led courseware, training decks, bootcamps, co-creation workshops, or decks with 讲师话术/作业/共创 pages.
10. Read `references/workshop-component-cards.md` when selecting reusable course or workshop components.
11. Read `references/interactive-course-components.md` when the courseware needs classroom interaction, clickable navigation, progressive reveal, scenario branching, voting, worksheets, or companion tools.
12. Read `references/case-story-patterns.md` when creating dealer case sharing or transformation narratives.
13. Read `references/component-cards.md` only after the Decision Component is selected and a visual expression is needed.
14. Read `references/template-selection.md` before choosing the visual base or method decks.
15. Build a page-level blueprint first. Read `references/quality-check.md` and revise it before generating a PPT.
16. Do not generate the final PPT until the user confirms or asks to Build.

## Page-Level Component Gate

For every substantive page, output:

- Page conclusion
- Teaching or management question
- Selected Decision Component and why it fits
- Required input and currently missing input
- Instructor action and learner action, when applicable
- Expected learner or management output
- Visual source or layout direction
- Usage risk and fallback

Do not output a component-name list without this mapping. Do not select a cherry-red or source-deck page before the teaching question and expected output are known.

## Default Narrative For Monthly Review

Use this sequence unless the user supplies a stronger structure:

1. 封面: dealer, month, review theme.
2. 核心结论: one sentence on the month.
3. 核心 KPI 回顾: sales, collection, active customers, new customers, key category/product contribution.
4. 目标达成: target vs actual, gap, and exceed/underperform areas.
5. 增长来源: customer, order, SKU/product, channel, and key-account contribution.
6. 结构诊断: customer tier, product/category mix, channel mix, high-value customers.
7. 专项深挖: choose product, channel, retail store, home decoration, or visit execution based on data.
8. 问题与风险: only the few risks that change next month management actions.
9. 下月行动计划: 3-5 actions with owner, target, and inspection metric.

## Writing Rules

- Lead each slide with a business claim, not a topic label.
- Use dealer language: 销售、回款、活跃客户、新开客户、重点客户、品项、爆品、渠道、动销、复购、目标达成.
- Write for owners: state management implication and next action.
- For courseware, every module should make clear what learners discuss, fill in, decide, or commit to.
- For interactive courseware, define what the instructor clicks, what learners do, what output is produced, and what fallback exists if animation or links fail.
- Avoid generic praise. If data is good, explain the growth quality.
- Do not invent missing metrics. Mark missing fields and propose a lower-confidence version.
- Keep visible slide text short. Put calculation definitions or caveats in notes or appendix when building a PPT.

## Assets

- `assets/reference-decks/yuhong-template.pptx`: default visual base.
- `assets/reference-decks/channel-intensive-cultivation.pptx`: 渠道精耕 method reference.
- `assets/reference-decks/product-battle.pptx`: 产品/爆品 method reference.
- `assets/reference-decks/retail-store-battle.pptx`: 零售专卖/工人会员 method reference.
- `assets/reference-decks/home-decoration-channel.pptx`: 家装渠道 method reference.
- `assets/reference-decks/trader-to-service-provider-course.pptx`: 216-page 转型服务商 courseware reference with instructor talk-track, co-creation pages, worksheets, four order-source tactics, team building, and risk-control modules.
- `assets/reference-decks/rongyu-case.pptx` and `jiabeili-case.pptx`: dealer case style references.
- `assets/reference-decks/cherry-red-logic-components.pptx`: optional logic component library.
- `assets/reference-data/yuhong-dealer-dynamic-diagnosis-20260724.xlsx`: metric definition and scoring reference.

Treat any unrelated dealer decks as optional examples only when the user explicitly asks.
