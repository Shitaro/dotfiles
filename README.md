# dotfiles

This repository contains my personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

This repository manages my Zsh configuration (`.zshrc`, `.zshenv`, `.zprofile`), along with the Antidote plugin list (`.zsh_plugins.txt`). It also includes my WezTerm terminal configuration (`.wezterm.lua`) and Git settings (`.gitconfig`).

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

When you make changes to your dotfiles locally, use `chezmoi re-add` to sync those changes back to the chezmoi source directory. Then commit and push the changes:

```bash
chezmoi re-add
chezmoi cd && git add -A && git commit -m "Update config" && git push
```

To pull the latest changes from the remote repository and apply them, simply run:

```bash
chezmoi update
```

## Useful Commands

To add a new file to chezmoi management, use `chezmoi add <file>`. To edit a managed file, use `chezmoi edit <file>`. You can preview changes with `chezmoi diff` before applying them with `chezmoi apply`. The `chezmoi cd` command takes you directly to the source directory where the dotfiles are stored.
