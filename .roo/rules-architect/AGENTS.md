# AGENTS.md (Architect)

- Core engine (`server.js`) is strictly a router + lifecycle coordinator.
- All heavy lifting/subprocess/env-reading logic must be offloaded to `lib/` modules or plugins.
- Plugins are the primary extension mechanism; keep core minimal.
- Telemetry (`lib/reporter.js`) is strictly a stateless HTTP client (no `fs`, no `child_process`).
