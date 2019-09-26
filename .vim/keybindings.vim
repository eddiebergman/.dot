" Normal
" ==========
" Text manip.
nnoremap <leader><space> i<space><esc>          " insert space
nnoremap <leader>o o<esc>                       " Insert line below
nnoremap <leader>O O<esc>                       " Insert line above

" Visual
" ==========
vnoremap // y/<C-R>"<CR>                        " Search Selected text

" Unmap
" ==========
if mapcheck("<esc>", "n") != ""
    nunmap <esc>
endif
