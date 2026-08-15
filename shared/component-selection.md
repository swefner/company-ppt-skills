# Component Selection

Components are decision tools, not decoration.

## Selection Order

1. Identify the slide's business question.
2. Identify the audience decision the slide should enable.
3. Check whether the required data exists.
4. Select a domain component or shared component.
5. Decide whether the component is the main page structure, a local visual module, or should be downgraded to a table.

## Component Types

- Decision component: explains when and why to use a page logic.
- Visual component: provides a reusable look, layout, or slide pattern.
- Data-binding component: defines required fields and data slots.
- Action component: turns diagnosis into owner, metric, target, and cadence.

## Reuse Rule

Use domain components first:

- UFS: use `domains/ufs/references/component-store/index.md`.
- Yuhong: use `domains/yuhong/references/decision-component-store.md` first, then `component-cards.md` only for visual expression.

Use shared rules only when the domain does not have a more specific rule.

## Anti-Hallucination Rule

Before recommending a component in any agent session:

1. Read the component store's contact sheet — one image listing all candidate components — and describe the layout detail you actually see for each candidate.
2. If any preview image cannot be read, write 「图片未读取」beside that component and base the choice on the text card only.
3. Never claim「已查看预览图」for an image that was not actually opened, and never invent layout details.
4. If your candidate's described layout contradicts its text card (e.g. a four-lens diagnosis described as a 2x2 matrix), re-check the source instead of proceeding.

This rule is mandatory: a real in-PowerPoint agent test showed four of five selected components were described from imagination while the agent claimed the previews were viewed.
