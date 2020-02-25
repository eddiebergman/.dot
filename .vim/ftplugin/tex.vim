" {{{ Keymaps
nnoremap <buffer> <nowait> <leader>ep :EditPreamble<cr>
nnoremap <buffer> <nowait> <leader>vv :VimtexView<cr>
nnoremap <buffer> <nowait> <leader>vc :VimtexCompile<cr>
nnoremap <buffer> <nowait> <leader>ve :VimtexErrors<cr>
nnoremap <buffer> <nowait> <leader>vt :VimtexTocToggle<cr>
" }}}
" {{{ Functions

" Open the preamble at b:vimtex.root/<name>
" A bit overly verbose, just put it all in a command
" and let vim handle the existance checking
" function! s:EditPreamble(name)
"     if ! exists('b:vimtex.root') | echo "Vimtex could not find a root"
"     endif
" 
"     let l:uri = b:vimtex.root . '/' . a:name
" 
"     if filereadable(l:uri)   | edit "&l:uri"
"     else                     | echo "File was unreadable" . &l:uri
"     endif
" 
" endfunction

" }}}
" {{{ Commands
let s:note_preamble='note_preamble.tex'
command! -buffer -nargs=0 EditPreamble
        \ exe 'edit ' . b:vimtex.root . '/' . s:note_preamble
" }}}
" {{{ Fold
function! TexFoldText()
    let l:line = getline(v:foldstart)
    let l:ncount = v:foldend - v:foldstart
    return "|".l:ncount . "|\t" . v:folddashes . substitute(l:line, '\\\|{\|}', ' ', 'g')
endfunction
setlocal foldmethod=expr
setlocal foldtext=TexFoldText()

" }}}
" {{{ syntax
exec 'hi TexStatement gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi TexTypeStyle gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi TexTypeSize gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi TexBeginEnd gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi TexBeginEndName gui=bold' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi TexSection gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi TexMathZoneX gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Constant')), 'fg', 'gui')
exec 'hi TexMathMatcher gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Constant')), 'fg', 'gui')
" }}}

