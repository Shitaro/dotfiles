" quick run
let g:quickrun_config= {
	\ "cpp" :{
	\ 'command' : 'clang++',
	\ 'cmdopt' : '-Wextra -std=c++14', 
	\ }
	\}
let g:quickrun_config={'*': {'split': 'vertical'}}
let g:quickrun_config['tex'] = {
\ 'command' : 'latexmk',
\ 'outputter' : 'error',
\ 'outputter/error/error' : 'quickfix',
\ 'cmdopt': '-pdfdvi',
\ 'exec': ['%c %o %s','evince %s:r.pdf']
\ }

