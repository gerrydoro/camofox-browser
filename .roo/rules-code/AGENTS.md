# AGENTS.md (Code)

- Use `ctx.auth()` middleware for all plugin routes.
- Do NOT read `process.env` in `register()` or route handlers; rely on `ctx.config`.
- Use `events.emitAsync()` for hooks requiring async mutation (e.g., `session:creating`).
- For new system deps, add to `apt.txt` and/or `post-install.sh`.
