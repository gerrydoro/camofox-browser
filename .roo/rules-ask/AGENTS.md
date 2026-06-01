# AGENTS.md (Ask)

- Core engine (`server.js`) is router + lifecycle coordinator only (no `process.env`, no `child_process`).
- Plugins are primary extension mechanism (`register(app, ctx)`).
- OpenAPI spec generation is mandatory on route changes (`npm run generate-openapi`).
- Telemetry (`lib/reporter.js`) is a stateless HTTP client (no `fs`, no `child_process`).
