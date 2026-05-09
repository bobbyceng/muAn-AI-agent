# Phase 3 设计：改写摘要 + 飞书 Bot 接入

## 目标

把 JD Tailor 从「本地 CLI 脚本」升级为「可在飞书里使用的 AI 产品」：
- 用户在飞书发送 JD 文本，Bot 自动跑完 pipeline，回复改写摘要 + 合规结果
- 支持从 OpenClaw 复制 JD 直接粘贴触发

---

## Phase 3A：改写摘要 Agent（飞书 Bot 前置条件）

### 问题

当前 pipeline 输出只有 YAML 和 PDF，在飞书里无法展示文件。
飞书 Bot 回复必须是文本，需要一个 Agent 把结果转成可读摘要。

### 新增：Summarizer Agent

**输入**：原始 master YAML + 改写后 YAML + agent_log（含审查轮次和违规点）

**输出**（纯文本，直接用于飞书回复）：
```
📋 JD 匹配评分：72/100
🎯 岗位：AI 产品经理（ToB 方向）- 深圳某 AI 科技公司

改写摘要：
• 个人总结：加入"Agent 工作流设计"，匹配 JD 核心要求
• 工作经历 bullet 2：数据指标强化，"提升效率"→"缩短 40% 处理时长"
• 删除：Coach Titan 技术细节（不匹配岗位方向）

✅ 合规审查：通过（第 1 轮，0 项违规）
📄 简历已生成：曾祥桉-AI产品经理.pdf
```

### 目录结构变化

```
jd-tailor/
├── agents/
│   ├── summarizer.py     # NEW：改写摘要 Agent
│   └── ...（原有不变）
├── prompts/
│   ├── summarizer.md     # NEW：摘要 prompt template
│   └── ...（原有不变）
└── output/{case}/
    ├── summary.txt       # NEW：摘要文本（供飞书 Bot 直接使用）
    └── ...（原有不变）
```

### main.py 改动

在渲染 PDF 之后，调用 summarizer 生成摘要，落盘为 `summary.txt`：

```
原流程末尾：
→ rendercv 渲染 PDF

新流程末尾：
→ rendercv 渲染 PDF
→ summarizer.generate(original_yaml, new_yaml, agent_log, score) → summary.txt
→ 打印摘要到 stdout（CLI 可见）
```

### 工时预估：2-3 小时（手机/Termius 可完成）

---

## Phase 3B：飞书 Bot 接入（需电脑）

### 整体流程

```
用户在飞书发送 JD 文本（从 OpenClaw 或任意来源复制）
    ↓
飞书 Bot (Webhook) 接收消息
    ↓
触发 JD Tailor pipeline（hardfilter → score → orchestrator → summarizer）
    ↓
飞书 Bot 回复：改写摘要文本 + PDF 附件
```

### 技术方案

- **飞书 Bot**：飞书开放平台，自建应用，订阅「接收消息」事件
- **Webhook Server**：FastAPI（轻量，已在 requirements 可加）
- **触发方式**：Bot 收到私信或群消息 → 判断是否为 JD（字数 > 100）→ 触发 pipeline
- **PDF 回复**：飞书 Bot 支持上传文件，pipeline 完成后上传 PDF 并发送

### 目录结构变化

```
jd-tailor/
├── bot/
│   ├── feishu_bot.py     # NEW：飞书 Bot webhook server
│   └── config.py         # NEW：飞书 App ID / Secret 等配置
├── .env.example          # NEW：环境变量模板
└── ...（原有不变）
```

### 飞书 OpenClaw 联动

OpenClaw 目前无公开 API，采用「手动复制」方案：
- Bot 说明文字：「直接粘贴 JD 文本即可，支持从 OpenClaw 复制」
- 面试讲法：「目前通过文本输入，OpenClaw API 接入在规划中」

### 工时预估：1-2 天（需电脑，需飞书开放平台注册）

---

## 实现顺序

| 阶段 | 内容 | 环境 | 工时 |
|------|------|------|------|
| 3A | Summarizer Agent | 手机可做 | 2-3h |
| 3B | 飞书 Bot + FastAPI | 需电脑 | 1-2天 |
| 3C | OpenClaw API 接入 | 视 API 开放情况 | 待定 |

---

## 简历描述（目标版本）

> 设计并实现 AI 驱动的简历定制系统：输入任意 JD 文本，经多 Agent 评分、改写、审查循环，自动输出针对性简历 PDF；集成飞书 Bot，支持对话式触发，从 JD 输入到 PDF 回复全流程自动化。

---

## 成功指标

| 指标 | 当前 | Phase 3 目标 |
|------|------|-------------|
| 使用门槛 | 需 CLI + 本地环境 | 飞书发消息即可触发 |
| 结果可读性 | 只有 PDF/YAML | 文字摘要 + PDF |
| 演示便利性 | 需要切换终端 | 飞书窗口内完成 |
| OpenClaw 联动 | 无 | 支持复制 JD 直接触发 |
