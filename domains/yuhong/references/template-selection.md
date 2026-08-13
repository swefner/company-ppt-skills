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

## Guided Mode Output

Before building, output:

1. Course type.
2. Audience.
3. Selected source deck.
4. Course module outline.
5. Reusable components.
6. Missing examples, data, worksheets, or instructor notes.

Do not build immediately unless the user explicitly asks to Build.
