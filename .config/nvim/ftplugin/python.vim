setlocal colorcolumn=89
set foldmethod=expr

if exists(":TSConfigInfo")
    set foldexpr=nvim_treesitter#foldexpr()
endif


#if exists(":UltestNearest")
#    augroup UltestRunner
#        au!
        # au BufWritePost * UltestNearest
#    augroup END
#endif
