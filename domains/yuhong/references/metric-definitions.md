# Metric Definitions

Use these definitions when analyzing Oriental Yuhong dealer health, monthly reviews, or key-battle decks. They are grounded in `assets/reference-data/yuhong-dealer-dynamic-diagnosis-20260724.xlsx`.

## Source Priority

When metric definitions conflict, use this priority:

1. User-supplied current project definition.
2. `yuhong-dealer-dynamic-diagnosis-20260724.xlsx`.
3. This reference file.
4. Conservative assumption, explicitly labeled.

Do not silently mix annual health-diagnosis definitions with monthly review definitions. If converting annual metrics to monthly review, state the conversion.

## Dealer Health Layers

Use three layers:

- Growth layer: contract achievement, sales growth, distribution, retail, channel balance, category balance.
- Support layer: meetings, warehouse efficiency, digital capability.
- Willingness layer: activity participation, business willingness, cultural awareness.

For owner-facing monthly review, prioritize Growth layer first, then Support layer actions, then Willingness only when it affects execution.

## General Performance

Contract achievement rate:
- Formula: actual annual sales / annual contract target.
- Monthly review adaptation: actual monthly sales / monthly sales target.
- Use for: fulfillment and target discipline.

Sales growth rate:
- Formula: (current-period actual sales - prior-period actual sales) / prior-period actual sales.
- Use for: whether the business is expanding.
- Risk: growth alone does not prove quality. Pair with customer, channel, and category structure.

## Distribution And Channel Intensive Cultivation

Outlet count / 网点数量:
- Definition: downstream stores or distributors with at least one transaction in the past 12 months.
- Monthly adaptation: customers/outlets with at least one transaction in the current month, plus a 12-month base if available.
- Use for: market network foundation.

Core-store ratio / 核心店占比:
- Formula: core stores / outlet count.
- Core stores include core image stores and core distribution stores unless the user provides a project-specific definition.
- Use for: whether the channel has a stable high-value core.

Single-store output / 单店产出:
- Formula: annual Yuhong distribution-channel sales / outlet count.
- Monthly adaptation: monthly distribution-channel sales / active or transaction outlets, with the denominator stated.
- Use for: outlet quality and productivity.

Effective-store ratio / 有效门店占比:
- Formula: effective stores / outlet count.
- Diagnosis definition: an effective store has visit records within three months and qualified display reporting.
- Monthly adaptation: a store with current-month purchase plus valid visit/display evidence, if both fields exist.
- Use for: whether coverage has management quality, not just a name list.

Outlet coverage rate / 网点覆盖率:
- Formula: actually covered outlets / target outlets in the region.
- Use for: market reach and blank-market opportunity.

Outlet activity rate / 网点活跃度:
- Formula: outlets with purchase records in the past three months / total outlets.
- Monthly adaptation: outlets with purchase in current month / total tracked outlets, or trailing-three-month active outlets / total tracked outlets.
- Use for: distribution activation.

Township coverage rate / 乡镇覆盖率:
- Formula: covered townships or streets / authorized region townships or streets.
- Use for: county and township market penetration.

Service density / 人均服务网点数:
- Formula: outlet count / (own sales staff count * Yuhong sales ratio + Hong salesperson count).
- Use for: staff service load and route pressure.

Own sales staff count / 自有人员数量:
- Definition: full-time employees paid by the dealer whose main duty is sales.
- Exclude warehouse and logistics roles. Do not count Hong salespeople in this field.
- Multi-brand dealers: adjust by Yuhong sales ratio for later calculations.

Human efficiency / 人效:
- Formula in diagnosis: annual Yuhong total sales / (own sales staff count * Yuhong sales ratio + Hong salesperson count).
- Alternate company-level formula: annual total sales / (own sales staff count + Hong salesperson count).
- Use for: staff productivity. Always state which numerator is used.

## Product Line, Category, Core Product, And Explosive Product

Category count / 品类数量:
- Definition: number of Yuhong categories stably operated by the dealer.
- Diagnosis categories include waterproofing, mortar, beauty seam, adhesive, membrane, accessories. Some materials also mention wall accessories, pipe materials, and related lines.
- Use for: category balance and one-stop service capability.

Category balance / 品类均衡发展:
- Interpretation: whether the dealer avoids overreliance on a single category and has enough category breadth to lift customer value.
- Monthly review evidence: sales by category, active SKU count by category, category growth, category gross margin if available.

Core product / 核心品项:
- Definition: the products or SKUs that the dealer should continuously stock, push, and inspect because they support volume, profit, strategic category growth, or channel control.
- Evidence: stable sales, high penetration among target customers, repeat purchase, or strategic fit with the key battle.

Explosive product / 爆品:
- Definition: a product selected for focused breakthrough in a period, with clear target customers, selling scenario, promotion method, and inspection rhythm.
- Do not label a SKU as explosive only because one large customer bought it once.
- Evidence: customer penetration, repeat purchase, SKU depth, category pull-through, and replicable sales action.

Product depth:
- Useful views: SKU count per customer, single-SKU vs multi-SKU customers, key-product penetration, repeat purchase, and customer migration into broader product mix.

## Retail Store And Worker Member

Member count / 会员数量:
- Definition: workers/masters formally registered in the member system.
- Use for: retail-channel customer resource base.

Member output per person / 会员人均产出:
- Formula: annual Yuhong retail-channel sales / member count.
- Monthly adaptation: monthly retail-channel sales / active or registered members; state denominator.
- Use for: member value and conversion quality.

Member activity rate / 会员活跃率:
- Formula: members with consumption records in the past three months / total members.
- Use for: whether the member pool is alive.

Professional meeting count / 专业人士会议次数:
- Definition: meetings for workers, designers, or other professionals in the past 12 months, such as tile-worker meetings, painter meetings, designer salons.
- Use for: member relationship maintenance and activation.

Worker-member diagnosis chain:
- member acquisition -> member tiering -> activation -> purchase -> repeat purchase -> referral.

## Home Decoration Channel

Home-decoration sales ratio / 家装销售占比:
- Formula: annual home-decoration channel sales / annual all-channel sales.
- Use for: whether home-decoration has become a real channel, not only a side activity.

Monthly home-decoration orders / 月均家装订单数:
- Formula: annual home-decoration channel order count / 12.
- Use for: order frequency and channel stability.

Home-decoration company output per month / 家装公司产出/月:
- Formula: annual home-decoration channel sales / cooperating home-decoration company count / 12.
- Use for: partner quality and maintenance result.

Home-decoration partner definitions:
- Cooperating company: signed or maintained relationship.
- Active company: produced orders in the period.
- High-value company: high order count, high sales contribution, or strong repeated cooperation.

Home-decoration diagnosis chain:
- company development -> partner maintenance -> order reporting -> average order amount -> repeat cooperation.

## Service / Double-Package Business

Work-order conversion rate / 工单转化率:
- Formula: converted work orders / total work orders.
- Use for: service lead conversion.

Monthly work-order count / 月均工单数量:
- Formula: annual service-business work orders / 12.
- Use for: service business scale and operating load.

Service diagnosis chain:
- lead/work order -> site inspection -> quote -> signing -> construction -> acceptance -> payment -> warranty.

## Channel And Category Balance

Channel count / 渠道数量:
- Definition: number of channels the dealer currently operates as a focus.
- Examples: distribution, retail, home decoration, engineering/project, service/C-end.
- Use for: risk resistance and business structure.

Category count and channel count should not be praised blindly. A high count is useful only when output and management capability follow.

## Support Metrics

Distribution meeting count / 分销会次数:
- Definition: dealer-led meetings for downstream distributors in the past 12 months.
- Use for: distribution network activation and maintenance.

Warehouse floor efficiency / 坪效:
- Formula: annual Yuhong total sales / warehouse area dedicated to Yuhong products.
- Use for: warehouse operating efficiency and product structure pressure.

Digital level / 数字化水平:
- a: only has basic inventory/sales digital system.
- b: can conduct data analysis.
- c: has digital metric insight capability.
- d: has not adopted a digital system.
- Use for: whether the dealer can manage by data.

## Willingness Metrics

Activity participation:
- a: actively participates in YH meetings, training, and activities with strong performance.
- b: participates with few absences or early departures.
- c: basically does not participate.

Business willingness:
- a: has strong confidence in YH, communicates with brand side at least weekly, and is willing to invest resources.
- b: has confidence and generally cooperates with market activities.
- c: plans to stop operating YH or does not cooperate with management and activities.

Cultural awareness:
- a: clearly understands, recognizes, and practices Oriental Yuhong culture.
- b: understands and recognizes it.
- c: does not understand or recognize it.

Use willingness metrics carefully in monthly reviews. They are useful for cooperation risk and execution readiness, not for replacing sales diagnosis.

## Monthly Review Safeguards

- State denominator for every rate.
- Separate "covered", "visited", "display-qualified", "purchased", and "active".
- Separate "registered member" from "active member".
- Separate "cooperating home-decoration company" from "order-producing company".
- Separate "channel count/category count" from "channel/category output".
- Do not call a product explosive without repeatability or a clear action mechanism.
