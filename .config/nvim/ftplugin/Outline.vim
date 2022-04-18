function! FoldOutline(lnum)
    " Marker for first character that isnt some guides or space
    let l:marker = '\v(\s|├|└|│)@!'

    " Get this line and next
    let l:this = getline(v:lnum)
    let l:next = getline(v:lnum + 1)

    " Calculate their indents, the 3 is spacing for the markers
    let l:this_indent = (match(l:this, l:marker) + 1) / 3
    let l:next_indent = (match(l:next, l:marker) + 1) / 3

    " If less indented than the next line, start a fold at
    " the level of the next line
    if l:this_indent < l:next_indent
        return ">".l:next_indent

    " If more indented the the next line, end the fold
    elseif l:this_indent > l:next_indent
        return "<".l:this_indent

    " Just return whatever the previous line is
    else
        return "="
    endif
endfunction

function! FoldTextOutline()
    return substitute(getline(v:foldstart), '├\|└\|│', '-', 'g')
endfunction

setl foldexpr=FoldOutline(v:lnum)
setl foldtext=FoldTextOutline()
setl foldmethod=expr
