local self = {}

function self.setup()
    vim.cmd [[ syntax on ]]

    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

    vim.cmd([[
        augroup FoldOnOpen
        augroup END
    ]])
end

return self
