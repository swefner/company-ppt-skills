---
name: customer-review-ppt
description: Create dealer customer-analysis review decks from customer analysis outputs (客户分析技能包). Use for 客户经营分析汇报、客户分层汇报、沉睡激活、新客转化、流失预警、维护计划. Brand-neutral light theme with themeColor semantic palette; components recolor when the theme changes.
---

# Customer Review PPT

## Core Job

Turn customer-analysis results (from the 客户分析技能包 document product: A/B/C/D tiering, profiles, tags, sleeping activation, new-customer conversion, churn warning, maintenance plans) into owner-facing review decks.

Audience: 经销商老板. Write in 老板模式 (conclusion first, exact numbers, 建议标注"供参考").

## Theme And Color Semantics

The domain uses a brand-neutral theme whose semantic colors live in PowerPoint theme accent slots — components reference themeColor, so changing the theme recolors everything:

- accent1 商务蓝: primary / normal emphasis
- accent2 红: warning / negative (churn, deep sleep)
- accent3 绿: positive / growth (conversion, recovery)
- accent4 琥珀: attention / neutral-watch
- accent5 灰: neutral auxiliary
- accent6 浅蓝: secondary emphasis

Master: `assets/reference-decks/customer-review-template.pptx` (build with `assets/reference-decks/build-customer-master.py`).
Components: `assets/components/customer-review-components.pptx` (build with `assets/components/build-components.py`).

## Workflow

1. Guided Mode first: confirm data period, customer entity merge status, and which analysis modules the output covers.
2. Read `references/decision-component-store.md` before selecting components.
3. Numbers must match the analysis output / acceptance reference values; mark missing fields, never invent.
4. Page blueprint first; confirm with user before Build.
5. Build with the demo script pattern (`outputs/build-demo.py`) or duplicate component source slides.

## Truthful Build Claims

- Do not claim a number is from data unless it matches the provided analysis output or reference values.
- Do not claim theme-color support unless components were built with themeColor references.
- Do not copy cherry-red or any customer-branded page directly; rebuild on this master.
