# Persistence Plugin

- Hooks: `session:creating` (load state), `session:created` (bootstrap cookies), `session:destroyed` (checkpoint).
- State storage: `~/.camofox/profiles/<sha256(userId)>/storage_state.json`.
- All hooks are async and awaited via `emitAsync()`.
