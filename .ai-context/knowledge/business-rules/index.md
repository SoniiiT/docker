# Business rules index

No domain business rules were found. The following operational invariants are source-backed configuration constraints:

- Bind9 permits queries and recursion only from `192.168.178.0/24` (`lxc-bind9/config/named.conf`).
- Bind9 dynamic zone updates require the configured `tsig-key` (`lxc-bind9/config/named.conf`).
- Authentik server and worker require healthy PostgreSQL and Redis dependencies (`cloud-srv-02/authentik/docker-compose.yaml`).
- Traefik file-provider route sources belong under `docker-srv-01/traefik/dynamic/services/`; generated `_svc__*` links are derived artifacts (`docker-srv-01/traefik/relink.sh`).
