scriptencoding utf-8
set encoding=utf-8

set number
set nocompatible

set tabstop=4
set autoindent
" set autochdir
set shiftwidth=4
set incsearch
set mouse=a
" set wildmenu wildmode=list:full
syntax on
set nohlsearch
set cursorline
set laststatus=2
" set statusline=%F%r%=%l,%c
set backspace=indent,eol,start
set showcmd
set clipboard=unnamed,autoselect
set list
set listchars=tab:>-,trail:_,nbsp:%,eol:$
"================================================================================
" setup for tabpage
"================================================================================
" function! s:SID_PREFIX()
" 	return matchstr(expand('<sfile>'),'<SNR>\d\+_\zeSID_PREFIX$')
" endfunction
"
" function! s:myTabline()
" 	let s=''
" 	for i in range(1,tabpagenr('$'))
" 		let bufnrs=tabpagebuflist(i)
" 		let bufnr=bufnrs[tabpagewinnr(i)-1]
" 		let no=i
" 		let mod=getbufvar(bufnr,'&modified') ? '!' : ' '
" 		let title=fnamemodify(bufname(bufnr),':t')
" 		let title='[' . title . ']'
" 		let s .= '%'.i.'T'
" 		let s .= '%#' . (i==tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
" 		let s .= no . ':' . title
" 		let s .= mod
" 		let s .= '%#TabLineFill# '
" 	endfor
" 	let s .= '%#TabLineFill#%T%=%#TabLine#'
" 	return s
" endfunction
"
" let &tabline = '%!'. s:SID_PREFIX() . 'myTabline()'

set showtabline=2


"================================================================================
" C++ cording in vim
"================================================================================
" complete braket"
" inoremap {<Enter> {}<Left><CR><Esc><S-o>
" inoremap ( ()<Left>
" inoremap " ""<Left>
" inoremap ' ''<Left>

function! s:cpp()
	setlocal path+=/usr/include,/usr/local/include,/usr/include/c++/6.3.1
" 	,/home/shitaro/boost
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal noexpandtab
	setlocal matchpairs+=<:>
	nnoremap <buffer><silent> <Space>ii :execute "?".&include<CR> :noh<CR> o
endfunction

augroup vimrc-cpp
	autocmd!
	autocmd FileType cpp call s:cpp()
augroup END

" When you open c++ standard libraries,
" Vim recognizes them as c++ files.
let $CPP_STDLIB='/usr/include/c++'
augroup vimrc-set_filetype_cpp
	autocmd!
	autocmd BufReadPost $CPP_STDLIB/* if empty(&filetype) | set filetype=cpp | endif
augroup END

" function! s:haskell() abort
" 	setlocal tabstop=2
" 	setlocal softtabstop=2
" 	setlocal shiftwidth=2
" 	setlocal expandtab
" endfunction
"
" augroup vimrc-haskell
" 	autocmd!
" 	autocmd FileType hs call s:haskell()
" augroup END

"================================================================================
" HTML cording in vim
"================================================================================
function! s:html() abort
	setlocal tabstop=2
	setlocal shiftwidth=2
	setlocal noexpandtab
	setlocal matchpairs+=<:>
endfunction

augroup vimrc-html
	autocmd!
	autocmd FileType html call s:html()
augroup END

"================================================================================
" TeX cording in vim
"================================================================================
autocmd BufNewFile,BufRead *.tex set filetype=tex "Set filetype to tex when open .tex file"

augroup ftplugin-bib
	autocmd!
	" bib file
	autocmd BufRead, BufNewFile *.bib set filetype = bib
	autocmd Filetype bib let &formatprg = "bibclean"
augroup END

"================================================================================
" Asciidoc cording in vim
"================================================================================

" function! s:adoc() abort
" 	set spell spelllang=en_us
" endfunction

augroup ftplugin-asciidoc
	autocmd!
	autocmd FileType asciidoc set spell spelllang=en_us
augroup END

