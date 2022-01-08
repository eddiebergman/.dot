local self = {}

local null_ls = require("null-ls")

local pydocstyle = require("lsp.null_ls_tools.pydocstyle")

function self.setup()
    null_ls.setup({
        debug = true,
        sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.diagnostics.mypy,
            null_ls.builtins.diagnostics.flake8,
            --pydocstyle -- using pylsp for this
        }
    })
end

return self
