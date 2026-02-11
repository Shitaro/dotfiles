# Claude Code Instructions

This is a Task-managed dotfiles repository.

## Editing Dotfiles

Edit the source files in this directory (`~/dotfiles/`). Changes are automatically reflected via symlinks.

- `home/*` → symlinked to `~/` (e.g. `home/.wezterm.lua` → `~/.wezterm.lua`)
- `.config/*` → symlinked to `~/.config/` (e.g. `.config/starship.toml` → `~/.config/starship.toml`)
  - `karabiner` is symlinked as a whole directory

## Task Commands

- `task install` — Create symlinks for all dotfiles
- `task clean` — Remove all dotfile symlinks
- `task brew` — Install Homebrew packages
