#!/usr/bin/env python3
"""Append one validated LENTE artifact to the dedicated, never-merged history branch.

Called ONLY by privileged workflow_run or explicit trusted workflow_dispatch. The
script itself comes from master, never from the artifact-producing PR.
"""
import argparse
import json
import os
import re
import shutil
import subprocess
from pathlib import Path

HISTORY_BRANCH = "lente-history"
RUN_RE = re.compile(r"^\d{8}T\d{6}Z-[a-f0-9]{12}-r\d+-a\d+$")
ALLOWED = {"pages", "scenes", "videos", "objects"}
ALLOWED_FILES = {"inventory.json", "capture-metadata.json", "browser-console-errors.txt",
                 "metrics.json", "CAVEMAN.md", "MODEL_REVIEW_PROMPT.md"}
ALLOWED_TYPES = {".png", ".webm"}

def git(*args, directory, check=True):
    return subprocess.run(["git", "-C", str(directory), *args],
                          text=True, capture_output=True, check=check)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--download-dir", required=True, type=Path)
    ap.add_argument("--expected-sha", required=True)
    ap.add_argument("--run-id", required=True)
    ap.add_argument("--attempt", required=True)
    args = ap.parse_args()

    if os.environ.get("GITHUB_REPOSITORY") != "az1nn/growing-rio":
        raise SystemExit("repository identity mismatch: refusing history write")
    if not re.fullmatch(r"[a-f0-9]{40}", args.expected_sha):
        raise SystemExit("invalid exact source head")
    if not args.run_id.isdecimal() or not args.attempt.isdecimal():
        raise SystemExit("invalid run identity")

    candidates = [p for p in args.download_dir.iterdir()
                  if p.is_dir() and RUN_RE.fullmatch(p.name)
                  and p.name.endswith(f"-r{args.run_id}-a{args.attempt}")
                  and f"-{args.expected_sha[:12]}-" in p.name]
    if len(candidates) != 1:
        raise SystemExit(f"expected one versioned run folder; found {candidates}")
    src = candidates[0]
    meta_path = src / "capture-metadata.json"
    if not meta_path.is_file() or not (src/"CAVEMAN.md").is_file() \
            or not (src/"metrics.json").is_file() or not (src/"MODEL_REVIEW_PROMPT.md").is_file():
        raise SystemExit("artifact lacks mandatory CAVEMAN/history metadata")
    meta = json.loads(meta_path.read_text(encoding="utf8"))
    metrics = json.loads((src/"metrics.json").read_text(encoding="utf8"))
    if (meta.get("commit") != args.expected_sha or str(meta.get("run_id")) != args.run_id
            or str(meta.get("run_attempt")) != args.attempt
            or meta.get("run_key") != src.name or metrics.get("run_key") != src.name):
        raise SystemExit("artifact provenance differs from verified workflow_run metadata")

    total = 0
    paths = list(src.rglob("*"))
    if len(paths) > 350:
        raise SystemExit("unreasonable artifact file count")
    for p in paths:
        if p.is_symlink():
            raise SystemExit("artifact contains a symlink")
        rel = p.relative_to(src)
        if rel.parts[0] not in ALLOWED and rel.as_posix() not in ALLOWED_FILES:
            raise SystemExit(f"unexpected artifact path: {rel}")
        if p.is_file():
            if rel.parts[0] in ALLOWED and p.suffix not in ALLOWED_TYPES:
                raise SystemExit(f"unexpected evidence file type: {rel}")
            total += p.stat().st_size
    if total > 80 * 1024 * 1024:
        raise SystemExit("archive exceeds 80 MiB safety cap")

    target = Path(os.environ.get("RUNNER_TEMP", "/tmp"))/"lente-history-working"
    if target.exists():
        shutil.rmtree(target)
    target.mkdir(parents=True)
    git("init", "-b", HISTORY_BRANCH, directory=target)
    git("remote", "add", "origin", os.environ["GITHUB_SERVER_URL"] + "/" +
        os.environ["GITHUB_REPOSITORY"] + ".git", directory=target)
    found = git("ls-remote", "--exit-code", "--heads", "origin", HISTORY_BRANCH,
                directory=target, check=False)
    if found.returncode == 0:
        git("fetch", "--depth=1", "origin", HISTORY_BRANCH, directory=target)
        git("checkout", "-B", HISTORY_BRANCH, "FETCH_HEAD", directory=target)
    elif found.returncode not in (2,):
        raise SystemExit(f"could not verify history branch: {found.stderr}")
    else:
        (target/"README.md").write_text(
            "# LENTE append-only visual history\n\n"
            "One immutable run directory per execution, including PNG, WebM, "
            "metadata, CAVEMAN.md, and a model-review prompt. This dedicated "
            "branch is NOT intended to merge into master: inspect its files "
            "directly or compare two run folders. Do not rewrite an old run.\n",
            encoding="utf8")

    dest = target/"runs"/src.name
    if dest.exists():
        old = json.loads((dest/"capture-metadata.json").read_text(encoding="utf8"))
        if old.get("commit") != args.expected_sha:
            raise SystemExit("same run key with different SHA: refusing overwrite")
        print("LENTE HISTORY: already archived, idempotent success:", src.name)
        return
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copytree(src, dest)
    rows = ["# LENTE run history", "",
            "Append-only evidence stored on the lente-history branch. "
            "Each report links to its own captures; source refs are commit-relative.", "",
            "| Run | Head | State | CAVEMAN |",
            "| --- | --- | --- | --- |"]
    for folder in sorted((target/"runs").iterdir(), reverse=True):
        m = json.loads((folder/"capture-metadata.json").read_text(encoding="utf8"))
        report = json.loads((folder/"metrics.json").read_text(encoding="utf8"))
        rows.append(f"| {folder.name} | {m['commit'][:12]} | "
                    f"{report['state']} | [ver análise](runs/{folder.name}/CAVEMAN.md) |")
    (target/"INDEX.md").write_text("\n".join(rows)+"\n", encoding="utf8")
    git("config", "user.name", "github-actions[bot]", directory=target)
    git("config", "user.email", "41898282+github-actions[bot]@users.noreply.github.com",
        directory=target)
    git("add", "runs", "INDEX.md", "README.md", directory=target,
        check=False)  # README exists only for the first run.
    git("add", "-A", directory=target)
    git("commit", "-m", f"archive(lente): {src.name}", directory=target)
    result = git("push", "origin", f"HEAD:refs/heads/{HISTORY_BRANCH}", directory=target,
                 check=False)
    if result.returncode:
        raise SystemExit(f"history push failed; run can be safely retried: {result.stderr}")
    print("LENTE HISTORY: archived", src.name, "bytes", total)

if __name__ == "__main__":
    main()
