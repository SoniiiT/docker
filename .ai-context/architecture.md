# Architecture

## System boundary

The repository declares a collection of host-local Compose projects. Each stack is deployed independently from the directory containing its Compose file. Persistent state is stored in bind mounts or named volumes on the host; the repository stores configuration and deployment wiring, not runtime data.

## Control and data flows

1. A host checks out the repository, usually with sparse checkout, and keeps secrets in a local ignored `.env` file.
2. A stack directory is pulled and updated by the deployment helper or manually with Docker Compose.
3. Traefik terminates HTTPS and routes to Compose services through the shared external `traefik_proxy` network where the stack is attached to it.
4. Traefik uses Docker labels for services such as Authentik, Uptime Kuma, and Teleport, and a file provider for the structured routes under `docker-srv-01/traefik/dynamic/services/`.
5. Cloudflare DNS-01 credentials are supplied through environment variables for ACME certificate issuance. Cloudflare Tunnel stacks separately provide outbound tunnel connectivity.
6. Bind9 serves the `home.soniiit.net`, `dev.soniiit.net`, and `demo.soniiit.net` zones plus the reverse `192.168.178.0/24` zone. Queries and recursion are restricted to the internal ACL; dynamic updates require the configured TSIG key.
7. Glance on `rpi01` presents dashboard pages for home, internal, exposed, cloud, and work services and calls external APIs using its local `.env` contract.

## Host and service topology

- `docker-srv-01` is the primary internal ingress host. Its Traefik Compose file publishes HTTP/HTTPS plus Teleport-related TCP entrypoints and watches `/etc/traefik/dynamic`.
- `cloud-srv-02` and `cloud-srv-03` have independent Traefik instances using the same external network name, allowing local stacks to attach to their proxy.
- `cloud-srv-03/teleport` uses Traefik HTTP labels for its web and wildcard application access and TCP labels for SSH and reverse tunnel ports.
- `cloud-srv-03/rustdesk` intentionally bypasses Traefik because its protocol includes UDP; its hbbs and hbbr services publish the RustDesk ports directly.
- `docker-srv-01/traefik/dynamic/services/` contains 36 HTTP route files grouped by `ai-srv-01`, `docker-srv-01`, `docker-srv-02`, `docker-srv-03`, `home`, and `lxc`. Targets are mostly fixed internal IPs and ports.
- `lxc-pterodactyl` separates the Panel database/cache/application from Wings. Wings has a dedicated `wings0` bridge and broad host mounts, including the Docker socket.
- `jellfin-home-01` combines media services, downloaders, library services, and supporting PostgreSQL, Redis, and MariaDB services in one Compose project.
- `cloud-srv-02/authentik` has PostgreSQL and Redis dependencies, Authentik server and worker processes, and a Traefik label route for `sso.soniiit.net`.

## Routing file-provider lifecycle

Traefik's file provider is configured with a non-recursive directory watch. `relink.sh` creates generated `_svc__*` symlinks in `docker-srv-01/traefik/dynamic/` for all YAML files below `dynamic/services/`; `relink-watch.sh` repeats this after inotify events. The source files under `dynamic/services/` are authoritative. Generated links are runtime artifacts and are not part of the tracked source index.

## Deployment shape

The documented process is Git plus Docker Compose with per-stack local `.env` files. The update script currently contains example stack paths only; it is a template that must be configured before use. It pulls each configured Git checkout, skips unchanged stacks unless `--start` is passed, then runs `docker compose pull`, `docker compose up -d --remove-orphans`, and `docker image prune -f`.
