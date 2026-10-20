"""Check every pack in packs/ against the rules Jarvis enforces, and zip each one into dist/.
Run it before a pull request: python3 build.py"""
import json
import re
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent
FILES = ("orb.json", "displace.glsl", "shade.glsl")
MAX_FILE = 64 * 1024
BASES = ("points", "shell", "wire", "disc", "orbits", "helix", "hypercube")
SLUG = re.compile(r"^[a-z0-9][a-z0-9-]{0,39}$")
SIGNATURE = {"displace.glsl": (re.compile(r"\bvec3\s+displace\s*\(\s*vec3\s+\w+\s*\)"), "vec3 displace(vec3 p)"),
             "shade.glsl": (re.compile(r"\bvec4\s+shade\s*\(\s*vec3\s+\w+\s*\)"), "vec4 shade(vec3 base)")}
# Names a pack must not declare: GLSL reserves gl_*, and Jarvis's wrapper already defines the rest.
TAKEN = re.compile(r"\b(?:void|float|int|bool|[biu]?vec[234]|mat[234])\s+(gl_\w*|main|snoise|mod289|permute|taylorInvSqrt|field|displaced)\s*[(;=,]")


def check(folder):
    errors = []
    if not SLUG.match(folder.name):
        errors.append("folder name must be lowercase letters, digits and dashes")
    names = {p.name for p in folder.iterdir()}
    if names - set(FILES):
        errors.append(f"only {', '.join(FILES)} are allowed; found {', '.join(sorted(names - set(FILES)))}")
    for p in folder.iterdir():
        if p.is_file() and p.stat().st_size > MAX_FILE:
            errors.append(f"{p.name} is over 64 KB")
    try:
        m = json.loads((folder / "orb.json").read_text())
    except (OSError, json.JSONDecodeError) as e:
        return errors + [f"orb.json: {e}"]
    if not str(m.get("name") or "").strip():
        errors.append("orb.json needs a name")
    if m.get("base", "points") not in BASES:
        errors.append(f"base must be one of {', '.join(BASES)}")
    for n, (sig, want) in SIGNATURE.items():
        if (folder / n).exists() and not sig.search((folder / n).read_text()):
            errors.append(f"{n} must define {want}")
        if (folder / n).exists() and (hit := TAKEN.search((folder / n).read_text())):
            errors.append(f"{n} declares {hit.group(1)}, a name that is taken (gl_ names are reserved)")
    return errors


def main():
    (ROOT / "dist").mkdir(exist_ok=True)
    bad = 0
    for folder in sorted(p for p in (ROOT / "packs").iterdir() if p.is_dir()):
        errors = check(folder)
        if errors:
            bad += 1
            print(f"✗ {folder.name}: " + "; ".join(errors))
            continue
        with zipfile.ZipFile(ROOT / "dist" / f"{folder.name}.zip", "w", zipfile.ZIP_DEFLATED) as z:
            for n in FILES:
                if (folder / n).exists():
                    z.write(folder / n, n)
        print(f"✓ {folder.name}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
