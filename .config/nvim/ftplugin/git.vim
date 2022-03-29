setlocal foldmethod=expr
setlocal foldexpr=GitFoldExpr(v:lnum)
setlocal foldtext=GitFoldText()

function! GitFoldText()
    return '>'.getline(v:foldstart)
endfunction

function! GitFoldExpr(lnum)
    let marker = '\v^\@\@*'

    " If we are at a marker, start a fold
    if getline(a:lnum) =~ marker
        return '>1'

    " If the next line is marker, end the fold
    elseif getline(a:lnum + 1) =~ marker
        return '<1'

    end

    " Otherwise, we are in whatever fold the last line was
    return '-1'

endfunction
