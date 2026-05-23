# cinchcli/homebrew-tap

Homebrew tap for [Cinch](https://cinchcli.com) — remote clipboard for developers.

## Install

```bash
brew tap cinchcli/tap

brew install --cask cinchcli    # Desktop app for macOS, with embedded `cinch` CLI on PATH
brew install cinchcli           # CLI only (also works on Linux)
```

Or in one line:

```bash
brew install --cask cinchcli/tap/cinchcli     # desktop (includes CLI)
brew install cinchcli/tap/cinchcli            # CLI only
```

The Cask and the Formula `conflict_with` each other — pick one. Most macOS
users want the Cask; servers and Linux machines want the Formula.

## About

- **Cask `cinchcli`** — Tauri desktop app for macOS (Apple Silicon). On install,
  Homebrew also links a `cinch` shim onto PATH so the CLI works from any shell —
  the same binary serves both routes (the GUI app when launched as `Cinch`, the
  CLI when invoked as `cinch`).
- **Formula `cinchcli`** — Standalone CLI for headless macOS, Linux, and any
  environment where the desktop app isn't applicable.

Both are auto-bumped by [`cinchcli/cinch`](https://github.com/cinchcli/cinch)'s
unified release workflow (`.github/workflows/publish.yml`). There is no separate
desktop repository anymore — the entire toolchain (CLI, desktop, shared client
library) lives in [`cinchcli/cinch`](https://github.com/cinchcli/cinch).
