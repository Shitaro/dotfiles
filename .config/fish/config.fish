set -U FZF_LEGACY_KEYBINDINGS 0

# Set alias
alias :q=exit
alias pu=pushd
alias po=popd

# to develop esp32
export PATH="$HOME/bin/esp/xtensa-esp32-elf/bin:$PATH"
export IDF_PATH="$HOME/bin/esp/esp-idf"

# Apply my keymap
if test $SHLVL=2
	xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keymap $DISPLAY 2> /dev/null
	source ~/dotfiles/bin/sands.sh
end

neofetch
