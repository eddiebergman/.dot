if !exists('g:python_command')
    let g:python_command = 'python'
endif

let b:comment_leader = '# ' " Outdated commenting thing

" {{{ Settings
setlocal expandtab
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
" }}}
" {{{ Folding
setlocal foldmethod=expr
setlocal foldexpr=PythonFoldLevel(v:lnum)
setlocal foldtext=getline(v:foldstart)

function! s:IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! s:NextNoneBlank(lnum)
    let numlines = line('$')
    let cur = a:lnum + 1

    while cur <= numlines
        if getline(cur) =~? '\v\S'
            return cur
        endif

        let cur += 1
    endwhile

    return -2
endfunction

function! PythonFoldLevel(lnum)
    let line = getline(a:lnum)
    if line =~? '\v^\s*$'
        return '-1'
    endif

    let i_current = s:IndentLevel(a:lnum)
    let i_next = s:IndentLevel(s:NextNoneBlank(a:lnum))
    if i_current == 0
        return 0
    endif

    " If previous line is func def or class def
    if getline(a:lnum - 1) =~? '\v(\s(def|class)\s)|(^(def|class)\s)'
        return '>' . i_next
    elseif i_next <= i_current
        return i_current
    elseif i_next > i_current
        return '>' . i_next
    endif
endfunction

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

