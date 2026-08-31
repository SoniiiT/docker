# Headscale on cloud-srv-03

Headscale and Headplane run as separate Compose projects on `cloud-srv-03`.

- Headscale: `cloud-srv-03/headscale/`
- Headplane: `cloud-srv-03/headplane/`
- Public endpoint: `https://headscale.soniiit.net`
- Embedded DERP/STUN: UDP 3478
- Headplane UI: `/admin`

Runtime state and credentials are deliberately excluded from Git. Populate the
local secret files before starting the services:

- `headplane/headscale_api_key`
- `headplane/oidc_client_secret`
- `headplane/cookie_secret`

The production `config.yaml` files remain host-local because they contain
runtime-sensitive integration settings. Use the tracked Compose files and this
README as the deployment contract; do not commit database files, private keys,
API keys, OIDC secrets, cookies, or backup copies.
