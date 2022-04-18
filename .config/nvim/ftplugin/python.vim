if exists(":TSConfigInfo")
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
else
    set foldmethod=expr
endif
