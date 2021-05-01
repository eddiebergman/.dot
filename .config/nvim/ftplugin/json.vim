setlocal foldmethod=indent
setlocal tabstop=2

if executable('jq')
    nnoremap <leader>af :%! jq .<cr>
endif
