# Compose stack deployment

## Exposed surfaces

Each stack is exposed through its directory-level `docker-compose.yaml` or `docker-compose.yml`. Some services use an external Traefik network and labels; others publish host ports directly. Persistent state is stored in the bind mounts or named volumes declared by the stack.

## Change checklist

1. Update the stack Compose file and its `.env.example` contract when variables change.
2. Check attached networks, direct port bindings, healthchecks, dependencies, and persistent mounts.
3. Add or update any matching Traefik route, DNS record, Glance link, or external tunnel configuration.
4. Keep secret values in the host-local ignored `.env`; do not add them to source.
5. Update the relevant host documentation if the operator procedure changes.
6. Validate with the repository's available Docker Compose/configuration tooling and a manual service smoke test. This is an inferred operational obligation because no automated test suite exists.

## Runtime rollout

The documented script pulls the configured checkout and, when Git changes are present or `--start` is supplied, runs `docker compose pull`, `docker compose up -d --remove-orphans`, and `docker image prune -f`. The `STACKS` array is currently an example and must be configured before relying on the script.
