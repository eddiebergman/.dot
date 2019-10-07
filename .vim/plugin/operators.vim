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
" {{{ s Comment Operator
"

" visual: Comments out the selected lines
vnoremap <leader>c :<c-u>call <SID>CommentOperator(visualmode())<cr>

" {{{ f CommentOperator(type) - Block comments out the selected text
function! s:CommentOperator(type)
    let saved_register = @@

    if a:type ==# 'V'
        if exists(b:supports_multineline_comment)
        else
            echom "Please set b:supports_multiline_comment in ftplugin " . %y
    endif
endfunction

" }}}

" }}}
" }}}
