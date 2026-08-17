# Customer Review Decision Component Store

Components are decision units, not decoration. All semantic colors use themeColor references (see SKILL.md).

## Selection Chain

`Page role -> question -> learner/owner output -> available data -> Decision Component -> visual expression`

## Cards

### CR-01 KPI Overview（KPI 总览）

- Question: 本期间核心经营指标是什么？
- Required input: 总销售额、总毛利、客户数、毛利率、头部集中度等 4 个指标及口径.
- Page position: 开场后总览页.
- Output: 4 个 KPI 块（标签/数值/口径说明）.
- Source slide: 1. Preview: `assets/components/previews/component-01.png`.
- Visual: 2×2 浅色圆角块；数值大号主题色，口径小字辅助色.
- Risk: 指标口径不一致产生伪结论；数字必须与参考值一致.
- Fallback: 无数据时数值标"数据缺失".

### CR-02 Tier Table（分层结果表）

- Question: 客户 A/B/C/D 分层结果如何呈现？
- Required input: 各层级客户数、销售额、占比、经营含义.
- Page position: KPI 之后.
- Output: 层级表 + 合计 + 一句核心结论（头部集中度）.
- Source slide: 2. Preview: `assets/components/previews/component-02.png`.
- Visual: 表头行 + 4 层级行 + 合计行 + 结论句；A 级层级名用主题强调色.
- Risk: 分层口径（按客户数 vs 按销售额）必须注明.
- Fallback: 未分层时标注"未分层"，用累计销售额前 50% 近似（需注明）.

### CR-03 List Table（名单表，沉睡/预警/新客/维护共用）

- Question: 名单类结果（沉睡档位/预警名单/新客名单/维护计划）如何呈现？
- Required input: 客户名、关键指标、状态、建议动作（模板化，标注"供参考"）.
- Page position: 各类名单页.
- Output: 表头 + 5 行 + 口径注脚.
- Source slide: 3. Preview: `assets/components/previews/component-03.png`.
- Visual: 交替浅色行；状态列可用警示色/正向色.
- Risk: 名单数字必须与客户清单核对一致；状态推导不能当成结论.
- Fallback: 数据跨度不足时整体标注，不硬算.

### CR-04 Customer Card（客户经营卡片）

- Question: 单个客户经营状况如何过会？
- Required input: 层级、累计销售额、累计毛利、品类结构、近期趋势、关注事项、建议.
- Page position: Top 客户逐一过会.
- Output: 字段卡 + 下一步建议（标注"供参考"）.
- Source slide: 4. Preview: `assets/components/previews/component-04.png`.
- Visual: 六字段（左标签右值）+ 建议区.
- Risk: 建议必须基于数据（如品类占比最低者），不编造.
- Fallback: 匿名示例时明确标注"示例".

## Page Blueprint Output

Before Build, present each page with: Page | Conclusion | Question | Component | Required input | Output | Visual source | Risk.
Use simple pages for cover, closing, and plain text pages; state why no component is needed.

### CR-05 Tier Share Pie（分层占比饼图）

- Question: 钱从哪里来？各层级销售额占比如何呈现？
- Required input: 各层级占比（和/接近 100%）、层级名.
- Source slide: 5. Preview: `assets/components/previews/component-05.png`.
- Visual: 饼图，系列色 themeColor（A=accent1 蓝、B=accent6 浅蓝、C=accent4 琥珀、D=accent5 灰）.
- Risk: 占比与分层表数字必须一致；层级顺序 A→B→C→D 固定.
- Fallback: 未分层时标注"未分层"，不硬画.

### CR-06 Monthly Trend Bar（月度趋势柱状图）

- Question: 趋势往哪走？月度销售额与毛利如何呈现？
- Required input: 月度销售额、毛利（同一量纲）.
- Source slide: 6. Preview: `assets/components/previews/component-06.png`.
- Visual: 簇状柱状图，系列色 themeColor（销售额=accent1 蓝、毛利=accent4 琥珀）.
- Risk: 单位必须一致（万元）；结论必须结合季节性判断.
- Fallback: 数据不足 3 个月时整体标注，不硬画趋势.

