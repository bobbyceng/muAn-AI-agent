#!/usr/bin/env python3
"""JD Tailor: 输入 JD 文本 → 硬过滤 → LLM 评分 → 满分则改写 YAML 并渲染 PDF。"""

import json
import os
import re
import subprocess
import sys
from datetime import datetime
from pathlib import Path

import yaml
from openai import OpenAI

from agents import orchestrator, summarizer

ROOT = Path(__file__).parent
CONFIG_PATH = ROOT / "config" / "settings.json"
PROFILE_PATH = ROOT / "config" / "profile.md"
SCORER_PROMPT_PATH = ROOT / "prompts" / "scorer.md"
OUTPUT_DIR = ROOT / "output"


def load_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def load_config() -> dict:
    return json.loads(load_text(CONFIG_PATH))


def _extract_job_title(jd_text: str) -> str:
    """提取 JD 的岗位名称行，用于黑白名单精确匹配。优先取【职位】行，fallback 取前 100 字。"""
    m = re.search(r'[【\[]?职位[】\]]?\s*[:：]?\s*(.+)', jd_text)
    if m:
        return m.group(1).strip().split('\n')[0]
    return jd_text[:100]


def hard_filter(jd_text: str, settings: dict) -> tuple[bool, str]:
    """规则硬过滤——失败直接拒，省 LLM 调用。"""
    f = settings["hard_filter"]
    text_lower = jd_text.lower()
    title_lower = _extract_job_title(jd_text).lower()

    # 城市
    if not any(loc in jd_text for loc in f["must_contain_location"]):
        return False, f"城市不匹配（要求包含：{f['must_contain_location']}）"

    # 岗位黑名单：只匹配岗位标题行，避免因 JD 正文描述业务而误杀
    for kw in f["job_title_blacklist"]:
        if kw.lower() in title_lower:
            return False, f"岗位黑名单命中：{kw}"

    # 公司黑名单：仍扫全文
    for kw in f["company_blacklist_keywords"]:
        if kw.lower() in text_lower:
            return False, f"公司黑名单命中：{kw}"

    # 岗位白名单：先匹配标题，标题未中则扫全文（兼容嵌入式岗位名）
    whitelist = f["job_title_whitelist"]
    title_hit = any(kw.lower() in title_lower for kw in whitelist)
    if not title_hit and not any(kw.lower() in text_lower for kw in whitelist):
        return False, "岗位白名单未命中（标题不属于目标岗位族）"

    # 工作年限：抓 "X 年以上 / X+ 年" 等模式
    year_patterns = [
        r"(\d+)\s*年(?:以上|及以上|\+)",
        r"(\d+)\s*\+\s*年",
        r"(\d+)\s*-\s*\d+\s*年",
    ]
    for pat in year_patterns:
        for m in re.finditer(pat, jd_text):
            yrs = int(m.group(1))
            if yrs > f["max_required_years"]:
                return False, f"工作年限要求 {yrs} 年 > 上限 {f['max_required_years']} 年"

    # 薪资：抓 "Xk-Yk" 或 "X-Yk" 模式，取下限
    salary_match = re.search(r"(\d+)\s*[-~]\s*(\d+)\s*[kK]", jd_text)
    if salary_match:
        low = int(salary_match.group(1))
        if low < f["min_salary_k"]:
            return False, f"薪资下限 {low}k < 最低 {f['min_salary_k']}k"

    return True, "通过硬过滤"


def call_llm(client: OpenAI, model: str, max_tokens: int, prompt: str) -> str:
    resp = client.chat.completions.create(
        model=model,
        max_tokens=max_tokens,
        messages=[{"role": "user", "content": prompt}],
    )
    return resp.choices[0].message.content


def score_jd(jd_text: str, profile: str, client: OpenAI, settings: dict) -> dict:
    template = load_text(SCORER_PROMPT_PATH)
    prompt = template.format(profile=profile, jd_text=jd_text)
    raw = call_llm(client, settings["model"], settings["max_tokens"], prompt)
    # 容错：剥掉可能的 markdown 代码块
    raw = raw.strip()
    if raw.startswith("```"):
        raw = re.sub(r"^```(?:json)?\s*", "", raw)
        raw = re.sub(r"\s*```$", "", raw)
    return json.loads(raw)


def validate_yaml(yaml_str: str) -> tuple[bool, str]:
    try:
        data = yaml.safe_load(yaml_str)
        if not isinstance(data, dict) or "cv" not in data:
            return False, "YAML 缺少 cv 字段"
        if "design" not in data:
            return False, "YAML 缺少 design 字段"
        return True, "ok"
    except yaml.YAMLError as e:
        return False, f"YAML 解析失败：{e}"


def render_pdf(yaml_path: Path, settings: dict) -> Path:
    out_dir = yaml_path.parent
    cmd = [
        settings["rendercv_bin"],
        "render",
        str(yaml_path),
        "--output-folder",
        str(out_dir / "rendercv_output"),
    ]
    subprocess.run(cmd, check=True, cwd=out_dir)
    pdfs = list((out_dir / "rendercv_output").glob("*.pdf"))
    if not pdfs:
        raise RuntimeError("rendercv 未生成 PDF")
    return pdfs[0]


def safe_filename(name: str) -> str:
    return re.sub(r'[<>:"/\\|?*\s]+', "_", name).strip("_")[:40] or "unknown"


def main():
    if len(sys.argv) > 1:
        jd_text = Path(sys.argv[1]).read_text(encoding="utf-8")
    else:
        print("粘贴 JD 文本，结束后按 Ctrl+D（macOS/Linux）：", file=sys.stderr)
        jd_text = sys.stdin.read()

    if len(jd_text.strip()) < 100:
        print("[SKIP] JD 文本过短（< 100 字），跳过。", file=sys.stderr)
        sys.exit(2)

    settings = load_config()
    profile = load_text(PROFILE_PATH)
    master_yaml = load_text(Path(settings["master_resume_path"]))

    # 1. 硬过滤
    passed, reason = hard_filter(jd_text, settings)
    print(f"[硬过滤] {reason}", file=sys.stderr)
    if not passed:
        sys.exit(3)

    # 2. LLM 评分
    key_env = settings.get("api_key_env", "DEEPSEEK_API_KEY")
    api_key = os.environ.get(key_env)
    if not api_key:
        print(f"[ERROR] 未设置 {key_env}", file=sys.stderr)
        sys.exit(1)
    client = OpenAI(
        api_key=api_key,
        base_url=settings.get("api_base_url", "https://api.deepseek.com"),
    )

    print("[评分] 调用 Claude...", file=sys.stderr)
    score_result = score_jd(jd_text, profile, client, settings)
    print(json.dumps(score_result, ensure_ascii=False, indent=2), file=sys.stderr)

    threshold = settings["score_threshold"]
    if score_result["total_score"] < threshold:
        print(
            f"[SKIP] 总分 {score_result['total_score']} < 阈值 {threshold}，"
            f"verdict={score_result['verdict']}",
            file=sys.stderr,
        )
        sys.exit(4)

    # 3. 改写循环（改写员 ↔ 审查员，最多 3 轮）
    print("[改写] 启动 multi-agent 流水线...", file=sys.stderr)
    new_yaml, agent_log = orchestrator.run(
        jd_text=jd_text,
        profile=profile,
        master_yaml=master_yaml,
        tailor_focus=score_result.get("tailor_focus", []),
        client=client,
        settings=settings,
    )
    print(
        f"[改写] 完成：status={agent_log['status']}, rounds={agent_log['final_round']}",
        file=sys.stderr,
    )

    # 强制将 headline 对齐 JD 目标岗位（改写员可能未同步更新 headline 字段）
    job_title_display = score_result.get("job_title", "")
    if job_title_display:
        new_yaml = re.sub(
            r"^(\s*headline:\s*).*$",
            lambda m: m.group(1) + job_title_display,
            new_yaml,
            count=1,
            flags=re.MULTILINE,
        )

    ok, msg = validate_yaml(new_yaml)
    if not ok:
        print(f"[ERROR] 改写后 YAML 校验失败：{msg}", file=sys.stderr)
        # 仍然存盘以便人工排查
    company = safe_filename(score_result.get("company_name", "unknown"))
    job_title = safe_filename(score_result.get("job_title", "unknown"))
    date_tag = datetime.now().strftime("%Y%m%d_%H%M")
    case_dir = OUTPUT_DIR / f"{company}_{job_title}_{date_tag}"
    case_dir.mkdir(parents=True, exist_ok=True)

    yaml_path = case_dir / f"曾祥桉-{job_title}.yaml"
    yaml_path.write_text(new_yaml, encoding="utf-8")
    (case_dir / "jd.txt").write_text(jd_text, encoding="utf-8")
    (case_dir / "score.json").write_text(
        json.dumps(score_result, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    (case_dir / "agent_log.json").write_text(
        json.dumps(agent_log, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print(f"[YAML] {yaml_path}", file=sys.stderr)
    print(f"[LOG ] {case_dir / 'agent_log.json'}", file=sys.stderr)

    if not ok:
        sys.exit(5)

    # 4. 渲染 PDF
    print("[渲染] 调用 rendercv...", file=sys.stderr)
    try:
        pdf_path = render_pdf(yaml_path, settings)
        print(f"[PDF] {pdf_path}")
    except subprocess.CalledProcessError as e:
        print(f"[ERROR] rendercv 渲染失败：{e}", file=sys.stderr)
        sys.exit(6)

    # 5. 改写摘要（供飞书 Bot 直接使用）
    print("[摘要] 生成改写摘要...", file=sys.stderr)
    try:
        summary = summarizer.generate(
            score_result=score_result,
            master_yaml=master_yaml,
            new_yaml=new_yaml,
            agent_log=agent_log,
            client=client,
            settings=settings,
        )
        summary_path = case_dir / "summary.txt"
        summary_path.write_text(summary, encoding="utf-8")
        print(f"[SUMMARY] {summary_path}", file=sys.stderr)
        print("\n" + "=" * 60)
        print(summary)
        print("=" * 60)
    except Exception as e:
        print(f"[WARN] 摘要生成失败（不阻塞主流程）：{e}", file=sys.stderr)


if __name__ == "__main__":
    main()
