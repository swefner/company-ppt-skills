# Build the customer-review domain master + semantic theme palette.
# Brand-neutral light theme; semantic colors live in theme accent slots so any
# component built with themeColor references recolors when the theme changes.
# Page furniture (top bar, footer) is added at build time by the page framework
# function in build-components.py / demo scripts, not baked into the master.
import os
import re
import sys

sys.stdout.reconfigure(encoding='utf-8')
from pptx import Presentation
from pptx.util import Emu

BASE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(BASE, 'customer-review-template.pptx')

PALETTE = {
    'dk1': '172A3A',      # main text ink (deep navy)
    'lt1': 'FFFFFF',      # background white
    'dk2': '1F4E79',      # secondary deep (business blue)
    'lt2': 'F4F5F2',      # light band (off-white)
    'accent1': '1F4E79',  # primary emphasis (business blue)
    'accent2': 'C61720',  # warning / negative (red)
    'accent3': '2F6B4F',  # positive / growth (green)
    'accent4': '8A5B13',  # attention / neutral-watch (amber)
    'accent5': '66747C',  # neutral auxiliary (grey)
    'accent6': '4B8BBE',  # auxiliary emphasis (light blue)
}
# semantic mapping (documented in component cards):
# normal/primary = accent1, warning/negative = accent2, positive = accent3,
# attention = accent4, neutral = accent5, secondary emphasis = accent6

prs = Presentation()
prs.slide_width = Emu(12192000)
prs.slide_height = Emu(6858000)

master = prs.slide_masters[0]
theme_part = master.part.part_related_by(
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme')
theme_xml = theme_part.blob.decode('utf-8')

for name, hexval in PALETTE.items():
    if name in ('dk1', 'lt1'):
        # These slots are sysClr references (windowText / window); convert to srgbClr.
        pattern = r'(<a:' + name + r'>\s*)<a:sysClr[^/]*/>'
        theme_xml, n = re.subn(pattern, r'\g<1><a:srgbClr val="' + hexval + '"/>', theme_xml, count=1)
    else:
        pattern = r'(<a:' + name + r'>\s*<a:srgbClr val=")[0-9A-Fa-f]{6}(")'
        theme_xml, n = re.subn(pattern, r'\g<1>' + hexval + r'\g<2>', theme_xml, count=1)
    if n == 0:
        print(f'WARN: slot {name} not found in theme')

theme_part._blob = theme_xml.encode('utf-8')

prs.save(OUT)
print('master written:', OUT)
print('palette:', PALETTE)
