# Project map

## Shape

This repository is an infrastructure inventory rather than an application. It contains independent Docker Compose stacks, host-specific reverse-proxy configuration, local DNS zone data, and shell helpers for deployment and Traefik file-provider management.

The repository is organized by host or environment:

- `docker-srv-01/`: primary Docker host, Traefik, Portainer, Cloudflare Tunnel, speed testing, uptime monitoring, and the largest dynamic route set.
- `docker-srv-02/`: application host with n8n, Obot, Wallos, IT tools, networking tools, Portainer Agent, and a Cloudflare Tunnel.
- `docker-srv-03/`: Portainer Agent.
- `cloud-srv-02/`: Authentik, Traefik, and Uptime Kuma.
- `cloud-srv-03/`: RustDesk, Teleport, and Traefik.
- `jellfin-home-01/`: home media and library stack (directory name is intentionally spelled `jellfin`).
- `lxc-bind9/`: authoritative/internal Bind9 DNS and zone files.
- `lxc-pterodactyl/`: Pterodactyl Panel and Wings.
- `lxc-remotely/`: Remotely remote-management service.
- `lxc-wgdashboard/`: Cloudflare DDNS updater using host networking.
- `rpi01/glance/`: Glance dashboard, assets, configuration, and integration credentials contract.

## Important entry points

| Path | Role |
| --- | --- |
| `README.md` | High-level Docker and deployment strategy overview |
| `docs/deployment-guide.md` | Git pull, local `.env`, sparse checkout, and cron deployment procedure |
| `scripts/update_docker_stacks.sh` | Per-stack pull and conditional `docker compose pull/up/prune` helper |
| `docker-srv-01/traefik/docker-compose.yaml` | Primary internal Traefik entrypoints and ACME configuration |
| `docker-srv-01/traefik/dynamic/services/` | Structured HTTP route definitions for home, LXC, Docker, and AI services |
| `docker-srv-01/traefik/relink.sh` | Flattens nested dynamic route files into Traefik-visible symlinks |
| `lxc-bind9/config/named.conf` | DNS ACL, forwarding, recursion, and zone declarations |
| `rpi01/glance/config/glance.yml` | Dashboard pages and integrations |

## Navigation guidance

For a stack change, start with its `docker-compose.yaml`, same-directory `.env.example` if present, persistent volume paths, and any matching Traefik route. For an exposed hostname, inspect both the route file and the DNS zone or external DNS documentation. For deployment behavior, read `docs/deployment-guide.md` together with `scripts/update_docker_stacks.sh`. Do not treat generated context as a substitute for the Compose source.
