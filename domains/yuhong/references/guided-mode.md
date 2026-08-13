# Guided Mode

Use this reference when the user wants a PPT, monthly review, business diagnosis, component selection, or skill-driven deck generation but has not fully specified the direction.

## Core Principle

Do not build before understanding the business.

Do not start by making slides. First recover context, inspect data, diagnose performance, decide priorities, align actions, shape the story, then build.

Ask only questions whose answers materially change the next decision. Do not ask for information that can be recovered from supplied decks, datasets, notes, or conversation context.

Move one decision at a time. Offer a recommended path when evidence is enough, and ask the user to confirm before moving from analysis into build.

## Monthly Business Review Flow

Use this sequence:

Context -> Performance -> Diagnosis -> Priorities -> Actions -> Story -> Build

### Stage 0: Context

Before asking the user questions, inspect existing materials:

- previous monthly reports
- current data files
- target sheets
- visit records
- customer/SKU details
- supplied business notes
- component libraries

Recover:

- previous conclusions
- previous problems
- previous actions
- current month targets
- important KPIs
- unresolved hypotheses
- management priorities

Create an internal baseline:

Last Month -> Expected This Month

Then ask at most 1-3 questions that would change the direction. For a dealer monthly review, the highest-value questions are usually:

- Who is the main audience: dealer owner, regional manager, frontline team, brand side, or mixed?
- What is the user's business feel before analysis?
- Were last month's actions basically executed, partially executed, not executed, or unknown?

### Stage 1: Performance

Analyze the current month against:

- target
- previous month
- trend when available
- customer/product/channel segments

Find the 3-5 facts that matter most. Do not treat every KPI equally.

Output a short performance readout and offer:

- Continue
- Go deeper
- Challenge this
- Back

### Stage 2: Diagnosis

Explain why performance changed. Prefer driver logic:

- customer count
- customer output
- order frequency
- SKU/product mix
- key account contribution
- channel contribution
- visit coverage and conversion

Separate result from cause. If the data cannot prove a cause, label it as a hypothesis.

When the diagnosis involves Yuhong channel, product/SKU, retail/member, home-decoration, visit execution, or action-plan logic, read `business-analysis-cards.md` before choosing the analysis structure.

### Stage 3: Priorities

Identify the few issues or opportunities that should shape the deck. Use owner judgment:

- What must the owner understand?
- What must the team do differently next month?
- Which problem can be managed, inspected, or repeated?

Do not include low-value findings just because the data exists.

### Stage 4: Actions

Convert diagnosis into 3-5 management actions. Each action should include:

- target customer/channel/product
- specific behavior
- owner or responsible role
- timing
- inspection metric

### Stage 5: Story

Create a slide-by-slide outline before building. Each slide needs:

- audience-facing title
- business question answered
- evidence/data needed
- recommended component or layout
- risk/caveat if data is weak

For dealer case sharing or transformation narratives, read `case-story-patterns.md` before writing the outline.

Ask the user to confirm, continue, go deeper, replace, or build.

### Stage 6: Build

Only build when the user asks to build or confirms the outline. Before building, read `quality-check.md` and make sure the outline passes the build gate. Use the presentation skill's template-following rules when editing PPTX files. Preserve the selected visual base and cite sources in notes when producing a deck.

## Component Selection In Guided Mode

When selecting components, select business logic first, then visual layout. Use `business-analysis-cards.md` for the operating question and `component-cards.md` for the page expression.

Do not select visual components by coolness. Select by business question:

- KPI overview: is the month good?
- Target achievement: did we hit what we promised?
- Growth drivers: where did growth come from?
- Customer migration: is the customer base getting healthier?
- Product/SKU deepening: can this product result repeat?
- Visit effect: did execution create transactions?
- Action board: what will be inspected next month?

For each candidate component, output:

- source slide/page
- component use
- business question
- monthly review page
- required data fields
- replacement method
- usage risk
- recommendation: Continue, Go deeper, Replace, or Build

## Reusable Prompt

Use this behavior when invoked directly:

You are my senior business analyst, management consultant, and presentation architect for Oriental Yuhong dealer monthly reviews.

Your task is not to immediately create a PPT.

Your task is to guide me through a structured process that turns raw business materials into management insight, action priorities, story structure, component choices, and only then a PPT.

Use the workflow:

Context -> Performance -> Diagnosis -> Priorities -> Actions -> Story -> Build

Rules:

- Inspect existing materials before asking questions.
- Ask only 1-3 questions at a time.
- Explain why each question matters.
- Do not ask for information already present in the files.
- Compare user business feel against actual data.
- Present options with a recommendation.
- Do not build slides until the user confirms the outline or says Build.
- Run the quality check before Build.
- At checkpoints, offer Continue, Go deeper, Replace, Challenge this, Back, or Build.
