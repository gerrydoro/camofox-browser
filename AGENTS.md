# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## Core Architectural Constraints

- **Route handlers (`server.js`)**: NO `process.env` access, NO `child_process` execution.
- **Config**: All `process.env` reads are centralized in `lib/config.js`.
- **Subprocess**: All `child_process` usage must be isolated in dedicated `lib/` or `plugin/*/` modules (e.g., `lib/launcher.js`).
- **OpenAPI**: Every route change requires an updated `@openapi` JSDoc block in `server.js` and `npm run generate-openapi`.

## Plugin Development

- Plugins export `register(app, ctx)`.
- Use `ctx.auth()` for routes, `ctx.log()` for output (no `console.log`).
- `browser:launching`, `session:creating`, `session:created`, `session:destroyed` hooks support async in-place mutations.

## Testing

- `npm run test:e2e` for end-to-end tests.
- `npx jest path/to/file.test.js` for single test files.
