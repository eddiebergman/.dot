let b:comment_leader = '# '
setlocal foldmethod=indent
setlocal foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g')
setlocal tags=./tags,tags;$HOME
setlocal tags+=~/venvs/py/lib/python3.7/site-packages/tags

setlocal expandtab
" setlocal smartindent
setlocal smarttab
setlocal tabstop=2
set shiftwidth=2

command! PythonRun execute '!python %'
nnoremap <leader>rf :PythonRun<cr>

" {{{ Django
let s:djangoport='8000'
let s:djangoip='127.0.0.1'
command! DjangoRun
      \   exe ':! python manage.py runserver ' .&s:djangoport . ' &'
      \ | exe ':! firefox' . &s:djangoip . ':' . &s:djangoport

command! DjangoMakeMigrations
      \ exe ':! python manage.py makemigrations'

command! -nargs=1 DjangoMigrate
      \ exe ':! python manage.py migrate ' . <q-args>

command! -nargs=+ DjangoViewMigrateSQL
      \ exe '!python manage.py sqlmigrate ' . <q-args>
" }}}
" {{{ Manim things
command! -nargs=1 Manimate execute '!manim -pl % ' . <q-args>
nnoremap <leader>mn :Manimate<space>
vnoremap <leader>mn yiw:Manimate<space><C-r>"<cr>
" }}}
