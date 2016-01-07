let g:lightline={
	\ 'colorscheme':'wombat',
	\ 'separator':{'left' : ">" , 'right' : "<"},
	\ 'subseparator':{'left' : "|" , 'right' : "|"},
	\ }
let g:lightline.active={
	\ 'left': [ [ 'mode', 'paste' ],
	\ 			[ 'readonly', 'filename', 'modified' ] ] }

let g:lightline.tabline={
	\ 'left': [ [ 'tabs' ] ],
	\ 'right': [ [ 'close' ] ] }
" let g:lightline = {
" 		\ 'component': {
" 		\   'lineinfo': ' %3l:%-2v',
" 		\ },
" 		\ 'component_function': {
" 		\   'readonly': 'LightLineReadonly',
" 		\   'fugitive': 'LightLineFugitive'
" 		\ },
" 		\ 'separator': { 'left': '', 'right': '' },
" 		\ 'subseparator': { 'left': '', 'right': '' }
" 		\ }
" 	function! LightLineReadonly()
" 		return &readonly ? '' : ''
" 	endfunction
" 	function! LightLineFugitive()
" 		if exists('*fugitive#head')
" 			let _ = fugitive#head()
" 			return strlen(_) ? ''._ : ''
" 		endif
" 		return ''
" 	endfunction
