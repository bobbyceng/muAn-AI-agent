"""审查员 Agent：独立检查改写后的 YAML 是否违反 10 条硬约束。"""

from __future__ import annotations

import json
import re
from pathlib import Path

from openai import OpenAI

ROOT = Path(__file__).resolve().parent.parent
REVIEWER_PROMPT_PATH = ROOT / "prompts" / "reviewer.md"


def _strip_code_fence(text: str) -> str:
    text = text.strip()
    if text.startswith("```"):
        text = re.sub(r"^```(?:json)?\s*", "", text)
        text = re.sub(r"\s*```$", "", text)
    return text


def check(
    rewritten_yaml: str,
    profile: str,
    client: OpenAI,
    settings: dict,
) -> dict:
    template = REVIEWER_PROMPT_PATH.read_text(encoding="utf-8")
    prompt = template.format(profile=profile, rewritten_yaml=rewritten_yaml)
    resp = client.chat.completions.create(
        model=settings["model"],
        max_tokens=settings["max_tokens"],
        messages=[{"role": "user", "content": prompt}],
    )
    raw = _strip_code_fence(resp.choices[0].message.content)
    return json.loads(raw)
