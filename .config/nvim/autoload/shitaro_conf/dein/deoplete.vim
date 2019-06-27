function! shitaro_conf#dein#deoplete#hook_add() abort
    let g:deoplete#enable_at_startup   = 1
    let g:deoplete#auto_complete_delay = 0

    " close popup and delete backword char
    inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"

    " close popup and save indent
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function() abort
        return deoplete#close_popup() . "\<CR>"
    endfunction
endfunction
