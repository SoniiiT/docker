# Traefik Dynamic Configuration Relinker

Traefik unterstützt standardmäßig kein rekursives Überwachen von Unterordnern für die dynamische Konfiguration (File Provider). Um dennoch eine strukturierte Konfiguration mit Unterordnern (z.B. `dynamic/services/home/`, `dynamic/services/external/`) nutzen zu können, verwenden wir diese Helper-Skripte.

Die Skripte erstellen "flache" Symlinks im `dynamic/` Ordner, die auf die eigentlichen Dateien in den Unterordnern zeigen.

## Dateien

- **`relink.sh`**: Durchsucht `dynamic/services/` rekursiv nach `.yml` und `.yaml` Dateien und erstellt entsprechende Symlinks in `dynamic/`.
- **`relink-watch.sh`**: Überwacht den Ordner `dynamic/services/` auf Änderungen und führt bei Bedarf `relink.sh` aus.

## Installation & Einrichtung

### 1. Voraussetzungen installieren

Das Watch-Skript benötigt `inotifywait`.

```bash
# Debian / Ubuntu
sudo apt-get update && sudo apt-get install -y inotify-tools

# Alpine
apk add inotify-tools
```

### 2. Skripte ausführbar machen

```bash
chmod +x relink.sh relink-watch.sh
```

### 3. Nutzung

#### Manuell (Einmalig)
Um die Links einmalig zu aktualisieren:
```bash
./relink.sh
```

#### Automatisch (Watch-Modus)
Um Änderungen live zu überwachen (empfohlen):
```bash
./relink-watch.sh
```

### 4. Als Systemd Service einrichten (Optional)

Damit der Watcher immer im Hintergrund läuft, kann ein Systemd-Service erstellt werden.

1. Datei erstellen: `/etc/systemd/system/traefik-relink.service`

```ini
[Unit]
Description=Traefik Relink Watcher
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/docker/traefik
ExecStart=/opt/docker/traefik/relink-watch.sh
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
```
*(Pfade in `WorkingDirectory` und `ExecStart` ggf. anpassen!)*

2. Service aktivieren und starten:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now traefik-relink.service
```

## Funktionsweise

1. Konfigurationen werden in `dynamic/services/...` abgelegt.
2. Das Skript erstellt Symlinks in `dynamic/` nach dem Schema `_svc__<pfad>__<dateiname>`.
   - Beispiel: `dynamic/services/home/jellyfin.yaml` -> `dynamic/_svc__home__jellyfin__yaml`
3. Traefik liest nur den Ordner `dynamic/` (nicht rekursiv) und findet dort alle Konfigurationen über die Symlinks.
