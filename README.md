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

### Install chezmoi and Apply Dotfiles

The easiest way to get started is to run the following one-liner, which installs chezmoi and applies the dotfiles in a single command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Shitaro/dotfiles
```

Alternatively, you can install chezmoi via Homebrew and then initialize:

```bash
brew install chezmoi
chezmoi init --apply Shitaro/dotfiles
```

### Install Dependencies

After applying the dotfiles, you'll need to install some dependencies for everything to work properly:

```bash
brew install antidote fzf
brew install --cask wezterm
```

Antidote is the Zsh plugin manager used by this configuration. WezTerm is my terminal emulator of choice, and fzf provides fuzzy finding capabilities.

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
