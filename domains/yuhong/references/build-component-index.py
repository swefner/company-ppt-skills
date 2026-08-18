# DEPRECATED (2026-08-18): replaced by build-component-registry.py as the single source of truth.
# component-registry.json now drives component-index.json + catalog + cards draft.
# Kept only for reference; do not extend - update the registry instead.
# Build the machine-readable component navigation index for Yuhong components.
# Data source: component-slots.json (single source of truth for id/code/slide/preview).
# Module and mode assignments are business judgments maintained here; new components
# must be added to MODULES (module) and BEST_MODES (modes) below, then re-run.
# Output: component-index.json next to this script.
import json
import os
import sys

BASE = os.path.dirname(os.path.abspath(__file__))
SLOTS = os.path.join(BASE, '..', 'assets', 'components', 'component-slots.json')
OUT = os.path.join(BASE, 'component-index.json')

# id -> module assignment (business judgment)
MODULES = {
    'county-trend-three-judgments': '看趋势',
    'county-business-territory-map': '判状态',
    'four-force-diagnosis': '判状态',
    'four-stage-growth-diagnosis': '判状态',
    'symptom-clustering-core-problem': '判状态',
    'integrated-stage-symptom-force-action-diagnosis': '判状态',
    'thirty-day-action-commitment-board': '收尾与行动',
    'channel-intensive-cultivation-driver-board': '渠道精耕',
}

# id -> best modes (mirrors decision-component-store.md card "Best modes")
BEST_MODES = {
    'county-trend-three-judgments': ['Create Courseware', 'Dealer Workshop'],
    'county-business-territory-map': ['Create Courseware', 'Dealer Workshop', 'Business Review'],
    'four-force-diagnosis': ['Create Courseware', 'Dealer Workshop', 'Adapt Existing Deck'],
    'four-stage-growth-diagnosis': ['Create Courseware', 'Dealer Workshop', 'Case Teaching'],
    'symptom-clustering-core-problem': ['Create Courseware', 'Dealer Workshop', 'Adapt Existing Deck'],
    'integrated-stage-symptom-force-action-diagnosis': ['Create Courseware', 'Dealer Workshop', 'Case Teaching'],
    'thirty-day-action-commitment-board': ['Dealer Workshop', 'Create Courseware', 'Business Review'],
    'channel-intensive-cultivation-driver-board': ['Create Courseware', 'Business Review', 'Dealer Workshop'],
}

# id -> short Chinese name
NAMES = {
    'county-trend-three-judgments': '三个趋势判断',
    'county-business-territory-map': '县域生意版图',
    'four-force-diagnosis': '四力诊断',
    'four-stage-growth-diagnosis': '四阶段成长判断',
    'symptom-clustering-core-problem': '病症聚类诊断',
    'integrated-stage-symptom-force-action-diagnosis': '阶段-病症-四力-动作综合诊断',
    'thirty-day-action-commitment-board': '30 天行动板',
    'channel-intensive-cultivation-driver-board': '渠道驱动板（覆盖×活跃×单店产出）',
}

slots = json.load(open(SLOTS, encoding='utf-8'))

components = []
for c in slots['components']:
    cid = c['id']
    if cid not in MODULES:
        print(f'WARN: component {cid} has no module assignment; skipped in index', file=sys.stderr)
        continue
    components.append({
        'id': cid,
        'code': c['decision_component'],
        'name': NAMES.get(cid, cid),
        'question': None,  # filled from slot? slots has no question field; keep empty
        'module': MODULES[cid],
        'best_modes': BEST_MODES.get(cid, []),
        'source_slide': c.get('source_slide'),
        'source_slide_id': c.get('source_slide_id'),
        'preview': c.get('preview'),
    })

# navigation grouped by mode then module
modes = sorted({m for c in components for m in c['best_modes']})
navigation = []
for mode in modes:
    mode_modules = []
    for comp in components:
        if mode in comp['best_modes']:
            mode_modules.append({'module': comp['module'], 'components': [comp['id']]})
    # merge same module entries
    merged = {}
    for entry in mode_modules:
        merged.setdefault(entry['module'], []).extend(entry['components'])
    navigation.append({
        'mode': mode,
        'modules': [{'module': k, 'components': v} for k, v in merged.items()],
    })

index = {
    'version': '1.0.0',
    'domain': 'yuhong-ppt',
    'generated_from': ['component-slots.json', 'build-component-index.py (module/mode maps)'],
    'selection_rule': 'Navigate by mode -> module -> shortlist (<=10) -> open that module contact sheet -> describe layouts from the image -> confirm against the component card. Never select from memory or from the full list.',
    'navigation': navigation,
    'components': components,
}

json.dump(index, open(OUT, 'w', encoding='utf-8'), ensure_ascii=False, indent=2)
print(f'index written: {OUT} ({len(components)} components, {len(navigation)} modes)')
