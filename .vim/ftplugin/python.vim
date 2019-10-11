let b:comment_leader = '# '
setlocal foldmethod=indent
" setlocal foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g')
setlocal foldtext=getline(v:foldstart)
setlocal tags=./tags,tags;$HOME
setlocal tags+=~/venvs/py/lib/python3.7/site-packages/tags

" {{{ Manim things
command! Manimate execute ':silent !manim % -pla'
nnoremap <leader>mn :Manimate<cr>
" }}}

