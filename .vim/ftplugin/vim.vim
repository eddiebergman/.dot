let maplocalleader=','
let b:comment_leader = '" '

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

setlocal foldmethod=marker
setlocal fillchars=fold:\ 

setlocal foldexpr=s:FoldExprText(v:lnum)
function! FoldExprText(lnum)

    " -1 indicates the line takes its parents foldlevel
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    return '0'
endfunction

setlocal foldtext=FoldText()
function! FoldText()
  let line = getline(v:foldstart)
  let headers = split(line, ",")
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . sub
endfunction

" {{{ Title, keymap,
" Description
" }}}




