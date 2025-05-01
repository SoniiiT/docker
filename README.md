# Docker

Docker ist eine Open-Source-Plattform, die es ermöglicht, Anwendungen in Containern zu verpacken, zu verteilen und auszuführen. Container sind leichtgewichtige, portable und in sich geschlossene Umgebungen, die alle notwendigen Komponenten für den Betrieb einer Anwendung enthalten.

## Vorteile von Docker

- **Portabilität:** Container laufen auf jedem System, das Docker unterstützt
- **Isolierung:** Anwendungen und ihre Abhängigkeiten sind voneinander getrennt
- **Effizienz:** Container teilen sich den Kernel des Host-Systems
- **Schnelle Bereitstellung:** Anwendungen können schnell gestartet, gestoppt und skaliert werden

## Grundlegende Docker-Konzepte

- **Images:** Vorlagen für Container, die alle notwendigen Dateien und Konfigurationen enthalten
- **Container:** Laufende Instanzen von Images
- **Dockerfile:** Textdatei mit Anweisungen zum Erstellen eines Images
- **Docker Hub:** Öffentliche Registry für Docker Images

## Installation

Docker kann auf verschiedenen Betriebssystemen installiert werden:
- [Windows](https://docs.docker.com/desktop/install/windows-install/)
- [macOS](https://docs.docker.com/desktop/install/mac-install/)
- [Linux](https://docs.docker.com/engine/install/)

## Erste Schritte

1. Installation von Docker
2. Überprüfen der Installation:
   ```bash
   docker --version
   ```
3. Testen mit einem Hello-World-Container:
   ```bash
   docker run hello-world
   ```