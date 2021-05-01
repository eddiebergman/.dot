let maplocalleader=','
let b:comment_leader = '" '

setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab
setlocal foldmethod=marker

setlocal foldtext=FoldText()
function! FoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . sub
endfunction
