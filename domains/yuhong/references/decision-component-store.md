# Yuhong Decision Component Store

Use this store before choosing visual layouts. A Decision Component is a reusable page logic unit, not a decorative slide.

## Visual Previews

Six executable components have rendered previews at `assets/components/previews/component-01.png` ... `component-06.png`, plus a grid contact sheet at `assets/components/previews/component-store-render-sheet.png`. Look at the rendered preview before selecting or adapting a component; the text card alone does not convey layout, density, or capacity. Previews are machine-rendered from the source deck: after any change to `yuhong-county-course-components-branded.pptx` or its master, re-run `assets/components/render-component-previews.ps1` so the previews do not go stale. Each component card below lists its preview file.

## Selection Chain

`Page role -> teaching question -> learner decision/output -> available evidence -> Decision Component -> visual expression`

Reject a candidate when the input is unavailable, the learner output is unclear, or the component implies an unsupported causal relationship.

## Card Contract

Each mature card must define:

- ID and name
- Best modes
- Teaching or management question
- Required input
- Suitable page position
- Instructor action
- Learner action
- Output artifact or decision
- Recommended visual expression
- Source references
- Adaptation rule
- Usage risk
- Fallback when evidence or interaction is unavailable

## First-Priority Cards

### DC-01 County Trend Three Judgments

- Best modes: Create Courseware, Dealer Workshop.
- Question: 县域机会是消失了，还是机会结构发生了变化？
- Required input: 国家方向、市场重心变化、消费决策变化，以及至少一个县域事实或案例.
- Page position: 开场后的“看趋势”模块，通常 2-4 页组成一组.
- Instructor action: 先让学员表态，再逐条揭示三条判断链并追问本地证据.
- Learner action: 写下一个仍存在的机会和一个已经变化的旧打法.
- Output: 县域机会判断句.
- Visual: Ask-Then-Reveal + 三段证据链，不用普通三栏口号页.
- Source: `county-opportunity-course.md`, `interactive-course-components.md` I1.
- Visual preview: `assets/components/previews/component-01.png`.
- Adaptation: 用真实县域数据替换宏观套话，每条判断落到经销商经营影响.
- Risk: 容易变成空泛趋势宣讲.
- Fallback: 没有本地数据时，标注“行业判断”，用案例提问代替定量结论.

### DC-02 County Business Territory Map

- Best modes: Create Courseware, Dealer Workshop, Business Review.
- Question: 我的增长空间具体落在哪些县城、已覆盖乡镇和空白薄弱乡镇？
- Required input: 行政区域、乡镇清单、网点覆盖、活跃状态、销售或潜力、负责人.
- Page position: “判状态”之后，进入渠道精耕之前.
- Instructor action: 示范一个区域标注方法，要求学员解释优先级依据.
- Learner action: 标出守盘区、做深区、开拓区.
- Output: 县域生意版图和优先乡镇清单.
- Visual: 分区地图或矩阵；数据不足时用区域清单热度图.
- Source: `county-opportunity-course.md`, `business-analysis-cards.md` A4.
- Visual preview: `assets/components/previews/component-02.png`.
- Adaptation: 颜色必须对应不同经营动作，而不只是销售高低.
- Risk: 地图好看但没有行动含义.
- Fallback: 无地图底图时使用“区域 x 覆盖/活跃/潜力”矩阵.

### DC-03 Four-Force Diagnosis

- Best modes: Create Courseware, Dealer Workshop, Adapt Existing Deck.
- Question: 当前限制县域增长的主短板是品牌力、渠道力、场景力还是产品力？
- Required input: 四个维度的定义、症状、证据、评分标准或案例.
- Page position: 趋势和区域状态之后，解决方案模块之前.
- Instructor action: 逐维度提问，挑战没有证据的自评分.
- Learner action: 评分并写出最低一项的事实依据.
- Output: 一个主短板、一个次短板和对应证据.
- Visual: Click-To-Diagnose 四象限或四卡诊断.
- Source: `county-opportunity-course.md`, `interactive-course-components.md` I4.
- Visual preview: `assets/components/previews/component-03.png`.
- Adaptation: 每一”力”必须连接可观测指标和后续组件.
- Risk: 四项都低或都高，无法形成优先级.
- Fallback: 取消评分，改为“症状选择 + 证据”诊断.

### DC-04 Four-Stage Growth Diagnosis

- Best modes: Create Courseware, Dealer Workshop, Case Teaching.
- Question: 经销商当前卡在进得去、站得住、卖得动还是做得深？
- Required input: 各阶段定义、进入条件、典型症状、案例或经营指标.
- Page position: 四力诊断之后，渠道和产品打法之前.
- Instructor action: 给出情景，让学员先选阶段，再揭示判断标准.
- Learner action: 选择当前阶段并列出一个证据.
- Output: 当前阶段和下一阶段通关任务.
- Visual: 阶段路径 + 情景选择，避免只有箭头流程.
- Source: `county-opportunity-course.md`, `interactive-course-components.md` I3.
- Visual preview: `assets/components/previews/component-04.png`.
- Adaptation: 每阶段只保留一个关键判断和一个通关指标.
- Risk: 将实际并行问题硬塞成线性成熟度.
- Fallback: 允许“主阶段 + 次级瓶颈”的双标签.

### DC-05 Channel Intensive Cultivation Driver Board

- Best modes: Create Courseware, Business Review, Dealer Workshop.
- Question: 渠道增长应优先补覆盖、提活跃还是拉单店产出？
- Required input: 目标网点、覆盖网点、活跃网点、销售额、网点等级、路线和拜访数据.
- Page position: 渠道精耕模块的诊断起始页.
- Instructor action: 拆解增长公式，并用一个真实区域演示主矛盾判断.
- Learner action: 选择一个主杠杆并圈定目标乡镇或网点.
- Output: 渠道主杠杆和重点网点池.
- Visual: 三杠杆驱动板 + 网点分层，不用泛化漏斗.
- Source: `business-analysis-cards.md` A1-A5, `channel-intensive-cultivation.pptx`.
- Adaptation: 根据数据只突出一个主杠杆，其余作为约束项.
- Risk: 指标口径不一致会产生伪诊断.
- Fallback: 无完整数据时输出“假设 + 待补字段 + 现场验证问题”.

### DC-06 Product Battle Growth Board

- Best modes: Create Courseware, Business Review, Dealer Workshop.
- Question: 产品增长来自铺得更广、卖得更动，还是核心品项产出更高？
- Required input: SKU 清单、铺货网点、活跃/回转、SKU 销售、复购、目标品项.
- Page position: 产品战役模块的诊断起始页.
- Instructor action: 用一个核心 SKU 拆解增长来源，区分一次性销量与可重复机制.
- Learner action: 选定守、扩、育或淘汰的品项及对应网点.
- Output: 核心品项策略和铺货/动销动作.
- Visual: 产品增长驱动板 + SKU/网点组合矩阵.
- Source: `business-analysis-cards.md` B1-B5, `product-battle.pptx`.
- Adaptation: 把产品名单转成不同经营动作，不能只做销售排名.
- Risk: 缺少回转和复购时容易把一次销量误判为爆品.
- Fallback: 使用销售贡献与覆盖作为低置信度代理，并明确缺失项.

### DC-07 Case Ask-Evidence-Decision-Reveal

- Best modes: Case Teaching, Create Courseware, Adapt Existing Deck.
- Question: 面对这个经销商情景，你会先做什么，为什么？
- Required input: 情景、冲突、可见证据、选择项、真实行动、结果、可迁移原则.
- Page position: 方法讲解前的引入，或方法讲解后的应用验证.
- Instructor action: 先停在决策点收集答案，再揭示行动、结果和原则.
- Learner action: 选择方案并引用证据辩护.
- Output: 决策理由和可迁移原则.
- Visual: 两页或三段递进揭示；事实、选择和答案不可同时出现.
- Source: `case-story-patterns.md`, `interactive-course-components.md` I7.
- Adaptation: 保留真实矛盾，不把案例改成品牌宣传.
- Risk: 先展示答案会失去教学价值.
- Fallback: PDF/无动画版本拆成“案例题”和“复盘答案”两页.

### DC-08 Thirty-Day Action Commitment Board

- Best modes: Dealer Workshop, Create Courseware, Business Review.
- Question: 课程结束后 30 天，谁要对哪个对象做什么，并用什么结果验收？
- Required input: 重点区域/网点/产品、具体动作、负责人、时间、目标、检查节奏.
- Page position: 收尾模块，在方法和练习之后.
- Instructor action: 展示一条合格样例，逐项检查对象、动作和指标是否具体.
- Learner action: 填写并公开承诺一项渠道动作和一项产品动作.
- Output: 30 天行动表和复盘节点.
- Visual: 战役行动板；对象、动作、责任人、节点、指标为固定字段.
- Source: `workshop-component-cards.md` C5, `business-analysis-cards.md` action cards.
- Adaptation: 每项行动必须连接前面诊断出的短板或机会.
- Risk: 变成泛泛待办清单，或列出过多动作.
- Fallback: 信息不足时先产出“行动假设 + 需会后确认字段”.

## External-Method Cards

These cards adapt proven workshop methods into Yuhong-native teaching components. Preserve the method logic, but rebuild the slide with editable Yuhong shapes and language. Do not copy the external visual design.

### DC-16 Township And Outlet Opportunity Prioritization

- Best modes: Create Courseware, Dealer Workshop, Business Review.
- Question: 在资源有限的情况下，哪些乡镇或网点最值得优先投入？
- Required input: 候选乡镇/网点、增长潜力证据、当前基础、进入或做深难度、配送服务半径、竞争、负责人.
- Page position: 县域生意版图之后、形成重点战场之前.
- Instructor action: 先带领学员只按经营价值排序，再加入实施难度，最后讨论资源下注；不要一开始就凭感觉投放四象限.
- Learner action: 为 8-12 个候选对象提供证据，完成第一轮价值排序和第二轮难度定位.
- Output: 1-3 个首战对象、候补对象和暂缓对象，以及每个选择的一条证据.
- Visual: 两阶段优先级画布。左侧为候选证据卡，右侧为“经营价值 x 攻坚难度”矩阵，底部为资源下注区.
- External method source: Mural Importance-Difficulty Matrix, `https://www.mural.co/templates/importance-difficulty-matrix`; Miro Priority Matrix, `https://miro.com/templates/priority-matrix/`.
- Adaptation: 将通用的 impact/effort 改为“经营价值/攻坚难度”；象限命名使用“优先拿下、重点攻坚、观察验证、暂缓投入”.
- Risk: 学员可能把熟悉程度当成潜力，把关系好当成价值高.
- Fallback: 缺少客观数据时不打精确分数，改用“高/中/低 + 证据 + 待验证字段”.

### DC-17 Symptom Clustering And Core-Problem Convergence

- Best modes: Create Courseware, Dealer Workshop, Adapt Existing Deck.
- Question: 面对大量零散经营问题，真正需要优先解决的主问题是什么？
- Required input: 现场症状、网点/产品/拜访/服务事实、问题提出人、影响对象、出现频率或严重程度.
- Page position: 诊断模块开头，进入四力、渠道或产品专项之前.
- Instructor action: 先收集可观察症状，禁止直接写原因或方案；随后带领学员聚类、命名问题簇并选择一个主问题.
- Learner action: 每人提交 1-2 张事实卡，参与归类并为主问题提供证据.
- Output: 3-5 个问题簇、一个主问题、一个待验证原因假设.
- Visual: “症状池 -> 聚类区 -> 主问题声明”三段式证据墙；卡片颜色只表示来源或对象，不表示严重度.
- Visual preview: `assets/components/previews/component-05.png`.
- External method source: Mural Feedback Grid, `https://www.mural.co/templates/feedback-grid`; Miro workshop template collection, `https://miro.com/templates/`.
- Adaptation: 用雨虹经营标签进行聚类，例如覆盖、活跃、产品、拜访、服务、回款；主问题必须写成“对象 + 可见表现 + 经营影响”.
- Risk: 把解决方案写成问题，或把不同层级的症状和原因混在一起.
- Fallback: 人数少或时间短时，由讲师预置 8-12 张症状卡，学员只做聚类和主问题选择.

### DC-18 Evidence Voting And Resource Bet

- Best modes: Dealer Workshop, Create Courseware, Case Teaching.
- Question: 当老板、经理和业务员判断不一致时，怎样基于证据决定资源投向？
- Required input: 2-5 个候选战役、各自证据卡、资源约束、参与角色、投票规则、最终决策人.
- Page position: 方案生成之后、30 天行动计划之前.
- Instructor action: 先让各方案陈述证据，再进行匿名或分角色投票；揭示分歧后追问原因，最后由明确的决策角色确认资源下注.
- Learner action: 将有限票数投给候选战役，并写下一条支持证据和一条主要风险.
- Output: 一个主战役、一个备选战役、资源分配和反对意见记录.
- Visual: 上部证据卡，中部点投票区，下部“主战/备选/暂缓”资源下注板；票数不能替代最终经营判断.
- External method source: Miro Priority Matrix and dot-voting pattern, `https://miro.com/templates/priority-matrix/`; Mural prioritization workshop, `https://www.mural.co/templates/prioritize-ideas-goals-projects`.
- Adaptation: 候选对象使用乡镇、网点、渠道动作或核心品项；资源单位使用人天、拜访次数、费用、样板或政策额度.
- Risk: 人多的一方压过证据，或把投票结果误当成正确答案.
- Fallback: 无匿名投票工具时使用纸票、举牌或每人三点手工计票；记录少数意见.

### DC-19 Case Decision Fork

- Best modes: Case Teaching, Create Courseware, Adapt Existing Deck.
- Question: 在信息不完整、资源有限的真实情境中，学员会选择哪条经营路径，为什么？
- Required input: 经销商背景、关键冲突、当时可见证据、2-4 个合理选项、资源约束、真实选择、过程、结果和复盘原则.
- Page position: 方法讲解前用于制造认知冲突，或方法讲解后用于迁移应用.
- Instructor action: 只展示当时可见信息并停在决策点；要求各组选择、下注和辩护，再分步揭示真实行动、结果及代价.
- Learner action: 选择一条路径，引用至少两条证据，并说明放弃其他路径的理由.
- Output: 决策记录、关键证据、被放弃选项和可迁移原则.
- Visual: 三页最稳妥：情境与约束 -> 决策岔路 -> 结果与复盘。交互版可用超链接跳转，但必须有线性 PDF 版本.
- External method source: SlideModel business case study pattern, `https://slidemodel.com/templates/business-case-study-powerpoint-template/`; Miro decision-workshop patterns, `https://miro.com/templates/`.
- Adaptation: 选项必须都是现场可能采取的动作，例如先做乡镇覆盖、先激活存量网点、先打核心品项；避免设置一个明显愚蠢的错误答案.
- Risk: 事后诸葛亮、提前泄露答案，或把案例包装成只有成功没有代价的宣传故事.
- Fallback: 没有完整真实案例时使用明确标注的合成情景，并说明哪些事实需要后续替换.

### DC-20 Integrated Stage-Symptom-Force-Action Diagnosis

- Best modes: Create Courseware, Dealer Workshop, Case Teaching.
- Question: 如何把乡镇经营事实完整转化为阶段判断、当前任务、主病症、四力短板和优先动作？
- Required input: 乡镇经营结果、当前阶段证据、投入与结果不匹配的症状、四力证据、资源约束和候选动作.
- Page position: 判状态模块收束页，或综合案例诊断页.
- Instructor action: 按“阶段 -> 任务 -> 病症 -> 四力短板 -> 优先动作”逐步追问，禁止从病症直接跳到促销或铺货动作.
- Learner action: 完成五步诊断，并用一句话说明证据和最终选择.
- Output: 一条完整诊断陈述和 2-3 项优先动作.
- Visual: 五步纵向诊断脊柱，左侧步骤名，中部诊断问题，右侧填写输出.
- Visual preview: `assets/components/previews/component-06.png`.
- Executable source: `assets/components/yuhong-county-course-components-branded.pptx`, slide 6; fields in `assets/components/component-slots.json`.
- Risk: 为了填满模型而编造原因，或动作数量过多、没有优先级.
- Fallback: 证据不足时保留“待验证”，不进入动作选择.

## Page Blueprint Output

Before Build, present each proposed page with:

| Page | Conclusion | Teaching question | Decision Component | Required input | Instructor action | Learner output | Visual source | Risk |
|---|---|---|---|---|---|---|---|---|

Use `simple-evidence-page` only for a title, agenda, section divider, source note, or a page whose single fact is clearer without a reusable component. State why no Decision Component is needed.
