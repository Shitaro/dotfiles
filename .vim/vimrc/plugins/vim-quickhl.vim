
" vim-quickhl関連
" <Space>m でカーソル下の単語、あるいは選択した範囲のハイライトを行う
" 再度<Space>m を入力することでそのハイライトを解除する
" <Space>M で全てのハイライトを解除する
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
