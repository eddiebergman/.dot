if !exists('g:python_command')
    let g:python_command = 'python'
endif


" {{{ Settings
setlocal expandtab
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
" }}}
" {{{ Folding
" Note: Currently using a plugin to manage folding
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

    " >x -- <x Fold comments
    " If not a single line comment """ """
    "    If it is the i'th occurenece and i is off
    "       open fold >x
    "   Else it is the end of the comment bloc
    "     close fold <x

    " 0   Lines with no indent
    if i_cur == 0 | return 0 | endif

    " >x  def's open a fold
    if cur_line =~# '\v^\s*def\s'
        return '>'.i_current
    endif

    " >x  classes open a fold
    if cur_line =~# '\v^\s*class\s.*$' | return '>'.i_current | endif

    " >x After opening braces and indented
    if prev_line =~# '\v*\s\{$' | return '5' | endif

    " =   Line continuations \
    if prev_line =~? '\vaa$'
        echom prev_line
        retur '='
    endif

    " -1 Indented whitespace
    if cur_line =~? '\v^\s*$' | return '-1' | endif

    return i_cur

endfunction

"setlocal foldmethod=expr
"setlocal foldexpr=g:PythonFoldLevel(v:lnum)

function! g:G_PythonCustomFoldText()
    let line_count = v:foldend - v:foldstart
    let str_line_count = '('.line_count.')'

    let line = getline(v:foldstart)
    let line = substitute(line, '\(^\s*\)\@<=\(def \|class \)', '', '')
    let line = substitute(line, ':$', '', '')

    "let cut_off = &columns - len(line_count)
    "let rest = str(padded_line[0:cut_off])
    let line = Pad(line, &colorcolumn)
    let line = line[0:&colorcolumn-2]

    return join([line, str_line_count], '  ')
endfunction

setlocal foldtext=g:G_PythonCustomFoldText()
" }}}
" {{{ Keymaps
nnoremap <leader>rf :!python % 
nnoremap <leader>af :Autopep8<cr>

" search for function
nnoremap <leader>sff :CtrlSF "def "<left>
" search for class
nnoremap <leader>sfc :CtrlSF "class "<left>

" }}}
" {{{ Mypy
command! -nargs=* -complete=file Mypy
            \ vnew
            \| setlocal textwidth=80
            \| setlocal buftype=nofile bufhidden=wipe noswapfile syntax=python
            \| call CloseBuffIfOpen('Mypy')
            \| file Mypy
            \| r !mypy <args>
nnoremap <leader>mp :Mypy
" }}}
" {{{ Pylint
command! -nargs=* -complete=file Pylint
            \ new
            \| setlocal textwidth=80
            \| setlocal buftype=nofile bufhidden=wipe noswapfile syntax=qf
            \| setlocal foldmethod=marker foldmarker=*****,*****
            \| call CloseBuffIfOpen('Pylint')
            \| file Pylint
            \| r !pylint <args>
nnoremap <leader>pl :PyLint
" }}}
" {{{ Pytest
command! -nargs=* -complete=file PyTest
            \ vnew
            \| setlocal buftype=nofile bufhidden=wipe noswapfile
            \| setlocal foldmarker=________________,________________
            \| setlocal foldmethod=marker syntax=python
            \| call CloseBuffIfOpen('PyTest')
            \| file PyTest
            \| r !pytest <args>
nnoremap <leader>pt :PyTest
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

if g:colors_name ==? 'nord'
    " make yellow
    highlight link PythonFloat Todo
    highlight link pythonNumber Todo
    highlight link PythonNone Todo
    highlight link PythonBuiltinObj Todo
    highlight link pythonClassVar Number
    highlight link pythonStrInterpRegion Type
    highlight link pythonBytesEscape Type
    highlight link pythonTyping Todo
    highlight link pythonExtraHighlight Todo
endif

if g:colors_name ==? 'solarized8'
    highlight link pythonbdoc pythonString
endif

if g:colors_name ==? 'gruvbox'
    highlight link pythonTyping GruvboxYellow
    highlight link pythonFunctionCall GruvboxAqua
    highlight link pythonFunction GruvboxAquaBold
    highlight link pythonClass GruvboxYellowBold
    highlight link pythonDottedName GruvboxPurple
    highlight link pythonDecorator GruvboxRed
    highlight link pythonExtraHighlight Folded
endif
if g:colors_name ==? 'xcodedark'
    highlight link pythonStatement FunctionDef
endif

" }}}
