#!/usr/bin/env python3
"""
PostToolUse Hook: 监控 memory 和 CLAUDE.md 的写入操作，追加日志到 changelog/memory_log.txt
触发条件：Write 工具写入 memory/ 目录或 CLAUDE.md 时
"""
import sys
import json
import datetime

data = json.load(sys.stdin)
fp = data.get('tool_input', {}).get('file_path', '')

if fp and ('memory' in fp or 'CLAUDE.md' in fp):
    log_path = '/Volumes/T7 Shield/AI-workspace/木安-AI分身/changelog/memory_log.txt'
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M')
    with open(log_path, 'a', encoding='utf-8') as f:
        f.write(f'[{timestamp}] {fp}\n')
