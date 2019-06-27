if &compatible
    set nocompatible
endif

let s:cache_home = expand('$HOME/.cache')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Is dein installed?
if !isdirectory(s:dein_repo_dir)
    call system('git clone "https://github.com/Shougo/dein.vim"' . shellescape(s:dein_repo_dir))
endif

let &runtimepath = s:dein_repo_dir . "," . &runtimepath

" path to toml file
let s:toml_file = expand('<sfile>:h') . '/dein.toml'
let s:toml_file_lazy = expand('<sfile>:h') . '/dein_lazy.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    "load toml files
    call dein#load_toml(s:toml_file)
    call dein#load_toml(s:toml_file_lazy, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting')
    if dein#check_install()
        call dein#install()
    endif

    call dein#call_hook('source')
    call dein#call_hook('post_source')
    filetype plugin indent on
    syntax enable
endif
