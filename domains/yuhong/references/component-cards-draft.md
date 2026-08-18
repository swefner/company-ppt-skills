# 组件卡草稿（由 component-registry.json 生成，勿手改）

> 生成时间：由 build-component-registry.py 输出。用于与 decision-component-store.md 同步/新增。

### DC-01 三个趋势判断
- Type: diagnosis ｜ Loops: 看趋势 ｜ Modules: 看趋势
- Status: executable ｜ Source slide 1 (256#)
- Question: 县域机会是消失了，还是机会结构发生了变化？
- Input: 国家方向、市场重心变化、消费决策变化，以及至少一个县域事实或案例
- Output: 县域机会判断句
- Invariant: 恰三条判断，每条 before->after；三判断名固定不可改写
- Best modes: Create Courseware, Dealer Workshop

### DC-02 县域生意版图
- Type: diagnosis ｜ Loops: 判状态 ｜ Modules: 判状态
- Status: executable ｜ Source slide 2 (257#)
- Question: 我的增长空间具体落在哪些县城、已覆盖乡镇和空白薄弱乡镇？
- Input: 行政区域、乡镇清单、网点覆盖、活跃状态、销售或潜力、负责人
- Output: 县域生意版图和优先乡镇清单
- Invariant: 颜色代表经营动作（守盘/做深/开拓），不是销售高低
- Best modes: Create Courseware, Dealer Workshop, Business Review

### DC-03 四力诊断
- Type: diagnosis ｜ Loops: 判状态 ｜ Modules: 判状态
- Status: executable ｜ Source slide 3 (258#)
- Question: 当前限制县域增长的主短板是品牌力、渠道力、场景力还是产品力？
- Input: 四个维度的定义、症状、证据、评分标准或案例
- Output: 一个主短板、一个次短板和对应证据
- Invariant: 四力定义固定：品牌/渠道/场景/产品；主短板≤1、次短板≤1
- Best modes: Create Courseware, Dealer Workshop, Adapt Existing Deck

### DC-04 四阶段成长判断
- Type: diagnosis ｜ Loops: 判状态 ｜ Modules: 判状态
- Status: executable ｜ Source slide 4 (259#)
- Question: 经销商当前卡在进得去、站得住、卖得动还是做得深？
- Input: 各阶段定义、进入条件、典型症状、案例或经营指标
- Output: 当前阶段和下一阶段通关任务
- Invariant: 四阶段名固定：进得去/站得住/卖得动/做得深
- Best modes: Create Courseware, Dealer Workshop, Case Teaching

### DC-05 渠道驱动板（覆盖×活跃×单店产出）
- Type: diagnosis ｜ Loops: 找机会 ｜ Modules: 渠道精耕
- Status: executable ｜ Source slide 8 (263#)
- Question: 渠道增长应优先补覆盖、提活跃还是拉单店产出？
- Input: 目标网点、覆盖网点、活跃网点、销售额、网点等级、路线和拜访数据
- Output: 渠道主杠杆和重点网点池
- Invariant: 覆盖×活跃×单店产出三杠杆固定；只突出一个主杠杆
- Best modes: Create Courseware, Business Review, Dealer Workshop

### DC-06 产品战役增长板
- Type: diagnosis ｜ Loops: 找机会 ｜ Modules: 产品战役
- Status: executable ｜ Source slide 11 (266#)
- Question: 产品增长来自铺得更广、卖得更动，还是核心品项产出更高？
- Input: SKU 清单、铺货网点、活跃/回转、SKU 销售、复购、目标品项
- Output: 核心品项策略（守/扩/育/淘汰）和铺货/动销动作
- Invariant: 一次销量≠爆品；缺回转/复购时用低置信度代理并标注缺失
- Best modes: Create Courseware, Business Review, Dealer Workshop

### DC-07 案例三幕（Ask-Evidence-Decision-Reveal）
- Type: co-creation ｜ Loops: 定方向 ｜ Modules: 案例教学
- Status: card-only
- Question: 面对这个经销商情景，你会先做什么，为什么？
- Input: 情景、冲突、可见证据、选择项、真实行动、结果、可迁移原则
- Output: 决策理由和可迁移原则
- Invariant: 事实、选择、答案不可同时出现（两页或三段揭示）
- Best modes: Case Teaching, Create Courseware, Adapt Existing Deck

### DC-08 30 天行动板
- Type: closing ｜ Loops: 定方向 ｜ Modules: 收尾与行动
- Status: executable ｜ Source slide 7 (262#)
- Question: 课程结束后30天，谁要对哪个对象做什么，并用什么结果验收？
- Input: 重点区域/网点/产品、具体动作、负责人、时间、目标、检查节奏
- Output: 30 天行动表和复盘节点
- Invariant: 五固定字段：对象/动作/责任人/节点/指标；每项行动须连接前面诊断的短板
- Best modes: Dealer Workshop, Create Courseware, Business Review

### DC-16 乡镇和网点机会优先级
- Type: diagnosis ｜ Loops: 盘区域 ｜ Modules: 盘区域
- Status: executable ｜ Source slide 10 (265#)
- Question: 在资源有限的情况下，哪些乡镇或网点最值得优先投入？
- Input: 候选乡镇/网点、增长潜力证据、当前基础、进入或做深难度、配送服务半径、竞争、负责人
- Output: 1-3 个首战对象、候补对象和暂缓对象，每个选择带一条证据
- Invariant: 象限命名固定：优先拿下/重点攻坚/观察验证/暂缓投入；先价值排序后难度定位
- Best modes: Create Courseware, Dealer Workshop, Business Review

### DC-17 病症聚类诊断
- Type: diagnosis ｜ Loops: 判状态 ｜ Modules: 判状态
- Status: executable ｜ Source slide 5 (260#)
- Question: 面对大量零散经营问题，真正需要优先解决的主问题是什么？
- Input: 现场症状、网点/产品/拜访/服务事实、问题提出人、影响对象、出现频率或严重程度
- Output: 3-5 个问题簇、一个主问题、一个待验证原因假设
- Invariant: 症状是可观察事实，聚类是诊断标签；先事实后原因
- Best modes: Create Courseware, Dealer Workshop, Adapt Existing Deck

### DC-18 证据投票与资源下注
- Type: co-creation ｜ Loops: 定方向 ｜ Modules: 定方向
- Status: card-only
- Question: 当老板、经理和业务员判断不一致时，怎样基于证据决定资源投向？
- Input: 2-5 个候选战役、各自证据卡、资源约束、参与角色、投票规则、最终决策人
- Output: 一个主战役、一个备选战役、资源分配和反对意见记录
- Invariant: 票数不能替代最终经营判断；保留少数意见
- Best modes: Dealer Workshop, Create Courseware, Case Teaching

### DC-19 案例决策岔路
- Type: co-creation ｜ Loops: 定方向 ｜ Modules: 案例教学
- Status: card-only
- Question: 在信息不完整、资源有限的真实情境中，学员会选择哪条经营路径，为什么？
- Input: 经销商背景、关键冲突、当时可见证据、2-4 个合理选项、资源约束、真实选择、过程、结果和复盘原则
- Output: 决策记录、关键证据、被放弃选项和可迁移原则
- Invariant: 选项必须都是现场可能采取的动作；避免设置明显愚蠢的错误答案
- Best modes: Case Teaching, Create Courseware, Adapt Existing Deck

### DC-20 阶段-病症-四力-动作综合诊断
- Type: diagnosis ｜ Loops: 判状态 ｜ Modules: 判状态
- Status: executable ｜ Source slide 6 (261#)
- Question: 如何把乡镇经营事实完整转化为阶段判断、当前任务、主病症、四力短板和优先动作？
- Input: 乡镇经营结果、当前阶段证据、投入与结果不匹配的症状、四力证据、资源约束和候选动作
- Output: 一条完整诊断陈述和 2-3 项优先动作
- Invariant: 五步顺序固定：阶段→任务→病症→四力短板→优先动作；禁止从病症直接跳到动作
- Best modes: Create Courseware, Dealer Workshop, Case Teaching

### I1 Ask-Then-Reveal 概念页
- Type: interactive ｜ Loops: 看趋势/判状态/定方向 ｜ Modules: 互动通用
- Status: executable ｜ Source slide 9 (264#)
- Question: 让学员先思考/表态，再揭示概念或结论（如"国家资源是不是离开县域了？"）
- Input: 问题、学员可能判断、最终原则/揭示内容
- Output: 学员先表态/判断，再对照揭示
- Invariant: 提问页不得提前出现揭示内容；学员页不出现讲师话术；无动画版由讲师控制节奏
- Best modes: Create Courseware, Dealer Workshop

### I2 四通道可点菜单
- Type: interactive ｜ Loops: 找机会 ｜ Modules: 渠道精耕
- Status: interactive-card
- Question: 今天先深挖哪个渠道？（分销/家装/工长/C 端）
- Input: 所选渠道模块与返回页
- Output: 渠道模块导航
- Invariant: 菜单全片稳定；每个分支有返回按钮
- Best modes: Dealer Workshop, Create Courseware

### I3 经销商情景选择
- Type: interactive ｜ Loops: 定方向/找机会 ｜ Modules: 互动通用
- Status: executable ｜ Source slide 12 (267#)
- Question: 如果你是这位经销商，面对这个局面先做什么？
- Input: 经销商画像、选项、后果逻辑、推荐答案
- Output: 选择与理由（先于方法讲解）
- Invariant: 避免羞辱错误选项，用作学习而非评判
- Best modes: Create Courseware, Dealer Workshop, Case Teaching

### I4 点击诊断矩阵
- Type: interactive ｜ Loops: 判状态 ｜ Modules: 互动通用
- Status: executable ｜ Source slide 13 (268#)
- Question: 按维度逐项点击揭示诊断（看大势/看竞争/看自我）
- Input: 维度、症状、解读、下一步动作
- Output: 分维度诊断
- Invariant: 可点击区 4-6 个；每个维度有解读与下一步
- Best modes: Create Courseware, Dealer Workshop

### I5 工作表演练
- Type: interactive ｜ Loops: 盘区域/找机会/定方向 ｜ Modules: 互动通用
- Status: interactive-card
- Question: 引导学员正确填写工具（版图/战役图/渠道计划等）
- Input: 工作表字段、示例值、时间限制、分享规则
- Output: 填好的工具
- Invariant: 完整工作表需放大/高亮展示，不整屏密集呈现
- Best modes: Dealer Workshop, Create Courseware

### I6 小组投票页
- Type: interactive ｜ Loops: 定方向 ｜ Modules: 互动通用
- Status: interactive-card
- Question: 让课堂判断可见（选重点渠道/排风险/选首动作）
- Input: 选项与投票方式
- Output: 投票结果与讨论焦点
- Invariant: 原生 PPT 不计数，用举手或表单；备好纸面回退
- Best modes: Dealer Workshop, Create Courseware

### I7 案例复盘揭示
- Type: interactive ｜ Loops: 定方向 ｜ Modules: 案例教学
- Status: interactive-card
- Question: 学员从案例中先提取教训，再揭示官方复盘
- Input: 案例背景、关键行动、结果、教训
- Output: 学员教训 vs 官方复盘
- Invariant: 案例太密集需拆事实页/复盘页；先学员后揭示
- Best modes: Case Teaching, Create Courseware

### I8 风险演练卡
- Type: interactive ｜ Loops: 定方向 ｜ Modules: 互动通用
- Status: interactive-card
- Question: 风险教育转为主动诊断："坑在哪？"
- Input: 风险场景、正确控制点、条款/流程示例
- Output: 控制规则与工具/示例条款
- Invariant: 操作示例不作法律建议
- Best modes: Dealer Workshop, Create Courseware

### A1 分销增长公式
- Type: analysis ｜ Loops: 找机会 ｜ Modules: 渠道精耕
- Status: analysis-card
- Question: 分销销售增长来自覆盖变多、活跃变好还是单店产出提升？
- Input: 网点总数/合作网点/活跃网点/网点销售额/单店产出/目标/上月同期值
- Output: 本月由哪个杠杆解释（主杠杆+最弱杠杆）
- Invariant: 公式固定：销售额=覆盖网点数×网点活跃率×平均单店产出
- Best modes: Business Review, Create Courseware

### B1 产品增长公式
- Type: analysis ｜ Loops: 找机会 ｜ Modules: 产品战役
- Status: analysis-card
- Question: 产品增长来自经营品项变多、品项活跃变好还是单品产出提升？
- Input: SKU/品项清单、本月销售 SKU、SKU 销售额、品类、铺货、回转/复购、目标、对比值
- Output: 是孤立爆品结果还是可重复的 SKU 经营方法
- Invariant: 公式固定：销售额=经营品项数×品项活跃率×品项平均产出；一次销量≠爆品
- Best modes: Business Review, Create Courseware

### C1 工人会员增长公式
- Type: analysis ｜ Loops: 找机会 ｜ Modules: 零售专卖
- Status: analysis-card
- Question: 会员/工人增长漏斗与 KPI 公式：增长从哪一层来？
- Input: 会员漏斗各层数量、转化率、活跃会员、产值、目标与对比值
- Output: 会员增长主瓶颈层
- Invariant: 按会员漏斗结构判断（获客→激活→活跃→产出），KPI 公式固定
- Best modes: Business Review, Create Courseware

### D1 家装增长公式
- Type: analysis ｜ Loops: 找机会 ｜ Modules: 家装渠道
- Status: analysis-card
- Question: 家装渠道增长来自哪些来源，TOP 贡献在哪里？
- Input: 家装业务来源、漏斗各层、TOP10 贡献、目标与对比值
- Output: 家装增长主来源与 TOP10 贡献卡
- Invariant: 按家装漏斗与 TOP10 贡献判断（非泛化漏斗）
- Best modes: Business Review, Create Courseware
