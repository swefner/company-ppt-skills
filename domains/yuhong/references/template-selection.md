# Yuhong Template Selection

Use this reference when choosing a Yuhong template or source deck.

## Current Primary Use

The current primary use case is courseware and instructor-led training decks.

Future use cases may include editing existing decks, adapting courseware, case sharing, dealer diagnosis, and business review pages. Keep the workflow extensible.

## Template Roles

| Template ID | Source file | Best for | Role |
|---|---|---|---|
| `yuhong-template` | `assets/reference-decks/yuhong-template.pptx` | Generic Yuhong visual base | default visual base |
| `channel-intensive-cultivation` | `assets/reference-decks/channel-intensive-cultivation.pptx` | Channel intensive cultivation course | method deck |
| `product-battle` | `assets/reference-decks/product-battle.pptx` | Product battle / hot-product course | method deck |
| `retail-store-battle` | `assets/reference-decks/retail-store-battle.pptx` | Retail specialty store and worker/member battle | method deck |
| `home-decoration-channel` | `assets/reference-decks/home-decoration-channel.pptx` | Home-decoration channel course | method deck |
| `trader-to-service-provider-course` | `assets/reference-decks/trader-to-service-provider-course.pptx` | Trader-to-service-provider transformation course, bootcamp, co-creation workshop | large courseware reference |
| `rongyu-case` | `assets/reference-decks/rongyu-case.pptx` | Dealer case sharing | case style reference |
| `jiabeili-case` | `assets/reference-decks/jiabeili-case.pptx` | Dealer case sharing | case style reference |

## Selection Rules

- For general courseware, start from `yuhong-template`.
- For channel cultivation topics, prioritize `channel-intensive-cultivation`.
- For product battle or hot-product topics, prioritize `product-battle`.
- For retail specialty store or worker/member topics, prioritize `retail-store-battle`.
- For home-decoration channel topics, prioritize `home-decoration-channel`.
- For transformation bootcamps or service-provider transformation, prioritize `trader-to-service-provider-course`.
- For case sharing, prioritize `rongyu-case` or `jiabeili-case`.

## Actual Role Of `yuhong-template`

The current `yuhong-template.pptx` is a one-slide brand visual base, not a multi-page content-layout library. Its current package contains 1 slide, 7 media assets, 9 layouts, and 1 master.

Use it to preserve:

- Background artwork and page atmosphere.
- Master and layout inheritance.
- Embedded approved brand media.
- Logo or program-mark placement.
- Page-edge and whitespace language.

Do not claim that it supplies multiple comparison, model, worksheet, or case layouts. Those page compositions come from `assets/components/yuhong-county-course-components-branded.pptx` or the selected method deck, but the executable components must inherit this template's real master.

For the county opportunity course, the correct pairing is:

- `yuhong-template.pptx` = brand visual base.
- `yuhong-county-course-components-branded.pptx` = editable course component compositions rebased onto the actual Yuhong master.

If either asset cannot be opened, do not fall back to a red-and-white generic rebuild. Stop and report the missing asset.

## Route Restrictions

- Use PPTX import, slide duplication, inherited layouts, and native-object editing.
- Do not use HTML-to-slide bulk generation as the primary route for a template-bound build.
- Do not rebuild the template from color sampling, screenshots, or remembered visual style.
- Do not obtain a replacement logo from web search when an approved source PPTX is supplied.

## Guided Mode Output

Before building, output:

1. Course type.
2. Audience.
3. Selected source deck.
4. Course module outline.
5. Reusable components.
6. Missing examples, data, worksheets, or instructor notes.

Do not build immediately unless the user explicitly asks to Build.
