#!/bin/bash
set -e

# In das Verzeichnis des Skripts wechseln
cd "$(dirname "$0")"

# Sicherstellen, dass das Entrypoint-Skript ausführbar ist
chmod +x entrypoint.sh

# Doppler run holt die neuesten Secrets und übergibt sie an docker-compose.
# Docker Compose vergleicht die neuen Variablen mit dem laufenden Container.
# - Wenn Key ANDERS: Container wird neu erstellt (Rotation erfolgreich).
# - Wenn Key GLEICH: "Container is up-to-date" (Nichts passiert, keine Downtime).
doppler run -- docker-compose up -d
