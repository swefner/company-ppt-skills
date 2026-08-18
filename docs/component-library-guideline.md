# 组件库补充方法 · 一页操作手册

> 用途：给 Agent/同事的"怎么补组件"操作手册。配套：`component-library-strategy.md`（为什么）、`component-library-blueprint-V0.1.md`（补什么）、`component-registry.json`（登记处）。
> 核心：组件 = 判断单元（教学问题 → 输入 → 输出 + 视觉表达）；门禁四问答不出不进库。

## 一、补充组件的三个来源（内容从哪来）

| 来源 | 说明 | 仓库现成素材 |
|---|---|---|
| 1. 方法资产转化（最大来源） | 把"判断方法"组件化：方法卡/方法 deck 里的逻辑 → 组件 | `business-analysis-cards.md`（A1-A5/B1-B5/C1-C3/D1-D4 共 20+ 卡）、方法 deck（product-battle / channel-intensive-cultivation / retail-store-battle / home-decoration-channel / trader-to-service-provider 216 页）、樱桃库 141 页（逻辑参考） |
| 2. 课程需求驱动 | 做课件时发现"这页要让学员判断，但库里有卡无源页/连卡都没有" | 四页实验提问页 → I1 即例证；每次课件蓝图缺页即需求 |
| 3. 案例固化 | 课件/复盘中反复出现的页面形态固化为可复用组件 | 15 页老板版页面、复盘 deck 是候选池 |

## 二、判定"补什么"的三个过滤器（按顺序过）

```
过滤器 1 · 决策流缺口：看趋势→判状态→盘区域→找机会→定方向，哪环缺组件？
过滤器 2 · 任务类型缺口：诊断 / 互动 / 共创 / 收尾，哪层缺源页？
过滤器 3 · 门禁四问：教学问题？输入？输出？不变式？——答不出的不补
```

当前缺口速查（2026-08-18）：DC-16 盘区域、DC-06 产品、I2-I8 互动、零售/家装无卡。

## 三、补充流程（五步，已验证）

```
1. 内容设计  从方法资产/需求提取 → 写门禁四问（问题/输入/输出/不变式）+ 视觉方向
             （参考同模块已有组件与樱桃库版式）
2. registry 登记  在 component-registry.json 加条目：type / decision_loops / modules /
             门禁四问 / best_modes；status = card-only（此时已是"卡"，可被检索）
3. 视觉+槽位  定版式 → 设计命名对象（replaceable_objects）+ 不变式
4. 源页构建   build-XX.ps1（纯 ASCII，模板令牌色）+ XX-content.json（中文）
             → work 副本 → 结构验证（对象齐/色值令牌内/无溢出）→ 渲染读图
5. 生产线      registry status 改 executable + 源页信息 → 生成器 → 预览 → 图册
              → catalog → 入库 → 契约/SHA 同步
```

## 四、生产线命令速查（每次补组件照跑）

```powershell
# ① 源页构建（在 assets/components 下）
Copy-Item yuhong-county-course-components-branded.pptx yuhong-county-course-components-branded-work.pptx
powershell -NoProfile -ExecutionPolicy RemoteSigned -File build-XX.ps1 -DeckPath '.\yuhong-county-course-components-branded-work.pptx'
# ② 渲染预览（9 页 → component-0N.png + manifest）
powershell -NoProfile -ExecutionPolicy RemoteSigned -File render-component-previews.ps1 -DeckPath '.\yuhong-county-course-components-branded-work.pptx'
# ③ 生成器（index + catalog + 卡片草稿；catalog SHA 实时重算——须在入库后跑一次）
cd domains\yuhong\references
python build-component-registry.py --update-catalog
# ④ 图册
python assets\components\build-contact-sheet.py
# ⑤ 入库 + 同步
Copy-Item work.pptx branded.pptx（覆盖）; 删除 work 副本
# 更新：component-slots.json（槽位合同 + source_deck_sha256）、build-execution-contract.md（SHA/页数）
```

**铁律**：build 脚本纯 ASCII（PS5.1 读无 BOM UTF-8 按 ANSI，中文会崩——中文进 JSON）；色值只用模板 theme1 令牌；新组件 SHA 以入库后正式 deck 为准（生成器重跑）。

## 五、示例走查：DC-16（从方法资产到可执行组件）

1. 来源一：`decision-component-store.md` 的 DC-16 卡片已完整（问题/输入/输出/视觉均写）
2. 门禁四问已答：问题=资源有限优先投哪；输入=候选+潜力证据+难度+半径+竞争+负责人；输出=首战/候补/暂缓+证据；不变式=象限命名固定（优先拿下/重点攻坚/观察验证/暂缓投入）
3. registry：已登记（status=card-only）
4. 待做：视觉（候选证据卡→价值×难度矩阵→资源下注区）+ 槽位（源页 slide 10）+ 源页构建 + 生产线五步
5. 产物：一个"盘区域"环节的可执行组件，补齐决策流咽喉

## 六、变更记录

| 版本 | 日期 | 说明 |
|---|---|---|
| V0.1 | 2026-08-18 | 初版：三来源、三过滤器、五步流程、命令速查、DC-16 示例走查。 |
