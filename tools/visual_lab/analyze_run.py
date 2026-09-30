#!/usr/bin/env python3
"""Produce a conservative, evidence-linked CAVEMAN report for every LENTE run."""
import argparse
import hashlib
import json
import os
import statistics
import subprocess
from datetime import datetime, timezone
from pathlib import Path

def read_json(file):
    try:
        return json.loads(file.read_text(encoding="utf8"))
    except (OSError, ValueError):
        return {}

def pixels(file):
    if not file.is_file() or not file.stat().st_size:
        return None
    try:
        data = subprocess.check_output([
            "ffmpeg", "-nostdin", "-v", "error", "-i", str(file),
            "-vf", "scale=64:64:flags=fast_bilinear,format=gray",
            "-frames:v", "1", "-f", "rawvideo", "-"
        ], timeout=20)
        return data if len(data) == 4096 else None
    except (OSError, subprocess.SubprocessError):
        return None

def image_metrics(file):
    data = pixels(file)
    if data is None:
        return None
    return {"luminance": round(statistics.fmean(data), 1),
            "contrast": round(statistics.pstdev(data), 1),
            "dark_share": round(sum(x < 36 for x in data) / 4096, 3),
            "sha256": hashlib.sha256(file.read_bytes()).hexdigest()}

def video_metrics(file, first):
    if not file.is_file() or not file.stat().st_size:
        return None
    try:
        duration = float(subprocess.check_output([
            "ffprobe", "-v", "error", "-show_entries", "format=duration",
            "-of", "default=noprint_wrappers=1:nokey=1", str(file)
        ], text=True, timeout=20).strip())
        late = subprocess.check_output([
            "ffmpeg", "-nostdin", "-v", "error", "-ss", str(max(0, duration - 0.6)),
            "-i", str(file), "-vf", "scale=64:64:flags=fast_bilinear,format=gray",
            "-frames:v", "1", "-f", "rawvideo", "-"
        ], timeout=25)
        early = pixels(first)
        delta = round(statistics.fmean(abs(a-b) for a,b in zip(early, late)), 2) \
            if early is not None and len(late) == len(early) else None
        return {"seconds": round(duration, 2), "motion_delta": delta,
                "sha256": hashlib.sha256(file.read_bytes()).hexdigest()}
    except (ValueError, OSError, subprocess.SubprocessError):
        return None

def generate(run, manifest, capture_ok):
    meta = read_json(run / "capture-metadata.json")
    meta.setdefault("commit", os.getenv("LENTE_EXACT_SHA", "unknown"))
    meta.setdefault("run_id", os.getenv("GITHUB_RUN_ID", "local"))
    meta.setdefault("run_attempt", os.getenv("GITHUB_RUN_ATTEMPT", "1"))
    meta["run_key"] = run.name
    meta.setdefault("generated_at", datetime.now(timezone.utc).isoformat())
    (run/"capture-metadata.json").write_text(json.dumps(meta, indent=2)+"\n", encoding="utf8")

    shots, videos, gaps, candidates = {}, {}, [], []
    def issue(priority, key, observation, action, evidence, owner):
        candidates.append({"priority":priority,"id":key,"observed_signal":observation,
                           "next_action":action,"evidence":evidence,"owner":owner,
                           "state":"HEURISTIC_NOT_ACCEPTED"})
    for folder, targets in (("pages", manifest["pages"]),
                            ("scenes", manifest["isolated_scenes"])):
        for target in targets:
            for size in manifest["page_sizes"]:
                rel = f"{folder}/{target['id']}-{size['id']}.png"
                shots[rel] = image_metrics(run/rel)
                if shots[rel] is None:
                    gaps.append(rel)
    for target in manifest["isolated_scenes"]:
        sid = target["id"]
        rel, poster = f"videos/{sid}.webm", f"videos/{sid}-first.png"
        videos[sid] = video_metrics(run/rel, run/poster)
        if videos[sid] is None: gaps.append(rel)
        if image_metrics(run/poster) is None: gaps.append(poster)

    error_file = run/"browser-console-errors.txt"
    if error_file.exists() and error_file.stat().st_size:
        gaps.append("browser-console-errors.txt: runtime errors")
    if gaps:
        issue("P0","EVIDENCE-coverage",f"{len(gaps)} missing/invalid evidence entries.",
              "Repair capture/runtime errors and repeat before visual acceptance.",gaps[:6],"SIGA/LENTE")

    size = manifest["page_sizes"][0]["id"]
    for scene in manifest["isolated_scenes"]:
        sid = scene["id"]
        pg, sc = f"pages/{sid}-{size}.png", f"scenes/{sid}-{size}.png"
        p, s, v = shots.get(pg), shots.get(sc), videos.get(sid)
        if p and (p["luminance"] < 12 or p["contrast"] < 8):
            issue("P1",f"SCENE-{sid}-visibility",
                  f"Full page may be blank or too subdued: luminance={p['luminance']}, contrast={p['contrast']}.",
                  "Check actual screenshot and loading state; preserve intentional dark direction.",[pg,sc],"CENA/SIGA")
        elif p and s and s["luminance"] > 18 and p["luminance"]/s["luminance"] < .52:
            issue("P1",f"SCENE-{sid}-composition",
                  f"Full page has {round(p['luminance']/s['luminance']*100)}% of isolated scene luminance.",
                  "Review overlay, focal subject size and framing at BOTH portrait resolutions.",[pg,sc],"CENA")
        elif p and (p["dark_share"] >= .78 or p["contrast"] < 20):
            issue("P2",f"SCENE-{sid}-legibility",
                  f"Full-page dark share {p['dark_share']:.0%}, contrast {p['contrast']}.",
                  "Inspect focal-object/interaction readability; dark pixels are not proof of a defect.",[pg,sc],"CENA")
        if v and v["motion_delta"] is not None and v["motion_delta"] < 1.2:
            issue("P2",f"MOTION-{sid}-review",
                  f"Diagnostic first/last frame grayscale delta={v['motion_delta']}.",
                  "Check orbit angles for occlusion/frozen view before concluding anything.",[f"videos/{sid}.webm"],"LENTE/CENA")
    candidates.sort(key=lambda a:("P0 P1 P2".split().index(a["priority"]),a["id"]))
    counts={"pages":sum(v is not None for k,v in shots.items() if k.startswith("pages/")),
            "scenes":sum(v is not None for k,v in shots.items() if k.startswith("scenes/")),
            "videos":sum(v is not None for v in videos.values()),
            "posters":sum((run/f"videos/{x['id']}-first.png").is_file()
                          for x in manifest["isolated_scenes"]),
            "gaps":len(gaps)}
    state="EVIDENCE_COMPLETE_REVIEW_PENDING" if capture_ok and not gaps else "INCOMPLETE"
    metrics={"schema_version":1,"run_key":run.name,"head":meta["commit"],
             "run_id":meta["run_id"],"run_attempt":meta["run_attempt"],
             "state":state,"counts":counts,"images":shots,"motion":videos,"candidates":candidates}
    (run/"metrics.json").write_text(json.dumps(metrics,indent=2,ensure_ascii=False)+"\n",encoding="utf8")

    lines=[
        f"# LENTE CAVEMAN — {run.name}", "",
        f"**ESTADO:** {state}  ",
        f"**EXACT HEAD:** {meta['commit']} · **RUN:** {meta['run_id']} / tentativa {meta['run_attempt']}", "",
        "## TEMOS",
        f"{counts['pages']}/{len(manifest['pages'])*len(manifest['page_sizes'])} páginas; "
        f"{counts['scenes']}/{len(manifest['isolated_scenes'])*len(manifest['page_sizes'])} cenas; "
        f"{counts['videos']}/{len(manifest['isolated_scenes'])} vídeos; "
        f"{counts['posters']} posters; {counts['gaps']} lacunas.", "",
        "## ONDE DÓI — PRIMEIRAS HIPÓTESES", ""
    ]
    if not candidates:
        lines.append("- Nenhum alerta quantitativo: revisão humana/multimodal ainda obrigatória.")
    for c in candidates[:5]:
        evidence=", ".join(f"[{Path(p).name}]({p})" for p in c["evidence"] if "/" in p)
        lines.append(f"- **{c['priority']} {c['id']}** — {c['observed_signal']} "
                     f"**FAZER:** {c['next_action']} **DONO:** {c['owner']}. {evidence}")
    lines += ["","## CENA POR CENA",
              "| Cena | Brilho página | Escuro | Movimento | Imagens + vídeo |",
              "| --- | ---: | ---: | ---: | --- |"]
    for x in manifest["isolated_scenes"]:
        sid=x["id"]; p=shots.get(f"pages/{sid}-{size}.png"); v=videos.get(sid)
        lines.append(f"| {sid} | {p['luminance'] if p else '-'} | "
                     f"{p['dark_share'] if p else '-'} | "
                     f"{v.get('motion_delta','-') if v else '-'} | "
                     f"[página](pages/{sid}-{size}.png) · "
                     f"[cena](scenes/{sid}-{size}.png) · [vídeo](videos/{sid}.webm) |")
    lines += ["","## FAZER AGORA",
              "1. Resolver P0/P1. Conferir os pixels e não tratar métricas como estética aprovada.",
              "2. Analisar páginas, cenas isoladas e vídeos com o MODEL_REVIEW_PROMPT.md. "
              "Registrar observações visuais reais e escolher 1–3 melhorias delimitadas.",
              "3. Encaminhar direção a CENA, Three.js a 3JS, engenharia a SIGA, cânone a LORE.",
              "4. Repetir LENTE em OUTRA pasta após mudar o código; comparar antes/depois.", "",
              "**LIMITES:** escuridão pode ser intencional; variação de pixels não prova "
              "3D nem usabilidade; CAVEMAN automático não substitui análise visual.", ""]
    (run/"CAVEMAN.md").write_text("\n".join(lines),encoding="utf8")
    prompt=f"""# LENTE multimodal review — {run.name}

Read CAVEMAN.md, inventory.json, metrics.json and the actual pixels in BOTH portrait sizes
under pages/ and scenes/; inspect each videos/*.webm (not just its QA poster).
Head: {meta['commit']}. Treat measured candidate warnings as suggestions, not factual art defects.

For every canonical scene, separate OBSERVED facts from HYPOTHESIS. Inspect hierarchy,
silhouette, 3D object visibility, camera, lighting, depth, UI interactions, and motion
occlusions. Preserve DA LATA's existing visual direction and lore. Mark unavailable
video/image evidence INCONCLUSIVE. Do not declare 3D from a single isolated image.

Write CAVEMAN-MODEL.md inside THIS run's immutable evidence folder or an append-only
review companion on the history branch: O QUE VI; TOP 3 PROBLEMAS linked to exact
relative PNG/WebM evidence; FAZER AGORA (1–3 bounded changes); NÃO MEXER;
PERGUNTA PARA CENA; NEXT LENTE before/after. Use stable SCENE-/OBJECT-/MOTION-
IDs and route to CENA/3JS/SIGA/LORE. Only an owner can ACCEPT direction.
"""
    (run/"MODEL_REVIEW_PROMPT.md").write_text(prompt,encoding="utf8")
    print(f"LENTE {state}: {counts}; {len(candidates)} review candidates")

if __name__=="__main__":
    ap=argparse.ArgumentParser()
    ap.add_argument("--run-dir",type=Path,required=True)
    ap.add_argument("--manifest",type=Path,required=True)
    ap.add_argument("--status",choices=["success","failure"],required=True)
    a=ap.parse_args()
    a.run_dir.mkdir(parents=True,exist_ok=True)
    generate(a.run_dir,json.loads(a.manifest.read_text(encoding="utf8")),a.status=="success")
