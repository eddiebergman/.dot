setlocal foldmethod=expr
setlocal foldexpr=GitFoldExpr(v:lnum)
setlocal foldtext=GitFoldText()


function! GitFoldText()
    let diffmark = '\v^diff --git'
    let hunkmark = '\v^\@\@*'

    let line = getline(v:foldstart)

    if line =~ diffmark
        return "  === ".line
    else
        return ">".line
    end
endfunction

function! GitFoldExpr(lnum)
    let diffmark = '\v^diff --git'
    let hunkmark = '\v^\@\@*'

    " If we are at a diff, that's a level 1 fold
    if getline(a:lnum) =~ diffmark
        return '>1'
    end

    " If next line is a diff mark, that's the end of 1 fold method
    if getline(a:lnum + 1) =~ diffmark
        return '<1'
    end

    " If we are at a hunkmarker, start a fold
    if getline(a:lnum) =~ hunkmark
        return '>2'
    end

    " If the next line is marker, end the fold
    if getline(a:lnum + 1) =~ hunkmark
        return '<2'
    end

    " Otherwise, we are in whatever fold the last line was
    return '-1'

endfunction
