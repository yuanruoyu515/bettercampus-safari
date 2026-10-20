#!/bin/bash
set -euo pipefail
root="$(cd -- "$(dirname -- "$0")/.." && pwd)"
python3 "$root/scripts/prepare.py"
mode="${1:---signed}"
case "$mode" in
  --signed)
    : "${TEAM_ID:?Set TEAM_ID to your own Xcode Personal Team identifier}"
    signing=(-allowProvisioningUpdates "DEVELOPMENT_TEAM=$TEAM_ID" "CODE_SIGN_IDENTITY=Apple Development" CODE_SIGNING_ALLOWED=YES)
    ;;
  --unsigned)
    signing=(CODE_SIGNING_ALLOWED=NO)
    ;;
  *) echo "Usage: TEAM_ID=YOUR_TEAM_ID ./scripts/build.sh [--signed|--unsigned]" >&2; exit 2 ;;
esac
xcodebuild -project "$root/AppleSignedXcode/BetterCampus Safari.xcodeproj" \
  -scheme "BetterCampus Safari" -configuration Release \
  -derivedDataPath "$root/Build" "${signing[@]}" build
printf '\nBuilt app: %s\n' "$root/Build/Build/Products/Release/BetterCampus Safari.app"
