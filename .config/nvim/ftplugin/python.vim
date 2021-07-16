let opts = {
    \ 'highlighting' : {
    \   'on' : 0,
    \   'limit': 1000,
    \ }
\ }

" {{{ Runtime info
let info = {
    \ 'enabled' : {
    \   'TS' : exists(":TSConfigInfo")
    \ }
\ }
" }}}

" {{{ Defaults for Python
set foldmethod=expr
" }}}

" {{{ TS_highlighting
if info['enabled']['TS'] && ! opts['highlighting']['on']
    augroup PythonAuGroup
        autocmd!
        autocmd BufEnter *.py
            \ if line('$') > opts['highlighting']['limit']
            \ | exe ':TSBufDisable highlight'
            \ | endif
    augroup END
endif
" }}}

" {{{ Folding
if info['enabled']['TS']
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
endif
" }}}

