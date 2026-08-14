# Pixel-level acceptance: template brand inheritance check on rendered pages.
import sys
sys.stdout.reconfigure(encoding='utf-8')
from PIL import Image
import os

BASE = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'previews')

def region_stats(im, x0, y0, x1, y1):
    w, h = im.size
    crop = im.crop((int(x0*w), int(y0*h), int(x1*w), int(y1*h)))
    px = list(crop.getdata())
    n = len(px)
    mean = tuple(sum(c[i] for c in px)//n for i in range(3))
    dark = sum(1 for c in px if sum(c) < 450)
    red = sum(1 for c in px if c[0] > 140 and c[1] < 90 and c[2] < 90)
    return mean, dark, red, n

def bg_sample(im):
    return region_stats(im, 0.02, 0.88, 0.20, 0.98)

t = Image.open(os.path.join(BASE, 'template', 'P01.png')).convert('RGB')
print('=== TEMPLATE ===')
m, d, r, n = region_stats(t, 0.68, 0.03, 0.97, 0.16)
print(f'brand zone: mean={m} dark={d} red={r} of {n}')
m, d, r, n = bg_sample(t)
print(f'bg lower-left: mean={m} dark={d}')
print()
print('=== BUILT DECK ===')
for i in range(1, 15):
    f = os.path.join(BASE, 'render', f'P{i:02d}.png')
    if not os.path.exists(f):
        continue
    im = Image.open(f).convert('RGB')
    m, d, r, n = region_stats(im, 0.68, 0.03, 0.97, 0.16)
    bgm, bgd, bgr, bgn = bg_sample(im)
    print(f'P{i:02d}: brand-zone dark={d:5d} red={r:4d} | bg mean={bgm} dark={bgd}')
