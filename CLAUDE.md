# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles for macOS (primary) and Linux. Configuration is kept under `lib/` and symlinked into the user's home directory by a Rakefile.

## Install / uninstall

- `./install` — idempotent bootstrap. On macOS installs Homebrew (if missing) then fish; on Linux installs fish via apt plus starship and git-delta. Each tool is only installed if its command isn't already on `PATH`. Then pipes `yes |` into `rake install:configuration_files` to auto-confirm symlink overwrites.
- `./uninstall` — runs `rake uninstall`, which removes any symlink in `~` that points into this repo's `lib/`.
- `rake install:configuration_files` — the core symlink task; interactive unless piped `yes`.

## Symlink convention (Rakefile:4–11)

`ConfigurationFile#target` decides where each entry in `lib/` lands:

- Names ending in `fish` or `nvim` → `~/.config/<name>` (XDG-style, e.g. `lib/fish` → `~/.config/fish`, `lib/nvim` → `~/.config/nvim`).
- Everything else → `~/.<name>` (e.g. `lib/zshrc` → `~/.zshrc`, `lib/gitconfig` → `~/.gitconfig`).

When adding a new dotfile, drop it directly into `lib/` — the Rakefile globs `lib/*` and handles the rest. If the target tool expects its config under `~/.config/<name>`, extend the `case source` branch in the Rakefile. Don't nest new configs inside subdirectories unless the target tool expects a directory.

## Shell architecture

fish is the primary (and only) configured shell; bash is assumed as a fallback and has no tracked config.

**fish** (`lib/fish/`):
- `config.fish` is intentionally small. Startup logic lives in `conf.d/*.fish` (auto-sourced by fish) — each file is scoped to one concern (`bin.fish` for PATH, `git-aliases.fish`, `sdk.fish`, `fnm.fish`, `rbenv.fish`, `zoxide.fish`, `staship.fish`, etc.).
- `functions/*.fish` are lazy-loaded by fish on first call; put new commands there, not in `conf.d/`.
- Plugins are managed by fisher; the manifest is `fish_plugins` and universal variables (including fisher's own state) live in `fish_variables`. Both are version-controlled — edit with care since fisher rewrites them.
- `reload` function re-sources config without restarting the shell.

## Neovim

`lib/nvim/init.lua` is the single entry point (kickstart.nvim style). On first launch, `lazy.nvim` bootstraps itself into `~/.local/share/nvim/lazy/` and installs plugins there; `mason.nvim` installs LSP servers and formatters into `~/.local/share/nvim/mason/`. Both locations are outside this repo, so no gitignore entries are needed. `lib/nvim/lazy-lock.json` (generated on first sync) pins plugin versions and SHOULD be committed for reproducibility.

## Git config

`lib/gitconfig` ends with `[include] path = ~/.gitconfig.local` at the top — put per-machine identity or private settings there, not in the tracked file (though user name/email are currently tracked).
