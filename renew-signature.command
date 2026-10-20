#!/bin/zsh
set -eu
root="$(cd -- "$(dirname -- "$0")" && pwd)"
exec "$root/scripts/build.sh" --signed
