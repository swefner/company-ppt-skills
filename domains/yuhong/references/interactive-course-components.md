# Interactive Course Components

Use this reference when building Yuhong training decks, workshop decks, or courseware that needs classroom interaction.

PowerPoint can support useful teaching interaction through animation, triggers, hyperlinks, section navigation, hidden slides, Morph, progressive reveal, and worksheet pages. It should not be treated as a full web app. For true live data input, scoring, drag-and-drop, or multi-user collaboration, use a companion HTML/Excel/Form tool and link to it from the PPT.

## Interaction Levels

### Level 1. Presenter-Controlled Reveal

Use for:

- Concept explanations.
- Case debrief.
- Model walkthrough.
- Answer reveal after discussion.

PowerPoint implementation:

- Appear / Fade / Wipe animations.
- One idea revealed per click.
- Build formula or framework step by step.
- Hide the conclusion until learners discuss.

Best classroom use:

- Ask first, reveal second.
- Let learners speak before showing the "standard answer".

Risk:

- Too many clicks slow down the class. Use reveal only where suspense or thinking matters.

### Level 2. Clickable Teaching Board

Use for:

- Module menus.
- Four-channel selection: 分销 / 家装 / 工长 / C端.
- Case library navigation.
- Risk checklist drill-down.

PowerPoint implementation:

- Hyperlinks to slides or sections.
- Return buttons back to the menu.
- Clickable icons or labels.
- Branch pages for each choice.

Best classroom use:

- Let the instructor choose a branch based on learner needs.
- Use for "今天先深挖哪个渠道?".

Risk:

- Navigation can get messy. Every branch needs a clear back button.

### Level 3. Triggered Reveal

Use for:

- Click a card to reveal answer.
- Click a channel to reveal typical pain.
- Click a risk to reveal control method.
- Click a customer type to reveal recommended tactic.

PowerPoint implementation:

- Animation trigger on shapes.
- One trigger group per card.
- Use simple labels and clear hover-like visual affordance.

Best classroom use:

- Ask groups to choose a card.
- Reveal only the card being discussed.

Risk:

- Trigger-heavy decks are harder to maintain. Use for key interaction pages only.

### Level 4. Branching Simulation

Use for:

- "If you are this dealer, which channel should you attack first?"
- "Facing this competitor, which response do you choose?"
- "This home-decoration company has these traits; do you develop, activate, or give up?"

PowerPoint implementation:

- Scenario page.
- Three or four choice buttons.
- Each choice links to a result slide.
- Result slide explains consequence and recommended decision.

Best classroom use:

- Good for workshop warm-up or review.
- Works well before teaching the formal method.

Risk:

- Keep branches shallow. A 2-level decision tree is usually enough in PPT.

### Level 5. Companion Tool Interaction

Use for:

- Live scoring.
- Dealer self-assessment.
- Team input collection.
- Dynamic charts.
- Multi-user worksheet collection.

Implementation:

- Link to Excel, Forms, questionnaire, or local HTML tool.
- PPT explains the task and shows QR/link.
- Companion tool collects input.
- PPT has a fixed debrief page for interpreting outputs.

Best classroom use:

- Use when many learners need to submit answers.
- Use when scoring should update live.

Risk:

- Network and device issues can interrupt class. Always prepare a paper/static fallback.

## Reusable Interactive Components

### I1. Ask-Then-Reveal Concept Page

- Purpose: Make learners think before the answer appears.
- Best for: mindset contrast, channel characteristics, risk awareness.
- Slide structure: question -> learner discussion -> reveal answer -> instructor summary.
- Data/input needed: question, expected answers, final principle.
- PPT effect: progressive reveal or triggered reveal.
- Risk: Do not reveal too much text at once.

### I2. Four-Channel Clickable Menu

- Purpose: Navigate between 分销、家装、工长、C端 modules.
- Best for: channel tactics workshop.
- Slide structure: four large channel options, each linked to a module opener.
- Data/input needed: selected channel modules and return slide.
- PPT effect: hyperlinks and return buttons.
- Risk: Keep menu stable across the deck.

### I3. Dealer Scenario Choice

- Purpose: Let learners make a decision before teaching the model.
- Best for: strategic positioning, channel choice, competitor response.
- Slide structure: scenario -> 3-4 choices -> consequence pages -> recommended logic.
- Data/input needed: dealer profile, options, consequence logic, recommended answer.
- PPT effect: branching hyperlinks.
- Risk: Avoid making the "wrong" option humiliating. Use it as learning.

### I4. Click-To-Diagnose Matrix

- Purpose: Reveal diagnosis by dimension.
- Best for: 看大势 / 看竞争 / 看自我, risk control, team capability.
- Slide structure: matrix or checklist with clickable dimensions.
- Data/input needed: dimensions, symptoms, interpretation, next action.
- PPT effect: triggered reveal on each dimension.
- Risk: Limit to 4-6 clickable areas.

### I5. Worksheet Walkthrough

- Purpose: Guide learners to fill a tool correctly.
- Best for: market opportunity assessment, battle map, outlet/channel plan, team plan.
- Slide structure: blank worksheet -> example row -> fill-in instruction -> share prompt.
- Data/input needed: worksheet fields, example values, time limit, share rule.
- PPT effect: build example row step by step.
- Risk: Do not put a dense full worksheet on screen without zooming or highlighting.

### I6. Group Voting Page

- Purpose: Make class judgment visible.
- Best for: selecting focus channel, ranking risks, choosing first action.
- Slide structure: prompt, 3-5 choices, voting method, debrief rule.
- Data/input needed: choices and voting method.
- PPT effect: static voting page, optional QR/link to Forms.
- Risk: Native PPT does not count votes. Use Forms or manual hand-raise unless using a companion tool.

### I7. Case Debrief Reveal

- Purpose: Let learners extract lessons from a case before showing the official debrief.
- Best for: Rongyu/Jiabeili case pages or dealer examples.
- Slide structure: case facts -> learner question -> reveal actions -> reveal lesson.
- Data/input needed: case background, key action, result, lesson.
- PPT effect: staged reveal.
- Risk: If the case is too text-heavy, split it into fact page and debrief page.

### I8. Risk Drill Card

- Purpose: Turn risk education into active diagnosis.
- Best for: delivery boundary, payment node, receivable, third-party payment.
- Slide structure: risk scenario -> "where is the pit?" -> reveal control rule -> tool/example clause.
- Data/input needed: risk scenario, correct control point, clause/process example.
- PPT effect: triggered reveal or branching choice.
- Risk: Avoid presenting operational examples as legal advice.

## Design Rules For Interactive PPT

- Make clickable areas visually obvious: icon, button-like shape, or consistent accent.
- Add a small "Back" or "Return" button on every branch slide.
- Keep interaction pages sparse. One interaction, one task.
- Do not hide critical content only behind complex triggers.
- Use animations to support thinking, not to decorate.
- Keep instructor notes explicit: when to ask, how long to discuss, what to reveal, what to challenge.
- Always provide a non-interactive fallback for print/PDF export.

## Build Checklist

Before building an interactive course deck:

- Which slides are interactive?
- What does the instructor click?
- What does the learner do?
- What output is produced?
- Is there a fallback if animation/hyperlink fails?
- Can the deck still be understood when exported to PDF?

