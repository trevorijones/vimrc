" To investigate: The value of LANG is different from the shell session.
" Under Cygwin it's set to 'en', totaly ignoring the en_US from the shell session.
"
" Pb section:
" How to put after a word with an extra space after the word
"
"
let $LANG='en_US'


" Open this file
map <leader>v :e ~/.vim_runtime/my_configs.vim<cr>

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
" set verbose=9

" AUTOCOMMANDS
" clear them all, in case this file is source twice
" Don't use autocmd! here as it screws up all others plugins
" autocmd!
"autocmd BufWinLeave *.[yaml|pp|sh] mkview
"autocmd BufWinLeave * mkview
"autocmd BufWinEnter *.[yaml|pp|sh] loadview
"autocmd BufWinEnter * silent loadview
autocmd BufNewFile * echo "This is a new file buffer!"
" Load vim for html files
" <sfile> is expanded at the definition of the command
" <cword> is expended at command execution
" au BufNewFile,BufRead *.html so <sfile>:h/html.vim

au BufNewFile,BufRead .module set filetype=sh
