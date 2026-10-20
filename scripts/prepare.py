#!/usr/bin/env python3
"""Copy the canonical extension resources into the generated Xcode resource folder."""
import json
import shutil
from pathlib import Path

root = Path(__file__).resolve().parents[1]
source = root / "safari-extension"
target = root / "AppleSignedXcode/BetterCampus Safari Extension/Resources"
if target.exists():
    shutil.rmtree(target)
shutil.copytree(source, target)
manifest_path = target / "manifest.json"
manifest = json.loads(manifest_path.read_text())
manifest["name"] = "BetterCampus (Safari Installed)"
manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
print(f"Prepared Xcode resources from {source.name}")
