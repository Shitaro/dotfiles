function! shitaro_conf#dein#denite#hook_add() abort
    " nnoremap [denite] <Nop>
    " nmap <C-p> [denite]
    "
    " nnoremap <silent> [denite]<C-p> :<C-u>Denite file_rec<CR>
    " nnoremap <silent> [denite]<C-m> :<C-u>Denite file_mru<CR>
    " nnoremap <silent> [denite]<C-r> :<C-u>Denite register<CR>
    "
    " call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
    " call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
    "
    " call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>', 'noremap')
    " call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>', 'noremap')
    "
    " "move cursor
    " call denite#custom#map('normal', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    " call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    " call denite#custom#map('normal', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
    " call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
    "
    " call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])
    " call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',['.git/', '__pycache__/', 'fonts/'])
    "
    " Define mappings
    " Main window of denite has a filetype 'denite'

    " noremap zn :<C-u>Denite file/rec

    autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR>
                    \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> d
                    \ denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr> p
                    \ denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> q
                    \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> i
                    \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
                    \ denite#do_map('toggle_select').'j'
    endfunction

    autocmd FileType denite-filter call s:denite_filter_my_settings()
    function! s:denite_filter_my_settings() abort
        imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
    endfunction

    " " Change file/rec command.
    " call denite#custom#var('file/rec', 'command',
    "            \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    " " For ripgrep
    " " Note: It is slower than ag
    " call denite#custom#var('file/rec', 'command',
    "            \ ['rg', '--files', '--glob', '!.git'])
    " " For Pt(the platinum searcher)
    " " NOTE: It also supports windows.
    " call denite#custom#var('file/rec', 'command',
    "            \ ['pt', '--follow', '--nocolor', '--nogroup',
    "            \  (has('win32') ? '-g:' : '-g='), ''])
    " " For python script scantree.py
    " " Read bellow on this file to learn more about scantree.py
    " call denite#custom#var('file/rec', 'command', ['scantree.py'])
    "
    " " Change matchers.
    " call denite#custom#source(
    "            \ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
    " call denite#custom#source(
    "            \ 'file/rec', 'matchers', ['matcher/cpsm'])
    "
    " " Change sorters.
    " call denite#custom#source(
    "            \ 'file/rec', 'sorters', ['sorter/sublime'])

    " Change default action.
    call denite#custom#kind('file', 'default_action', 'split')

    " Add custom menus
    let s:menus = {}

    let s:menus.zsh = {
                \ 'description': 'Edit your import zsh configuration'
                \ }
    let s:menus.zsh.file_candidates = [
                \ ['zshrc', '~/.config/zsh/.zshrc'],
                \ ['zshenv', '~/.zshenv'],
                \ ]

    let s:menus.my_commands = {
                \ 'description': 'Example commands'
                \ }
    let s:menus.my_commands.command_candidates = [
                \ ['Split the window', 'vnew'],
                \ ['Open zsh menu', 'Denite menu:zsh'],
                \ ['Format code', 'FormatCode', 'go,python'],
                \ ]

    call denite#custom#var('menu', 'menus', s:menus)

    " Ag command on grep source
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " Ack command on grep source
    call denite#custom#var('grep', 'command', ['ack'])
    call denite#custom#var('grep', 'default_opts',
                \ ['--ackrc', $HOME.'/.ackrc', '-H', '-i',
                \  '--nopager', '--nocolor', '--nogroup', '--column'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--match'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " Pt command on grep source
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " jvgrep command on grep source
    call denite#custom#var('grep', 'command', ['jvgrep'])
    call denite#custom#var('grep', 'default_opts', ['-i'])
    call denite#custom#var('grep', 'recursive_opts', ['-R'])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', [])
    call denite#custom#var('grep', 'final_opts', [])

    " Specify multiple paths in grep source
    "call denite#start([{'name': 'grep',
    "      \ 'args': [['a.vim', 'b.vim'], '', 'pattern']}])

    " Define alias
    call denite#custom#alias('source', 'file/rec/git', 'file/rec')
    call denite#custom#var('file/rec/git', 'command',
                \ ['git', 'ls-files', '-co', '--exclude-standard'])

    call denite#custom#alias('source', 'file/rec/py', 'file/rec')
    call denite#custom#var('file/rec/py', 'command',['scantree.py'])

    " Change ignore_globs
    call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
                \ [ '.git/', '.ropeproject/', '__pycache__/',
                \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

    " Custom action
    " Note: lambda function is not supported in Vim8.
    call denite#custom#action('file', 'test',
                \ {context -> execute('let g:foo = 1')})
    call denite#custom#action('file', 'test2',
                \ {context -> denite#do_action(
                \ context, 'open', context['targets'])})
endfunction
