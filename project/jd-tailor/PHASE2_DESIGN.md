# Phase 2 设计:Multi-agent 改写流水线

## 目标

把现在的"单次改写"升级为三角色循环:
1. **改写员 Agent**:看 JD + Profile,输出改写后的 YAML
2. **审查员 Agent**(独立推理):对照 profile.md 的 10 条边界 check 改写产物
3. **决策循环**:审查通过 → 落盘;不通过 → 反馈给改写员重写(最多 3 轮)

## 目录结构变化

```
jd-tailor/
├── agents/
│   ├── __init__.py
│   ├── rewriter.py      # 改写员 Agent(包含 prompt)
│   ├── reviewer.py      # 审查员 Agent(包含 prompt)
│   └── orchestrator.py  # 循环控制(改写 → 审查 → 决策)
├── config/
│   ├── profile.md       # 不变
│   └── settings.json    # 不变
├── prompts/
│   ├── scorer.md        # 不变(v1 的硬评分)
│   ├── rewriter.md      # 改为"一次改写"的 prompt template
│   └── reviewer.md      # NEW:审查员 prompt template
├── main.py              # 改为调用 orchestrator 而非直接改写
├── requirements.txt     # 不变
└── output/
    └── {case}/
        ├── jd.txt
        ├── score.json
        ├── agent_log.json  # NEW:三角色交互日志
        └── 曾祥桉-{job}.yaml
```

## 核心改动

### 1. main.py 改动

**原流程**:
```
JD → 硬过滤 → 评分 → (如果过阈值) → 单次改写 → 渲染 PDF
```

**新流程**:
```
JD → 硬过滤 → 评分 → (如果过阈值) → orchestrator.run() 
  ├─ 改写员生成 v1
  ├─ 审查员检查 v1 → [通过 | 不通过 + 违规点]
  ├─ (不通过 & 轮次 < 3) → 反馈改写员重写 v2
  ├─ 循环直到通过或达 3 轮上限
  └─ 落盘最后版本 + agent_log.json
→ 渲染 PDF
```

### 2. 改写员 Prompt 变化

**v1 (现在)**:
- 输入:JD + profile.md + tailor_focus + 原始 YAML
- 输出:改写后的 YAML
- **约束**:单次改写,包含 10 条边界 check

**v2 (Phase 2)**:
- 输入:JD + profile.md + tailor_focus + 原始 YAML + [可选] 审查员反馈
- 输出:改写后的 YAML
- **约束**:同上,但如果收到审查员反馈,**必须按反馈修复**

改写员 prompt 不再包含边界 check(那是审查员的职责)。改写员只关心"对齐 JD"。

### 3. NEW:审查员 Prompt

```
你是一名资深简历安全审查专家。
输入:改写后的 YAML + profile.md(含 10 条边界清单)
任务:逐一检查 YAML 是否违反 10 条约束。

输出 JSON:
{
  "passed": true/false,
  "violations": [
    {
      "check_id": 1,
      "check_name": "没有声称会编程(除vibe coding外)",
      "violated": true,
      "evidence": "在个人总结中发现'用Python独立编写'",
      "fix_suggestion": "改为'用AI Coding工具辅助实现'"
    },
    ...
  ],
  "summary": "共X项违反，建议..."
}
```

**关键**:审查员是"独立裁判",不知道改写员的思路,只看结果。

### 4. Orchestrator(循环控制)

伪代码:
```python
def run(jd_text, profile, master_yaml, tailor_focus):
    agent_log = {"rounds": []}
    
    for round_num in range(1, 4):  # 最多3轮
        # 1. 改写员
        if round_num == 1:
            rewrite_input = {jd, profile, tailor_focus, master_yaml}
        else:
            # 第2、3轮:加入审查员反馈
            rewrite_input = {..., reviewer_feedback: violations}
        
        yaml_v = rewriter.generate(rewrite_input)
        agent_log["rounds"].append({"round": round_num, "rewrite": yaml_v})
        
        # 2. 审查员
        review_result = reviewer.check(yaml_v, profile)
        agent_log["rounds"][-1]["review"] = review_result
        
        if review_result["passed"]:
            agent_log["final_yaml"] = yaml_v
            agent_log["final_round"] = round_num
            agent_log["status"] = "APPROVED"
            return yaml_v, agent_log
        
        # 不通过 & 还有轮次 → 继续
    
    # 3 轮后仍未通过 → 落盘最后一版
    agent_log["status"] = "TIMEOUT"  # 超时,没通过审查但已输出
    return yaml_v, agent_log
```

## 成功指标

| 指标 | v1 预期 | Phase 2 目标 |
|---|---|---|
| **合规率**(10 条 check 全过) | ~70% | 95%+ |
| **循环次数平均** | 1 | < 2 |
| **单次改写耗时** | ~30s | ~45s(多一个审查) |
| **用户感知** | 改写后的 PDF 有时违反边界 | 保证输出 PDF 合规 |

## 实现计划(工时预估)

1. **Rewriter Agent 重写**(1 天)
   - 改 prompts/rewriter.md(去掉边界 check,加反馈处理)
   - 写 agents/rewriter.py(prompt 模板 + LLM 调用)

2. **Reviewer Agent 从零写**(0.5 天)
   - 写 prompts/reviewer.md
   - 写 agents/reviewer.py(check 逻辑)

3. **Orchestrator 循环**(0.5 天)
   - 写 agents/orchestrator.py
   - main.py 改调用点

4. **测试 + 调试**(1 天)
   - 10 个测试 case:通过 / 1 轮 / 2 轮 / 超时
   - 调试 prompt 边界(审查员不能太严或太松)

**总计:3 天**

## 风险 & 缓解

| 风险 | 缓解 |
|---|---|
| 审查员永远拒(prompt 写得太严) | 先松后严,跑几个 case 校准 |
| 改写员无视反馈(陷入死循环) | 改写员 prompt 明确"必须修复" |
| token 消耗翻倍 | 实际只多一个审查(原有评分 + 改写 + 新审查) |
| 改写员和审查员不一致 | 这是特性,不是 bug(独立审裁) |

## 下一步

等你看完这份设计,确认思路,我就开始:
1. 写 agents/ 目录的三个文件(rewriter, reviewer, orchestrator)
2. 改 main.py 调用 orchestrator
3. 跑几个 case 验证

有问题或不同意见,现在说。
