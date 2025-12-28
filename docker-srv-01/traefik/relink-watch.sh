#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT_DIR/dynamic/services"
INOTIFY=/usr/bin/inotifywait

[ -x "$INOTIFY" ] || { echo "ERROR: $INOTIFY nicht gefunden (inotify-tools installieren)"; exit 1; }

mkdir -p "$SRC"

# initial
"$ROOT_DIR/relink.sh"

# reagiert auf create/modify/delete/move rekursiv
while true; do
  "$INOTIFY" -qq -r -e create -e modify -e delete -e move "$SRC" || true
  sleep 0.2
  "$ROOT_DIR/relink.sh" || true
done