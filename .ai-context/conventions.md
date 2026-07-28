# Conventions

## Configuration and naming

- Compose files are named `docker-compose.yaml`, with one `docker-compose.yml` exception in `lxc-wgdashboard`.
- Service and network names are lower-case with hyphens or underscores; host directories use environment prefixes such as `docker-srv-01`, `cloud-srv-02`, and `lxc-*`.
- YAML is the dominant configuration format. Compose syntax and version declarations are mixed across inherited stack templates.
- Timezone settings commonly use `Europe/Berlin`.
- Images are commonly pinned to a version, but several stacks still use `latest`, `unstable`, or floating image tags.

## Secrets and configuration

- Secrets are referenced through Compose interpolation or `env_file: .env`; values are not stored in the repository.
- `.env.example` files document variable names. The root `.gitignore` ignores `.env`.
- Secret-related variable names observed include Cloudflare, ACME email, Authentik, database, tunnel, API, bootstrap-token, and dashboard credentials. This context records names and roles only, never values.
- 1Password is the documented source for secrets. Operators copy values into local ignored `.env` files; secret values are not stored in this repository.

## Runtime and security

- Most services use `restart: unless-stopped` or `restart: always`.
- Reverse proxies use the Docker provider with `exposedbydefault=false` and a file provider. Traefik mounts the Docker socket read-only; several application stacks mount it read-write for their own control-plane requirements.
- Public or host-bound ports are declared explicitly in each stack. Do not assume a route can replace direct TCP/UDP exposure.
- Bind9 restricts query and recursion access to `192.168.178.0/24`; dynamic updates are keyed.
- Compose healthchecks and `depends_on` health conditions are used where the source stack defines them, notably Authentik.

## Shell and operations

- `relink.sh` and `relink-watch.sh` use Bash with `set -euo pipefail`.
- The update helper prints per-stack status and continues after missing directories or failed `git pull`; it does not enable strict shell mode.
- Operational documentation is primarily German and includes copy-pasteable Linux, Docker, Git, systemd, and cron commands.
- No automated test suite or CI workflow was found. Renovate is configured with `config:recommended` for dependency update management.
