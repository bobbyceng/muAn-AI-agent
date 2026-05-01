# JD Tailor

输入 JD 文本，自动输出针对性改写的简历 PDF。

**流水线：** 硬过滤 → LLM 评分 → Multi-Agent 改写+审查循环 → rendercv 渲染 PDF

## 架构（Phase 2）

```
JD 输入
  ↓
① 规则硬过滤（城市 / 岗位黑白名单 / 薪资 / 年限）
  ↓
② 评分员 Agent — LLM 四维打分，输出 tailor_focus
  ↓ （低于阈值则跳过）
③ Orchestrator 循环（最多 3 轮）
   改写员 Agent → 生成改写后 YAML
   审查员 Agent → 独立校验 10 条合规约束
   通过 → 落盘；不通过 → 反馈改写员重写
  ↓
④ rendercv 渲染 PDF + agent_log.json 落盘
```

**关键设计：** 审查员与改写员完全解耦（独立裁判），只看产物、不知思路，防止约束漂移。

## 安装

```bash
cd jd-tailor
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

安装并配置 [rendercv](https://docs.rendercv.com)，更新 `config/settings.json` 中的 `rendercv_bin` 路径。

## 配置

复制并填写个人信息：

```bash
cp config/profile.md.example config/profile.md   # 填写个人背景与禁止清单
```

设置 API key（默认使用 DeepSeek，兼容 OpenAI SDK）：

```bash
export DEEPSEEK_API_KEY=sk-xxx
```

如需切换模型，修改 `config/settings.json` 中的 `model` 和 `api_base_url`。

## 使用

```bash
# 文件输入
.venv/bin/python3 main.py path/to/jd.txt

# 标准输入（粘贴 JD，Ctrl+D 结束）
.venv/bin/python3 main.py
```

## 输出

`output/{公司名}_{岗位}_{时间戳}/`

| 文件 | 内容 |
|------|------|
| `jd.txt` | 原始 JD |
| `score.json` | 评分结果（维度分 + match/gap 分析） |
| `曾祥桉-{岗位}.yaml` | 改写后简历 YAML |
| `agent_log.json` | 每轮改写 + 审查日志（status / rounds / violations） |
| `rendercv_output/*.pdf` | 最终 PDF |

## 退出码

| 码 | 含义 |
|----|------|
| 0 | 成功 |
| 2 | JD 过短（< 100 字）|
| 3 | 硬过滤未通过 |
| 4 | 评分低于阈值 |
| 5 | YAML 校验失败（已落盘待排查）|
| 6 | rendercv 渲染失败 |

## 调参

`config/settings.json`：

- `score_threshold`：评分阈值（默认 55，建议跑 10-20 条 JD 后校准）
- `hard_filter`：城市 / 岗位黑白名单 / 薪资下限 / 年限上限
- `model` / `api_base_url`：切换 LLM 后端
