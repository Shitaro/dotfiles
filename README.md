# Environment
Arch Linux + i3wm  

# Dependencies
## Neovim
Install neovim  
`yay -S neovim`  

Install [dein.vim](https://github.com/Shougo/dein.vim)  
`curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh`  
`sh ./installer.sh ~/.cache/dein`  

Install Python module  
`yay -S python-neovim`  

## mykeymap
`yay -S xcape`  

## polybar
Install polybar  
`yay -S polybar`  

Install font to show status icons, i.e. cpu, ram, measurement  
`yay -S siji-git`  

## fish
Install fish  
`yay -S fish`  

Setting fish as default shell  
NOTE: [Not setting fish as system wide or user default allows the current Bash scripts to run on startup](https://wiki.archlinux.org/index.php/Fish#System_integration).  

Install fisherman  
`yay -S fisher`  

Install [oh-my-fish/theme-bobthefish](https://github.com/oh-my-fish/theme-bobthefish)  
`fisher add oh-my-fish/theme-bobthefish`
`yay -S powerline-fonts-git`  

Install [jethrokuan/fzf](https://github.com/jethrokuan/fzf)  
`yay -S fzf`  
`fisher add jethrokuan/fzf`  
