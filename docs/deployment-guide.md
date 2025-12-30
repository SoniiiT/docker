# 🚀 Anleitung: Automatisiertes Docker-Deployment mit Git & Doppler

Diese Anleitung richtet ein System ein, das automatisch Änderungen aus deinem Git-Repo zieht, Secrets sicher aus Doppler lädt und die Container aktualisiert.

### Voraussetzungen
*   Git ist installiert (`apt install git`)
*   Docker & Docker Compose sind installiert
*   Doppler CLI ist installiert ([Anleitung](https://docs.doppler.com/docs/install-cli))
*   Du hast dich einmalig mit `git config --global credential.helper store` und einem `git pull` authentifiziert.

---

### Schritt 0: Repository einrichten (Optional: Sparse Checkout)

Wenn du auf einem Server nur bestimmte Ordner (z.B. nur den Ordner für diesen Server und die Skripte) haben möchtest, kannst du **Git Sparse Checkout** verwenden. Das hält das Dateisystem sauber.

So richtest du es ein (Beispiel für `lxc-semaphore`):

1.  **Repo initialisieren (ohne Dateien auszuchecken):**
    ```bash
    mkdir -p /opt/docker-stack
    cd /opt/docker-stack
    git clone --no-checkout https://github.com/SoniiiT/docker.git .
    ```

2.  **Sparse Checkout aktivieren:**
    ```bash
    git sparse-checkout init --cone
    ```

3.  **Gewünschte Ordner festlegen:**
    Hier wählst du den Ordner für deinen Container (z.B. `lxc-semaphore`) UND den `scripts` Ordner aus.
    ```bash
    git sparse-checkout set lxc-semaphore scripts
    ```

4.  **Dateien holen:**
    ```bash
    git checkout main
    ```

*Ergebnis:* Du siehst im Ordner `/opt/docker-stack` nur die Unterordner `lxc-semaphore`, `scripts` und die `.git` Dateien.

---

### Schritt 1: Secrets sicher hinterlegen

Wir speichern die Doppler-Tokens in einer geschützten Datei, damit sie nicht im Skript stehen.

1.  **Datei erstellen & Rechte setzen (nur root darf lesen):**
    ```bash
    sudo touch /root/.doppler_secrets
    sudo chmod 600 /root/.doppler_secrets
    sudo nano /root/.doppler_secrets
    ```

2.  **Tokens eintragen:**
    Füge hier deine Service-Tokens ein.
    *   *Für LXC-Semaphore (nur ein Token):*
        ```bash
        export DOPPLER_TOKEN="dp.st.prd.xxxxxxxxx"
        ```
    *   *Für Docker-SRV (mehrere Tokens):*
        ```bash
        export DOPPLER_TOKEN_PAPERLESS="dp.st.prd.xxxxxxxxx"
        export DOPPLER_TOKEN_NGINX="dp.st.prd.yyyyyyyyy"
        ```
    *(Speichern mit `STRG+O`, Beenden mit `STRG+X`)*

---

### Schritt 2: Das Update-Skript erstellen

Das Skript liegt bereits im Repository unter `scripts/update_docker_stacks.sh`.

1.  **Skript kopieren:**
    Kopiere das Skript an den Zielort auf deinem Server:
    ```bash
    sudo cp scripts/update_docker_stacks.sh /usr/local/bin/update_docker_stacks.sh
    ```

2.  **Konfiguration anpassen:**
    Bearbeite das Skript und passe den Bereich `STACKS` an deine Ordnerstruktur an:
    ```bash
    sudo nano /usr/local/bin/update_docker_stacks.sh
    ```

    ```bash
    # List of Stacks: "Path to folder" -> "Variable Name in secrets file"
    declare -A STACKS
    STACKS=(
      # BEISPIEL LXC (Zeile einkommentieren & anpassen):
      # ["/opt/docker-stack/LXC-Semaphore"]="DOPPLER_TOKEN"

      # BEISPIEL DOCKER SERVER (Zeilen einkommentieren & anpassen):
      # ["/opt/docker/paperless"]="DOPPLER_TOKEN_PAPERLESS"
      # ["/opt/docker/nginx"]="DOPPLER_TOKEN_NGINX"

      # BEISPIEL OHNE DOPPLER (einfach leer lassen):
      # ["/opt/docker/simple-service"]=""
    )
    ```

3.  **Ausführbar machen:**
    ```bash
    sudo chmod +x /usr/local/bin/update_docker_stacks.sh
    ```

---

### Schritt 3: Manueller Test

Bevor wir die Automatisierung einschalten, teste einmal, ob alles klappt:

```bash
/usr/local/bin/update_docker_stacks.sh
```
*   Wenn keine Fehler kommen (und "No changes in Git" oder "Update completed" steht), ist alles perfekt.

**Erzwingen des Starts:**
Wenn du den Container starten möchtest, auch wenn keine Änderungen in Git vorliegen (z.B. nach einem Neustart oder manuellen Änderungen), kannst du das Flag `--start` verwenden:

```bash
/usr/local/bin/update_docker_stacks.sh --start
```
Dies führt `docker compose pull` und `docker compose up -d` aus, unabhängig vom Git-Status.

---

### Schritt 4: Cronjob einrichten (Automatisierung)

Damit der Server alle 15 Minuten prüft:

1.  **Crontab öffnen:**
    ```bash
    sudo crontab -e
    ```

2.  **Zeile am Ende einfügen:**
    ```cron
    */1 * * * * /usr/local/bin/update_docker_stacks.sh >> /var/log/docker_stack_update.log 2>&1
    ```

3.  **Logs prüfen (optional):**
    Du kannst später jederzeit schauen, was das Skript gemacht hat:
    ```bash
    cat /var/log/docker_stack_update.log
    ```

✅ **Fertig!** Dein Server aktualisiert sich jetzt vollautomatisch und sicher.
