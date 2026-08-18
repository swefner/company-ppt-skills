# describe-image 插件补丁说明（2026-08-18）

> 留档目的：describe-image（图像理解）工具的本地修复过程与补丁内容，防止未来重复排查。像 `server.mjs` 崩溃修复一样留档。
> 涉及文件（**用户环境，不在本仓库**）：
> `%USERPROFILE%\.dsh\profiles\web\node_modules\@linxin666\dsh-tool-describe-image\lib\types\vision-client.js`

---

## 一、现象与诊断过程

| 阶段 | 现象 | 诊断 |
|---|---|---|
| 1 | `describe_image` 报 `baseURL must be an absolute http(s) URL` | 插件端点未配置 |
| 2 | 配置端点后报 `vision endpoint returned HTTP 404` | 接口地址配成裸域 `https://cloud.dataeyes.ai`，插件按协议拼出 `/chat/completions` → 404 |
| 3 | 端点实测 | `…/chat/completions` → 404；`…/v1/chat/completions` → **401**（端点存在）；`…/v1/responses` → 401（存在）；`…/v1/models` → 404（不支持 models 列表，正常） |
| 4 | 修复：接口地址改为 `https://cloud.dataeyes.ai/v1`，配置有效密钥 | 请求通过（200），但报 `vision endpoint returned no text content` |
| 5 | 读插件源码定位 | `extractChatCompletionsContent()` 只接受 `choices[0].message.content` 为**非空字符串**；而请求体用的是多模态数组（`[{type:'text'},{type:'image_url'}]`），部分 OpenAI 兼容网关会**把 content 以数组形式回传** → 插件判为非字符串 → 报错。属插件兼容性 bug |

## 二、补丁内容

**文件**：`%USERPROFILE%\.dsh\profiles\web\node_modules\@linxin666\dsh-tool-describe-image\lib\types\vision-client.js`
**函数**：`extractChatCompletionsContent(payload)`

改动：content 解析增加数组分支——`content` 为字符串时维持原逻辑；为数组时拼接其中 `type === 'text'` 且非空的 `text` 块；两者皆空才抛 `no text content`。

```js
if (typeof content === 'string') {
    if (content.trim().length === 0) throw new Error('...no text content');
    return content;
}
if (Array.isArray(content)) {
    const texts = [];
    for (const block of content) {
        const b = asRecord(block);
        if (b !== undefined && b.type === 'text' && typeof b.text === 'string' && b.text.trim().length > 0) {
            texts.push(b.text);
        }
    }
    if (texts.length > 0) return texts.join('\n');
}
throw new Error('...no text content');
```

## 三、当前状态与待验证

- ✅ 端点路径修复（`/v1`）已生效（404 → 200）
- ✅ 密钥已生效（不再 401）
- ⚠️ **补丁已写入文件但尚未生效**：DSH 主进程内存中的插件代码需**重启 DSH** 才加载
- 重启后仍报 `no text content` 时的排查顺序：
  1. 面板「接口协议」Chat Completions → **Responses**（插件支持 `/v1/responses`，走 `output_text` 解析，路径已实测存在）；
  2. 换模型 id（如 `gpt-4o`）再试；
  3. 在插件内临时加"响应体转储到临时文件"日志，复现一次拿到网关真实返回结构。

## 四、维护与风险

- **升级会被覆盖**：该文件位于 `~/.dsh/profiles/web/node_modules`（本地插件安装），插件升级/重装后补丁失效，需按本文重新打；
- **恢复**：删除数组分支即恢复原行为（`git` 不跟踪该目录，改动前建议备份该文件）；
- **密钥**：接口密钥经 DSH 面板「图像理解」配置或环境变量 `VISION_API_KEY` 提供；不写入本仓库。
