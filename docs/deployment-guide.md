# 🚀 Anleitung: Automatisiertes Docker-Deployment mit Git & .env

Diese Anleitung richtet ein System ein, das automatisch Änderungen aus dem Git-Repo zieht und die Container aktualisiert. Secrets werden lokal in einer `.env` Datei pro Stack gespeichert.

### Voraussetzungen
*   Git ist installiert (`apt install git`)
*   Docker & Docker Compose sind installiert
*   Du hast dich einmalig mit `git config --global credential.helper store` und einem `git pull` authentifiziert.

---

### Schritt 0: Repository einrichten (Optional: Sparse Checkout)

Wenn du auf einem Server nur bestimmte Ordner haben möchtest, kannst du **Git Sparse Checkout** verwenden. Das hält das Dateisystem sauber.

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

### Schritt 1: Secrets hinterlegen

Jeder Stack bekommt eine `.env` Datei direkt im Stack-Ordner. Docker Compose lädt diese automatisch.
Die `.env` Datei ist in `.gitignore` eingetragen und wird **nie** ins Repository committed.
Die aktuellen Werte aller Secrets liegen in **1Password**.

1.  **`.env` aus der Vorlage erstellen:**
    Jeder Stack enthält eine `.env.example` Datei mit allen benötigten Variablennamen (Werte leer).
    ```bash
    cp /opt/docker-stack/lxc-semaphore/.env.example /opt/docker-stack/lxc-semaphore/.env
    chmod 600 /opt/docker-stack/lxc-semaphore/.env
    nano /opt/docker-stack/lxc-semaphore/.env
    ```

2.  **Secrets eintragen** (Werte aus 1Password kopieren):
    ```env
    MY_SECRET_KEY=xxxxxxxx
    ANOTHER_SECRET=yyyyyyyy
    ```
    *(Speichern mit `STRG+O`, Beenden mit `STRG+X`)*

> Die `.env.example` enthält alle Variablennamen des Stacks. Die `.env` ist in `.gitignore` und wird **nie** von `git pull` überschrieben.

---

### Schritt 2: Das Update-Skript einrichten

Das Skript liegt im Repository unter `scripts/update_docker_stacks.sh`.

1.  **Skript kopieren:**
    ```bash
    sudo cp /opt/docker-stack/scripts/update_docker_stacks.sh /usr/local/bin/update_docker_stacks.sh
    ```

2.  **Konfiguration anpassen:**
    Bearbeite das Skript und trage deine Stack-Ordner ein:
    ```bash
    sudo nano /usr/local/bin/update_docker_stacks.sh
    ```

    ```bash
    STACKS=(
      "/opt/docker-stack/lxc-semaphore"
      # "/opt/docker-stack/another-service"
    )
    ```

3.  **Ausführbar machen:**
    ```bash
    sudo chmod +x /usr/local/bin/update_docker_stacks.sh
    ```

---

### Schritt 3: Manueller Test

```bash
/usr/local/bin/update_docker_stacks.sh
```
*   Wenn keine Fehler kommen (und "No changes in Git" oder "Update completed" steht), ist alles perfekt.

**Erzwingen des Starts:**
Wenn du den Container starten möchtest, auch wenn keine Änderungen in Git vorliegen (z.B. nach einem Neustart):

```bash
/usr/local/bin/update_docker_stacks.sh --start
```

---

### Schritt 4: Cronjob einrichten (Automatisierung)

1.  **Crontab öffnen:**
    ```bash
    sudo crontab -e
    ```

2.  **Zeile am Ende einfügen:**
    ```cron
    */1 * * * * /usr/local/bin/update_docker_stacks.sh >> /var/log/docker_stack_update.log 2>&1
    ```

3.  **Logs prüfen (optional):**
    ```bash
    cat /var/log/docker_stack_update.log
    ```

✅ **Fertig!** Dein Server aktualisiert sich jetzt vollautomatisch.
