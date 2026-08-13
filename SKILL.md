---
name: company-ppt-skills
description: Company-level PowerPoint Skill Hub for selecting industry-specific PPT skills, templates, component libraries, and guided workflows across client projects. Use in PowerPoint ChatGPT workflows to identify the right domain skill, choose reusable templates, map business questions to components, and produce structured outlines before building slides.
---

# Company PPT Skills

Use this as the company-level entrypoint for PowerPoint ChatGPT work.

The job of this hub is not to generate every slide directly. The job is to route the request to the right domain skill, template, component library, and guided workflow.

## Default Workflow

1. Identify the client, industry, deck type, audience, and output expectation.
2. Read `registry/skill-registry.json` and select the matching domain skill.
3. Read `registry/template-registry.json` and select the most relevant template.
4. Read `registry/component-registry.json` and select only the components needed for the business question.
5. Produce a Guided Mode response before building:
   - recognized client / industry / deck type
   - selected domain skill
   - selected template
   - selected components
   - missing data or materials
   - recommended outline
6. Ask for Continue / Go deeper / Replace / Build.
7. Build or edit PPT only after explicit Build confirmation.

## Routing Rules

- Use UFS when the task involves UFS, 联合利华饮食策划, 生意合伙人项目, 经销商老板月会, 经营复盘, 家乐, SKU 做深, 拜访商机, or terminal-store advancement.
- Use Yuhong when the task involves 东方雨虹, 县域经销商, 渠道精耕, 产品战役, 零售专卖, 家装渠道, training courses, or dealer capability building.
- If the client or industry is unclear, ask for the minimum missing context before selecting a template.
- Do not mix domain styles unless the user explicitly asks for a cross-industry synthesis.
- Do not start from visual components. Start from the business question and audience decision.

## PowerPoint Plugin Constraints

PowerPoint ChatGPT sessions may not access local Windows paths or ZIP uploads. Prefer GitHub URLs and raw files.

When a domain skill is hosted in a separate repository, read its `SKILL.md` first, then follow its own references.

## Current Domains

- UFS: active, hosted on GitHub.
- Yuhong: local draft, to be published and registered.

## Quality Rules

- Keep domain vocabulary intact.
- Use Guided Mode for analysis, outline, and component selection before slide building.
- Prefer reusable templates and inherited PPT elements over generic consulting-style rebuilds.
- Treat component libraries as decision tools, not decoration.
