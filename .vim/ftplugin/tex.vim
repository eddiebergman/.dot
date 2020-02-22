" {{{ Keymaps
nnoremap <buffer> <nowait> <leader>ep :EditPreamble<cr>
nnoremap <buffer> <nowait> <leader>vv :VimtexView<cr>
nnoremap <buffer> <nowait> <leader>vc :VimtexCompile<cr>
nnoremap <buffer> <nowait> <leader>ve :VimtexErrors<cr>
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


