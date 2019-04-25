nnoremap [denite] <Nop>
nmap <C-p> [denite]

nnoremap <silent> [denite]<C-p> :<C-u>Denite file_rec<CR>
nnoremap <silent> [denite]<C-m> :<C-u>Denite file_mru<CR>
nnoremap <silent> [denite]<C-r> :<C-u>Denite register<CR>

call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>', 'noremap')

call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>', 'noremap')

"move cursor
call denite#custom#map('normal', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',['.git/', '__pycache__/', 'fonts/'])
