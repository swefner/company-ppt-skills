# Build the large-label contact sheet used for one-image component selection by in-PowerPoint agents.
# Each cell: preview thumbnail + big DC-number badge (top-left) + big name label (bottom).
# Data source: component-index.json (single source of truth; built by build-component-index.py).
# Optional --module <name> renders a contact sheet for one module subset only.
# Run after render-component-previews.ps1 so the sheet always matches the rendered previews.
import argparse
import json
import os
from PIL import Image, ImageDraw, ImageFont

BASE = os.path.dirname(os.path.abspath(__file__))
PREVIEWS = os.path.join(BASE, 'previews')
INDEX = os.path.join(BASE, '..', '..', 'references', 'component-index.json')

parser = argparse.ArgumentParser()
parser.add_argument('--module', default=None, help='render sheet for one module subset only')
args = parser.parse_args()

index = json.load(open(INDEX, encoding='utf-8'))
# Contact sheet shows EXECUTABLE components only (those with a rendered preview).
# Card-only / interactive-card / analysis-card entries are navigated by text cards.
COMPONENTS = [(c['code'], c['name'], c['id']) for c in index['components'] if c.get('preview')]
if args.module:
    COMPONENTS = [c for c in COMPONENTS if args.module in next(x for x in index['components'] if x['id'] == c[2])['modules']]
    if not COMPONENTS:
        raise SystemExit(f'no components in module {args.module!r}')
    print(f'[module subset] {args.module}: {[c[0] for c in COMPONENTS]}')

FONT_BIG = 'C:/Windows/Fonts/msyhbd.ttc'   # Microsoft YaHei Bold
FONT_REG = 'C:/Windows/Fonts/msyh.ttc'     # Microsoft YaHei
try:
    font_badge = ImageFont.truetype(FONT_BIG, 26)
    font_label = ImageFont.truetype(FONT_BIG, 20)
    font_title = ImageFont.truetype(FONT_BIG, 24)
    font_hint = ImageFont.truetype(FONT_REG, 13)
except Exception:
    font_badge = font_label = font_title = font_hint = ImageFont.load_default()

INK = (23, 42, 58)       # #172A3A
RED = (198, 23, 32)      # #C61720
PAPER = (244, 245, 242)
GREY = (102, 116, 124)

COLS = 3 if len(COMPONENTS) <= 6 else 4
ROWS = -(-len(COMPONENTS) // COLS)
THUMB_W, THUMB_H = (640, 360) if COLS == 3 else (520, 292)
PAD = 12
LABEL_H = 46
TITLE_H = 52
MARGIN = 20

grid_w = COLS * THUMB_W + (COLS + 1) * PAD + 2 * MARGIN
grid_h = TITLE_H + MARGIN + ROWS * (THUMB_H + LABEL_H) + (ROWS + 1) * PAD + MARGIN

sheet = Image.new('RGB', (grid_w, grid_h), PAPER)
draw = ImageDraw.Draw(sheet)

# Title bar
draw.rectangle([0, 0, grid_w, TITLE_H], fill=INK)
draw.text((MARGIN, 12), 'YUHONG EXECUTABLE COMPONENTS', fill=(255, 255, 255), font=font_title)
tw = draw.textlength('YUHONG EXECUTABLE COMPONENTS', font=font_title)
sheet_label = f'可执行组件预览图册 · 共 {len(COMPONENTS)} 个' + (f' · 模块「{args.module}」' if args.module else '') + ' · 按编号对照选择'
draw.text((MARGIN + tw + 24, 17), sheet_label, fill=(174, 188, 195), font=font_hint)

index_components = {c['id']: c for c in index['components']}
for idx, (code, name, cid) in enumerate(COMPONENTS):
    r, c = divmod(idx, COLS)
    src = os.path.join(PREVIEWS, os.path.basename(index_components[cid]['preview']))
    if not os.path.exists(src):
        raise FileNotFoundError(src)
    im = Image.open(src).convert('RGB').resize((THUMB_W, THUMB_H))
    x = MARGIN + PAD + c * (THUMB_W + PAD)
    y = TITLE_H + MARGIN + PAD + r * (THUMB_H + LABEL_H + PAD)

    sheet.paste(im, (x, y))

    # Big DC badge on top-left of the thumbnail
    badge_w = 74
    badge_h = 42
    badge = Image.new('RGBA', (badge_w, badge_h), (23, 42, 58, 220))
    bd = ImageDraw.Draw(badge)
    bd.text((8, 6), code, fill=(255, 255, 255), font=font_badge)
    sheet.paste(badge, (x + 8, y + 8), badge)

    # Name label under the thumbnail
    ly = y + THUMB_H + 8
    draw.text((x, ly), code + ' ', fill=RED, font=font_label)
    cw = draw.textlength(code + ' ', font=font_label)
    draw.text((x + cw, ly), name, fill=INK, font=font_label)

out_name = 'component-store-render-sheet.png'
if args.module:
    out_name = 'component-store-render-sheet-' + args.module + '.png'
out = os.path.join(PREVIEWS, out_name)
sheet.save(out)
print('contact sheet:', out, sheet.size)
