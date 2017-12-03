# Set zsh complete function
autoload -U compinit ; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*' format '%B%d%b'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:default' menu select=2
# zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix

setopt correct


# Set my prompt
autoload -U promptinit; promptinit
autoload -U colors; colors
#
# Settings of showing git status
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+!"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# %b branch info
# %a action(ex.merge)
# %c changes
# %u uncommit

precmd () { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Left prompt
PROMPT="%{$fg[cyan]%}$USER@$HOST%{$reset_color%}"
# if [ ${#vcs_info_msg_0_} -ne 0 ]; then
# 	PROMPT=$PROMPT' $vcs_info_msg_0_%{$reset_color%} '
# 	echo "vcs_info_msg_0_ != 0"
# fi
# PROMPT=$PROMPT'%{$fg[cyan]%}%#%{$reset_color%} '
PROMPT=$PROMPT'$vcs_info_msg_0_%{$fg[cyan]%}%#%{$reset_color%} '
# Right prompt
RPROMPT="%{$fg[cyan]%}[%d]%{$reset_color%}"

# echo ${#vcs_info_msg_0_}

# Set ls colors
eval `dircolors ~/.colorrc`

# Set alias
alias :q=exit
alias vi=vim
alias ls='ls --color=auto -F'
alias l='ls --color=auto -F'
alias ll='ls -l --color=auto -h -F'
alias la='(){ ls -all -h -F --color=auto $@ }'
alias nc='(){ sudo wifi-menu $@ }'
alias update-grub2='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias pacman-conf='sudo vim /etc/pacman.conf'
alias cp='cp -i'
alias rm='rm -i'
alias -g G='| grep'
alias po='popd 1>/dev/null 2>/dev/null'
alias pbcopy='xsel --clipboard --input'
alias sands='source ~/bin/sands.sh'
alias df='df -h'
alias du='du -h'
if [ $SHLVL=2 ]; then
	alias tmux='tmux attach || tmux new-session \; source-file ~/.tmux/session'
fi

export CLICOLOR=true

DIRSTACKSIZE=1000
# Use directory stack
setopt auto_pushd
# Can move directory without cd
setopt auto_cd
# Show the directory stack if change directory
# chpwd_functions=($chpwd_functions dirs)

# Enable to show Japanese file name
setopt print_eight_bit

zstyle ':completion:*' list-colors "${LS_COLORS}"

setopt magic_equal_subst

# Execute commands
neofetch
if [ $SHLVL=2 ]; then
	xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keymap $DISPLAY 2> /dev/null
	source ~/bin/sands.sh
fi

# History
# autoload history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey "^P" history-beginning-search-backward-end
# bindkey "^N" history-beginning-search-forward-end
# bindkey "^S" history-incremental-search-forward

# Path to command history file
HISTFILE=~/.zsh_history
# The number of history which preserves in a memory
HISTSIZE=100000
# The number of history which preserve in the history file
SAVEHIST=100000
# Save also runtime & rundate in history file
setopt extended_history
# Remove the old command from zsh history if it corresponds with new one
setopt hist_ignore_all_dups
# Share command history data with zsh process
setopt share_history

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
