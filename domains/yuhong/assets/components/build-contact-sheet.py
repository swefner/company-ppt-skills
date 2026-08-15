# Build the large-label contact sheet used for one-image component selection by in-PowerPoint agents.
# Each cell: preview thumbnail + big DC-number badge (top-left) + big name label (bottom).
# Run after render-component-previews.ps1 so the sheet always matches the rendered previews.
import os
from PIL import Image, ImageDraw, ImageFont

BASE = os.path.dirname(os.path.abspath(__file__))
PREVIEWS = os.path.join(BASE, 'previews')

COMPONENTS = [
    ('DC-01', '三个趋势判断', 'county-trend-three-judgments'),
    ('DC-02', '县域生意版图', 'county-business-territory-map'),
    ('DC-03', '四力诊断', 'four-force-diagnosis'),
    ('DC-04', '四阶段成长判断', 'four-stage-growth-diagnosis'),
    ('DC-17', '病症聚类诊断', 'symptom-clustering-core-problem'),
    ('DC-20', '阶段-病症-四力-动作', 'integrated-stage-symptom-force-action-diagnosis'),
]

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

COLS, ROWS = 3, 2
THUMB_W, THUMB_H = 640, 360
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
draw.text((MARGIN + tw + 24, 17), '可执行组件预览图册 · 共 6 个 · 按编号对照选择', fill=(174, 188, 195), font=font_hint)

for idx, (code, name, cid) in enumerate(COMPONENTS):
    r, c = divmod(idx, COLS)
    src = os.path.join(PREVIEWS, 'component-%02d.png' % (idx + 1))
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

out = os.path.join(PREVIEWS, 'component-store-render-sheet.png')
sheet.save(out)
print('contact sheet:', out, sheet.size)
