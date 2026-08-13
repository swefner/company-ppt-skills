# Data Requirements

Use the most granular source data available. Prefer raw detail tables over summarized screenshots.

Read `metric-definitions.md` when deciding exact Oriental Yuhong metric definitions, especially for outlets, effective stores, members, home decoration, service work orders, channel balance, and category balance.

## Minimum For Monthly Review

- Month and dealer name.
- Monthly target: sales, collection, key category/product target, active customers, new customers.
- Sales detail: date, customer, product/SKU, category, quantity, amount, salesperson/channel if available.
- Collection detail or monthly collection total.
- Customer master/list: customer name, type, region/channel, first purchase date if available.
- Last month actuals or same-period baseline.
- Last month action plan and execution status.

## Useful Optional Fields

- Visit records: date, customer, salesperson, visit purpose, result, next step.
- SKU mapping: product line, key product, explosive product, auxiliary product.
- Customer tier rules: high-value, active, new, lost, reactivated, single-SKU, multi-SKU.
- Channel tags: retail store, home decoration, engineering/project, distribution, e-commerce, other.
- Gross margin or profitability data when discussing business quality.

## Preferred Yuhong Diagnostic Fields

- Dealer profile: city tier, dealer volume band, authorized region, Yuhong sales ratio for multi-brand dealers.
- Distribution: outlet count, core store count, effective store count, target outlet count, covered outlet count, active outlet count, township/street total, township/street covered.
- People: own sales staff count, Hong salesperson count, sales role allocation, visit route ownership.
- Retail/member: registered member count, active member count, retail-channel sales, member purchase records, professional meeting count.
- Home decoration: home-decoration channel sales, home-decoration order count, cooperating company count, active/order-producing company count.
- Service: total work orders, converted work orders, service sales if available.
- Category/product: stable Yuhong category count, category sales, SKU sales, core product list, explosive product list, SKU penetration by customer.
- Support: warehouse area dedicated to Yuhong products, distribution meeting count, digital level.
- Willingness: activity participation, business willingness, cultural awareness.

## Calculation Principles

- Sales achievement = actual sales / sales target.
- Collection achievement = actual collection / collection target.
- Active customer = customer with purchase in the review month unless user provides another definition.
- New customer = first purchase in the review month unless user provides another definition.
- Key customer = use the user's threshold first; otherwise propose a threshold and label it as an assumption.
- Product depth = SKU count per customer, key-product penetration, and repeat purchase.

Yuhong-specific defaults:

- Outlet count = downstream stores/distributors with at least one transaction in the past 12 months.
- Effective store = store with visit record within three months and qualified display reporting.
- Outlet activity rate = stores with purchase records in the past three months / total stores.
- Member activity rate = members with consumption records in the past three months / total members.
- Home-decoration sales ratio = annual home-decoration channel sales / annual all-channel sales.
- Work-order conversion rate = converted work orders / total work orders.

If a required field is missing, do not fake the metric. Use one of:

- "not calculable from current data"
- "directional only"
- "needs customer-level sales detail"
- "needs SKU mapping"
