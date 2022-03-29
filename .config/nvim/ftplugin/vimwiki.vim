set foldmethod=syntax
" {{{ Highlighting
if g:colors_name ==? 'gruvbox'
    highlight link vimwikiHeader1 GruvboxYellowBold
    highlight link vimwikiHeader2 GruvboxYellowBold
    highlight link vimwikiHeaderChar GruvboxRedBold
    highlight link vimwikiCode GruvboxOrange
    highlight link vimwikiPre Comment
    highlight link vimwikiListTodo Comment
endif

" }}}
"
noremap <buffer> <tab> :bnext<cr>
