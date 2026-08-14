# Executable Component Store

Use this reference during `Build` after selecting a matching Decision Component. These assets are editable source slides, not mood-board references.

## Asset Contract

- Source deck: `assets/components/yuhong-county-course-components-branded.pptx`.
- Visual inheritance: every source slide uses the real master imported from `assets/reference-decks/yuhong-template.pptx`; the template logo and grey arc background must remain visible.
- Visual contact sheet: `assets/components/component-store-contact-sheet.png`.
- Named replacement contract: `assets/components/component-slots.json`.
- Individual previews: `assets/components/previews/component-01.png` through `component-06.png`.
- PowerPoint insertion bridge: `../../../tools/powerpoint-skill-bridge/manifest.xml` with catalog `../../../tools/powerpoint-skill-bridge/catalog.json`.

When a requested page matches one of the six components below:

1. Duplicate the exact source slide from the source deck.
2. Read `component-slots.json` for replaceable object names.
3. Replace only named objects required by the current content.
4. Preserve the source page's dominant composition, hierarchy, spatial relationships, and semantic colors.
5. Keep all text, shapes, and connectors editable.
6. Do not redraw the component from its name or preview.
7. If content exceeds the component capacity, split it across another slide; do not shrink it into a dense card grid.

Inside PowerPoint, use the bridge to insert the registered source slide with source formatting. The bridge correlates each visual title and preview with its fixed PowerPoint source slide ID; do not ask the Agent to infer that ID from a screenshot.

Reject any inserted page that brings back the former left red rail or typed `东方雨虹` brand mark. Those were local imitations and were removed when the executable store was rebased onto the supplied template master.

## Components

| Decision Component | Component ID | Source slide | Visual form | Core invariant |
|---|---|---:|---|---|
| DC-01 | `county-trend-three-judgments` | 1 | Three vertical change lanes | Exactly three judgments, each expressed as before -> after |
| DC-02 | `county-business-territory-map` | 2 | County center with township nodes | Colors represent operating actions, not sales level |
| DC-03 | `four-force-diagnosis` | 3 | Central problem with four diagnostic lenses | Select one primary shortfall and at most one secondary shortfall |
| DC-04 | `four-stage-growth-diagnosis` | 4 | Four-step growth staircase | Judge by formed results, then state the next-stage task |
| DC-17 | `symptom-clustering-core-problem` | 5 | Symptom wall converging into problem clusters | Symptoms are observable facts; clusters are diagnosis labels |
| DC-20 | `integrated-stage-symptom-force-action-diagnosis` | 6 | Five-step diagnostic spine | Follow stage -> task -> symptom -> force -> action without skipping |

## Rejection Rules

Reject the generated page when:

- The source slide was not duplicated even though the component matched.
- Named objects were replaced by a newly drawn grey-card layout.
- The dominant source composition changed without a documented content-capacity reason.
- Text became non-editable or the whole page was flattened to an image.
- The component invariant was broken, such as marking all four forces as equally important.

Use the preview PNG as the visual acceptance target and the PPTX slide as the editable source of truth.
