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

" not working on linux
"set clipboard=unnamed

map <leader>ln :lnext<cr>
map <leader>lp :lprevious<cr>

"surround word 
map <leader>q" ciw""<Esc>P

imap <leader>1 ()<Esc>i
imap <leader>2 {}<Esc>i
imap <leader>3 []<Esc>i
imap <leader>4 <><Esc>i

imap <leader>5 ""<Esc>i
imap <leader>6 ''<Esc>i


set viewdir=$HOME/.vim/views

"autocmd BufWinLeave *.[yaml|pp|sh] mkview
autocmd BufWinLeave * mkview
"autocmd BufWinEnter *.[yaml|pp|sh] loadview
autocmd BufWinEnter * silent loadview

