let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \ 'left': [ ['mode', 'paste'], ['readonly', 'filepath', 'modified'] ]
    \ },
    \ 'component_function': {
    \ 'filepath': 'FilePath'
    \ },
    \ 'tabline': {
    \ 'left': [ ['tabs'] ],
    \ 'right': [ ['close'] ]
    \ }
  \ }

function! FilePath()
  if winwidth(0) > 90
    return expand("%:p")
  else
    return expand("%")
  endif
endfunction

set laststatus=2
set showtabline=2
set noshowmode
