"""改写员 Agent：根据 JD + (可选) 审查反馈生成改写后的 YAML。"""

from __future__ import annotations

import json
import re
from pathlib import Path

from openai import OpenAI

ROOT = Path(__file__).resolve().parent.parent
REWRITER_PROMPT_PATH = ROOT / "prompts" / "rewriter.md"


def _strip_code_fence(text: str) -> str:
    text = text.strip()
    if text.startswith("```"):
        text = re.sub(r"^```(?:yaml)?\s*", "", text)
        text = re.sub(r"\s*```$", "", text)
    return text


def _format_feedback(violations: list[dict] | None) -> str:
    if not violations:
        return "null"
    return json.dumps(violations, ensure_ascii=False, indent=2)


def generate(
    jd_text: str,
    profile: str,
    master_yaml: str,
    tailor_focus: list[str],
    client: OpenAI,
    settings: dict,
    reviewer_feedback: list[dict] | None = None,
) -> str:
    template = REWRITER_PROMPT_PATH.read_text(encoding="utf-8")
    prompt = template.format(
        profile=profile,
        jd_text=jd_text,
        tailor_focus=", ".join(tailor_focus),
        master_yaml=master_yaml,
        reviewer_feedback=_format_feedback(reviewer_feedback),
    )
    resp = client.chat.completions.create(
        model=settings["model"],
        max_tokens=settings["max_tokens"],
        messages=[{"role": "user", "content": prompt}],
    )
    return _strip_code_fence(resp.choices[0].message.content)
