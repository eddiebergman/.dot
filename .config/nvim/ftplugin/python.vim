set foldmethod=expr

if exists(":TSConfigInfo")
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    " Some plugin somewhere is causing issues, we make this an autocmd too
    "
    augroup PythonForceFoldMethod
        autocmd!
        autocmd BufWinEnter *.py set foldmethod=expr
    augroup END

endif
