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
NeoBundle 'Rip-Rip/clang_complete',{
	\ 'build' : {
	\ 'windows' : "make",
	\ 'cygwin' : "make", 
	\ 'mac' : "make", 
	\ 'unix' : "make", 
	\ },
	\ }
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-surround'
NeoBundle 'itchyny/calendar.vim'
" NeoBundle 'jiangmiao/auto-pairs'

call neobundle#end()

filetype plugin indent on

set runtimepath+=$HOME/.vim/vimrc/
runtime! vimrc/*.vim
runtime! vimrc/plugins/*.vim

NeoBundleCheck

