# Risks and review points

- `scripts/update_docker_stacks.sh` ships with placeholder stack paths, so it is not operational until configured.
- Multiple Compose files use floating `latest` or `unstable` tags; Renovate cannot provide deterministic rollback for every such service.
- Docker socket mounts grant high control-plane access to several services. Traefik is read-only, but Obot, Authentik worker, Portainer, Pterodactyl Wings, and agents have broader mounts.
- RustDesk and several other stacks publish ports directly, bypassing Traefik policy and middleware.
- Traefik route files contain hardcoded internal IP addresses and ports; host addressing changes can silently break routing.
- ACME storage files and local `.env` files are runtime prerequisites but are not represented by tracked source.
- `lxc-bind9/config/named.conf` includes `named.conf.key`; the key file is intentionally not read or indexed for secret safety.
- The repository has no automated tests or CI workflow; configuration regressions are likely to be discovered at deployment or manual smoke-test time.
