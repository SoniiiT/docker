# Glance dashboard integrations

`rpi01/glance/config/glance.yml` defines five observed pages: Home, Internal Services, Exposed Services, Cloud, and Work. It references service URLs and API credentials through the local `.env` contract declared in `rpi01/glance/.env.example`. `home.yml` and `assets/user.css` provide additional dashboard layout and styling.

When changing a service, search the Glance configuration for its URL, API key variable, page placement, and health/status widget. Keep integration values as environment substitutions or redacted placeholders; never inline credentials.

There is no automated dashboard test. A change should be checked by rendering the Glance container and manually loading the affected page and widget, which is an inferred operational obligation.
