# Bind9 Setup Anleitung

Diese Schritte sind notwendig, nachdem das Repository geklont wurde, um die Docker-Container und den GitHub Runner korrekt auszuführen.

## 1. Berechtigungen für Bind9 setzen (Wichtig!)

Da der Bind9-Container nicht als `root`, sondern als User `bind` (UID 100) läuft, benötigt er Schreibrechte auf die gemounteten Verzeichnisse auf dem Host, um Journal-Dateien (`.jnl`) und dynamische Updates zu schreiben.

Führe folgende Befehle im Verzeichnis aus, in dem deine `docker-compose.yml` und die Bind-Ordner liegen (`lxc-bind9`):

```bash
# Verzeichnisse erstellen, falls sie noch nicht existieren
mkdir -p config cache records

# Eigentümer der Verzeichnisse auf UID 100 (bind User im Container) ändern
# Dies behebt den "Permission denied" Fehler beim Schreiben von managed-keys oder Zone-Updates
sudo chown -R 100:100 ./config
sudo chown -R 100:100 ./cache
sudo chown -R 100:100 ./records
```

> **Hinweis:** Pfade ggf. anpassen, falls deine Ordnerstruktur anders benannt ist.

## 2. Docker Container starten

Nachdem die Berechtigungen gesetzt sind, starte den DNS-Server:

```bash
docker-compose up -d
```
