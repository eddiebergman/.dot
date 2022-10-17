setlocal colorcolumn=89
set foldmethod=expr

if exists(":TSConfigInfo")
    set foldexpr=nvim_treesitter#foldexpr()
endif

nnoremap <buffer> <leader>fa ggOfrom __future__ import annotations<esc><C-o>
