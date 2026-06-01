# YouTube Plugin

- Endpoint: `POST /youtube/transcript` (requires auth if `"auth": true` set in config).
- `child_process` (yt-dlp) strictly in `youtube.js`.
- `apt.txt` / `post-install.sh` handles binary setup via `scripts/install-plugin-deps.sh`.
