# OpenWolf

This project uses OpenWolf for context management. The always-on rules live in `.claude/rules/openwolf.md`; the hooks handle bookkeeping (anatomy index, memory log, read tracking) automatically.

For the full operating protocol (session handoff, memory discipline, bug logging), load the `openwolf` skill, or read `.wolf/OPENWOLF.md`. Regenerate the session handoff with `/handoff`.


# Claude project context

Use `.ai-context/` as the canonical shared project context for this repository. Read the relevant `.ai-context` files before changing stacks, routing, DNS, deployment automation, or dashboard integrations.

Treat the context as guidance and navigation only: verify facts in the source files, preserve curated knowledge, and never record secret values.
