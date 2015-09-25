" neocomplete option
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns={}
endif
let g:neocomplete#enable_at_startup=1
let g:neocomplete#skip_auto_completion_time=""
let g:neocomplete#force_omni_input_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.python='\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

let g:neocomplete#sources#dictionary#dictionaries={
	\ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
		\ }

inoremap <expr><Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><C-H> neocomplete#smart_close_popup()."\<C-H>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-H>"
inoremap <expr><C-Y> neocomplete#close_popup()
inoremap <expr><C-E> neocomplete#cancel_popup()	
