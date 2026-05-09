"""摘要 Agent：对比原始/改写 YAML，输出可读的飞书摘要文本。"""

from __future__ import annotations

import json
from pathlib import Path

from openai import OpenAI

ROOT = Path(__file__).resolve().parent.parent
SUMMARIZER_PROMPT_PATH = ROOT / "prompts" / "summarizer.md"


def _format_violation_history(agent_log: dict) -> str:
    rounds = agent_log.get("rounds", [])
    if not rounds:
        return "无"
    lines = []
    for r in rounds:
        review = r.get("review", {})
        n = len(review.get("violations", []))
        passed = review.get("passed")
        lines.append(
            f"第{r.get('round')}轮：{'通过' if passed else f'未通过（{n} 项违规）'}"
        )
    return "；".join(lines)


def generate(
    score_result: dict,
    master_yaml: str,
    new_yaml: str,
    agent_log: dict,
    client: OpenAI,
    settings: dict,
) -> str:
    template = SUMMARIZER_PROMPT_PATH.read_text(encoding="utf-8")
    prompt = template.format(
        job_title=score_result.get("job_title", "未知"),
        company_name=score_result.get("company_name", "未知"),
        total_score=score_result.get("total_score", 0),
        verdict=score_result.get("verdict", ""),
        tailor_focus=", ".join(score_result.get("tailor_focus", [])) or "无",
        master_yaml=master_yaml,
        new_yaml=new_yaml,
        review_status=agent_log.get("status", "UNKNOWN"),
        final_round=agent_log.get("final_round", 0),
        violation_history=_format_violation_history(agent_log),
    )
    resp = client.chat.completions.create(
        model=settings["model"],
        max_tokens=settings["max_tokens"],
        messages=[{"role": "user", "content": prompt}],
    )
    return resp.choices[0].message.content.strip()
