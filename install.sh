#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Setup Homebrew environment first (Apple Silicon / Intel 両対応)
# PATH に無くても既存インストールを探す
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Install Homebrew if still not found
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # 再度環境設定
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Install Task if not present
if ! command -v task >/dev/null 2>&1; then
  brew install go-task
fi

# Run install task
cd "$DOTFILES_DIR"
task install

echo ""
echo "Dotfiles installed! (Task v3+ required)"
echo ""
echo "Next steps:"
echo "  task brew       # Install Homebrew packages"
