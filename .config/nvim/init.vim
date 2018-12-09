" dein Scripts
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($HOME . '/.cache/dein')
  call dein#begin($HOME . '/.cache/dein')

  "Path to toml file
  let s:toml_dir  = $HOME . '/.config/nvim'
  let s:toml      = s:toml_dir . '/dein.toml'
  let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

  " Load toml files
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

set number "show column number
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set splitright
set clipboard=unnamed
set hls
set inccommand=split

set list
set listchars=tab:>-,trail:_,nbsp:%,eol:$

" highlight cursor
set cursorline
set cursorcolumn

" make background transparent
highlight Normal term=none cterm=none ctermbg=none
highlight NonText term=none cterm=none ctermbg=none
highlight LineNr cterm=none ctermfg=116 ctermbg=none
