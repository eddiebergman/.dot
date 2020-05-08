if !exists('g:python_command')
    let g:python_command = 'python'
endif

let b:comment_leader = '# ' " Outdated commenting thing

" {{{ Settings
setlocal foldmethod=indent
setlocal foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g')
setlocal tags=./tags,tags;$HOME
setlocal tags+=~/venvs/py/lib/python3.7/site-packages/tags

setlocal expandtab
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
" }}}
" {{{ keymaps
nnoremap <leader>rf :!python % 
" }}}
" {{{ Style

let b:python_format_style = 'pep8'
command! -buffer StyleDiff
    \ execute ':call python#StyleDiff("'.b:python_format_style.'")'

nnoremap <buffer> <leader>sd :StyleDiff<cr>
" }}}
" {{{ Pytest
function! s:ClosePyTest()
    if bufwinnr('PyTest') > 0
      bd PyTest
    endif
endfunction

command! -complete=shellcmd PyTest
            \ vnew
            \| setlocal buftype=nofile bufhidden=wipe noswapfile
            \| setlocal foldmarker=________________,________________
            \| setlocal foldmethod=marker syntax=python
            \| call s:ClosePyTest()
            \| file PyTest
            \| r !pytest
nnoremap <leader>pt :PyTest<cr>
" }}}
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
" {{{ Syntax
" Taken from $VIMRUNITME/syntax/python.vim

exec 'hi pythonBuiltin gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')

exec 'hi pythonNumber gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')

" }}}

