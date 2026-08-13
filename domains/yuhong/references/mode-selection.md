# Yuhong PPT Mode Selection

Select exactly one primary mode before choosing templates or components. A deck may borrow components from another mode, but one mode must control the story and build rules.

## Modes

### Create Courseware

- Trigger: 做课件、培训、课程、训练营、讲师授课.
- Primary outcome: learners understand a method and produce a usable diagnosis or action artifact.
- Required context: audience, duration, topic, learner stage, teaching outcome, available cases.
- Default references: `course-story-structure.md`, `decision-component-store.md`, `workshop-component-cards.md`.

### Adapt Existing Deck

- Trigger: 修改、优化、改编、压缩、扩展、换受众, with an existing PPT.
- Primary outcome: preserve useful source content and visual identity while repairing story, teaching flow, and component fit.
- Required context: source deck, target audience, target duration, content that must remain, allowed visual changes.
- Rule: audit each source page as Keep / Rewrite / Replace Component / Remove / Add.

### Case Teaching

- Trigger: 案例、标杆、转型故事、经验复盘、案例教学.
- Primary outcome: learners infer the decision logic from evidence before seeing the lesson.
- Required context: situation, conflict, actions, results, evidence, transferable lesson.
- Default references: `case-story-patterns.md`, `interactive-course-components.md`.

### Dealer Workshop

- Trigger: 共创、工作坊、现场诊断、分组讨论、行动计划.
- Primary outcome: participants create an artifact during the session.
- Required context: participant roles, workshop duration, input data, grouping, output template, review method.
- Default references: `workshop-component-cards.md`, `interactive-course-components.md`.

### Business Review

- Trigger: 月会、经营复盘、目标达成、渠道或产品战役复盘.
- Primary outcome: owner sees the result, cause, risk, and accountable next action.
- Required context: targets, actuals, comparison baseline, customer/channel/SKU detail, prior actions.
- Default references: `business-analysis-cards.md`, `metric-definitions.md`.

## Conflict Rules

- If a new deck teaches methods and includes exercises, choose `Create Courseware`; use workshop components inside it.
- If an existing PPT is supplied and the user asks to improve it, choose `Adapt Existing Deck`, even if the subject is courseware.
- If the case is evidence for a broader course, keep `Create Courseware`; use a case-teaching sequence only for that module.
- If monthly data is used only as a classroom exercise, keep `Create Courseware` or `Dealer Workshop`, not `Business Review`.
- Ask one clarifying question only when the primary mode materially changes the output.

## Guided Mode Declaration

State before outlining:

- Primary mode
- Secondary borrowed mode, if any
- Audience and session length
- Required learner or management output
- Selected template family
- Missing inputs that affect component choice
