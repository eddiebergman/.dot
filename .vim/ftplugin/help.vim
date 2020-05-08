setlocal foldmethod=expr
setlocal foldexpr=GetHelpFold(v:lnum)
setlocal foldtext=HelpFoldText()

function! HelpFoldText()
    return '>'.getline(v:foldstart + 1)
endfunction

function! GetHelpFold(lnum)
    if getline(a:lnum + 1) =~? '\v^\=\=*'
        return '0'
    elseif getline(a:lnum) =~? '\v^\=\=*'
        return '>1'
    else
        return '1'
    endif

    return '-1'
endfunction
