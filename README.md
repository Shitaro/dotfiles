# dotfiles

This repository contains my personal configuration files managed with Task (go-task) using symlinks.

## Requirements

- macOS (tested on Apple Silicon)
- Homebrew
- Task v3+

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
| Karabiner | `.config/karabiner/` | Keyboard remapping |

## Setting Up a New Machine

```bash
git clone https://github.com/Shitaro/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
task brew
```

`install.sh` automatically:
- Installs Homebrew (if not present)
- Installs Task (if not present)
- Creates symlinks for all dotfiles

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

SketchyBar starts automatically with AeroSpace (configured via `after-startup-command` in `aerospace.toml`).

### Restart Your Shell

```bash
exec zsh
```

## Daily Usage

### Editing Dotfiles

Edit the source files in this repository (`~/dotfiles/`).
Changes are applied immediately via symlinks.

Examples:

- Edit `home/.wezterm.lua` instead of `~/.wezterm.lua`
- Edit `home/.zshrc` instead of `~/.zshrc`
- Edit `.config/starship.toml` instead of `~/.config/starship.toml`

### Committing Changes

```bash
git add -A
git commit -m "Update config"
git push
```

### Pulling Updates

```bash
git pull
# Re-run symlink task if needed
task symlink
```

## Useful Commands

| Command | Description |
|---------|-------------|
| `task --list` | Show available tasks |
| `task symlink` | Create/update all symlinks |
| `task clean` | Remove all dotfile symlinks |
| `task brew` | Install Homebrew packages |
