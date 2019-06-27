function! shitaro_conf#dein#lightline#hook_add() abort
    let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \ 'left': [ ['mode', 'paste'], ['readonly', 'filepath', 'modified'] ]
        \ },
        \ 'component_function': {
        \ 'filepath': 'FilePath',
        \ 'mode': 'LightlineMode',
        \ },
        \ 'tabline': {
        \ 'left': [ ['tabs'] ],
        \ 'right': [ ['close'] ]
        \ }
    \ }

    function! LightlineMode() abort
        return expand('%:t') ==# 'NERD_tree' ? 'NERD':
            \ lightline#mode()
    endfunction

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
endfunction
