# Build derived artifacts from the single source of truth component-registry.json.
# Strategy: docs/component-library-strategy.md - one registry, generators derive the rest.
# Outputs (all in this repo, paths relative to this script):
#   component-index.json              - navigation index (ALL components: executable + cards)
#   component-cards-draft.md          - draft cards for decision-component-store sync (ALL)
#   catalog.json (with --update-catalog) - bridge catalog components section (EXECUTABLE only)
# Usage:
#   python build-component-registry.py                 # write index + cards draft
#   python build-component-registry.py --update-catalog # also merge executable components into catalog.json
#   python build-component-registry.py --check          # compare without writing
import json
import os
import sys

BASE = os.path.dirname(os.path.abspath(__file__))
REGISTRY = os.path.join(BASE, 'component-registry.json')
INDEX_OUT = os.path.join(BASE, 'component-index.json')
CARDS_OUT = os.path.join(BASE, 'component-cards-draft.md')
REPO = os.path.abspath(os.path.join(BASE, '..', '..', '..'))
CATALOG = os.path.join(REPO, 'tools', 'powerpoint-skill-bridge', 'catalog.json')
DECK = os.path.join(REPO, 'domains', 'yuhong', 'assets', 'components',
                    'yuhong-county-course-components-branded.pptx')


def load_registry():
    with open(REGISTRY, encoding='utf-8') as f:
        return json.load(f)


def build_index(registry):
    components = []
    for c in registry['components']:
        components.append({
            'id': c['id'],
            'code': c['code'],
            'name': c['name'],
            'type': c['type'],
            'decision_loops': c['decision_loops'],
            'modules': c['modules'],
            'question': c['question'],
            'status': c['status'],
            'best_modes': c['best_modes'],
            'source_slide': c.get('executable', {}).get('source_slide'),
            'source_slide_id': c.get('executable', {}).get('source_slide_id'),
            'preview': c.get('executable', {}).get('preview'),
        })
    modes = sorted({m for c in components for m in c['best_modes']})
    navigation = []
    for mode in modes:
        merged = {}
        for comp in components:
            if mode in comp['best_modes']:
                for module in comp['modules']:
                    merged.setdefault(module, []).append(comp['id'])
        navigation.append({
            'mode': mode,
            'modules': [{'module': k, 'components': sorted(set(v))} for k, v in merged.items()],
        })
    return {
        'version': '1.1.0',
        'domain': registry['domain'],
        'generated_from': ['component-registry.json (single source of truth)',
                           'build-component-registry.py'],
        'selection_rule': 'Navigate by mode -> module -> shortlist (<=10) -> open that module contact sheet -> describe layouts from the image -> confirm against the component card. Never select from memory or from the full list.',
        'navigation': navigation,
        'components': components,
    }


def build_cards_draft(registry):
    lines = ['# 组件卡草稿（由 component-registry.json 生成，勿手改）',
             '', '> 生成时间：由 build-component-registry.py 输出。用于与 decision-component-store.md 同步/新增。',
             '']
    for c in registry['components']:
        exe = c.get('executable', {})
        lines.append(f"### {c['code']} {c['name']}")
        lines.append(f"- Type: {c['type']} ｜ Loops: {'/'.join(c['decision_loops'])} ｜ Modules: {'/'.join(c['modules'])}")
        lines.append(f"- Status: {c['status']}" + (f" ｜ Source slide {exe.get('source_slide')} ({exe.get('source_slide_id')})" if exe else ''))
        lines.append(f"- Question: {c['question']}")
        lines.append(f"- Input: {c['input']}")
        lines.append(f"- Output: {c['output']}")
        lines.append(f"- Invariant: {c['invariant']}")
        lines.append(f"- Best modes: {', '.join(c['best_modes'])}")
        lines.append('')
    return '\n'.join(lines)


def build_catalog_components(registry):
    components = []
    for c in registry['components']:
        exe = c.get('executable')
        if not exe:
            continue
        components.append({
            'id': c['id'],
            'code': c['code'],
            'title': c['name'],
            'question': c['question'],
            'sourceSlide': exe['source_slide'],
            'sourceSlideId': exe['source_slide_id'],
            'preview': '/domains/yuhong/assets/components/' + exe['preview'],
        })
    return components


def update_catalog(registry):
    if not os.path.exists(CATALOG):
        raise SystemExit(f'catalog not found: {CATALOG}')
    with open(CATALOG, encoding='utf-8') as f:
        catalog = json.load(f)
    deck = next(d for d in catalog['decks'] if d['id'] == 'yuhong-county-course-components')
    deck['components'] = build_catalog_components(registry)
    if os.path.exists(DECK):
        import hashlib
        deck['sha256'] = hashlib.sha256(open(DECK, 'rb').read()).hexdigest().upper()
    with open(CATALOG, 'w', encoding='utf-8') as f:
        json.dump(catalog, f, ensure_ascii=False, indent=2)
        f.write('\n')
    return deck['sha256']


def main():
    registry = load_registry()
    index = build_index(registry)
    cards = build_cards_draft(registry)
    catalog_components = build_catalog_components(registry)

    check = '--check' in sys.argv
    if check:
        old_index = json.load(open(INDEX_OUT, encoding='utf-8')) if os.path.exists(INDEX_OUT) else {}
        diff = 'index components: %d -> %d' % (len(old_index.get('components', [])), len(index['components']))
        print('[check]', diff)
        print('[check] catalog executable count would be:', len(catalog_components))
        return

    with open(INDEX_OUT, 'w', encoding='utf-8') as f:
        json.dump(index, f, ensure_ascii=False, indent=2)
        f.write('\n')
    with open(CARDS_OUT, 'w', encoding='utf-8') as f:
        f.write(cards)
    print('index written:', INDEX_OUT, '(%d components)' % len(index['components']))
    print('cards draft written:', CARDS_OUT)

    if '--update-catalog' in sys.argv:
        sha = update_catalog(registry)
        print('catalog updated (deck sha256:', sha, ')')
    else:
        print('catalog NOT updated; run with --update-catalog to merge executable components (count=%d)' % len(catalog_components))


if __name__ == '__main__':
    main()
