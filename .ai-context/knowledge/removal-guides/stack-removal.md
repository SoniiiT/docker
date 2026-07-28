# Compose stack removal

This is an inferred checklist; the repository does not provide a formal decommissioning procedure.

1. Identify the stack directory, service image(s), published ports, external networks, bind mounts, named volumes, tunnel entries, DNS records, and Glance references.
2. Stop the stack with the appropriate Docker Compose command and confirm dependent services are not sharing its network or data mounts.
3. Preserve or archive host data before removing bind-mounted directories or named volumes. Do not delete runtime data as part of a source-only change.
4. Remove matching Traefik labels or file-provider route files and regenerate the dynamic links.
5. Remove DNS records and external Cloudflare/Tunnel references only after traffic has been drained.
6. Remove unused `.env.example` variables, documentation links, sparse-checkout examples, and entries in the configured `STACKS` array.
7. Review API integrations in `rpi01/glance/config/` and any other cross-host references before closing the removal.
