# VNC Plugin

- Activation: `ENABLE_VNC=1` or `"vnc": { "enabled": true }` in `camofox.config.json`.
- `child_process` strictly in `vnc-launcher.js`.
- `vnc-watcher.sh` polls for Xvfb, attaches x11vnc, starts noVNC.
- Storage state export requires auth (`/vnc/status` is unauthenticated).
