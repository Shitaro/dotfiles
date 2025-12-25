# dotfiles

This repository contains my personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

This repository manages my Zsh configuration (`.zshrc`, `.zshenv`, `.zprofile`), along with the Antidote plugin list (`.zsh_plugins.txt`). It also includes my WezTerm terminal configuration (`.wezterm.lua`), Git settings (`.gitconfig`), Atuin shell history configuration (`.config/atuin/config.toml`), and Starship prompt configuration (`.config/starship.toml`).

## Setting Up a New Machine

To set up a new machine with these dotfiles, follow the steps below.

### Install Homebrew

First, install Homebrew if it's not already installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

On Apple Silicon Macs, add Homebrew to your PATH after installation:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Install Dependencies and chezmoi

First, install the required dependencies and chezmoi together:

```bash
brew install chezmoi antidote fzf atuin starship
brew install --cask wezterm@nightly font-hack-nerd-font
```

Antidote is the Zsh plugin manager used by this configuration. WezTerm (nightly build is required for latest config options) is my terminal emulator of choice, fzf provides fuzzy finding capabilities, atuin provides enhanced shell history, and starship is the shell prompt.

### Apply Dotfiles

Apply the dotfiles with chezmoi:

```bash
chezmoi init --apply Shitaro/dotfiles
```

Alternatively, you can use the one-liner (installs chezmoi and applies in a single command):

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Shitaro/dotfiles
```

Note: If using the one-liner, make sure to install the dependencies (antidote, fzf, wezterm) before restarting your shell.

### Configure Git User

The `.gitconfig` in this repository contains the repository owner's name and email. Update it for your environment:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### Restart Your Shell

Finally, restart your shell to load the new configuration:

```bash
exec zsh
```

## Daily Usage

### Editing Dotfiles

There are two workflows for editing dotfiles:

#### Recommended: Edit source files directly

Edit the source file in `~/.local/share/chezmoi/`, then apply changes to the target:

```bash
chezmoi edit ~/.wezterm.lua   # Opens the source file in your editor
chezmoi apply                 # Apply changes to target files
```

Or navigate to the source directory and edit directly:

```bash
chezmoi cd                    # Go to ~/.local/share/chezmoi
vim private_dot_wezterm.lua   # Edit the source file
chezmoi apply                 # Apply changes to target files
```

This approach keeps the source of truth in the chezmoi repo and changes are immediately tracked in git.

#### Alternative: Edit target files and sync back

If you edit target files directly (e.g., `~/.wezterm.lua`), sync changes back to chezmoi:

```bash
chezmoi add ~/.wezterm.lua    # Sync a specific file
# or
chezmoi re-add                # Sync all managed files
```

### Committing Changes

After editing, commit and push your changes:

```bash
chezmoi cd && git add -A && git commit -m "Update config" && git push
```

### Pulling Updates

To pull the latest changes from the remote repository and apply them:

```bash
chezmoi update
```

## Useful Commands

To add a new file to chezmoi management, use `chezmoi add <file>`. To edit a managed file, use `chezmoi edit <file>`. You can preview changes with `chezmoi diff` before applying them with `chezmoi apply`. The `chezmoi cd` command takes you directly to the source directory where the dotfiles are stored.
