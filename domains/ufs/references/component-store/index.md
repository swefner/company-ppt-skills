# UFS Decision Component Store

This store contains the first-tier decision components for UFS monthly business review PPTs.

Use it as the component-selection entrypoint before designing pages. The selection order is:

1. Identify the page's business question.
2. Match the question to one component card.
3. Check whether required data exists.
4. Decide whether the component should be used as the main page structure, a local visual module, or downgraded to a table.
5. Keep the UFS monthly-review frame; use cherry-red only for inner logic expression.

## First-Tier Components

| ID | Component | Source | Best Answers | Monthly Review Pages |
|---|---|---|---|---|
| `core-kpi-dashboard` | Core KPI Dashboard | Cherry-red Slide 102 | 本月核心结果是否达标？老板先看什么？ | 核心结论、核心指标、老板看板 |
| `growth-driver-breakdown` | Growth Driver Breakdown | Cherry-red Slide 46 | 增长或下滑来自哪里？ | 销售增长来源、家乐增长来源 |
| `customer-tier-migration` | Customer Tier Migration | Cherry-red Slide 87 | 客户结构有没有变好？哪些要保、做深、追回？ | 客户结构、大户保护、浅采做深、断采追回 |
| `stage-path-sku-deepening` | Stage Path / SKU Deepening | Cherry-red Slide 59 | 专项从拉升到稳定，下一步怎么推进？ | 家乐专项、SKU 做深 |
| `visit-lead-effect-curve` | Visit / Lead Effect Curve | Cherry-red Slide 111 | 拜访和商机有没有产生推进效果？ | 拜访覆盖、商机转化、断采追回 |
| `next-month-action-board` | Next-Month Action Board | Cherry-red Slide 113 | 下月老板抓哪几件事，怎么追责？ | 8 月行动计划、责任机制 |

## Selection Heuristics

- Use `core-kpi-dashboard` for result judgment, not detailed diagnosis.
- Use `growth-driver-breakdown` for cause judgment only when driver values exist.
- Use `customer-tier-migration` before customer-name tables to explain the segmentation logic.
- Use `stage-path-sku-deepening` when the page needs a route from trial to repeat to deepening to stable purchase.
- Use `visit-lead-effect-curve` when visit, lead, or recovery stages can be connected to business outcomes.
- Use `next-month-action-board` when analysis must become inspectable owner actions.

## Data Gate

If the required data is missing:

- Keep the card's business question.
- Downgrade the visual component to a simpler UFS table or action list.
- Mark the missing field instead of inventing metrics.
- Do not use cherry-red logic diagrams as decoration.

## Store Files

- [Core KPI Dashboard](cards/core-kpi-dashboard.md)
- [Growth Driver Breakdown](cards/growth-driver-breakdown.md)
- [Customer Tier Migration](cards/customer-tier-migration.md)
- [Stage Path / SKU Deepening](cards/stage-path-sku-deepening.md)
- [Visit / Lead Effect Curve](cards/visit-lead-effect-curve.md)
- [Next-Month Action Board](cards/next-month-action-board.md)
