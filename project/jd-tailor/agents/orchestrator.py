"""Orchestrator：循环控制改写员 ↔ 审查员，最多 3 轮。"""

from __future__ import annotations

import sys

from anthropic import Anthropic

from . import rewriter, reviewer

MAX_ROUNDS = 3


def run(
    jd_text: str,
    profile: str,
    master_yaml: str,
    tailor_focus: list[str],
    client: Anthropic,
    settings: dict,
) -> tuple[str, dict]:
    """返回 (最终 YAML, agent_log)。"""
    agent_log: dict = {"rounds": [], "status": None, "final_round": None}
    feedback: list[dict] | None = None
    yaml_v = ""

    for round_num in range(1, MAX_ROUNDS + 1):
        print(f"[orchestrator] 第 {round_num} 轮 - 改写...", file=sys.stderr)
        yaml_v = rewriter.generate(
            jd_text=jd_text,
            profile=profile,
            master_yaml=master_yaml,
            tailor_focus=tailor_focus,
            client=client,
            settings=settings,
            reviewer_feedback=feedback,
        )

        print(f"[orchestrator] 第 {round_num} 轮 - 审查...", file=sys.stderr)
        review = reviewer.check(yaml_v, profile, client, settings)

        agent_log["rounds"].append(
            {
                "round": round_num,
                "rewrite": yaml_v,
                "review": review,
            }
        )

        if review.get("passed"):
            agent_log["status"] = "APPROVED"
            agent_log["final_round"] = round_num
            print(f"[orchestrator] 第 {round_num} 轮通过审查。", file=sys.stderr)
            return yaml_v, agent_log

        feedback = review.get("violations", [])
        n = len(feedback) if feedback else 0
        print(
            f"[orchestrator] 第 {round_num} 轮未通过，{n} 项违规，进入下一轮。",
            file=sys.stderr,
        )

    agent_log["status"] = "TIMEOUT"
    agent_log["final_round"] = MAX_ROUNDS
    print(
        f"[orchestrator] {MAX_ROUNDS} 轮后仍未通过审查，落盘最后一版。",
        file=sys.stderr,
    )
    return yaml_v, agent_log
