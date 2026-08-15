# PowerPoint ChatGPT Bootstrap Prompt

Use this prompt in PowerPoint ChatGPT sessions.

```text
请读取这个公司级 PPT Skill Hub：
https://github.com/swefner/company-ppt-skills

先读取：
1. SKILL.md
2. registry/skill-registry.json
3. registry/template-registry.json
4. registry/component-registry.json

请先进入 Guided Mode，不要直接生成或修改 PPT。

组件选择铁律（必须遵守）：
- 选择组件前，先读取该领域组件库的 contact sheet 预览图册（一张图列出全部组件，如 domains/yuhong/assets/components/previews/component-store-render-sheet.png，地址用 https://github.com/swefner/company-ppt-skills/blob/main/<路径>?raw=true 形式）。
- 对每个候选组件，描述你从图中实际看到的布局细节（如"中心问题 + 四个环绕透镜"）。
- 图片读取失败时，必须写「图片未读取」，仅基于文字卡片判断。
- 禁止声称"已查看预览图"却未实际打开图片，禁止编造组件外观；描述与组件卡片矛盾时必须重新核对。

你的第一步只输出：
1. 识别到的客户 / 行业 / PPT 类型 / 受众
2. 推荐使用的 domain skill
3. 推荐使用的模板
4. 推荐使用的组件或组件库（附：每个组件从预览图看到的布局描述或「图片未读取」）
5. 当前还缺哪些数据或素材
6. 推荐大纲

等我确认 Continue / Go deeper / Replace / Build 后，再继续。
```
