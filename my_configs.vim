set wildignore+=*/target/*
map <leader>v :e ~/.vim_runtime/my_configs.vim<cr>
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

map <leader>ln :lnext<cr>
map <leader>lp :lprevious<cr>

