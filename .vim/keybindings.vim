" Normal
" ==========
" Text manip.
nnoremap <leader><space> i<space><esc>          " insert space
nnoremap <leader>o o<esc>                       " Insert line below
nnoremap <leader>O O<esc>                       " Insert line above
nnoremap <A-j> :m .+1<CR>==                     " Move line up
nnoremap <A-k> :m .-2<CR>==                     " Move line down

" Plugins
nnoremap <leader>m :NERDTree<CR>
nnoremap <leader>c :NERDTreeClose<CR>

" Visual
" ==========
vnoremap // y/<C-R>"<CR>                        " Search Selected text
