# Claude Code Instructions

This is a chezmoi-managed dotfiles repository.

## Editing Dotfiles

When editing configuration files, always edit the **source files in this directory** (`~/.local/share/chezmoi/`), not the target files in the home directory.

- Edit `private_dot_wezterm.lua` instead of `~/.wezterm.lua`
- Edit `dot_zshrc` instead of `~/.zshrc`
- Edit `dot_gitconfig` instead of `~/.gitconfig`

After editing, automatically run `chezmoi apply` to apply changes.
