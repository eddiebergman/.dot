let b:comment_leader = '# '
setlocal foldmethod=indent
" setlocal foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g')
setlocal foldtext=getline(v:foldstart)
setlocal tags=./tags,tags;$HOME
setlocal tags+=~/venvs/py/lib/python3.7/site-packages/tags

command! PythonRun execute '!python %'
nnoremap <leader>rf :PythonRun<cr>

" {{{ Manim things
command! -nargs=1 Manimate execute '!manim -pl % ' . <q-args>
nnoremap <leader>mn :Manimate<space>
nnoremap <leader>mw yiw:Manimate<space><C-r>"<cr>
" }}}
