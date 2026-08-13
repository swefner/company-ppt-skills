# System Field Map

Use these fields as canonical references when reading app exports, API JSON, or system-derived tables.

## Operating Overview

- `current_sales`: 本期销售额
- `previous_comparable_sales` or `previous_sales`: 上期可比销售额
- `change_amount`: 销售变化额
- `change_rate`: 销售变化率
- `active_customers`: 活跃客户数
- `new_customers`: 新开客户数
- `previous_active_customers`: 上期活跃客户数
- `previous_new_customers`: 上期新开客户数

## Goals

- `goals.sales_amount.target`: 销售目标
- `goals.sales_amount.actual`: 销售实际
- `goals.sales_amount.completion_rate`: 销售完成率
- `goals.active_customers.target`: 活跃客户目标
- `goals.active_customers.actual`: 活跃客户实际
- `goals.new_customers.target`: 新开客户目标
- `goals.new_customers.actual`: 新开客户实际

## Customer Structure

- `customer_count`: 客户总数
- `visit_pool_count`: 当前经营/拜访池客户数
- `category_counts`: 经营类别数量
- `value_tier_counts`: 价值层数量
- `customer_transitions`: 客户流转

## Customer Detail

- `customer_id`: 客户 ID
- `customer_name`: 客户名称
- `current_owner`: 当前负责人
- `business_scope`: 经营盘
- `in_current_scope`: 是否在当前经营范围
- `value_tier`: 价值层
- `category`: 当前经营类别
- `judge_reason`: 系统判定原因
- `suggested_action`: 建议动作
- `amount_90d`: 近 90 天销售额
- `amount_28d`: 近 28 天销售额
- `days_since_last_purchase`: 距上次采购天数
- `category_change`: 类别变化

Canonical action groups:

- `to_recover`: 休眠唤回, 下滑挽回
- `to_nurture`: 新客培育, 上升拓展
- `stable`: 稳定维护

Urgency order for customer pages:

1. 休眠唤回
2. 下滑挽回
3. 新客培育
4. 上升拓展
5. 稳定维护

## Product / Jiale / SKU

- `jiale_sales`: 家乐销售额
- `jiale_sales_prev`: 上期家乐销售额
- `jiale_change_amount`: 家乐变化额
- `jiale_share`: 家乐销售占比
- `jiale_share_prev`: 上期家乐占比
- `jiale_share_change_pct`: 家乐占比变化率
- `active_sku_count`: 活跃 SKU 数
- `active_sku_change`: 活跃 SKU 变化
- `sku_analytics.top_skus`: Top SKU
- `sku_analytics.jiale_skus`: 家乐 SKU
- `sku_name`: SKU 名称
- `current_amount`: 本期 SKU 销售额
- `previous_amount`: 上期 SKU 销售额
- `customer_count`: 覆盖客户数
- `contribution_rate`: SKU 贡献率
- `role_label`: SKU 角色

Jiale rule: use explicit Jiale flag first; if not available, SKU name containing 家乐 is the fallback.

## Leads / Visits

- `lead_key`: 商机 ID
- `customer_id`: 客户 ID
- `merchant_name`: 商户/客户名称
- `visit_date`: 拜访日期
- `customer_grade`: 客户等级
- `communication`: 沟通内容
- `lead_judgment`: 商机判断
- `judgment_reason`: 判断原因
- `visit_owner`: 拜访负责人

Lead judgment groups:

- 建议跟进
- 持续观察
- 成交待转出
- 暂不跟进

For PPT, prioritize 建议跟进 and 成交待转出.
