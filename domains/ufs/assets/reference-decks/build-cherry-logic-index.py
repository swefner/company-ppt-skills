# Build the searchable index of the cherry-red generic logic library.
# Reads cherry-red-logic-scan.tsv (produced by scan-cherry-logic.ps1), classifies
# pages into decorative-template vs business-example, and writes cherry-red-logic-index.md.
import os
import re

BASE = os.path.dirname(os.path.abspath(__file__))
TSV = os.path.join(BASE, 'cherry-red-logic-scan.tsv')
OUT = os.path.join(BASE, 'cherry-red-logic-index.md')

DECORATIVE = {
    '输入标题文字', '输入一级标题', '输入标 题文字', '神奇的逻辑图', '逻辑图 观点展示',
    '请根据标题在此处输入正文内容支持主题模式一键自由换色', '1', '01', '2019.06',
    '步步高升', '龙凤呈祥', '蒸蒸日上', '鹏程万里', '气宇轩昂', '意气风发 情投意合 日进斗金',
    '孜孜不倦', '登峰造极', '财运亨通',
}
DECORATIVE_RE = re.compile(r'^(输入|请根据标题|神奇的逻辑图|逻辑图)')


def esc(t):
    return t.replace('|', '\\|')


def guess_type(title, shapes):
    if '矩阵' in title:
        return '矩阵'
    if any(k in title for k in ('架构', '中台', '系统')):
        return '架构图'
    if any(k in title for k in ('解决方案', '方案')):
        return '解决方案'
    if any(k in title for k in ('漏斗', '转化', '获取', '线索', '获取用户')):
        return '漏斗/转化'
    if any(k in title for k in ('用户', '会员', '客户', '付费', '运营', '私域')):
        return '用户/运营逻辑'
    if any(k in title for k in ('考核', '管理', '组织')):
        return '管理/考核'
    if shapes >= 80:
        return '复杂图（高密度）'
    return '逻辑图'


rows = []
for line in open(TSV, encoding='utf-8').read().strip().split('\n')[1:]:
    parts = line.split('\t')
    if len(parts) < 3:
        continue
    slide, title, shapes = parts[0], parts[1], parts[2]
    pics = parts[3] if len(parts) > 3 else '0'
    kind = '装饰模板' if (title in DECORATIVE or DECORATIVE_RE.match(title)) else '业务样例'
    rows.append({'slide': int(slide), 'title': title, 'shapes': int(shapes), 'pics': int(pics), 'kind': kind})

rows.sort(key=lambda r: r['slide'])
deco = [r for r in rows if r['kind'] == '装饰模板']
samples = [r for r in rows if r['kind'] == '业务样例']

md = []
md.append('# 樱桃红逻辑库索引（通用逻辑层 · 141 页）')
md.append('')
md.append('> 扫描时间：2026-08-15 ｜ 来源：`cherry-red-logic-components.pptx` ｜ 重新扫描：运行 `scan-cherry-logic.ps1` 后重建本索引。')
md.append('> 用途：通用逻辑层的**参考源**——按业务问题挑页，在客户母版上重建。**不要直接复制页面进任何领域组件库**（视觉不兼容、违反品牌契约）。')
md.append('')
md.append('## 分类统计')
md.append('')
md.append(f'- 装饰模板页（占位/吉祥词标题，通用逻辑图结构）：**{len(deco)} 页**')
md.append(f'- 业务样例页（带真实业务内容的逻辑图示例）：**{len(samples)} 页**')
md.append('')
md.append('## 业务样例页（按页号）')
md.append('')
md.append('| 页号 | 标题 | 形状数 | 图片 | 可能类型 |')
md.append('|---|---|---:|---:|---|')
for r in samples:
    md.append(f"| {r['slide']} | {esc(r['title'])} | {r['shapes']} | {r['pics']} | {guess_type(r['title'], r['shapes'])} |")
md.append('')
md.append('## 装饰模板页（按页号）')
md.append('')
md.append('| 页号 | 标题 | 形状数 | 图片 |')
md.append('|---|---|---:|---:|')
for r in deco:
    md.append(f"| {r['slide']} | {esc(r['title'])} | {r['shapes']} | {r['pics']} |")
md.append('')
md.append('## 使用说明')
md.append('')
md.append('1. 按业务问题（增长拆解/驱动板/矩阵/路径/漏斗/架构）在索引中粗筛；')
md.append('2. 打开对应页目视精筛（索引只有标题，精筛靠打开页看结构）；')
md.append('3. 选定后：定义决策组件卡片（业务问题）→ 在客户母版上重建 → 槽位化 → 渲染预览 → 索引入库。')

open(OUT, 'w', encoding='utf-8').write('\n'.join(md) + '\n')
print(f'index written: {OUT} ({len(deco)} decorative, {len(samples)} sample)')
