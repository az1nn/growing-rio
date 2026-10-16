#!/usr/bin/env python3
"""Check SIGA task ownership from a live GitHub PR snapshot, without writes."""
import argparse
import fnmatch
import json
import re
import sys

TASK = re.compile(r"^\s*SIGA-TASK-KEY:\s*(\S.*?)\s*$", re.I | re.M)
PATHS = re.compile(r"^\s*(?:Intended paths|SIGA-INTENDED-PATHS):\s*(.+)$", re.I | re.M)

def split_paths(s):
    chunks, buf, depth = [], "", 0
    for ch in s:
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
        if ch == "," and depth == 0:
            chunks.append(buf)
            buf = ""
        else:
            buf += ch
    chunks.append(buf)
    return [p for p in (x.strip().strip(chr(96)) for x in chunks) if "/" in p and " " not in p]

def expand(p):
    m = re.search(r"\{([^{}]+)\}", p)
    if not m:
        return [p]
    return [out for choice in m.group(1).split(",") for out in expand(p[:m.start()] + choice + p[m.end():])]

def overlap(a, b):
    for x in expand(a):
        for y in expand(b):
            if x == y or fnmatch.fnmatchcase(x, y) or fnmatch.fnmatchcase(y, x):
                return True
            xp, yp = re.split(r"[*?[]", x, 1)[0], re.split(r"[*?[]", y, 1)[0]
            if xp.startswith(yp) or yp.startswith(xp):
                return True
    return False

def parse(pr):
    body = pr.get("body") or ""
    task, paths = TASK.search(body), PATHS.search(body)
    return {
        "number": int(pr["number"]), "head": pr.get("head", {}).get("sha", ""),
        "created": pr.get("created_at") or "",
        "task": re.sub(r"\s+", "", task.group(1)).upper() if task else "",
        "paths": split_paths(paths.group(1)) if paths else [],
    }

def collides(a, b):
    if not a["task"] or not b["task"]:
        return False
    return a["task"] == b["task"] or any(
        overlap(x, y) for x in a["paths"] for y in b["paths"]
    )

def decide(prs, number, expected_head=""):
    items = [parse(p) for p in prs]
    current = next((p for p in items if p["number"] == number), None)
    if current is None:
        raise ValueError("current PR absent from live snapshot")
    result = {"pr": number, "decision": "PARALLEL_SAFE", "owner_pr": number,
              "task": current["task"], "head": current["head"], "overlaps": []}
    if expected_head and expected_head != current["head"]:
        result["decision"] = "BRANCH_LEASE_LOST"
    elif not current["task"]:
        result["decision"] = "UNCLAIMED_LEGACY"
    else:
        group = sorted((p for p in items if collides(current, p)),
                       key=lambda p: (p["created"], p["number"]))
        result["owner_pr"] = group[0]["number"]
        result["overlaps"] = [p["number"] for p in group if p["number"] != number]
        if len(group) > 1:
            result["decision"] = "OWNER" if result["owner_pr"] == number else "SUPERSEDED"
    return result

def main():
    cli = argparse.ArgumentParser()
    cli.add_argument("--snapshot", required=True)
    cli.add_argument("--pr", required=True, type=int)
    cli.add_argument("--expected-head", default="")
    args = cli.parse_args()
    try:
        with open(args.snapshot, encoding="utf-8") as f:
            data = json.load(f)
        if not isinstance(data, list):
            raise ValueError("invalid PR snapshot")
        pages = [p for group in data for p in group] if data and isinstance(data[0], list) else data
        result = decide(pages, args.pr, args.expected_head)
    except (ValueError, OSError, KeyError, TypeError) as exc:
        print(json.dumps({"decision": "GITHUB_STATE_UNAVAILABLE", "error": str(exc)}))
        return 2
    print(json.dumps(result, sort_keys=True))
    return {"SUPERSEDED": 3, "BRANCH_LEASE_LOST": 4}.get(result["decision"], 0)

if __name__ == "__main__":
    sys.exit(main())
