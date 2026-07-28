# Traefik route removal

1. Remove the authoritative file under `docker-srv-01/traefik/dynamic/services/`, not the generated `_svc__*` symlink.
2. Run `relink.sh` or allow the watcher to remove the generated entry.
3. Check the target Compose labels, DNS zone data, Cloudflare DNS/Tunnel configuration, and Glance links for the same hostname.
4. Confirm no TLS resolver, middleware, or shared service reference remains solely for the removed route.
5. Reload or restart the affected Traefik instance only through the normal host procedure and verify that the hostname no longer resolves or routes unexpectedly.
