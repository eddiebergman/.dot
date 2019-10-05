" {{{ S Operators
" {{{ s Grep Operator
" Note: Doesnt work on V or <C-v>

" normal: Grep on words selected by motion
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
" visual: Grep on visually selected words
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

" {{{ f GrepOperator(type) - Performs a grep on selected/motioned text
function! s:GrepOperator(type)
    let saved_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[y`]
    else
        return
    endif
    silent execute "grep! -R " . shellescape(@@) . " . "
    copen

    let @@ = saved_register
endfunction
" }}}
" }}}
" }}}
