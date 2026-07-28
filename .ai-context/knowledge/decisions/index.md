# Decisions index

No explicit architecture decision records were found in the repository.

Observed design choices are documented as facts in `architecture.md`: Traefik uses a shared external network where attached, nested file-provider routes are flattened by a relinker, and RustDesk bypasses Traefik for UDP-compatible direct exposure. These are treated as observed or inferred implementation decisions, not approved business policy.
