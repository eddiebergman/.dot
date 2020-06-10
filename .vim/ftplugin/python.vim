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

function! g:PythonFoldLevel(lnum)
    " Note: Move instansiation if laggish

    let i_cur = s:IndentLevel(a:lnum)
    let cur_line = getline(a:lnum)

    let pnum = PrevOccurence(a:lnum, '\v(\S)@!')
    let i_prev = s:IndentLevel(pnum)
    let prev_line = line(pnum)

    let nnum = NextOccurence(a:lnum, '\v(\S)@!')
    let next_indent = s:IndentLevel(nnum)
    let next_line = line(nnum)

    " -1  Blank lines
    if cur_line =~# '\v^$' | return '-1' | endif

    " 0   Lines with no indent
    if i_cur == 0 | return 0 | endif

    " >x  After func def
    if prev_line =~# '\v^\s*def\s' | return '>'.i_current | endif

    " >x  After class def
    if prev_line =~# '\v^\s*class\s' | return '>'.i_current | endif

    " >x After opening braces and indented
    if prev_line =~# '\v*\s\{$' | return '5' | endif

    " =   Line continuations \
    if prev_line =~? '\vaa$'
        echom prev_line
        return '='
    endif

    " -1 Indented whitespace
    if cur_line =~? '\v^\s*$' | return '-1' | endif

    return i_cur

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

