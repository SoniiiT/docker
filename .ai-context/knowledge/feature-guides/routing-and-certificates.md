# Traefik routes and certificates

## Route sources

For `docker-srv-01`, add HTTP file-provider routes below `docker-srv-01/traefik/dynamic/services/<group>/`. Existing groups are `ai-srv-01`, `docker-srv-01`, `docker-srv-02`, `docker-srv-03`, `home`, and `lxc`. Each route normally defines a Host rule, `websecure` entrypoint, a service, and an internal HTTP(S) target.

The file provider is configured as non-recursive. Run `docker-srv-01/traefik/relink.sh` after a route change, or keep `relink-watch.sh` running with `inotify-tools`. Do not edit generated `_svc__*` links as source.

## Certificate path

Traefik uses Cloudflare DNS-01 with the `leprod` resolver for production and `lestage` for staging. The resolver email and Cloudflare token are environment-backed. ACME state is stored in `acme.json` and `acme-staging.json`, which must be files with appropriate host permissions before startup.

## Inferred change obligations

Route changes should be reviewed together with the target service's published port, DNS zone or external DNS, TLS resolver choice, middleware, and whether the target is reachable from the Traefik host. Hardcoded internal IPs in the route files are deployment dependencies and must be updated if host addressing changes.
