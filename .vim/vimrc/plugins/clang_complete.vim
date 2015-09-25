" " clang_complete
let g:clang_auto_select=0
let g:clang_library_path='/usr/lib/libclang.so'
" let g:clang_library_path='/usr/lib/x86_64-linux-gnu'
" let g:clang_library_path='/usr/lib/x86_64-linux-gnu'
" let g:clang_exec='/usr/lib/x86_64-linux-gnu'
let g:neocomplete#force_overwrite_completefunc=1
let g:clang_complete_auto=0
let g:clang_use_library=1

" let g:clang_user_options='2> NUL || exit 0"'
" let g:clang_complete_copen=0
" let g:clang_hl_errors=1
" let g:clang_snippets=1
" let g:clang_snippets_engine='ultisnips'
" let g:clang_conceal_snippets=1
" let g:clang_trailing_placeholder=1
" let g:clang_close_preview=0
" "
let g:clang_user_options='-std=c++11 '.
						\'-I/usr/local/include/GLFW'.
						\'-I/usr/local/include/glm'.
						\'-I/usr/include/*' 
"						\'-I/opt/microchip/xc8/v1.34/include'
" let g:clang_complete_macros=1
" let g:clang_complete_patterns=1
