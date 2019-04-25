"### BEGIN DEIN ###
" dein Scripts
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($HOME . '/.cache/dein')
  call dein#begin($HOME . '/.cache/dein')

  "path to toml file
  let s:toml_dir  = $HOME . '/.config/nvim'
  let s:toml      = s:toml_dir . '/dein.toml'
  let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

  "load toml files
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

"### END DINE ###

set number "show column number
set autoindent
set tabstop=2 "number of spaces that a <Tab> in the file counts for.
"set softtabstop=2 "number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
set shiftwidth=0 "number of spaces to use for each step of (auto)indent
set expandtab "use the appropriate number of spaces to insetrt a <Tab>
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

nnoremap [Tab] <Nop>
nmap t [Tab]

for n in range(1, 9)
  execute 'nnoremap <silent> [Tab]'.n ' :tabnext '.n.'<CR>'
endfor

map <silent> [Tab]c :tablast <bar> tabnew<CR>
map <silent> [Tab]x :tabclose<CR>
map <silent> [Tab]n :tabnext<CR>
map <silent> [Tab]p :tabprevious<CR>
