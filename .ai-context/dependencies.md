# Dependencies

## Runtime images and services

The Compose manifests pull images from Docker Hub, GHCR, GitHub-authored registries, public ECR, and LinuxServer registries. The main families are:

- Traefik v3.6.22, Cloudflare Tunnel, Portainer and Portainer Agent, Uptime Kuma, Speedtest Tracker, n8n, Obot, Wallos, IT Tools, and Networking Toolbox.
- Authentik with PostgreSQL 16 Alpine and Redis; Teleport 18.9.2; RustDesk server 1.1.15.
- Home media and library services including Jellyfin, Jellyfin Vue, Sonarr, Radarr, Prowlarr, Seerr, SABnzbd, qBittorrent, Kapowarr, Kaizoku, Calibre-Web, Readarr, Kavita, Romm, and Questarr, with PostgreSQL, Redis, and MariaDB support.
- Bind9, Pterodactyl Panel and Wings, Remotely, Cloudflare DDNS, and Glance.

Exact image references and tags remain in the Compose files; consult those files before upgrades.

## Platform dependencies

- Docker Engine and Docker Compose on every deployed host.
- Git credentials and a Git checkout for the documented pull-based deployment flow.
- A local ignored `.env` file for stacks that declare environment contracts.
- Traefik's Docker socket and file provider, an external `traefik_proxy` network where referenced, and writable ACME storage files.
- Cloudflare API access for DNS-01 certificates, tunnels, and DDNS; Let's Encrypt for certificate issuance.
- `inotify-tools` for the optional Traefik dynamic configuration watcher.
- Bind-mounted host paths and named volumes for databases, application data, media, certificates, logs, and Docker control-plane access.

## External integrations

Glance configuration references internal services and APIs including Proxmox, n8n, WireGuard Dashboard, Semaphore, Speedtest Tracker, Traefik, Portainer, Jellyfin, Sonarr, Radarr, Jellyseerr/Seerr, Wallos, GitHub, and Cloudflare. These integrations are configured through environment variables or explicit URLs in `rpi01/glance/config/`.
