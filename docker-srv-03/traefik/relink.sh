#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT_DIR/dynamic/services"
DST="$ROOT_DIR/dynamic"

mkdir -p "$SRC" "$DST"

# 1) ALLE von uns generierten Einträge entfernen (Symlink ODER Datei)
find "$DST" -maxdepth 1 \( -type l -o -type f \) -name '_svc__*' -exec rm -f {} + || true

# 2) Neue Links für alle *.yml/*.yaml unterhalb von services erstellen
#    Linkname kodiert den Unterpfad: services/home/pbs.yml -> _svc__home__pbs__yml
while IFS= read -r f; do
  rel="${f#${ROOT_DIR}/dynamic/}"                       # z.B. services/home/pbs.yml
  name="_svc__$(echo "${rel#services/}" | tr '/.' '__')"  # _svc__home__pbs__yml

  # Vor dem Erstellen sicherheitshalber entfernen (falls gerade geschrieben wurde)
  rm -f "$DST/$name" 2>/dev/null || true

  # Link ERZWINGEN/ersetzen (-sfn) und mtime anfassen (touch -h), damit Traefik ein Event sieht
  ln -sfn "$rel" "$DST/$name"
  touch -h "$DST/$name" 2>/dev/null || true
done < <(find "$SRC" -type f \( -name '*.yml' -o -name '*.yaml' \) | sort)

count=$(ls -1 "$DST"/_svc__* 2>/dev/null | wc -l || true)
echo "Symlinks aktualisiert: $count"