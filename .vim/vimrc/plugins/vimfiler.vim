let g:vimfiler_as_default_explorer = 1
noremap <C-E> :VimFiler -split -simple -winwidth=30 -no-quit<ENTER>
" close vimfiler automatically when there are only vimfiler open
autocmd bufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks("vimfiler")
