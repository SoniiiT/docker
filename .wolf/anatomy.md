# anatomy.md

> Auto-maintained by OpenWolf. Last scanned: 2026-09-21T16:32:35.720Z
> Files: 110 tracked | Anatomy hits: 0 | Misses: 0

> Project structure index. Auto-maintained by OpenWolf hooks and daemon.
> Run `openwolf scan` to generate, or wait for the first Claude Code session.
> Status: Pending initial scan

## ./

- `.gitignore` — Git ignore rules (~146 tok)
- `AGENTS.md` — Agent context (~197 tok)
- `CLAUDE.md` — OpenWolf (~194 tok)
- `README.md` — Project documentation (~466 tok)
- `renovate.json` (~33 tok)

## .ai-context/

- `architecture.md` — Architecture (~927 tok)
- `conventions.md` — Conventions (~596 tok)
- `dependencies.md` — Dependencies (~480 tok)
- `manifest.json` (~274 tok)
- `project-map.md` — Project map (~626 tok)

## .ai-context/indexes/

- `files.json` (~1158 tok)
- `symbols.json` (~867 tok)

## .ai-context/knowledge/

- `README.md` — Project documentation (~166 tok)

## .ai-context/knowledge/business-rules/

- `index.md` — Business rules index (~162 tok)

## .ai-context/knowledge/decisions/

- `index.md` — Decisions index (~110 tok)

## .ai-context/knowledge/feature-guides/

- `dashboard-integrations.md` — Glance dashboard integrations (~198 tok)
- `deployment.md` — Compose stack deployment (~332 tok)
- `index.md` — Feature guides index (~70 tok)
- `routing-and-certificates.md` — Traefik routes and certificates (~315 tok)

## .ai-context/knowledge/removal-guides/

- `index.md` — Removal guides index (~47 tok)
- `route-removal.md` — Traefik route removal (~153 tok)
- `stack-removal.md` — Compose stack removal (~258 tok)

## .ai-context/knowledge/risks/

- `index.md` — Risks and review points (~272 tok)

## .github/

- `copilot-instructions.md` — Copilot project context (~94 tok)

## cloud-srv-02/authentik/

- `docker-compose.yaml` — Docker Compose services (~850 tok)

## cloud-srv-02/traefik/

- `docker-compose.yaml` — Docker Compose services (~643 tok)

## cloud-srv-02/uptimekuma/

- `docker-compose.yaml` — Docker Compose services (~200 tok)

## cloud-srv-03/headplane/

- `docker-compose.yaml` — Docker Compose services (~313 tok)

## cloud-srv-03/headscale/

- `docker-compose.yaml` — Docker Compose services (~488 tok)
- `README.md` — Project documentation (~200 tok)

## cloud-srv-03/headscale/config/

- `acl.hujson` (~1 tok)

## cloud-srv-03/rustdesk/

- `docker-compose.yaml` — Docker Compose services (~438 tok)

## cloud-srv-03/teleport/

- `docker-compose.yaml` — Docker Compose services (~506 tok)

## cloud-srv-03/teleport/config/

- `teleport.yaml` (~325 tok)

## cloud-srv-03/traefik/

- `docker-compose.yaml` — Docker Compose services (~442 tok)

## cloud-srv-03/traefik/dynamic/

- `middleware.yaml` (~57 tok)
- `transport.yaml` (~24 tok)

## docker-srv-01/cloudflared/

- `docker-compose.yaml` — Docker Compose services (~79 tok)

## docker-srv-01/portainer-mcp/

- `docker-compose.yaml` — Docker Compose services (~249 tok)

## docker-srv-01/portainer/

- `docker-compose.yaml` — Docker Compose services (~82 tok)

## docker-srv-01/speedtest-tracker/

- `docker-compose.yaml` — Docker Compose services (~128 tok)

## docker-srv-01/traefik/

- `docker-compose.yaml` — Docker Compose services (~783 tok)
- `README.md` — Project documentation (~748 tok)
- `relink-watch.sh` (~142 tok)
- `relink.sh` — Declares l (~329 tok)

## docker-srv-01/traefik/dynamic/

- `middleware.yaml` — traefik/dynamic/middlewares.yml (~345 tok)

## docker-srv-01/traefik/dynamic/services/ai-srv-01/

- `agentsview.yaml` (~107 tok)
- `odysseus.yaml` (~105 tok)
- `open-design.yaml` (~108 tok)

## docker-srv-01/traefik/dynamic/services/docker-srv-01/

- `homepage.yaml` (~104 tok)
- `portainer-mcp.yaml` (~97 tok)
- `portainer.yaml` (~140 tok)
- `speedtest-tracker.yaml` (~106 tok)
- `uptimekuma.yaml` (~107 tok)

## docker-srv-01/traefik/dynamic/services/docker-srv-02/

- `dns.yaml` (~99 tok)
- `filestash.yaml` (~106 tok)
- `it.yaml` (~98 tok)
- `wallos.yaml` (~102 tok)
- `whatsupdocker.yaml` — Docker Compose: 2 services (~99 tok)

## docker-srv-01/traefik/dynamic/services/docker-srv-03/

- `dokploy.yaml` (~103 tok)

## docker-srv-01/traefik/dynamic/services/home/

- `calibre-web.yaml` (~108 tok)
- `casaos.yaml` (~101 tok)
- `jellyfin-vue.yaml` (~109 tok)
- `jellyfin.yaml` (~104 tok)
- `jellyseerr.yaml` (~107 tok)
- `kapowarr.yaml` (~105 tok)
- `kavita.yaml` (~102 tok)
- `prowlarr.yaml` (~104 tok)
- `proxmox.yaml` (~137 tok)
- `questarr.yaml` (~105 tok)
- `radarr.yaml` (~102 tok)
- `readarr.yaml` (~104 tok)
- `romm.yaml` (~100 tok)
- `sonarr.yaml` (~102 tok)
- `umbrelos.yaml` (~103 tok)

## docker-srv-01/traefik/dynamic/services/lxc/

- `adguard.yaml` (~101 tok)
- `netbox.yaml` (~102 tok)
- `network.yaml` (~104 tok)
- `omada.yaml` (~134 tok)
- `pve-helper-scripts.yaml` (~107 tok)
- `semaphore.yaml` (~106 tok)
- `wgdashboard.yaml` (~108 tok)

## docker-srv-01/uptimekuma/

- `docker-compose.yaml` — Docker Compose services (~82 tok)

## docker-srv-02/cloudflared/

- `docker-compose.yaml` — Docker Compose services (~79 tok)

## docker-srv-02/it-tools/

- `docker-compose.yaml` — Docker Compose services (~61 tok)

## docker-srv-02/n8n/

- `docker-compose.yaml` — Docker Compose services (~130 tok)

## docker-srv-02/networking-toolbox/

- `docker-compose.yaml` — Docker Compose services (~110 tok)

## docker-srv-02/obot/

- `docker-compose.yaml` — Docker Compose services (~181 tok)

## docker-srv-02/portainer-agent/

- `docker-compose.yaml` — Docker Compose services (~86 tok)

## docker-srv-02/wallos/

- `docker-compose.yaml` — Docker Compose services (~92 tok)

## docker-srv-03/portainer-agent/

- `docker-compose.yaml` — Docker Compose services (~86 tok)

## docs/

- `deployment-guide.md` — 🚀 Anleitung: Automatisiertes Docker-Deployment mit Git & .env (~976 tok)

## jellfin-home-01/

- `docker-compose.yaml` — Docker Compose services (~1996 tok)

## lxc-bind9/

- `docker-compose.yaml` — Docker Compose services (~94 tok)
- `README.md` — Project documentation (~284 tok)

## lxc-bind9/config/

- `demo-soniiit-net.zone` (~143 tok)
- `dev-soniiit-net.zone` (~142 tok)
- `home-soniiit-net.zone` (~143 tok)
- `named.conf` — Declares master (~259 tok)
- `rev-192-168-178.zone` (~133 tok)

## lxc-pterodactyl/panel/

- `docker-compose.yaml` — Docker Compose services (~699 tok)

## lxc-pterodactyl/wings/

- `docker-compose.yaml` — Docker Compose services (~325 tok)

## lxc-remotely/

- `docker-compose.yaml` — Docker Compose services (~548 tok)

## lxc-wgdashboard/

- `docker-compose.yml` — Docker Compose services (~252 tok)

## rpi01/glance/

- `docker-compose.yaml` — Docker Compose services (~75 tok)

## rpi01/glance/assets/

- `user.css` (~0 tok)

## rpi01/glance/config/

- `glance.yml` — Declares url (~21434 tok)
- `home.yml` (~629 tok)

## rpi01/upsnap/

- `docker-compose.yaml` — Docker Compose services (~98 tok)

## scripts/

- `update_docker_stacks.sh` — CONFIGURATION (~516 tok)
