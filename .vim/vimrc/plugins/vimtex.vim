let g:vimtex_complete_enabled= 1
" to disable/enable vimtex completion

let g:vimtex_latexmk_continuous = 0

let g:vimtex_labels_enabled = 1
" let g:vimtex_latexmk_background = 1
let g:vimtex_latexmk_options='-pdfdvi'
let g:vimtex_view_enable = 1
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
