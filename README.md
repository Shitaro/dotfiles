# dotfiles

This repository contains my personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

## Requirements

- macOS (tested on Apple Silicon)
- Homebrew

## What's Included

| Category | Files | Description |
|----------|-------|-------------|
| Zsh | `.zshrc`, `.zshenv`, `.zprofile`, `.zsh_plugins.txt` | Shell configuration and Antidote plugin list |
| WezTerm | `.wezterm.lua` | Terminal emulator configuration |
| Git | `.gitconfig` | Git settings |
| Atuin | `.config/atuin/config.toml` | Enhanced shell history |
| Starship | `.config/starship.toml` | Shell prompt |
| AeroSpace | `.config/aerospace/aerospace.toml` | Tiling window manager |
| SketchyBar | `.config/sketchybar/` | Status bar with AeroSpace integration |

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
brew install chezmoi antidote fzf atuin starship sketchybar
brew install --cask wezterm@nightly nikitabobko/tap/aerospace
brew install --cask font-hack-nerd-font font-jetbrains-mono-nerd-font
```

| Package | Description |
|---------|-------------|
| chezmoi | Dotfiles manager |
| antidote | Zsh plugin manager |
| fzf | Fuzzy finder |
| atuin | Enhanced shell history |
| starship | Shell prompt |
| sketchybar | Customizable status bar |
| wezterm@nightly | Terminal emulator (nightly required for latest config options) |
| aerospace | i3-like tiling window manager |
| font-hack-nerd-font | Terminal and general UI font |
| font-jetbrains-mono-nerd-font | SketchyBar workspace indicators (includes Nerd Font icons) |

### Apply Dotfiles

Apply the dotfiles with chezmoi:

```bash
chezmoi init --apply Shitaro/dotfiles
```

Alternatively, you can use the one-liner (installs chezmoi and applies in a single command):

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Shitaro/dotfiles
```

Note: If using the one-liner, make sure to install all dependencies listed above before restarting your shell.

### Configure Git User

The `.gitconfig` in this repository contains the repository owner's name and email. Update it for your environment:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### Configure AeroSpace

After applying dotfiles, launch AeroSpace and grant accessibility permission:

1. Open AeroSpace: `open -a AeroSpace`
2. macOS will prompt for accessibility permission
3. Go to **System Settings** → **Privacy & Security** → **Accessibility**
4. Enable **AeroSpace**

AeroSpace will start managing your windows immediately after permission is granted.

#### AeroSpace Keybindings

| Keybinding | Action |
|------------|--------|
| `Alt + H/J/K/L` | Focus window (left/down/up/right) |
| `Alt + Shift + H/J/K/L` | Move window (left/down/up/right) |
| `Alt + 0-9` | Switch to workspace |
| `Alt + Shift + 0-9` | Move window to workspace |
| `Alt + Tab` | Switch to previous workspace |
| `Alt + Shift + Tab` | Move workspace to next monitor |
| `Alt + /` | Toggle tiles layout |
| `Alt + ,` | Toggle accordion layout |
| `Alt + -/=` | Resize window |
| `Alt + Shift + ;` | Enter service mode |

**Service Mode** (`Alt + Shift + ;`):

| Keybinding | Action |
|------------|--------|
| `Esc` | Reload config and exit |
| `R` | Reset layout |
| `F` | Toggle floating/tiling |
| `Backspace` | Close all windows but current |

### Configure SketchyBar

SketchyBar is configured to display AeroSpace workspace indicators with the following color scheme:

- **Orange** - Currently focused workspace
- **Green** - Visible workspace on another monitor
- **Blue** - Background workspace (has windows but not visible)
- **Gray** - Empty workspace

Each workspace also displays an icon indicating which monitor it belongs to (external monitor or built-in display).

To start SketchyBar:

```bash
brew services start sketchybar
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

| Command | Description |
|---------|-------------|
| `chezmoi add <file>` | Add a new file to chezmoi management |
| `chezmoi edit <file>` | Edit a managed file |
| `chezmoi diff` | Preview changes before applying |
| `chezmoi apply` | Apply changes to target files |
| `chezmoi cd` | Go to the source directory |
| `chezmoi update` | Pull and apply latest changes from remote |
