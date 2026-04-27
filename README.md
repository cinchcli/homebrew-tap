# cinchcli/homebrew-tap

Homebrew tap for [Cinch](https://cinchcli.com) — remote clipboard for developers.

## Install

```bash
brew tap cinchcli/tap

brew install cinch                    # CLI only
brew install --cask cinch-desktop     # Desktop app (auto-installs CLI)
```

Or in one line:

```bash
brew install --cask cinchcli/tap/cinch-desktop
```

## About

- **Formula `cinch`** — CLI tool (`cinch push` / `cinch pull`). Auto-updated by GoReleaser on each `cinchcli/cinch` release.
- **Cask `cinch-desktop`** — Tauri desktop app for macOS. Auto-updated by the `cinchcli/desktop` release workflow. Installing the cask automatically installs the CLI formula.
