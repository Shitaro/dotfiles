if !1 | finish | endif

if has('vim_starting')
	if &compatible
		set nocompatible
	endif

	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

"Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

"My Bundles here:
NeoBundle 'Shougo/vimproc', {
			\ 'build' : {
			\ 'windows' : 'make -f make_mingw32.mak',
			\ 'cygwin' : 'make -f make_cygwin.mak',
			\ 'mac' : 'make -f make_mac.mak',
			\ 'unix' : 'make -f make_unix.mak',
			\ },
			\ }
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'spolu/dwm.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'justmao945/vim-clang'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-surround'
NeoBundle 'jiangmiao/auto-pairs'
" NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'sudo.vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'rust-lang/rust.vim'
" NeoBundle 'lervag/vim-latex'
NeoBundle 'lervag/vimtex'

let g:rustfmt_autosave = 1

call neobundle#end()

filetype plugin indent on
" let $PYTHONPATH='/usr/lib/python3.5/site-packages'
" set laststatus=2
set runtimepath+=$HOME/.vim/vimrc/
runtime! vimrc/*.vim
runtime! vimrc/plugins/*.vim

NeoBundleCheck

